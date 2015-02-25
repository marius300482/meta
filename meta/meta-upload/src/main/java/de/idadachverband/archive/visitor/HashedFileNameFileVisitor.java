package de.idadachverband.archive.visitor;

import de.idadachverband.archive.HashService;
import lombok.Getter;

import javax.inject.Inject;
import javax.inject.Named;
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
@Named
public class HashedFileNameFileVisitor extends SimpleFileVisitor<Path>
{
    private final HashService hashService;

    @Getter
    private final Map<String, Path> fileMap = new HashMap<>();

    @Inject
    public HashedFileNameFileVisitor(HashService hashService)
    {
        this.hashService = hashService;
    }

    @Override
    public FileVisitResult visitFile(Path path, BasicFileAttributes attr)
    {
        if (Files.isRegularFile(path))
        {
            fileMap.put(hashService.getHashedFileName(path), path);
        }
        return FileVisitResult.CONTINUE;
    }
}
