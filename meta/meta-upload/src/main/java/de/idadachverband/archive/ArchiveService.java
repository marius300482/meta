package de.idadachverband.archive;

import static de.idadachverband.archive.Directories.*;
import de.idadachverband.archive.bean.ArchiveCoreBean;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveUpdateBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessStep;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by boehm on 25.02.15.
 */
@Slf4j
@Named
public class ArchiveService
{
    public static final String VERSION_PREFIX = "v";
    public static final String UPDATE_PREFIX = "u";
    public static final String LATEST_VERSION = "v_latest";
    public static final String LATEST_UPDATE = "u_latest";
    public static final String NO_UPDATE = "u_none";
    
    private final ArchiveConfiguration archiveConfiguration;
    
    private final ProcessFileConfiguration processFileConfiguration;
    
    private final SimpleDateFormat dateFormat;
    
    private final IdaInputArchiver idaInputArchiver;
    
    private final IdaInstitutionConverter idaInstitutionConverter;
    

    @Inject
    public ArchiveService(ArchiveConfiguration archiveConfiguration,
                          ProcessFileConfiguration processFileConfiguration,
                          SimpleDateFormat dateFormat,
                          IdaInputArchiver idaInputArchiver,
                          IdaInstitutionConverter idaInstitutionConverter)
    {
        this.archiveConfiguration = archiveConfiguration;
        this.processFileConfiguration = processFileConfiguration;
        this.dateFormat = dateFormat;
        this.idaInputArchiver = idaInputArchiver;
        this.idaInstitutionConverter = idaInstitutionConverter;
    }
    
    /**
     * finds the path of an archived file
     * @param step
     * @param coreName
     * @param institutionId
     * @param versionId
     * @param updateId id of incremental update, or LATEST_UPDATE / NO_UPDATE
     * @return
     * @throws ArchiveException
     */
    public Path findFile(ProcessStep step, String coreName, String institutionId, String versionId, String updateId) 
            throws ArchiveException
    {
        Path folder = (NO_UPDATE.equals(updateId))
                ? archiveConfiguration.getFolder(step, coreName, institutionId, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionId, versionId, updateId);
        try 
        {
            Path file = Directories.findFirstFile(folder);
            return file;
        } catch (IOException e)
        {
            log.error("Could not find an archived file in: {}", folder, e);
            throw new ArchiveException(String.format("Could not find an archived file of step: %s for institution: %s version: %s/%s on core: %s", 
                    step, institutionId, versionId, updateId, coreName), e);
        }
    }
    
    /* -------- archive transformations --------*/
    
    /**
     * archives the step files of a given transformation
     * @param transformationBean
     * @throws IOException
     * @throws ArchiveException
     */
    public void archive(TransformationBean transformationBean) throws IOException, ArchiveException
    {
        final String key = transformationBean.getKey();
        final String coreName = transformationBean.getCoreName();
        final String institutionId = transformationBean.getInstitutionId();
        final boolean incrementalUpdate = transformationBean.isIncrementalUpdate();
        
        final String versionId = (incrementalUpdate) 
                ? getLatestVersionId(coreName, institutionId)
                : buildNextVersionId(coreName, institutionId);
        final String updateId = (incrementalUpdate)
                ? buildNextUpdateId(coreName, institutionId, versionId)
                : ArchiveService.NO_UPDATE;
                
        transformationBean.setArchivedVersionId(versionId);
        transformationBean.setArchivedUpdateId(updateId);

        log.info("Archive transformation: {} for institution: {} using version: {}/{}", key, institutionId, versionId, updateId);

        archive(ProcessStep.upload, key, institutionId, coreName, versionId, updateId);
        archive(ProcessStep.workingFormat, key, institutionId, coreName, versionId, updateId);
        archive(ProcessStep.solrFormat, key, institutionId, coreName, versionId, updateId);

        clearOldVersions(institutionId, coreName);   
    }

    private Path archive(ProcessStep step, String key, String institutionId, String coreName, String versionId, String updateId) throws IOException
    {
        final Path sourcePath = Directories.findFirstFile(processFileConfiguration.getFolder(step, key));

        final Path targetFolder = (updateId.equals(ArchiveService.NO_UPDATE))   
                ? archiveConfiguration.getFolder(step, coreName, institutionId, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionId, versionId, updateId);      
        
        return idaInputArchiver.archiveFile(sourcePath, targetFolder);
    }
    
    protected void clearOldVersions(String institutionId, String coreName) 
    {
        final List<String> versions = getVersionIds(coreName, institutionId);
        for (int i=0; i < versions.size() - archiveConfiguration.getMaxArchivedVersions(); i++) 
        {
            final String oldVersion = versions.get(i);
            log.info("Clear old version: {} of institution: {} in core: {}", oldVersion, institutionId, coreName);
            deleteVersion(coreName, institutionId, oldVersion);
        }
    }
    
