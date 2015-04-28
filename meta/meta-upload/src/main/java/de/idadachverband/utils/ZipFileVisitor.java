package de.idadachverband.utils;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;

/**
 * Created by boehm on 18.02.15.
 */
@Slf4j
class ZipFileVisitor extends SimpleFileVisitor<Path>
{
    private Path destinationPath;
    @Getter
    private Path extractedFilePath;

    ZipFileVisitor(Path destinationPath)
    {
        this.destinationPath = destinationPath;
    }

    @Override
    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException
    {
        log.debug("Try to extract {}", file);
        final Path destFile = (Files.isDirectory(destinationPath))
                ? destinationPath.resolve(file.getFileName().toString())
                : destinationPath;
        log.info("Extracting file {} to {}", file, destFile);
        Files.copy(file, destFile, StandardCopyOption.REPLACE_EXISTING);
        // Stop after first file
        extractedFilePath = destFile;
        return FileVisitResult.TERMINATE;
    }
}
