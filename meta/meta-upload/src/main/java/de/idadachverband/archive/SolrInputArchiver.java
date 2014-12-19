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
public class SolrInputArchiver
{
    private final Path archivePath;

    private final ZipService zipService;

    @Getter
    @Setter
    private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd_hhmmss");

    @Getter
    @Setter
    private boolean deleteOld = true;

    @Getter
    @Setter
    private boolean zip = true;

    /**
     * @param archivePath Root of archive
     * @param zipService
     */
    @Inject
    public SolrInputArchiver(Path archivePath, ZipService zipService)
    {
        this.archivePath = archivePath;
        this.zipService = zipService;
    }

    /**
     * @param file            to archive
     * @param solrCoreName    Name of Solr core
     * @param institutionName Name of institution the input file belongs to
     * @return The archived file
     * @throws IOException
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
        final String date = simpleDateFormat.format(new Date());
        return archivePath.resolve(solrServiceName).resolve(institutionName).resolve(date + "-" + file.getName());
    }

}
