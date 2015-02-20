package de.idadachverband.archive;

import de.idadachverband.process.ProcessStep;
import lombok.Getter;

import java.nio.file.Path;

/**
 * Created by boehm on 20.02.15.
 */
public class AbstractArchiveConfiguration
{
    @Getter
    final private Path basePath;
    final private String uploadFolder = "upload";
    final private String workingFormatFolder = "workingformat";
    final private String solrFormatFolder = "solr";
    final private String incremental = "incremental";

    public AbstractArchiveConfiguration(Path path)
    {
        this.basePath = path;
    }

    public Path getPath(String fileName, ProcessStep step, String key)
    {
        final Path folder = getFolder(step, key);
        final Path path = folder.resolve(fileName);

        return path;
    }

    public Path getFolder(ProcessStep step, String key)
    {
        switch (step)
        {
            case upload:
                return basePath.resolve(key).resolve(uploadFolder);
            case workingFormat:
                return basePath.resolve(key).resolve(workingFormatFolder);
            case solrFormat:
                return basePath.resolve(key).resolve(solrFormatFolder);
            default:
                return basePath.resolve(key);
        }
    }

    public Path getIncrementalPath(String fileName, ProcessStep step, String key)
    {
        return getIncrementalFolder(step, key).resolve(fileName);
    }

    public Path getIncrementalFolder(ProcessStep step, String key)
    {
        final Path basePath = getFolder(step, key);
        return basePath.resolve(incremental);
    }
}
