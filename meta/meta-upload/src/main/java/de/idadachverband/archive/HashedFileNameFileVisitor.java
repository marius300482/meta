package de.idadachverband.archive;

import lombok.Getter;

import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by boehm on 30.10.14.
 */
public class HashedFileNameFileVisitor extends SimpleFileVisitor<Path>
{
    private final HashService hashService;

    @Getter
    private final Map<String, Path> fileMap = new HashMap<>();

    public HashedFileNameFileVisitor(HashService hashService)
    {
        this.hashService = hashService;
    }

    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
    {
        if (Files.isRegularFile(file))
        {
            fileMap.put(hashService.getHashedFileName(file.toFile()), file);
        }
        return FileVisitResult.CONTINUE;
    }
}
