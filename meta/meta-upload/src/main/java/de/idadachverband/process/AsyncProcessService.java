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
import java.util.concurrent.Future;

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
        log.debug("**************** In async method");
        AsyncResult<Void> asyncResult = new AsyncResult<>(null);
        try
        {
            File file = idaInputArchiver.archiveFile(input, institution.getInstitutionName());
            File workingFormatFile = transformToWorkingFormat(file, institution);

            file = idaInputArchiver.archiveFile(workingFormatFile, institution.getInstitutionName());
            final File transformedFile = transformToSolrFormat(institution, file);

            file = idaInputArchiver.archiveFile(transformedFile, institution.getInstitutionName());
            transformationBean.setTransformedFile(file);
            upateSolr(solr, transformationBean, file);

        } catch (TransformerException | IOException | SolrServerException e)
        {
            log.warn("Transformation failed: ", e);
            transformationBean.setException(e);
        } finally
        {
            final String transformationMessages1 = transformationStrategy.getTransformationMessages();
            final String transformationMessages = workingFormatTransformer.getTransformationMessages();
            transformationBean.setTransformationMessages(" - Transformation to working format: " + transformationMessages1 + "\n - Transformation to solr format: " + transformationMessages);
            resultMailSender.notify(transformationBean);
        }

        log.debug("**************** End of async method");
        return asyncResult;
    }


    public File transformToWorkingFormat(File inputFile, IdaInstitutionBean institution) throws TransformerException, IOException
    {
        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        return transformationStrategy.transform(unzippedFile, institution);
    }

    public File transformToSolrFormat(IdaInstitutionBean institution, File inputFile) throws TransformerException, IOException
    {
        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        return workingFormatTransformer.transform(unzippedFile, institution);
    }

    public void upateSolr(SolrService solr, TransformationBean transformationBean, File inputFile) throws IOException, SolrServerException
    {
        final File unzippedFile = idaInputArchiver.readArchivedFile(inputFile);
        String solrResult = solr.update(unzippedFile);
        transformationBean.setSolrResponse(solrResult);
        log.debug("Solr result {}", solrResult);
    }

}
