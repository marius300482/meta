package de.idadachverband.archive;

import de.idadachverband.archive.visitor.ArchiveFileVisitor;
import de.idadachverband.utils.ZipService;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by boehm on 19.02.15.
 */
@Slf4j
public class AbstractIdaArchiver
{
    private final ZipService zipService;

    private final SimpleDateFormat dateFormat;

    @Getter
    @Setter
    private boolean zip = true;

    /**
     * @param zipService
     * @param dateFormat
     */
    public AbstractIdaArchiver(ZipService zipService, SimpleDateFormat dateFormat)
    {
        this.zipService = zipService;
        this.dateFormat = dateFormat;
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
        final Path path;
        if (!zip || inputIsZip(input))
        {
            path = targetFolder.resolve(input.getFileName());
            log.info("Zip disabled or file: {} is a zip file. Move to: {}", input, path);
            Files.createDirectories(path.getParent());
            Files.move(input, path);
            log.debug("Moved: {} to:  {}", input, path);
        } else
        {
            path = targetFolder.resolve(input.getFileName() + ".zip");
            log.debug("Create folder (if not exists) for file: {}", path);
            Files.createDirectories(path.getParent());
            zipService.zip(input, path);
            log.debug("Zipped: {} as: {}", input, path);
            Files.deleteIfExists(input);
            log.debug("Deleted: {}", input);
        }
        log.debug("Archived: {} to: {}", input, path);
        return path;
    }

    private boolean inputIsZip(Path input) throws IOException
    {
        final String contentType = Files.probeContentType(input);
        final boolean zipContentType = contentType.contains("zip") || input.endsWith(".zip");
        log.debug("File: {} {} zip file.", input, zipContentType ? "is a" : " is not a");
        return zipContentType;
    }

    /**
     * @param input The archived file. May be zipped or uncompressed.
     * @return path to temporary uncompressed file. Should be deleted on exit of JVM. Rather delete earlier.
     * @throws IOException
     */
    public Path uncompressToTemporaryFile(Path input) throws IOException
    {
        final Path tempDirectory = Files.createTempDirectory("unzip");
        final Path tempFile = Files.createTempFile(tempDirectory, "" + System.currentTimeMillis(), ".xml");

        if (!zip)
        {
            Files.copy(input, tempFile, StandardCopyOption.REPLACE_EXISTING);
        } else
        {
            final Path unzip = zipService.unzip(input);
            Files.move(unzip, tempFile, StandardCopyOption.REPLACE_EXISTING);
        }
        return tempFile;
    }

    private void deleteOldFiles(Path currentPath) throws IOException
    {
        final Path parent = currentPath.getParent();
        final ArchiveFileVisitor archiveFileVisitor = new ArchiveFileVisitor();
        Files.walkFileTree(parent, archiveFileVisitor);
        final List<Path> list = archiveFileVisitor.getPaths();
        for (Path path : list)
        {
            if (!path.equals(currentPath))
            {
                Files.deleteIfExists(path);
            }
        }
    }
}
