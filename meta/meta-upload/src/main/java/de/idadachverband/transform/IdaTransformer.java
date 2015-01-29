package de.idadachverband.transform;

import de.idadachverband.institution.IdaInstitutionBean;

import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;

/**
 * Created by boehm on 13.11.14.
 */
public interface IdaTransformer
{
    /**
     * Performs transformation
     *
     * @param input           The input file which should be transformed
     * @param institutionBean Bean which holds information about the institution.
     * @return The transformed File
     * @throws TransformerException
     * @throws IOException
     */
    File transform(File input, IdaInstitutionBean institutionBean) throws TransformerException, IOException;

    /**
     * Used to present potential errors and warnings to the user.
     *
     * @return Errors and warnings gathered during transformation.
     */

    String getTransformationMessages();
}
