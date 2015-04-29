package de.idadachverband.archive.visitor;

import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

@Slf4j
public class DeletingFileVisitor extends SimpleFileVisitor<Path>
{
    public static final DeletingFileVisitor INSTANCE = new DeletingFileVisitor();
    
    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attributes)
            throws IOException
    {
        if (attributes.isRegularFile())
        {
            log.debug("Deleting Regular File: {}", file.getFileName());
            Files.delete(file);
        }
        return FileVisitResult.CONTINUE;
    }

    @Override
    public FileVisitResult postVisitDirectory(Path directory, IOException e)
            throws IOException
    {
        log.debug("Deleting Directory: {}", directory.getFileName());
        Files.delete(directory);
        return FileVisitResult.CONTINUE;
    }

    @Override
    public FileVisitResult visitFileFailed(Path file, IOException e)
            throws IOException
    {
        log.warn("Something went wrong while working on: {}", file.getFileName(), e);
        return FileVisitResult.CONTINUE;
    }
}