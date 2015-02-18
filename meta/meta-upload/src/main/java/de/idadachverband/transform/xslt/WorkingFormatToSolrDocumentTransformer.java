package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.xml.transform.TransformerException;
import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;

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
        final Path path = getOutputFile(institutionBean.getInstitutionName(), "solr");

        @Cleanup
        InputStream in = new FileInputStream(input.toFile());

        @Cleanup
        OutputStream out = new FileOutputStream(path.toFile());
        transformInstitution(in, out, Paths.get(gleichXsl));
        log.info("Transformed to Solr format");

        return path;
    }

    @Override
    public String getTransformationMessages()
    {
        return null;
    }
}
