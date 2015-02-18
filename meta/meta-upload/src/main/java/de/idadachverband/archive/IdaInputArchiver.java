package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Archives Solr input files. By default zipped and historic files will be deleted.
 * Created by boehm on 30.10.14.
 */
@Named
@Slf4j
public class IdaInputArchiver
{
    private final Path archivePath;

    private final ZipService zipService;

    private final SimpleDateFormat dateFormat;

    @Getter
    @Setter
    private boolean deleteOld = true;

    @Getter
    @Setter
    private boolean zip = true;

    /**
     * @param archivePath Root of archive
     * @param zipService
     * @param dateFormat
     */
    @Inject
    public IdaInputArchiver(Path archivePath, ZipService zipService, SimpleDateFormat dateFormat)
    {
        this.archivePath = archivePath;
        this.zipService = zipService;
        this.dateFormat = dateFormat;
    }

    /**
     * @param input
     * @param institutionName
     * @return
     * @throws IOException
     */
    public Path archiveFile(Path input, String institutionName) throws IOException
    {
        if (!zip)
        {
            log.debug("Compression disabled for file: {}", input);
            return input;
        } else
        {
            if (inputIsZip(input))
            {
                final Path target = getArchivePathOfInstitution(institutionName).resolve(input.getFileName());
                log.info("File: {} is a zip file. Move to: {}", input, target);
                Files.createDirectories(target.getParent());
                Files.move(input, target);
                return target;
            } else
            {
                Path path = getArchivePathOfInstitution(institutionName).resolve(input.getFileName() + ".zip");
                log.debug("Create folder (if not exists) for file: {}", path);
                Files.createDirectories(path.getParent());
                zipService.zip(input, path);
                Files.deleteIfExists(input);
                return path;
            }
        }
    }

    private boolean inputIsZip(Path input) throws IOException
    {
        final String contentType = Files.probeContentType(input);
        return contentType.contains("zip") || input.endsWith(".zip");
    }

    protected Path getArchivePathOfInstitution(String institutionName)
    {
        return archivePath.resolve(institutionName);
    }

    /**
     * @param input
     * @return
     * @throws IOException
     */
    public Path readArchivedFile(Path input) throws IOException
    {
        if (!zip)
        {
            return input;
        } else
        {
            final Path unzip = zipService.unzip(input);
            final Path tempDirectory = Files.createTempDirectory("unzip");
            final Path tempFile = Files.createTempFile(tempDirectory, "" + System.currentTimeMillis(), null);
            Files.move(unzip, tempFile, StandardCopyOption.REPLACE_EXISTING);
            return tempFile;
        }
    }

    /**
     * @param file            to archive
     * @param solrCoreName    Name of Solr core
     * @param institutionName Name of institution the input file belongs to
     * @return The archived file
     * @throws IOException
     * @deprecated
     */
    public Path saveSolrFile(Path file, String solrCoreName, String institutionName) throws IOException
    {
        final Path filename = getFilename(file, solrCoreName, institutionName);
        Files.createDirectories(filename.getParent());
        final Path compressedFile;
        if (isZip())
        {
            final String zipFileName = filename.toAbsolutePath() + ".zip";
            compressedFile = Paths.get(zipFileName);
            zipService.zip(file, compressedFile);
        } else
        {
            compressedFile = Files.copy(file, getFilename(file, solrCoreName, institutionName));
        }
        if (this.isDeleteOld())
        {
            deleteOldFiles(compressedFile);
        }
        return compressedFile;
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

    private Path getFilename(Path path, String solrServiceName, String institutionName)
    {
        final String date = dateFormat.format(new Date());
        return archivePath.resolve(solrServiceName).resolve(institutionName).resolve(date + "-" + path.toString());
    }

}