    /* -------- version / update id handling --------*/
    
    /**
     * @param coreName
     * @param institutionId 
     * @return a list of chronologically sorted version ids for the given institution
     */
    protected List<String> getVersionIds(String coreName, String institutionId) 
    {
    	final List<String> versionIds = listDirectoryNames(archiveConfiguration.getVersionsBasePath(coreName, institutionId));
        Collections.sort(versionIds);
        return versionIds;
    }
    
    protected String getLatestVersionId(String coreName, String institutionId) throws ArchiveException
    {
        final List<String> versionIds = getVersionIds(coreName, institutionId);
        if (versionIds.isEmpty()) {
            log.warn("Found no archived versions for institution: {} in core: {}", institutionId, coreName);
            throw new ArchiveException(String.format("Found no archived version for institution: %s in core: %s", 
                    institutionId, coreName)); 
        }
        return versionIds.get(versionIds.size()-1);
    }
    
    protected String buildNextVersionId(String coreName, String institutionId) 
    {
        final List<String> versionIds = getVersionIds(coreName, institutionId);
        int nextVersion = (versionIds.isEmpty())
                ? 1
                : 1 + parseVersion(versionIds.get(versionIds.size() - 1), VERSION_PREFIX);
        Date now = new Date();
        return String.format("%s%04d_%s", VERSION_PREFIX, nextVersion, dateFormat.format(now));
    }
    
    /**
     * @param coreName
     * @param institutionId 
     * @param versionId
     * @return a list of chronologically sorted incremental update ids for the given version
     */
    protected List<String> getUpdateIds(String coreName, String institutionId, String versionId) 
    {
        final List<String> updateIds;
        Path updatesBasePath = archiveConfiguration.getUpdatesBasePath(coreName, institutionId, versionId);
        if (Files.exists(updatesBasePath))
        {
            updateIds = listDirectoryNames(updatesBasePath);
            Collections.sort(updateIds);
        } else
        {
            updateIds = Collections.emptyList(); 
        }        
        return updateIds;
    }
    
    protected String buildNextUpdateId(String coreName, String institutionId, String versionId) 
    {
        final List<String> updateIds = getUpdateIds(coreName, institutionId, versionId);
        int nextVersion = (updateIds.isEmpty())
                ? 1
                : 1 + parseVersion(updateIds.get(updateIds.size() - 1), UPDATE_PREFIX);
        Date now = new Date();
        return String.format("%s%04d_%s", UPDATE_PREFIX, nextVersion, dateFormat.format(now));
    }
    
    private static int parseVersion(String versionId, String prefix) 
    {
        return Integer.parseInt(versionId.substring(prefix.length(), prefix.length() + 4));
    }
    
    /* -------- delete archived files --------*/
    
    public void deleteVersion(String coreName, String institutionId, String versionId) 
    {
        final Path versionFolder = archiveConfiguration.getVersionFolder(coreName, institutionId, versionId);
        delete(versionFolder);
    }
    
    public void deleteUpdate(String coreName, String institutionId, String versionId, String updateId) 
    {
        final Path versionFolder = archiveConfiguration.getUpdateFolder(coreName, institutionId, versionId, updateId);
        delete(versionFolder);
    }
        
    /* -------- archive traversal --------*/
    
    /**
     * lists all archived cores while traversing the whole archive 
     * @return list of archived cores
     * @throws ArchiveException 
     */
    public List<ArchiveCoreBean> getArchivedCores() throws ArchiveException
    {
        final List<ArchiveCoreBean> archivedCores = new ArrayList<>();
        for (String coreName : getCoreNames())
        {
            log.debug("found core: {}", coreName);
            archivedCores.add(
                    buildCoreBean(coreName, true));
        }
        return archivedCores;
    }
    
    /**
     * lists all archived institutions of a core
     * @param coreName
     * @param traverseVersions
     * @return list of archived institutions
     * @throws ArchiveException 
     */
    public List<ArchiveInstitutionBean> getArchivedInstitutions(String coreName, boolean traverseVersions) throws ArchiveException
    {
        // build parent without traversing the archive
        ArchiveCoreBean parent = buildCoreBean(coreName, false);
        
        List<ArchiveInstitutionBean> archivedInstitutions = new ArrayList<>();
        for  (String institutionId : getInstitutionIds(coreName))
        {
            archivedInstitutions.add(
                    buildInstitutionBean(parent, institutionId, traverseVersions));
        }
        return archivedInstitutions;
    }
    
