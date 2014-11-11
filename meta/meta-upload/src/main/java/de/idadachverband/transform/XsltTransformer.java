package de.idadachverband.transform;

import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.TimeZone;

/**
 * Transforms XML files to Solr input format.
 * Created by boehm on 17.07.14.
 */
@Slf4j
public class XsltTransformer
{
    final private String gleichXsl;

    /**
     * Implementation class for TransformerFactory is defined in:
     * {@code src/main/resources/META-INF/services/javax.xml.transform.TransformerFactory}
     * Currently @see net.sf.saxon.TransformerFactoryImpl is used because it is the only one that works for me.
     *
     * @param gleichXsl to transform to Ida standard format
     */
    public XsltTransformer(String gleichXsl)
    {
        //System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
        this.gleichXsl = gleichXsl;
    }

    /**
     * Transforms input to to Ida standard format, only stored in temporary file, and then to Solr input xml.
     *
     * @param inputStream    the input XML to be transformed
     * @param institutionXsl XSL for institution corresponding to input XML
     * @return Solr input file. Can be added to Solr via update request
     * @throws TransformerException
     * @throws IOException
     */
    public File transform(final InputStream inputStream, File institutionXsl) throws TransformerException, IOException
    {
        Path tempFile = Files.createTempFile("work-", ".xml");
        log.info("Create temp file {}", tempFile);

        OutputStream out = new FileOutputStream(tempFile.toFile());
        transformInstitution(inputStream, out, institutionXsl);
        log.info("Transformed to Working format");

        @Cleanup
        FileInputStream fileInputStream = new FileInputStream(tempFile.toFile());

        File file = Files.createTempFile("result-", ".xml").toFile();
        file.deleteOnExit();
        log.info("Transform to {}", file);

        @Cleanup
        OutputStream outputStream = new FileOutputStream(file);

        transformGeneric(fileInputStream, outputStream);
        log.info("Transformed to Solr format");

        Files.deleteIfExists(tempFile);
        log.debug("Deleted temp File {}", tempFile);

        return file;
    }

    private void transformInstitution(InputStream inputStream, OutputStream outputStream, File institutionXsl) throws TransformerException, IOException
    {
        Transformer transformer = getTransformerInstance(institutionXsl);
        transformer.transform(new StreamSource(inputStream), new StreamResult(outputStream));
    }

    private void transformGeneric(InputStream inputStream, OutputStream outputStream) throws TransformerException, IOException
    {
        transformInstitution(inputStream, outputStream, new File(gleichXsl));
    }

    private Transformer getTransformerInstance(File institutionXslt) throws TransformerConfigurationException
    {
        TransformerFactory factory = TransformerFactory.newInstance();
        Source xslt = new StreamSource(institutionXslt);
        return factory.newTransformer(xslt);
    }
}