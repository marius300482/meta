package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.nio.file.Path;

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
    public void transform(Path input, Path output, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        transform(input, output, institutionBean.getTransformationRecipeFile());
        log.info("Transformed to Working format");
    }
}