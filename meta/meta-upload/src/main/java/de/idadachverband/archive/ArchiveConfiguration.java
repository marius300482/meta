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
class ArchiveConfiguration
{
    @Getter
    private final Path basePath;
    private final ProcessFileConfiguration processFileConfiguration;

    @Inject
    public ArchiveConfiguration(Path archivePath) throws IOException
    {
        this.basePath = archivePath;
        this.processFileConfiguration = new ProcessFileConfiguration(archivePath);
        Files.createDirectories(this.basePath);
    }

    public Path getFolder(ProcessStep step, String institution, String coreName)
    {
        return processFileConfiguration.getFolder(step, Paths.get(coreName, institution).toString());
    }

    public Path getIncrementalFolder(ProcessStep step, String institutionName, String coreName)
    {
        return getFolder(step, institutionName, coreName).resolve("incremental");
    }
}