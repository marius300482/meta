package de.idadachverband.archive;

import de.idadachverband.archive.visitor.ArchiveFileVisitor;
import de.idadachverband.process.ProcessStep;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by boehm on 25.02.15.
 */
@Slf4j
@Named
public class ArchiveService
{
    private final ArchiveConfiguration archiveConfiguration;

    @Inject
    public ArchiveService(ArchiveConfiguration archiveConfiguration)
    {
        this.archiveConfiguration = archiveConfiguration;
    }

    private ArchiveBean getArchiveBean(Path path, boolean files)
    {
        ArchiveBean archiveBean = new ArchiveBean(path);
        final List<Path> list = findFiles(path, false);
        for (Path folder : list)
        {
            final ArchiveBean bean = new ArchiveBean(folder);
            archiveBean.add(bean, findFiles(path, files));
        }
        return archiveBean;
    }

    public List<Path> findFiles(Path folder, boolean files)
    {
        List<Path> pathList = new ArrayList<>();
        try (final DirectoryStream<Path> paths = Files.newDirectoryStream(folder))
        {
            // Actually it should only be one.
            for (Path path : paths)
            {
                if (shouldBeAdded(files, path))
                {
                    pathList.add(path);
                }
            }
        } catch (IOException e)
        {
            e.printStackTrace();
        }
        return pathList;
    }

    private boolean shouldBeAdded(boolean files, Path path)
    {
        return (files && Files.isRegularFile(path)) ||
                (!files && Files.isDirectory(path));
    }

    public Map<String, List<Path>> findReindexPaths()
    {
        Map<String, List<Path>> reindexPaths = new HashMap<>();
        List<Path> cores = findFiles(archiveConfiguration.getBasePath(), false);
        for (Path core : cores)
        {
            final String fileName = core.getFileName().toString();
            log.debug("add {}", core);
            reindexPaths.put(fileName, findFiles(core, false));
        }
        return reindexPaths;
    }

    public List<Path> findSolrFiles(String coreName) throws IOException
    {
        List<Path> solrFiles = new ArrayList<>();
        final List<Path> institutions = findFiles(archiveConfiguration.getBasePath().resolve(coreName), false);
        for (Path institutionPath : institutions)
        {
            solrFiles.addAll(findSolrFiles(institutionPath.getFileName().toString(), coreName));
        }
        return solrFiles;
    }

    public List<Path> findSolrFiles(String ínstitutionName, String coreName) throws IOException
    {
        List<Path> solrFiles = new ArrayList<>();
        final Path folder = archiveConfiguration.getFolder(ProcessStep.solrFormat, ínstitutionName, coreName);

        // Actually it should only be one.
        solrFiles.addAll(findFiles(folder, true));
        final Path incrementalFolder = archiveConfiguration.getIncrementalFolder(ProcessStep.solrFormat, ínstitutionName, coreName);
        // Add incremental updates later
        if (Files.exists(incrementalFolder))
        {
            final ArchiveFileVisitor archiveFileVisitor = new ArchiveFileVisitor();
            Files.walkFileTree(incrementalFolder, archiveFileVisitor);
            final List<Path> paths = archiveFileVisitor.getPaths();
            for (Path path : paths)
            {
                if (Files.isRegularFile(path))
                {
                    solrFiles.add(path);
                }
            }
        }
        return solrFiles;
    }
}

