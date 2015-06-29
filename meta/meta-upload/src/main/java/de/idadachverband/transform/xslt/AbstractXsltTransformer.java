package de.idadachverband.transform.xslt;

import de.idadachverband.transform.IdaTransformer;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import net.sf.saxon.Configuration;
import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.lib.ErrorGatherer;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.s9api.StaticError;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;

import javax.inject.Inject;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

/**
 * Created by boehm on 15.01.15.
 */
@Slf4j
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public abstract class AbstractXsltTransformer implements IdaTransformer
{

    @Getter
    final private List<StaticError> errorList = new ArrayList<>();
    @Inject
    protected Path archivePath;
    
    @Getter
    final private List<ExtensionFunctionDefinition> extensionFunctions = new ArrayList<>();

    protected AbstractXsltTransformer()
    {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
    }

    protected void transformInstitution(InputStream inputStream, OutputStream outputStream, Path institutionXsl) throws TransformerException
    {
        Transformer transformer = getTransformerInstance(institutionXsl);
        transformer.transform(new StreamSource(inputStream), new StreamResult(outputStream));
        transformer.reset();
    }

    private Transformer getTransformerInstance(Path institutionXslt) throws TransformerConfigurationException
    {
        TransformerFactory factory = TransformerFactory.newInstance();
        if (factory instanceof TransformerFactoryImpl)
        {
            log.debug("XSLT transformer supports extension functions.");
            Configuration config = 
                    ((TransformerFactoryImpl)factory).getConfiguration();
            for (ExtensionFunctionDefinition extensionFunction : extensionFunctions)
            {
                config.registerExtensionFunction(extensionFunction);
                log.debug("Registered XSLT extension function: {}", extensionFunction.getFunctionQName());
            }
        }
        else
        {
            log.warn("XSLT transformer does NOT support extension functions!");
        }
        factory.setErrorListener(new ErrorGatherer(getErrorList()));
        Source xslt = new StreamSource(institutionXslt.toFile());
        return factory.newTransformer(xslt);
    }

    /**
     * @return readable presentation of all errors
     */
    public String getTransformationMessages()
    {
        StringBuilder sb = new StringBuilder();
        for (StaticError e : errorList)
        {
            sb.append(ExceptionUtils.getStackTrace(e.getUnderlyingException()));
        }
        return sb.toString();
    }
    
    public void register(ExtensionFunctionDefinition extensionFunction) 
    {
        this.extensionFunctions.add(extensionFunction);
    }
}
