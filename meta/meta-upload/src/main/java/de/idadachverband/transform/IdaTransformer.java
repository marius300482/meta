package de.idadachverband.transform;

import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by boehm on 13.11.14.
 */
public interface IdaTransformer
{
    File transform(InputStream input, TransformationBean transformationBean) throws TransformerException, IOException;

    String getTransformationMessages();
}
