package de.idadachverband.utils;

import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.nio.file.*;
import java.util.HashMap;
import java.util.Map;

/**
 * Utility process to zip and unzip files
 * Created by boehm on 30.10.14.
 */
@Slf4j
@Named
public class ZipService
{
    /**
     * @param input Either an uncompressed file or a zip archive with one entry
     * @return InputStream of infile. If infile is zip file, first found file from zip file
     */
    public Path unzip(final Path input) throws IOException
    {
        @Cleanup FileSystem zipfs = createZipFileSystem(input, false);

        final Path root = zipfs.getPath("/");
        final ZipFileVisitor zipFileVisitor = new ZipFileVisitor(input.getParent());
        Files.walkFileTree(root, zipFileVisitor);

        final Path extractedFilePath = zipFileVisitor.getExtractedFilePath();
        log.debug("Extracted: {} from archive: {}", extractedFilePath, input);
        return extractedFilePath;
    }

    protected String stripZipSuffixFromPath(File input)
    {
        final String inputPath = input.getPath();
        final int endIndex = inputPath.lastIndexOf(".zip");
        return inputPath.substring(0, endIndex);
    }

    /**
     * @param infile     The file which should be zipped
     * @param zippedFile The zipped file
     * @throws IOException
     */
    public void zip(Path infile, Path zippedFile) throws IOException
    {
        log.debug("Compressing {} to {}", infile, zippedFile);

        @Cleanup FileSystem zipfs = createZipFileSystem(zippedFile, true);

        /* Path inside ZIP File */
        Path pathInZipfile = zipfs.getPath(infile.getFileName().toString());

        /* Add file to archive */
        Files.copy(infile, pathInZipfile);
        log.debug("wrote {} bytes", Files.size(zippedFile));
    }

    private FileSystem createZipFileSystem(Path zipPath,
                                           boolean create)
            throws IOException
    {
        // convert the filename to a URI
        final URI uri = URI.create("jar:file:" + zipPath.toUri().getPath());
        final Map<String, String> env = new HashMap<>();
        if (create)
        {
            env.put("create", "true");
        }
        return FileSystems.newFileSystem(uri, env);
    }

    /**
     * Zips a file. The new filename ist the original with suffix "zip"
     *
     * @param infile The file which should be zipped
     * @return The zipped file.
     * @throws IOException
     */
    public Path zip(Path infile) throws IOException
    {
        final Path zippedFile = Paths.get(infile.toString() + ".zip");
        zip(infile, zippedFile);
        Files.delete(infile);
        return zippedFile;
    }

}
