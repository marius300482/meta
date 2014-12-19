package de.idadachverband.process;

import de.idadachverband.archive.SolrInputArchiver;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.result.NotificationException;
import de.idadachverband.result.ResultNotifier;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.IdaTransformer;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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

    final private SolrInputArchiver solrInputArchiver;

    @Inject
    public AsyncProcessService(IdaTransformer transformationStrategy, ResultNotifier resultMailSender, SolrInputArchiver solrInputArchiver)
    {
        this.transformationStrategy = transformationStrategy;
        this.resultMailSender = resultMailSender;
        this.solrInputArchiver = solrInputArchiver;
    }

    @Async
    public Future<Void> processAsynchronous(InputStream input, IdaInstitutionBean institution, SolrService solr, TransformationBean transformationBean) throws NotificationException
    {
        log.debug("**************** In async method");
        AsyncResult<Void> asyncResult = new AsyncResult<>(null);
        try
        {
            File transformedFile = transformationStrategy.transform(input, transformationBean);
            final File archivedFile = solrInputArchiver.saveSolrFile(transformedFile, solr.getName(), institution.getName());
            transformationBean.setTransformedFile(archivedFile);
            String solrResult = solr.update(transformedFile);
            transformationBean.setSolrResponse(solrResult);
            log.debug("Solr result {}", solrResult);

        } catch (TransformerException | IOException | SolrServerException e)
        {
            log.warn("Transformation failed: ", e);
            transformationBean.setException(e);
        } finally
        {
            transformationBean.setTransformationMessages(transformationStrategy.getTransformationMessages());
            resultMailSender.notify(transformationBean);
        }

        log.debug("**************** End of async method");
        return asyncResult;
    }

}
