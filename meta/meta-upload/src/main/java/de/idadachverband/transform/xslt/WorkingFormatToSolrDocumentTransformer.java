package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

/**
 * Created by boehm on 15.01.15.
 */
@Slf4j
public class WorkingFormatToSolrDocumentTransformer extends AbstractXsltTransformer
{
    final private String gleichXsl;

    public WorkingFormatToSolrDocumentTransformer(String gleichXsl)
    {
        this.gleichXsl = gleichXsl;
    }

    @Override
    public Path transform(Path input, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        final Path outputFile = getOutputFile(institutionBean.getInstitutionName(), "solr");

        try
        {
            @Cleanup
            InputStream in = Files.newInputStream(input, StandardOpenOption.READ);
            @Cleanup
            OutputStream out = Files.newOutputStream(outputFile, StandardOpenOption.CREATE, StandardOpenOption.WRITE);

            transformInstitution(in, out, Paths.get(gleichXsl));
        } catch (UnsupportedOperationException e)
        {
            log.warn("Transformation failed", e);
            throw e;
        }

        log.info("Transformed to Solr format");
        return outputFile;
    }

    @Override
    public String getTransformationMessages()
    {
        return null;
    }
}
