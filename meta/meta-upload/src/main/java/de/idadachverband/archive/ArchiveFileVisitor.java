package de.idadachverband.archive;

import lombok.Getter;

import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by boehm on 30.10.14.
 */
public class ArchiveFileVisitor extends SimpleFileVisitor<Path>
{
    @Getter
    private final List<Path> paths = new ArrayList<>();

    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
    {
        if (Files.isRegularFile(file))
        {
            paths.add(file);
        }
        return FileVisitResult.CONTINUE;
    }
}
