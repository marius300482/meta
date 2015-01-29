package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.*;

/**
 * Transforms XML files to Solr input format.
 * Created by boehm on 17.07.14.
 */
@Slf4j
@Named
public class XsltTransformer extends AbstractXsltTransformer
{
    /**
     * Implementation class for TransformerFactory is defined in:
     * {@code src/main/resources/META-INF/services/javax.xml.transform.TransformerFactory}
     * Currently @see net.sf.saxon.TransformerFactoryImpl is used because it is the only one that works for me.
     */
    public XsltTransformer()
    {
        //System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
    }

    @Override
    public File transform(File input, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        return transform(input, institutionBean.getTransformationRecipeFile(), institutionBean.getInstitutionName());
    }

    /**
     * Transforms input to to Ida standard format, only stored in temporary file, and then to Solr input xml.
     *
     * @param input           the input XML to be transformed
     * @param institutionXsl  XSL for institution corresponding to input XML
     * @param institutionName
     * @return Solr input file. Can be added to Solr via update request
     * @throws TransformerException
     * @throws IOException
     */
    private File transform(final File input, File institutionXsl, String institutionName) throws TransformerException, IOException
    {
        final File file = getOutputFile(institutionName, "workingformat");

        @Cleanup
        InputStream in = new FileInputStream(input);

        @Cleanup
        OutputStream out = new FileOutputStream(file);
        transformInstitution(in, out, institutionXsl);
        log.info("Transformed to Working format");

        return file;
    }
}