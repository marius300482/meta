package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.xml.transform.TransformerException;
import java.io.*;

/**
 * Created by boehm on 15.01.15.
 */
@Slf4j
public class WorkingFormatToSolrDocumentTransformer extends AbstractXsltTransfomer
{
    final private String gleichXsl;

    public WorkingFormatToSolrDocumentTransformer(String gleichXsl)
    {
        this.gleichXsl = gleichXsl;
    }

    @Override
    public File transform(InputStream input, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        final File file = getOutputFile(institutionBean.getInstitutionName(), "solr");

        @Cleanup
        OutputStream out = new FileOutputStream(file);
        transformInstitution(input, out, new File(gleichXsl));
        log.info("Transformed to Solr format");

        return file;
    }

    @Override
    public String getTransformationMessages()
    {
        return null;
    }
}
