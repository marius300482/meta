package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

/**
 * Created by boehm on 19.02.15.
 */
@Slf4j
public class AbstractIdaArchiver
{
    private final ZipService zipService;

    @Getter
    @Setter
    private boolean zip = true;

    /**
     * @param zipService
     * @param dateFormat
     */
    public AbstractIdaArchiver(ZipService zipService)
    {
        this.zipService = zipService;
    }

    /**
     * @param input
     * @param targetFolder
     * @return
     * @throws java.io.IOException
     */
    public Path archiveFile(Path input, Path targetFolder) throws IOException
    {
        log.debug("Archive file: {} to folder: {}", input, targetFolder);
        Files.createDirectories(targetFolder);
        final Path path;
        if (!zip || inputIsZip(input))
        {
            path = targetFolder.resolve(input.getFileName());
            log.info("Zip disabled or file: {} is a zip file. Copy to: {}", input, path);
            Files.copy(input, path);
            log.debug("Copied: {} to:  {}", input, path);
        } else
        {
            path = targetFolder.resolve(input.getFileName() + ".zip");
            zipService.zip(input, path);
            log.debug("Zipped: {} as: {}", input, path);
        }
        log.debug("Archived: {} to: {}", input, path);
        return path;
    }

    public boolean inputIsZip(Path input) throws IOException
    {
        final String contentType = Files.probeContentType(input);
        final boolean zipContentType = input.toString().endsWith(".zip")
                || (contentType != null && contentType.contains("zip"));
        log.debug("File: {} {} zip file.", input, zipContentType ? "is a" : " is not a");
        return zipContentType;
    }

    /**
     * @param input The archived file. May be zipped or uncompressed.
     * @param targetFolder target for uncompressed file
     * @return path to uncompressed file. Should be deleted on exit of JVM. Rather delete earlier.
     * @throws IOException
     */
    public Path uncompressFile(Path input, Path targetFolder) throws IOException
    {
        Path targetFile;
        Files.createDirectories(targetFolder);

        if (!zip || !inputIsZip(input))
        {
            targetFile = targetFolder.resolve(input.getFileName());
            Files.copy(input, targetFile, StandardCopyOption.REPLACE_EXISTING);
        } else
        {
            targetFile = zipService.unzip(input, targetFolder);
        }
        return targetFile;
    }
    
    /**
     * @param input The archived file. May be zipped or uncompressed.
     * @return path to temporary uncompressed file. Should be deleted on exit of JVM. Rather delete earlier.
     * @throws IOException
     */
    public Path uncompressToTemporaryFile(Path input) throws IOException
    {
        final Path tempFile = Files.createTempFile("ida-unzip-" + System.currentTimeMillis(), ".xml");

        if (!zip || !inputIsZip(input))
        {
            Files.copy(input, tempFile, StandardCopyOption.REPLACE_EXISTING);
        } else
        {
            zipService.unzip(input, tempFile);
        }
        return tempFile;
    }
}
