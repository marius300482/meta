package de.idadachverband.transform;

import de.idadachverband.institution.IdaInstitutionBean;

import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by boehm on 13.11.14.
 */
public interface IdaTransformer
{
    /**
     * Performs transformation
     *
     * @param input
     * @param institutionBean
     * @return
     * @throws TransformerException
     * @throws IOException
     */
    File transform(InputStream input, IdaInstitutionBean institutionBean) throws TransformerException, IOException;

    String getTransformationMessages();
}
