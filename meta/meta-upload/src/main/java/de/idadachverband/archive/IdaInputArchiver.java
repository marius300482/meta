package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
    public File archiveFile(File input, String institutionName) throws IOException
    {
        if (!zip)
        {
            log.debug("Compression disabled for file: {}", input);
            return input;
        } else
        {
            if (inputIsZip(input))
            {
                final Path target = getArchivePathOfInstitution(institutionName).resolve(input.getName());
                log.info("File: {} is a zip file. Move to: {}", input, target);
                Files.createDirectories(target.getParent());
                Files.move(input.toPath(), target);
                return target.toFile();
            } else
            {
                Path path = getArchivePathOfInstitution(institutionName).resolve(input.getName() + ".zip");
                log.debug("Create folder (if not exists) for file: {}", path);
                Files.createDirectories(path.getParent());
                zipService.zip(input, path.toFile());
                input.delete();
                return path.toFile();
            }
        }
    }

    private boolean inputIsZip(File input) throws IOException
    {
        final String contentType = Files.probeContentType(input.toPath());
        return contentType.contains("zip") || input.getName().toLowerCase().endsWith(".zip");
    }

    protected Path getArchivePathOfInstitution(String institutionName)
    {
        return archivePath.resolve(institutionName);
    }

    public File readArchivedFile(File input) throws IOException
    {
        if (!zip)
        {
            return input;
        } else
        {
            return zipService.unzip(input);
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
    public File saveSolrFile(File file, String solrCoreName, String institutionName) throws IOException
    {
        final Path filename = getFilename(file, solrCoreName, institutionName);
        Files.createDirectories(filename.getParent());
        final File compressedFile;
        if (isZip())
        {
            final String zipFileName = filename.toAbsolutePath() + ".zip";
            compressedFile = Paths.get(zipFileName).toFile();
            zipService.zip(file, compressedFile);
        } else
        {
            final Path copy = Files.copy(Paths.get(file.getAbsolutePath()), getFilename(file, solrCoreName, institutionName));
            compressedFile = copy.toFile();
        }
        if (this.isDeleteOld())
        {
            deleteOldFiles(compressedFile);
        }
        return compressedFile;
    }

    private void deleteOldFiles(File currentFile) throws IOException
    {
        final Path currentPath = Paths.get(currentFile.getAbsolutePath());
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

    private Path getFilename(File file, String solrServiceName, String institutionName)
    {
        final String date = dateFormat.format(new Date());
        return archivePath.resolve(solrServiceName).resolve(institutionName).resolve(date + "-" + file.getName());
    }

}
