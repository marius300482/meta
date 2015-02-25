package de.idadachverband.transform;

import de.idadachverband.institution.IdaInstitutionBean;

import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.nio.file.Path;

/**
 * Created by boehm on 13.11.14.
 */
@Named
public class TransformationStrategy implements IdaTransformer
{
    private IdaTransformer transformer;

    @Override
    public void transform(Path input, Path output, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        transformer = institutionBean.getTransformationStrategy();
        transformer.transform(input, output, institutionBean);
    }

    @Override
    public String getTransformationMessages()
    {
        return transformer.getTransformationMessages();
    }
}
