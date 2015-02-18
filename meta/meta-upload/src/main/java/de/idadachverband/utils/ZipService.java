package de.idadachverband.utils;

import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.io.*;
import java.net.URI;
import java.nio.file.FileSystem;
import java.nio.file.*;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

/**
 * Utility process to zip and unzip files
 * Created by boehm on 30.10.14.
 */
@Slf4j
@Named
public class ZipService
{

    public Path unzip(final Path input) throws IOException
    {
        @Cleanup FileSystem zipfs = createZipFileSystem(input, false);

        final Path root = zipfs.getPath("/");
        final ZipFileVisitor zipFileVisitor = new ZipFileVisitor(input.getParent());
        Files.walkFileTree(root, zipFileVisitor);

        return zipFileVisitor.getExtractedFilePath();
    }
    /**
     * @param input Either an uncompressed file or a zip archive with one entry
     * @return InputStream of infile. If infile is zip file, first found file from zip file
     */
    @Deprecated
    public File unzip(File input) throws IOException
    {
        if (input.getName().toLowerCase().endsWith(".zip"))
        {
            try
            {
                ZipFile zipFile = new ZipFile(input);
                Enumeration<? extends ZipEntry> entries = zipFile.entries();

                //noinspection LoopStatementThatDoesntLoop
                while (entries.hasMoreElements())
                {
                    ZipEntry zipEntry = entries.nextElement();
                    @Cleanup
                    final InputStream inputStream = zipFile.getInputStream(zipEntry);

                    final File unzipped = new File(stripZipSuffixFromPath(input));
                    if (!unzipped.exists())
                    {
                        unzipped.createNewFile();
                    }
                    @Cleanup
                    final FileOutputStream fileOutputStream = new FileOutputStream(unzipped);

                    writeInputStreamToOutputStream(inputStream, fileOutputStream);

                    // stop after first file
                    return unzipped;
                }
            } catch (ZipException e)
            {
                log.debug("{} is no zip file ", input);
            }
        }
        return input;
    }

    private void writeInputStreamToOutputStream(InputStream inputStream, FileOutputStream fileOutputStream) throws IOException
    {
        byte[] b = new byte[10000];
        while (true)
        {
            int r = inputStream.read(b);
            if (r == -1) break;
            fileOutputStream.write(b, 0, r);
        }
    }

    protected String stripZipSuffixFromPath(File input)
    {
        final String inputPath = input.getPath();
        final int endIndex = inputPath.lastIndexOf(".zip");
        return inputPath.substring(0, endIndex);
    }

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
     * @param infile     The file which should be zipped
     * @param zippedFile The zipped file
     * @throws IOException
     */
    @Deprecated
    public void zip(File infile, File zippedFile) throws IOException
    {
        log.debug("Compressing {} to {}", infile, zippedFile);
        long byteCount = 0;

        try (FileInputStream in = new FileInputStream(infile);
             ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zippedFile)))
        {
            out.putNextEntry(new ZipEntry(infile.getName()));
            byte[] buf = new byte[16000];
            int read;
            while ((read = in.read(buf)) != -1)
            {
                out.write(buf, 0, read);
                byteCount += read;
            }

        } catch (IOException e)
        {
            log.warn("Creation of Zipfile {} of {} failed", zippedFile, infile, e);
            throw e;
        }

        log.debug("read {} bytes", byteCount);
        log.debug("wrote {} bytes", zippedFile.length());
    }

    /**
     * Zips a file. The new filename ist the original with suffix "zip"
     *
     * @param infile The file which should be zipped
     * @return The zipped file.
     * @throws IOException
     */
    public File zip(File infile) throws IOException
    {
        final File zippedFile = new File(infile.getPath() + ".zip");
        zip(infile, zippedFile);
        Files.delete(Paths.get(infile.toURI()));
        return zippedFile;
    }

}
