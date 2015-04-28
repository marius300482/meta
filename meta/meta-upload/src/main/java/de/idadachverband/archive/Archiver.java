package de.idadachverband.archive;

import de.idadachverband.process.ProcessStep;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.IOException;
import java.nio.file.Path;
import java.text.SimpleDateFormat;

/**
 * Created by boehm on 20.02.15.
 */
@Named
@Slf4j
public class Archiver
{
    final private ProcessFileConfiguration processFileConfiguration;
    
    final private ArchiveConfiguration archiveConfiguration;
    
    final private ArchiveService archiveService;
    
    final private IdaInputArchiver idaInputArchiver;

    @Inject
    public Archiver(ProcessFileConfiguration processFileConfiguration, ArchiveConfiguration archiveConfiguration, 
                    ArchiveService archiveService, IdaInputArchiver idaInputArchiver, SimpleDateFormat dateFormat)
    {
        this.processFileConfiguration = processFileConfiguration;
        this.archiveConfiguration = archiveConfiguration;
        this.archiveService = archiveService;
        this.idaInputArchiver = idaInputArchiver;
    }

    public void archive(TransformationBean transformationBean) throws IOException
    {
        final String key = transformationBean.getKey();
        final String coreName = transformationBean.getCoreName();
        final String institutionName = transformationBean.getInstitutionName();
        final boolean incrementalUpdate = transformationBean.isIncrementalUpdate();
        
        final String versionId = (incrementalUpdate) 
                ? archiveService.getLatestVersionId(coreName, institutionName)
        		: archiveService.buildNextVersionId(coreName, institutionName);
        final String updateId = (incrementalUpdate)
                ? archiveService.buildNextUpdateId(coreName, institutionName, versionId)
                : ArchiveService.NO_UPDATE;
                
        transformationBean.setArchivedVersionId(versionId);
        transformationBean.setArchivedUpdateId(updateId);

        log.info("Archive transformation: {} for institution: {} using version: {}/{}", key, institutionName, versionId, updateId);

        archive(ProcessStep.upload, key, institutionName, coreName, versionId, updateId);
        archive(ProcessStep.workingFormat, key, institutionName, coreName, versionId, updateId);
        archive(ProcessStep.solrFormat, key, institutionName, coreName, versionId, updateId);

        archiveService.clearOldVersions(institutionName, coreName);   
    }

    private Path archive(ProcessStep step, String key, String institutionName, String coreName, String versionId, String updateId) throws IOException
    {
        log.debug("Archive {} transformation: {} for institution: {} using version: {}/{}", step, key, institutionName, versionId, updateId);
        final Path sourcePath = Directories.findFirstFile(processFileConfiguration.getFolder(step, key));

        final Path targetFolder = (updateId.equals(ArchiveService.NO_UPDATE))	
                ? archiveConfiguration.getFolder(step, coreName, institutionName, versionId)
                : archiveConfiguration.getIncrementalFolder(step, coreName, institutionName, versionId, updateId);		
        
        return idaInputArchiver.archiveFile(sourcePath, targetFolder);
    }
}
