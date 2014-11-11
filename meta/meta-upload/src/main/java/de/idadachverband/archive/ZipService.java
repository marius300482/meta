package de.idadachverband.archive;

import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.io.*;
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
     * @return InputStream of input. If input is zip file, first found file from zip file
     */
    public InputStream unzip(File input) throws IOException
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
                    return zipFile.getInputStream(zipEntry);
                }
            } catch (ZipException e)
            {
                log.debug("{} is no zip file ", input);
            }
        }
        return new FileInputStream(input);
    }


    /**
     * @param infile     File which should be zipped
     * @param zippedFile
     * @return Zipped file
     * @throws IOException
     */
    public void zip(File infile, File zippedFile) throws IOException
    {
        log.debug("Compressing {} to {}", infile, zippedFile);
        long byteCount = 0;

        try (FileInputStream in = new FileInputStream(infile);
             ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zippedFile));)
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

}
