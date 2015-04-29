package de.idadachverband.process;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;

import org.apache.solr.client.solrj.SolrServerException;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.bean.ArchiveUpdateBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobCallable;
import de.idadachverband.job.JobExecutionService;
import de.idadachverband.job.BatchJobBean;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author rpr
 *
 */
@Named
@Slf4j
public class ReprocessService
{
    @Inject
    private ProcessService processService;
    
    @Inject
    private ArchiveService archiveService;
    
    @Inject
    private JobExecutionService jobExecutionService;
    
    
    /**
     * Asynchronously re-processes latest uploads of all institution in a Solr core 
     * @param solr
     * @return batch job waiting for all re-processes jobs (one job per institution)
     * @throws ArchiveException
     */
    public BatchJobBean reprocessCoreAsync(SolrService solr) throws ArchiveException
    {
        final String coreName = solr.getName();
        final BatchJobBean batchJob = new BatchJobBean(String.format("Re-process archived uploads for all institutions on %s", coreName));
        for (IdaInstitutionBean institution : archiveService.findArchivedInstitutions(coreName))
        {
            batchJob.addChildJob(reprocessInstitutionAsync(solr, institution));
        }
        jobExecutionService.executeBatchAsynchronous(batchJob);
        return batchJob;
    }
    
    /**
     * Asynchronously re-processes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return the bean of the enqueued re-process job
     * @throws ArchiveException
     */
    public ReprocessJobBean reprocessInstitutionAsync(SolrService solr, IdaInstitutionBean institution) throws ArchiveException
    {
        return reprocessVersionAsync(solr, institution, ArchiveService.LATEST_VERSION, ArchiveService.LATEST_UPDATE);
    }
    
    /**
     * Asynchronously re-processes a given upload version (up to a given incremental update) of an institution in a Solr core
     * @param solr
     * @param institution
     * @param versionId
     * @param upToUpdateId
     * @return the bean of the enqueued re-process job
     * @throws ArchiveException
     */
    public ReprocessJobBean reprocessVersionAsync(SolrService solr, IdaInstitutionBean institution, String versionId, String upToUpdateId) throws ArchiveException
    {
        log.info("Start re-processing of version: {}.{} for institution: {} on Solr core: {}", 
                versionId, upToUpdateId, institution.getInstitutionName(), solr.getName());
        
        ArchiveVersionBean versionBean = archiveService.getVersion(solr.getName(), institution.getInstitutionName(), versionId);
        ReprocessJobBean reprocessJobBean = 
                new ReprocessJobBean(solr, institution, versionBean.getUploadFile(), versionBean.getVersionNumber());
        
        for (ArchiveUpdateBean updateBean : versionBean.getUpdatesUpTo(upToUpdateId))
        {
            reprocessJobBean.addIncrementalTransformation(updateBean.getUploadFile(), updateBean.getUpdateNumber());
        }
        
        jobExecutionService.executeAsynchronous(reprocessJobBean, new JobCallable<ReprocessJobBean>()
        {
            @Override
            public void call(ReprocessJobBean jobBean) throws Exception
            {
                reprocess(jobBean);
            }
        });
        
        return reprocessJobBean;
    }
    
    private void reprocess(ReprocessJobBean jobBean) throws IOException, SolrServerException, TransformerException, ArchiveException
    {
        List<TransformationBean> transformations = jobBean.getTransformations();
        try
        {
            for (TransformationBean transformationBean : transformations)
            {
                processService.transform(transformationBean);
                processService.updateSolr(transformationBean);
            }

            // archive only after success
            for (TransformationBean transformationBean : transformations)
            {
                archiveService.archive(transformationBean);
            }
        } finally
        {
            for (TransformationBean transformationBean : transformations)
            {
                processService.deleteProcessingFolder(transformationBean.getKey());
            }
            // do not delete archived transformation input
        }
        
    }
}
