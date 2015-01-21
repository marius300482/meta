package de.idadachverband.transform;

import de.idadachverband.institution.IdaInstitutionBean;

import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;

/**
 * Created by boehm on 13.11.14.
 */
@Named
public class TransformationStrategy implements IdaTransformer
{
    private IdaTransformer transformer;

    @Override
    public File transform(File input, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        transformer = institutionBean.getTransformationStrategy();
        return transformer.transform(input, institutionBean);
    }

    @Override
    public String getTransformationMessages()
    {
        return transformer.getTransformationMessages();
    }
}
