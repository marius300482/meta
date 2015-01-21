package de.idadachverband.utils;

import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Enumeration;
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
    /**
     * @param input Either an uncompressed file or a zip archive with one entry
     * @return InputStream of infile. If infile is zip file, first found file from zip file
     */
    public File unzip(File input) throws IOException
    {
        if (input.getName().toLowerCase().endsWith(".zip"))
        {
            try
            {
                ZipFile zipFile = new ZipFile(input);
                Enumeration<? extends ZipEntry> entries = zipFile.entries();

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

                    writeInputStreamToOutputstream(inputStream, fileOutputStream);

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

    private void writeInputStreamToOutputstream(InputStream inputStream, FileOutputStream fileOutputStream) throws IOException
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


    /**
     * @param infile     The file which should be zipped
     * @param zippedFile The zipped file
     * @throws IOException
     */
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
