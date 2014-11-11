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
    private final HashedFileService hashedFileService;
    @Getter
    private final Map<String, Path> fileMap = new HashMap<>();

    public HashedFileNameFileVisitor(HashedFileService hashedFileService)
    {
        this.hashedFileService = hashedFileService;
    }

    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
    {
        if (Files.isRegularFile(file))
        {
            fileMap.put(hashedFileService.getHashedFileName(file.toFile()), file);
        }
        return FileVisitResult.CONTINUE;
    }
}
