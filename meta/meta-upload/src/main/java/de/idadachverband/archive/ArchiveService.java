package de.idadachverband.archive;

import static de.idadachverband.archive.Directories.*;
import de.idadachverband.archive.bean.ArchiveCoreBean;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.archive.bean.ArchiveBaseVersionBean;
import de.idadachverband.archive.bean.VersionOrigin;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessStep;
import de.idadachverband.transform.TransformationBean;
import de.idadachverband.user.UserService;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

/**
 * Created by boehm on 25.02.15.
 */
@Slf4j
@Named
public class ArchiveService
{
    
    public static final String VERSION_PROPERTIES = "version.properties";
    
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
                          IdaInstitutionConverter idaInstitutionConverter,
                          UserService userService)
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
     * @param baseId
     * @param updateId id of incremental update, or LATEST_UPDATE / NO_UPDATE
     * @return
     * @throws ArchiveException
     */
    public Path findFile(ProcessStep step, String coreName, String institutionId, VersionKey version) 
            throws ArchiveException
    {
        Path folder = getStepFolder(step, coreName, institutionId, version);
        try 
        {
            Path file = Directories.findFirstFile(folder);
            return file;
        } catch (IOException e)
        {
            log.error("Could not find an archived file in: {}", folder, e);
            throw new ArchiveException(String.format("Could not find an archived file of step: %s for institution: %s version: %s on core: %s", 
                    step, institutionId, version, coreName), e);
        }
    }
    
    /* -------- archive transformations --------*/
    
    /**
     * archives the step files of a given transformation
     * @param transformationBean
     * @throws IOException
     * @throws ArchiveException
     */
    public ArchiveVersionBean archive(TransformationBean transformationBean, VersionOrigin origin, String username) throws IOException, ArchiveException
    {
        final String key = transformationBean.getKey();
        final String coreName = transformationBean.getCoreName();
        final String institutionId = transformationBean.getInstitutionId();
        final boolean incrementalUpdate = transformationBean.isIncrementalUpdate();
        
        VersionKey version = createNextVersionKey(coreName, institutionId, incrementalUpdate);
        transformationBean.setArchivedVersion(version);
        log.info("Archive transformation: {} for institution: {} using version: {}", key, institutionId, version);

        ArchiveVersionBean versionBean = (incrementalUpdate)
                ? new ArchiveVersionBean(version)
                : new ArchiveBaseVersionBean(version);
        
        versionBean.setUploadFile(
                archive(ProcessStep.upload, key, institutionId, coreName, version));
        versionBean.setWorkingFormatFile(
                archive(ProcessStep.workingFormat, key, institutionId, coreName, version));
        versionBean.setSolrFormatFile(
                archive(ProcessStep.solrFormat, key, institutionId, coreName, version));
        
        versionBean.setUserName(username);
        versionBean.setOrigin(origin);
        versionBean.setOriginalVersion(transformationBean.getOriginalVersion());       
        
        storeVersionProperties(versionBean, coreName, institutionId, version);

        clearOldVersions(coreName, institutionId);   
        
        return versionBean;
    }
    
    /**
     * pushes an archived version to the head of the archive by copying all files
     * @param coreName
     * @param institutionId
     * @param originalVersion
     * @param origin
     * @return
     * @throws ArchiveException 
     * @throws IOException 
     */
    public ArchiveVersionBean rearchive(String coreName, String institutionId, 
            VersionKey originalVersion, VersionOrigin origin, String username) throws ArchiveException, IOException
    {
        final boolean incrementalUpdate = !originalVersion.isBaseVersion();
        
        VersionKey version = createNextVersionKey(coreName, institutionId, incrementalUpdate);
        ArchiveVersionBean versionBean = (incrementalUpdate)
                ? new ArchiveVersionBean(version)
                : new ArchiveBaseVersionBean(version);
                
        versionBean.setUploadFile(
                archiveFile(
                    findFile(ProcessStep.upload, coreName, institutionId, originalVersion),
                    ProcessStep.upload, coreName, institutionId, version));
                    
        versionBean.setWorkingFormatFile(
                archiveFile(
                        findFile(ProcessStep.workingFormat, coreName, institutionId, originalVersion),
                        ProcessStep.workingFormat, coreName, institutionId, version));
        versionBean.setSolrFormatFile(
                archiveFile(
                        findFile(ProcessStep.solrFormat, coreName, institutionId, originalVersion),
                        ProcessStep.solrFormat, coreName, institutionId, version));
        
        versionBean.setUserName(username);
        versionBean.setOrigin(origin);
        versionBean.setOriginalVersion(originalVersion);       
        
        storeVersionProperties(versionBean, coreName, institutionId, version);
        
        return versionBean;
    }

    protected Path archive(ProcessStep step, String key, String institutionId, String coreName, VersionKey version) throws IOException
    {
        final Path sourcePath = Directories.findFirstFile(processFileConfiguration.getFolder(step, key));

        return archiveFile(sourcePath, step, coreName, institutionId, version);
    }

    private Path archiveFile(final Path sourcePath, ProcessStep step,
            String coreName, String institutionId, VersionKey version)
            throws IOException
    {
        final Path targetFolder = getStepFolder(step, coreName, institutionId, version);      
        
        return idaInputArchiver.archiveFile(sourcePath, targetFolder);
    }
    
    public void clearOldVersions(String coreName, String institutionId) 
    {
        final List<String> baseIds = getBaseIds(coreName, institutionId);
        for (int i=0; i < baseIds.size() - archiveConfiguration.getMaxArchivedVersions(); i++) 
        {
            final String baseId = baseIds.get(i);
            log.info("Clear old version: {} of institution: {} in core: {}", baseId, institutionId, coreName);
            delete(archiveConfiguration.getVersionFolder(coreName, institutionId, baseId));
        }
    }
    
    
    /* -------- version id handling --------*/
    
    public VersionKey getLatestVersionKey(String coreName, String institutionId) throws ArchiveException
    {
        final List<String> baseIds = getBaseIds(coreName, institutionId);
        if (baseIds.isEmpty()) {
            return VersionKey.NO_VERSION; 
        }
        String baseId = baseIds.get(baseIds.size()-1);
        
        final List<String> updateIds = getUpdateIds(coreName, institutionId, baseId);
        if (updateIds.isEmpty())
        {
            return new VersionKey(baseId);
        } else 
        {
            return new VersionKey(baseId, updateIds.get(updateIds.size()-1));
        }
    }
    
    public VersionKey createNextVersionKey(String coreName, String institutionId, boolean incremental) throws ArchiveException
    {
        VersionKey latestVersion = getLatestVersionKey(coreName, institutionId);
        return (!incremental || latestVersion == VersionKey.NO_VERSION) 
            ? new VersionKey(latestVersion.getBaseNumber() + 1, 0)
            : new VersionKey(latestVersion.getBaseNumber(), latestVersion.getUpdateNumber() + 1);            
    }
    
    /**
     * @param coreName
     * @param institutionId 
     * @return a list of chronologically sorted version ids for the given institution
     */
    protected List<String> getBaseIds(String coreName, String institutionId) 
    {
    	final List<String> baseIds = listDirectoryNames(archiveConfiguration.getVersionsBasePath(coreName, institutionId));
        Collections.sort(baseIds);
        return baseIds;
    }
    
    /**
     * @param coreName
     * @param institutionId 
     * @param baseId
     * @return a list of chronologically sorted incremental update ids for the given version
     */
    protected List<String> getUpdateIds(String coreName, String institutionId, String baseId) 
    {
        final List<String> updateIds;
        Path updatesBasePath = archiveConfiguration.getUpdatesBasePath(coreName, institutionId, baseId);
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
    
    /* -------- delete archived files --------*/
    
    public void deleteVersion(String coreName, String institutionId, VersionKey version) 
    {
        final Path versionFolder = getVersionFolder(coreName, institutionId, version);
        delete(versionFolder);
    }
        
    /* -------- archive traversal --------*/
    
    /**
     * lists all archived cores while traversing the whole archive 
     * @return list of archived cores
     * @throws ArchiveException 
     */
    public List<ArchiveCoreBean> getArchivedCores()
    {
        final List<ArchiveCoreBean> archivedCores = new ArrayList<>();
        for (String coreName : getCoreNames())
        {
            log.debug("found core: {}", coreName);
            archivedCores.add(buildCoreBean(coreName, true, true));
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
    public List<ArchiveInstitutionBean> getArchivedInstitutions(String coreName, boolean traverseVersions)
    {
        // build parent core 
        ArchiveCoreBean parent = buildCoreBean(coreName, true, traverseVersions);
        
        return parent.getInstitutions();
    }
    
    /**
     * gets an upload version from the archive (without traversing the rest of the archive)
     * @param coreName
     * @param institutionId
     * @param baseId
     * @return 
     * @throws ArchiveException
     */
    public ArchiveBaseVersionBean getArchivedBaseVersion(String coreName, String institutionId, VersionKey versionKey) throws ArchiveException
    {
        return buildBaseVersionBean(coreName, institutionId, versionKey.getBaseId());
    }
    
    protected ArchiveCoreBean buildCoreBean(String coreName, boolean traverseInstitutions, boolean traverseVersions)
    {
        ArchiveCoreBean bean = new ArchiveCoreBean(coreName);
        
        if (traverseInstitutions)
        {
            for (String institutionId : getInstitutionIds(coreName))
            {
                log.debug("found institution: {}", institutionId);
                try
                {
                    ArchiveInstitutionBean archivedInstitution = buildInstitutionBean(coreName, institutionId, traverseVersions);
                    bean.getInstitutions().add(archivedInstitution);
                } catch (Exception e)
                {
                    log.warn("Could not read archived institution {} from core {}", institutionId, coreName, e);
                }
            }
        }
            
        return bean;
    }
    
    protected ArchiveInstitutionBean buildInstitutionBean(String coreName, String institutionId, boolean traverseVersions) 
    {
        IdaInstitutionBean institutionBean = idaInstitutionConverter.convert(institutionId);
        ArchiveInstitutionBean bean = new ArchiveInstitutionBean(institutionBean);
       
        if (traverseVersions)
        {
            // read versions 
            for (String baseId : getBaseIds(coreName, institutionId))
            {
                log.debug("found version: {}", baseId);
                try 
                {
                    bean.getBaseVersions().add(buildBaseVersionBean(coreName, institutionId, baseId));
                } catch (Exception e)
                {
                    log.warn("Could not read archived version {} of institution {} from core {}", baseId, institutionId, coreName, e);
                }
            }
        }
       
        return bean;
    }
    
    protected ArchiveBaseVersionBean buildBaseVersionBean(String coreName, String institutionId, String baseId) throws ArchiveException 
    {  
        final VersionKey versionKey = new VersionKey(baseId);
        final ArchiveBaseVersionBean baseVersionBean = new ArchiveBaseVersionBean(versionKey);
        
        loadVersionProperties(baseVersionBean, coreName, institutionId, versionKey);
        
        // read updates 
        for (String updateId : getUpdateIds(coreName, institutionId, baseId))
        {
            log.debug("found update: {}", updateId);
            final VersionKey updateVersionKey = new VersionKey(baseId, updateId);
            final ArchiveVersionBean updateBean = new ArchiveVersionBean(updateVersionKey);

            loadVersionProperties(updateBean, coreName, institutionId, updateVersionKey);
            
            baseVersionBean.getIncrementalUpdates().add(updateBean);
        }
        
        return baseVersionBean;
    }
    
    protected void loadVersionProperties(ArchiveVersionBean versionBean, String coreName,
            String institutionId, VersionKey versionKey)
            throws ArchiveException
    {
        try
        {
            Path folder = getVersionFolder(coreName, institutionId, versionKey);
            Properties properties = new Properties();
            @Cleanup 
            InputStream in = Files.newInputStream(folder.resolve(VERSION_PROPERTIES)); 
            properties.load(in);
            versionBean.loadProperties(properties, dateFormat);
        } 
        catch (Exception e)
        {
            log.warn("Could not load version.properties for archived version {} of institution {} from core {}",
                    versionKey, institutionId, coreName);
        }
        
        versionBean.setUploadFile(
                findFile(ProcessStep.upload, coreName, institutionId, versionKey));
        versionBean.setWorkingFormatFile(
                findFile(ProcessStep.workingFormat, coreName, institutionId, versionKey));
        versionBean.setSolrFormatFile(
                findFile(ProcessStep.solrFormat, coreName, institutionId, versionKey));
    }
    
    protected void storeVersionProperties(ArchiveVersionBean versionBean, String coreName, 
            String institutionId, VersionKey versionKey) throws IOException
    {
        Path folder = getVersionFolder(coreName, institutionId, versionKey);
        Properties properties = new Properties();
        versionBean.storeProperties(properties, dateFormat);
        @Cleanup 
        OutputStream out = Files.newOutputStream(folder.resolve(VERSION_PROPERTIES));
        properties.store(out, "");
    }
    
    protected List<String> getCoreNames() {
        return listDirectoryNames(archiveConfiguration.getBasePath());
    }
    
    protected List<String> getInstitutionIds(String coreName)
    {
        return listDirectoryNames(archiveConfiguration.getInstitutionsBasePath(coreName));
    }
    
    private Path getVersionFolder(String coreName, String institutionId, VersionKey version)
    {
        return (version.isBaseVersion())
            ? archiveConfiguration.getVersionFolder(coreName, institutionId, version.getBaseId())
            : archiveConfiguration.getUpdateFolder(coreName, institutionId, version.getBaseId(), version.getUpdateId());
    }
    
    private Path getStepFolder(ProcessStep step, String coreName, String institutionId, VersionKey version)
    {
        return (version.isBaseVersion())
            ? archiveConfiguration.getFolder(step, coreName, institutionId, version.getBaseId())
            : archiveConfiguration.getIncrementalFolder(step, coreName, institutionId, version.getBaseId(), version.getUpdateId());
    }
}

