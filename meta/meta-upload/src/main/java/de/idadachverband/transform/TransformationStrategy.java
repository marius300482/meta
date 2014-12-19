package de.idadachverband.transform;

import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by boehm on 13.11.14.
 */
@Named
public class TransformationStrategy implements IdaTransformer
{
    private IdaTransformer transformer;

    @Override
    public File transform(InputStream input, TransformationBean transformationBean) throws TransformerException, IOException
    {
        transformer = transformationBean.getInstitutionBean().getTransformationStrategy();
        return transformer.transform(input, transformationBean);
    }

    @Override
    public String getTransformationMessages()
    {
        return transformer.getTransformationMessages();
    }
}
