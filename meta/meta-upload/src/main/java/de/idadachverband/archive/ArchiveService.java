package de.idadachverband.archive;

import static de.idadachverband.archive.Directories.*;
import de.idadachverband.process.ProcessStep;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.FileNotFoundException;
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
    
    private final SimpleDateFormat dateFormat;

    @Inject
    public ArchiveService(ArchiveConfiguration archiveConfiguration,
                          SimpleDateFormat dateFormat)
    {
        this.archiveConfiguration = archiveConfiguration;
        this.dateFormat = dateFormat;
    }
    
    public Path findFile(ProcessStep step, String coreName, String institutionName, String versionId, String updateId) 
            throws FileNotFoundException
    {
        Path folder = (NO_UPDATE.equals(updateId))
                ? archiveConfiguration.getFolder(step, coreName, institutionName, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionName, versionId, updateId);
        try {
            Path file = Directories.findFirstFile(folder);
            return file;
        } catch (IOException e)
        {
            log.warn("Could not find an archived file in: {}", folder);
            throw new FileNotFoundException(String.format("Could not find an archived file of step: %s for institution: %s version: %s/%s on core: %s", 
                    step, institutionName, versionId, updateId, coreName));
        }
    }
    
    public List<String> getCoreNames() {
        return listDirectoryNames(archiveConfiguration.getBasePath());
    }
    
    public List<String> getInstitutionNames(String coreName)
    {
        return listDirectoryNames(archiveConfiguration.getInstitutionsBasePath(coreName));
    }
    
    /**
     * @param coreName
     * @param institutionName 
     * @return a list of chronologically sorted version ids for the given institution
     */
    public List<String> getVersionIds(String coreName, String institutionName) 
    {
    	final List<String> versionIds = listDirectoryNames(archiveConfiguration.getVersionsBasePath(coreName, institutionName));
        Collections.sort(versionIds);
        return versionIds;
    }
    
    public String getLatestVersionId(String coreName, String institutionName) throws FileNotFoundException 
    {
        final List<String> versionIds = getVersionIds(coreName, institutionName);
        if (versionIds.isEmpty()) {
            log.warn("Found no archived versions for institution: {} in core: {}", institutionName, coreName);
            throw new FileNotFoundException(String.format("Found no archived version for institution: %s in core: %s", 
                    institutionName, coreName)); 
        }
        return versionIds.get(versionIds.size()-1);
    }
    
    public int getVersionNumber(String versionId)
    {
        return parseVersion(versionId, VERSION_PREFIX);
    }
    
    public int getUpdateNumber(String updateId)
    {
        return parseVersion(updateId, UPDATE_PREFIX);
    }
    
    private int parseVersion(String versionId, String prefix) 
    {
        return Integer.parseInt(versionId.substring(prefix.length(), prefix.length() + 4));
    }
    
    public String buildNextVersionId(String coreName, String institutionName) 
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
    public List<String> getUpdateIds(String coreName, String institutionName, String versionId) 
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
    
    public List<String> getUpdateIdsUpTo(String coreName, String institutionName, String versionId, String upToUpdateId)
    {
        final List<String> updateIds = new ArrayList<>();
        if (!NO_UPDATE.equals(upToUpdateId))
        {
            for (String updateId : getUpdateIds(coreName, institutionName, versionId)) 
            {
                updateIds.add(updateId);
                if (updateId.equals(upToUpdateId))
                {
                    //stop here
                    break;
                }
            }
        }
        return updateIds;
    }
    
    public String buildNextUpdateId(String coreName, String institutionName, String versionId) 
    {
        final List<String> updateIds = getUpdateIds(coreName, institutionName, versionId);
        int nextVersion = (updateIds.isEmpty())
                ? 1
                : 1 + parseVersion(updateIds.get(updateIds.size() - 1), UPDATE_PREFIX);
        Date now = new Date();
        return String.format("%s%04d_%s", UPDATE_PREFIX, nextVersion, dateFormat.format(now));
    }
    
    public void clearOldVersions(String institutionName, String coreName) 
    {
    	final List<String> versions = getVersionIds(coreName, institutionName);
    	for (int i=0; i < versions.size() - archiveConfiguration.getMaxArchivedVersions(); i++) 
    	{
    		final String oldVersion = versions.get(i);
    		log.info("Clear old version: {} of institution: {} in core: {}", oldVersion, institutionName, coreName);
    		deleteVersion(coreName, institutionName, oldVersion);
    	}
    }
    
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
    
    public ArchiveBean getArchiveTree()
    {
        final ArchiveBean archiveBean = new ArchiveBean("");
        for (String coreName : getCoreNames())
        {
            log.debug("found core: {}", coreName);
            final ArchiveBean coreBean = new ArchiveBean(coreName);
            archiveBean.add(coreBean);
            
            for (String institutionName : getInstitutionNames(coreName))
            {
                log.debug("found institution: {}", institutionName);
                final ArchiveBean institutionBean = new ArchiveBean(institutionName);
                coreBean.add(institutionBean);
                
                for (String versionId : getVersionIds(coreName, institutionName))
                {
                    log.debug("found version: {}", versionId);
                    
                    final ArchiveUploadBean versionBean = buildVersionBean(coreName, institutionName, versionId);
                    institutionBean.add(versionBean);
                    
                    for (String updateId : getUpdateIds(coreName, institutionName, versionId))
                    {
                        log.debug("found update: {}", updateId);
                        final ArchiveUploadBean updateBean = buildUpdateBean(coreName, institutionName, versionId, updateId);
                        versionBean.add(updateBean);
                    }
                }
            }
        }
        return archiveBean;
    }
    
    private ArchiveUploadBean buildVersionBean(String coreName, String institutionName, String versionId) 
    {
        try{
            int version = parseVersion(versionId, VERSION_PREFIX);
            Date date = dateFormat.parse(versionId.substring(VERSION_PREFIX.length() + 5));
            String uploadFileName = 
                    findFile(ProcessStep.upload, coreName, institutionName, versionId, NO_UPDATE).getFileName().toString();
            return new ArchiveUploadBean(versionId, version, date, uploadFileName);
        } catch (Exception e)
        {
            log.warn("Could not parse version {}/{}/{}", coreName, institutionName, versionId, e);
            throw new RuntimeException(e);
        }
    }
    
    private ArchiveUploadBean buildUpdateBean(String coreName, String institutionName, String versionId, String updateId) 
    {
        try{
            int version = parseVersion(updateId, UPDATE_PREFIX);
            Date date = dateFormat.parse(updateId.substring(UPDATE_PREFIX.length() + 5));
            String uploadFileName = 
                    findFile(ProcessStep.upload, coreName, institutionName, versionId, updateId).getFileName().toString();
            return new ArchiveUploadBean(updateId, version, date, uploadFileName);
        } catch (Exception e)
        {
            log.warn("Could not parse version {}/{}/{}/{}", coreName, institutionName, versionId, updateId, e);
            throw new RuntimeException(e);
        }
    }
}

