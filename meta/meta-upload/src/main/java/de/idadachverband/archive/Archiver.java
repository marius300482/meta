package de.idadachverband.archive;

import de.idadachverband.archive.visitor.ArchiveFileVisitor;
import de.idadachverband.archive.visitor.DeletingFileVisitor;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.process.ProcessStep;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

/**
 * Created by boehm on 20.02.15.
 */
@Named
@Slf4j
public class Archiver
{
    final private ProcessFileConfiguration processFileConfiguration;
    final private ArchiveConfiguration archiveConfiguration;

    @Inject
    public Archiver(ProcessFileConfiguration processFileConfiguration, ArchiveConfiguration archiveConfiguration)
    {
        this.processFileConfiguration = processFileConfiguration;
        this.archiveConfiguration = archiveConfiguration;
    }

    public void archive(IdaInstitutionBean institution, TransformationBean transformationBean, String coreName) throws IOException
    {
        final String key = transformationBean.getKey();
        final String institutionName = institution.getInstitutionName();
        final boolean incrementalUpdate = institution.isIncrementalUpdate();

        log.info("Archive transformation: {} for institution: {}", key, institutionName);

        archive(ProcessStep.upload, key, institutionName, coreName, incrementalUpdate);
        archive(ProcessStep.workingFormat, key, institutionName, coreName, incrementalUpdate);
        archive(ProcessStep.solrFormat, key, institutionName, coreName, incrementalUpdate);

        deleteProcessingFolder(key);
    }

    private void deleteProcessingFolder(String key) throws IOException
    {
        final Path resolve = processFileConfiguration.getBasePath().resolve(key);
        Files.walkFileTree(resolve, new DeletingFileVisitor());
    }

    private void archive(ProcessStep step, String key, String institutionName, String coreName, boolean incrementalUpdate) throws IOException
    {
        log.debug("Archive {} transformation: {} for institution: {}", step, key, institutionName);
        final Path source = processFileConfiguration.getFolder(step, key);

        final Path targetPath = getTargetPath(step, institutionName, incrementalUpdate, coreName);
        if (!incrementalUpdate)
        {
            try
            {
                log.info("Delete: {} because it is no incremental update", targetPath);
                delete(targetPath);
            } catch (IOException e)
            {
                log.warn("Failed to delete directory: {}", targetPath, e);
            }
        }
        moveToArchive(source, targetPath);
    }

    private Path getTargetPath(ProcessStep step, String institutionName, boolean incrementalUpdate, String coreName) throws IOException
    {
        Path target;
        if (incrementalUpdate)
        {
            target = archiveConfiguration.getIncrementalFolder(step, institutionName, coreName);
        } else
        {
            target = archiveConfiguration.getFolder(step, institutionName, coreName);
        }
        return target;
    }

    private void delete(Path path) throws IOException
    {
        if (!Files.exists(path))
        {
            return;
        }
        Files.walkFileTree(path, new SimpleFileVisitor<Path>()
        {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException
            {
                Files.delete(file);
                return FileVisitResult.CONTINUE;
            }

            @Override
            public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException
            {
                Files.delete(dir);
                return FileVisitResult.CONTINUE;
            }
        });
    }

    private void moveToArchive(Path source, Path targetPath) throws IOException
    {
        log.debug("Move contents of: {} to folder: {}", source, targetPath);
        Files.createDirectories(targetPath);
        final ArchiveFileVisitor visitor = new ArchiveFileVisitor();
        Files.walkFileTree(source, visitor);
        log.debug("Found files: {} to move.", visitor.getPaths());
        for (Path path : visitor.getPaths())
        {
            final Path targetFile = targetPath.resolve(path.getFileName());
            log.debug("Move: {} to: {}", path, targetFile);
            Files.move(path, targetFile);
        }
    }
}
