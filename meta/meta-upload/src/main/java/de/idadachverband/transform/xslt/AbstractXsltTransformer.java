package de.idadachverband.transform.xslt;

import de.idadachverband.transform.IdaTransformer;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import net.sf.saxon.lib.ErrorGatherer;
import net.sf.saxon.s9api.StaticError;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;

import javax.inject.Inject;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

    protected AbstractXsltTransformer()
    {
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
    }

    protected void transformInstitution(InputStream inputStream, OutputStream outputStream, File institutionXsl) throws TransformerException
    {
        Transformer transformer = getTransformerInstance(institutionXsl);
        transformer.transform(new StreamSource(inputStream), new StreamResult(outputStream));
    }

    private Transformer getTransformerInstance(File institutionXslt) throws TransformerConfigurationException
    {
        TransformerFactory factory = TransformerFactory.newInstance();
        factory.setErrorListener(new ErrorGatherer(getErrorList()));
        Source xslt = new StreamSource(institutionXslt);
        return factory.newTransformer(xslt);
    }

    protected File getOutputFile(String institutionName, String type) throws IOException
    {
        final Date now = new Date();
        DateFormat df = new SimpleDateFormat("yyyyMMdd-hhmmss");
        final String dateString = df.format(now);

        Files.createDirectories(archivePath.resolve(institutionName));
        final File file = Files.createFile(archivePath.resolve(dateString + "-" + type + ".xml")).toFile();
        log.info("Create {} file {}", type, file);
        return file;
    }

    /**
     * @return readable presentation of all errors
     */
    public String getTransformationMessages()
    {
        StringBuilder sb = new StringBuilder();
        for (StaticError e : errorList)
        {
            sb.append(ExceptionUtils.getFullStackTrace(e.getUnderlyingException()));
        }
        return sb.toString();
    }
}
