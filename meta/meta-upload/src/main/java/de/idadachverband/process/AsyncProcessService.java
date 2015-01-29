package de.idadachverband.process;

import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.result.NotificationException;
import de.idadachverband.result.ResultNotifier;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.IdaTransformer;
import de.idadachverband.transform.TransformationBean;
import de.idadachverband.transform.xslt.WorkingFormatToSolrDocumentTransformer;
import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.concurrent.Future;

import static org.apache.solr.client.solrj.impl.HttpSolrServer.RemoteSolrException;

/**
 * Created by boehm on 08.10.14.
 */
@Named
@Slf4j
public class AsyncProcessService
{
    final private IdaTransformer transformationStrategy;

    final private ResultNotifier resultMailSender;

    final private IdaInputArchiver idaInputArchiver;

    final private WorkingFormatToSolrDocumentTransformer workingFormatTransformer;

    @Inject
    public AsyncProcessService(IdaTransformer transformationStrategy, WorkingFormatToSolrDocumentTransformer workingFormatTransformer, ResultNotifier resultMailSender, IdaInputArchiver idaInputArchiver)
    {
        this.transformationStrategy = transformationStrategy;
        this.resultMailSender = resultMailSender;
        this.idaInputArchiver = idaInputArchiver;
        this.workingFormatTransformer = workingFormatTransformer;
    }

    @Async
    public Future<Void> processAsynchronous(File input, IdaInstitutionBean institution, SolrService solr, TransformationBean transformationBean) throws NotificationException
    {
        log.debug("Start asynchronous processing of: {}", transformationBean);
        AsyncResult<Void> asyncResult = new AsyncResult<>(null);
        try
        {
            File file = idaInputArchiver.archiveFile(input, institution.getInstitutionName());
            File workingFormatFile = transformToWorkingFormat(file, institution);

            file = idaInputArchiver.archiveFile(workingFormatFile, institution.getInstitutionName());
            final File transformedFile = transformToSolrFormat(institution, file);

            file = idaInputArchiver.archiveFile(transformedFile, institution.getInstitutionName());
            transformationBean.setTransformedFile(file);
            upateSolr(solr, transformationBean, file, institution.getInstitutionName());

        } catch (TransformerException | IOException | SolrServerException | RemoteSolrException e)
        {
            log.warn("Transformation failed: ", e);
            transformationBean.setException(e);
        } finally
        {
            transformationBean.setEndTime(new Date());
            final String transformationMessagesFromUpload = transformationStrategy.getTransformationMessages();
            final String transformationMessagesToSolrFormat = workingFormatTransformer.getTransformationMessages();
            transformationBean.setTransformationMessages(" - Transformation to working format: " + transformationMessagesFromUpload + "\n - Transformation to solr format: " + transformationMessagesToSolrFormat);
            resultMailSender.notify(transformationBean);
        }

        log.debug("* End of asynchronous processing of: {}", transformationBean);
        return asyncResult;
    }


    public File transformToWorkingFormat(File inputFile, IdaInstitutionBean institution) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to working format", inputFile, institution);
        final long start = System.currentTimeMillis();
        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        final File transformedFile = transformationStrategy.transform(unzippedFile, institution);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to working format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return transformedFile;
    }

    public File transformToSolrFormat(IdaInstitutionBean institution, File inputFile) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to Solr format", inputFile, institution);
        final long start = System.currentTimeMillis();
        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        final File transformedFile = workingFormatTransformer.transform(unzippedFile, institution);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to Solr format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return transformedFile;
    }

    public void upateSolr(SolrService solr, TransformationBean transformationBean, File inputFile, String institutionName) throws IOException, SolrServerException
    {
        log.info("Start Solr update of core: {} for: {} with file: {}", solr, institutionName, inputFile);
        final long start = System.currentTimeMillis();

        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        solr.deleteInstitution(institutionName);

        String solrResult = solr.update(unzippedFile);
        transformationBean.setSolrResponse(solrResult);

        final long end = System.currentTimeMillis();
        log.info("Solr update of core: {} for: {} with file: {} took: {} seconds.", solr, institutionName, inputFile, (end - start) / 1000);

        log.debug("Solr result {}", solrResult);
    }

}
