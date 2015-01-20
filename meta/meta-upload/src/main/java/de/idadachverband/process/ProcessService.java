package de.idadachverband.process;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.result.NotificationException;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.TransformationBean;
import de.idadachverband.transform.TransformationProgressService;
import de.idadachverband.utils.ZipService;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.Future;

/**
 * Created by boehm on 09.10.14.
 */
@Named
@Slf4j
public class ProcessService
{
    @Inject
    private AsyncProcessService asyncProcessService;

    @Inject
    private TransformationProgressService transformationProgressService;

    @Inject
    private ZipService zipService;

    public TransformationBean process(File input, IdaInstitutionBean institution, SolrService solr) throws IOException
    {
        return processFile(zipService.unzip(input), institution, solr);
    }

    private TransformationBean processFile(InputStream input, IdaInstitutionBean institution, SolrService solr)
    {
        TransformationBean transformationBean = new TransformationBean();
        transformationProgressService.add(transformationBean);
        log.debug("====================== Call async method");
        Future<?> voidFuture = null;
        try
        {
            voidFuture = asyncProcessService.processAsynchronous(input, institution, solr, transformationBean);
        } catch (NotificationException e)
        {
            log.error("Failed to notify result of transformation {}", transformationBean, e);
        }
        transformationBean.setFuture(voidFuture);
        log.debug("====================== Async method returned");
        return transformationBean;
    }
}
