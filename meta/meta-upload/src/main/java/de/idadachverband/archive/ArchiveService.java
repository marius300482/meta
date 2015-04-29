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
     * finds the path an archived file
     * @param step
     * @param coreName
     * @param institutionName
     * @param versionId
     * @param updateId id of incremental update, or LATEST_UPDATE / NO_UPDATE
     * @return
     * @throws ArchiveException
     */
    public Path findFile(ProcessStep step, String coreName, String institutionName, String versionId, String updateId) 
            throws ArchiveException
    {
        Path folder = (NO_UPDATE.equals(updateId))
                ? archiveConfiguration.getFolder(step, coreName, institutionName, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionName, versionId, updateId);
        try 
        {
            Path file = Directories.findFirstFile(folder);
            return file;
        } catch (IOException e)
        {
            log.error("Could not find an archived file in: {}", folder, e);
            throw new ArchiveException(String.format("Could not find an archived file of step: %s for institution: %s version: %s/%s on core: %s", 
                    step, institutionName, versionId, updateId, coreName), e);
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
        final String institutionName = transformationBean.getInstitutionName();
        final boolean incrementalUpdate = transformationBean.isIncrementalUpdate();
        
        final String versionId = (incrementalUpdate) 
                ? getLatestVersionId(coreName, institutionName)
                : buildNextVersionId(coreName, institutionName);
        final String updateId = (incrementalUpdate)
                ? buildNextUpdateId(coreName, institutionName, versionId)
                : ArchiveService.NO_UPDATE;
                
        transformationBean.setArchivedVersionId(versionId);
        transformationBean.setArchivedUpdateId(updateId);

        log.info("Archive transformation: {} for institution: {} using version: {}/{}", key, institutionName, versionId, updateId);

        archive(ProcessStep.upload, key, institutionName, coreName, versionId, updateId);
        archive(ProcessStep.workingFormat, key, institutionName, coreName, versionId, updateId);
        archive(ProcessStep.solrFormat, key, institutionName, coreName, versionId, updateId);

        clearOldVersions(institutionName, coreName);   
    }

    private Path archive(ProcessStep step, String key, String institutionName, String coreName, String versionId, String updateId) throws IOException
    {
        final Path sourcePath = Directories.findFirstFile(processFileConfiguration.getFolder(step, key));

        final Path targetFolder = (updateId.equals(ArchiveService.NO_UPDATE))   
                ? archiveConfiguration.getFolder(step, coreName, institutionName, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionName, versionId, updateId);      
        
        return idaInputArchiver.archiveFile(sourcePath, targetFolder);
    }
    
    protected void clearOldVersions(String institutionName, String coreName) 
    {
        final List<String> versions = getVersionIds(coreName, institutionName);
        for (int i=0; i < versions.size() - archiveConfiguration.getMaxArchivedVersions(); i++) 
        {
            final String oldVersion = versions.get(i);
            log.info("Clear old version: {} of institution: {} in core: {}", oldVersion, institutionName, coreName);
            deleteVersion(coreName, institutionName, oldVersion);
        }
    }
    
    /* -------- version / update id handling --------*/
    
    /**
     * @param coreName
     * @param institutionName 
     * @return a list of chronologically sorted version ids for the given institution
     */
    protected List<String> getVersionIds(String coreName, String institutionName) 
    {
    	final List<String> versionIds = listDirectoryNames(archiveConfiguration.getVersionsBasePath(coreName, institutionName));
        Collections.sort(versionIds);
        return versionIds;
    }
    
    protected String getLatestVersionId(String coreName, String institutionName) throws ArchiveException
    {
        final List<String> versionIds = getVersionIds(coreName, institutionName);
        if (versionIds.isEmpty()) {
            log.warn("Found no archived versions for institution: {} in core: {}", institutionName, coreName);
            throw new ArchiveException(String.format("Found no archived version for institution: %s in core: %s", 
                    institutionName, coreName)); 
        }
        return versionIds.get(versionIds.size()-1);
    }
    
    protected String buildNextVersionId(String coreName, String institutionName) 
    {
        final List<String> versionIds = getVersionIds(coreName, institutionName);
        int nextVersion = (versionIds.isEmpty())
                ? 1
                : 1 + parseVersion(versionIds.get(versionIds.size() - 1), VERSION_PREFIX);
        Date now = new Date();
        return String.format("%s%04d_%s", VERSION_PREFIX, nextVersion, dateFormat.format(now));
    }
    
    /**
     * @param coreName
     * @param institutionName 
     * @param versionId
     * @return a list of chronologically sorted incremental update ids for the given version
     */
    protected List<String> getUpdateIds(String coreName, String institutionName, String versionId) 
    {
        final List<String> updateIds;
        Path updatesBasePath = archiveConfiguration.getUpdatesBasePath(coreName, institutionName, versionId);
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
    
    protected String buildNextUpdateId(String coreName, String institutionName, String versionId) 
    {
        final List<String> updateIds = getUpdateIds(coreName, institutionName, versionId);
        int nextVersion = (updateIds.isEmpty())
                ? 1
                : 1 + parseVersion(updateIds.get(updateIds.size() - 1), UPDATE_PREFIX);
        Date now = new Date();
        return String.format("%s%04d_%s", UPDATE_PREFIX, nextVersion, dateFormat.format(now));
    }
    
    private int parseVersion(String versionId, String prefix) 
    {
        return Integer.parseInt(versionId.substring(prefix.length(), prefix.length() + 4));
    }
    
    /* -------- delete archived files --------*/
    
    public void deleteVersion(String coreName, String institutionName, String versionId) 
    {
        final Path versionFolder = archiveConfiguration.getVersionFolder(coreName, institutionName, versionId);
        delete(versionFolder);
    }
    
    public void deleteUpdate(String coreName, String institutionName, String versionId, String updateId) 
    {
        final Path versionFolder = archiveConfiguration.getUpdateFolder(coreName, institutionName, versionId, updateId);
        delete(versionFolder);
    }
        
    /* -------- archive traversal --------*/
    
    /**
     * finds all archived institutions (without traversing upload versions)
     * @param coreName
     * @return
     */
    public List<IdaInstitutionBean> findArchivedInstitutions(String coreName)
    {
        List<IdaInstitutionBean> institutions = new ArrayList<>();
        for  (String institutionName : getInstitutionNames(coreName))
        {
            institutions.add(idaInstitutionConverter.convert(institutionName));
        }
        return institutions;
    }
    
    /**
     * reads the whole archive 
     * @return list of archived cores
     */
    public List<ArchiveCoreBean> getCores()
    {
        final List<ArchiveCoreBean> cores = new ArrayList<>();
        for (String coreName : getCoreNames())
        {
            log.debug("found core: {}", coreName);
            final ArchiveCoreBean coreBean = buildCoreBean(coreName);
            cores.add(coreBean);
        }
        return cores;
    }
    
    /**
     * reads an upload version from the archive (without traversing the rest of the archive)
     * @param coreName
     * @param institutionName
     * @param versionId
     * @return 
     * @throws ArchiveException
     */
    public ArchiveVersionBean getVersion(String coreName, String institutionName, String versionId) throws ArchiveException
    {
        if (LATEST_VERSION.equals(versionId))
        {
            versionId = getLatestVersionId(coreName, institutionName);
        }
        return buildVersionBean(new ArchiveInstitutionBean(institutionName, new ArchiveCoreBean(coreName)), versionId);
    }
    
    private ArchiveCoreBean buildCoreBean(String coreName) 
    {
        try
        {
            ArchiveCoreBean bean = new ArchiveCoreBean(coreName);
           
            // read institutions 
            for (String institutionName : getInstitutionNames(coreName))
            {
                log.debug("found institution: {}", institutionName);
                bean.add(buildInstitutionBean(bean, institutionName));
            }
            return bean;
        } catch (Exception e)
        {
            log.warn("Could not read archived core {}",coreName, e);
            throw new RuntimeException(e);
        }
    }
    
    private ArchiveInstitutionBean buildInstitutionBean(ArchiveCoreBean parent, String institutionName) throws ArchiveException 
    {
        ArchiveInstitutionBean bean = new ArchiveInstitutionBean(institutionName, parent);
       
        // read versions 
        final String coreName = bean.getCoreName();
        for (String versionId : getVersionIds(coreName, institutionName))
        {
            log.debug("found version: {}", versionId);
            bean.add(buildVersionBean(bean, versionId));
        }
        return bean;
    }
    
    private ArchiveVersionBean buildVersionBean(ArchiveInstitutionBean institutionBean, String versionId) throws ArchiveException 
    {  
        final String coreName = institutionBean.getCoreName();
        final String institutionName = institutionBean.getName();
        
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
        bean.setUploadFile(findFile(ProcessStep.upload, coreName, institutionName, versionId, NO_UPDATE));
        bean.setWorkingFormatFile(findFile(ProcessStep.workingFormat, coreName, institutionName, versionId, NO_UPDATE));
        bean.setSolrFormatFile(findFile(ProcessStep.solrFormat, coreName, institutionName, versionId, NO_UPDATE));
        
        // read updates 
        for (String updateId : getUpdateIds(coreName, institutionName, versionId))
        {
            log.debug("found update: {}", updateId);
            bean.add(buildUpdateBean(bean, updateId));
        }
        return bean;
    }
    
    private ArchiveUpdateBean buildUpdateBean(ArchiveVersionBean versionBean, String updateId) throws ArchiveException 
    {
        final String coreName = versionBean.getCoreName();
        final String institutionName = versionBean.getInstitutionName();
        final String versionId = versionBean.getName();
        
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
        bean.setUploadFile(findFile(ProcessStep.upload, coreName, institutionName, versionId, updateId));
        bean.setWorkingFormatFile(findFile(ProcessStep.workingFormat, coreName, institutionName, versionId, updateId));
        bean.setSolrFormatFile(findFile(ProcessStep.solrFormat, coreName, institutionName, versionId, updateId));
        return bean;
    }
    
    protected List<String> getCoreNames() {
        return listDirectoryNames(archiveConfiguration.getBasePath());
    }
    
    protected List<String> getInstitutionNames(String coreName)
    {
        return listDirectoryNames(archiveConfiguration.getInstitutionsBasePath(coreName));
    }
}