    /**
     * gets an upload version from the archive (without traversing the rest of the archive)
     * @param coreName
     * @param institutionId
     * @param versionId
     * @return 
     * @throws ArchiveException
     */
    public ArchiveVersionBean getVersion(String coreName, String institutionId, String versionId) throws ArchiveException
    {
        if (LATEST_VERSION.equals(versionId))
        {
            versionId = getLatestVersionId(coreName, institutionId);
        }
        
        // build parent without traversing other versions
        ArchiveInstitutionBean parent = 
                buildInstitutionBean(
                        buildCoreBean(coreName, false), 
                        institutionId, false);
        return buildVersionBean(parent, versionId);
    }
    
    
    protected ArchiveCoreBean buildCoreBean(String coreName, boolean traverseInstitutions) throws ArchiveException
    {
        ArchiveCoreBean bean = new ArchiveCoreBean(coreName);
        
        if (traverseInstitutions)
        {
            for (String institutionId : getInstitutionIds(coreName))
            {
                log.debug("found institution: {}", institutionId);
                bean.add(buildInstitutionBean(bean, institutionId, true));
            }
        }
            
        return bean;
    }
    
    protected ArchiveInstitutionBean buildInstitutionBean(ArchiveCoreBean parent, String institutionId, boolean traverseVersions) throws ArchiveException 
    {
        IdaInstitutionBean institutionBean = idaInstitutionConverter.convert(institutionId);
        ArchiveInstitutionBean bean = new ArchiveInstitutionBean(institutionBean, parent);
       
        if (traverseVersions)
        {
            // read versions 
            final String coreName = bean.getCoreName();
            for (String versionId : getVersionIds(coreName, institutionId))
            {
                log.debug("found version: {}", versionId);
                bean.add(buildVersionBean(bean, versionId));
            }
        }
       
        return bean;
    }
    
    protected ArchiveVersionBean buildVersionBean(ArchiveInstitutionBean institutionBean, String versionId) throws ArchiveException 
    {  
        final String coreName = institutionBean.getCoreName();
        final String institutionId = institutionBean.getId();
        
        final ArchiveVersionBean bean = new ArchiveVersionBean(versionId, institutionBean);
        try
        {
            bean.setVersionNumber(parseVersion(versionId, VERSION_PREFIX));
            bean.setDate(dateFormat.parse(versionId.substring(VERSION_PREFIX.length() + 5)));
        } catch (Exception e)
        {
            log.error("Invalid version id: {}", versionId, e);
            throw new ArchiveException("Invalid version id", e);
        }
        bean.setUploadFile(findFile(ProcessStep.upload, coreName, institutionId, versionId, NO_UPDATE));
        bean.setWorkingFormatFile(findFile(ProcessStep.workingFormat, coreName, institutionId, versionId, NO_UPDATE));
        bean.setSolrFormatFile(findFile(ProcessStep.solrFormat, coreName, institutionId, versionId, NO_UPDATE));
        
       // read updates 
        for (String updateId : getUpdateIds(coreName, institutionId, versionId))
        {
            log.debug("found update: {}", updateId);
            bean.add(buildUpdateBean(bean, updateId));
        }
        
        return bean;
    }
    
    protected ArchiveUpdateBean buildUpdateBean(ArchiveVersionBean versionBean, String updateId) throws ArchiveException 
    {
        final String coreName = versionBean.getCoreName();
        final String institutionId = versionBean.getInstitutionId();
        final String versionId = versionBean.getId();
        
        ArchiveUpdateBean bean = new ArchiveUpdateBean(updateId, versionBean);
        try
        {
            bean.setUpdateNumber(parseVersion(updateId, UPDATE_PREFIX));
            bean.setDate(dateFormat.parse(updateId.substring(UPDATE_PREFIX.length() + 5)));
        } catch (Exception e)
        {
            log.error("Invalid update id: {}", updateId, e);
            throw new ArchiveException("Invalid update id", e);
        }
        bean.setUploadFile(findFile(ProcessStep.upload, coreName, institutionId, versionId, updateId));
        bean.setWorkingFormatFile(findFile(ProcessStep.workingFormat, coreName, institutionId, versionId, updateId));
        bean.setSolrFormatFile(findFile(ProcessStep.solrFormat, coreName, institutionId, versionId, updateId));
        return bean;
    }
    
    protected List<String> getCoreNames() {
        return listDirectoryNames(archiveConfiguration.getBasePath());
    }
    
    protected List<String> getInstitutionIds(String coreName)
    {
        return listDirectoryNames(archiveConfiguration.getInstitutionsBasePath(coreName));
    }
}

