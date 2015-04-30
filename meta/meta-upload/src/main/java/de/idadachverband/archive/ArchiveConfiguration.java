package de.idadachverband.archive;

import de.idadachverband.process.ProcessStep;
import lombok.Getter;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by boehm on 19.02.15.
 */
@Named
class ArchiveConfiguration {

    final private String incrementalFolder = "incremental";
    
    @Getter
    private final Path basePath;
    private final ProcessFileConfiguration processFileConfiguration;
    
    @Getter
    final private int maxArchivedVersions;
    
    @Inject
    public ArchiveConfiguration(Path archivePath, Integer maxArchivedVersions) throws IOException
    {
        this.basePath = archivePath;
        this.processFileConfiguration = new ProcessFileConfiguration(archivePath);
        Files.createDirectories(this.basePath);
        this.maxArchivedVersions = maxArchivedVersions;
    }
    
    public Path getFolder(ProcessStep step, String coreName, String institutionName, String versionId)
    {
        return checkPath(processFileConfiguration.getFolder(step, Paths.get(coreName, institutionName, versionId).toString()));
    }
    
    public Path getIncrementalFolder(ProcessStep step, String coreName, String institutionName, String versionId, String updateId)
    {
        return checkPath(processFileConfiguration.getFolder(step, 
                Paths.get(coreName, institutionName, versionId, incrementalFolder, updateId).toString()));
    }
    
    public Path getInstitutionsBasePath(String coreName)
    {
        return checkPath(basePath.resolve(coreName));
    }
    
    public Path getVersionsBasePath(String coreName, String institutionName) 
    {
    	return checkPath(basePath.resolve(coreName).resolve(institutionName));
    }
    
    public Path getVersionFolder(String coreName, String institutionName, String versionId)
    {
        return checkPath(basePath.resolve(coreName).resolve(institutionName).resolve(versionId));
    }
    
    public Path getUpdatesBasePath(String coreName, String institutionName, String versionId) 
    {
        return checkPath(basePath.resolve(coreName).resolve(institutionName).resolve(versionId).resolve(incrementalFolder));
    }
    
    public Path getUpdateFolder(String coreName, String institutionName, String versionId, String updateId) 
    {
        return checkPath(basePath.resolve(coreName).resolve(institutionName).resolve(versionId).resolve(incrementalFolder).resolve(updateId));
    }
 
    
    public Path checkPath(Path path) 
    {
        final Path normalizedPath = path.normalize();
        if (!normalizedPath.startsWith(basePath)) 
        {
            throw new IllegalArgumentException("Path: " + path + " points out of archive directory!");
        }
        return path;
    }
}