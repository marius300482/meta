package de.idadachverband.archive;

import de.idadachverband.process.ProcessStep;
import lombok.Getter;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by boehm on 20.02.15.
 */
@Named
public class ProcessFileConfiguration
{
    @Getter
    final private Path basePath;
    final private String uploadFolder = "upload";
    final private String workingFormatFolder = "workingformat";
    final private String solrFormatFolder = "solr";
    final private String incremental = "incremental";

    @Inject
    public ProcessFileConfiguration(Path processBasePath) throws IOException
    {
        this.basePath = processBasePath;
        Files.createDirectories(this.basePath);
    }

    public Path getPath(String fileName, ProcessStep step, String key)
    {
        final Path folder = getFolder(step, key);
        final Path path = folder.resolve(fileName);

        return path;
    }

    public Path getFolder(ProcessStep step, String key)
    {
        Path path;
        switch (step)
        {
            case upload:
                path = basePath.resolve(key).resolve(uploadFolder);
                break;
            case workingFormat:
                path = basePath.resolve(key).resolve(workingFormatFolder);
                break;
            case solrFormat:
                path = basePath.resolve(key).resolve(solrFormatFolder);
                break;
            default:
                path = basePath.resolve(key);
                break;
        }
        return path;
    }
}
