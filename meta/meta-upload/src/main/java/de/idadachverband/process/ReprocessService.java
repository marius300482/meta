package de.idadachverband.process;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;

import org.apache.solr.client.solrj.SolrServerException;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.archive.bean.ArchiveBaseVersionBean;
import de.idadachverband.archive.bean.VersionOrigin;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobCallable;
import de.idadachverband.job.JobExecutionService;
import de.idadachverband.job.BatchJobBean;
import de.idadachverband.solr.SolrUpdateService;
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
    private SolrUpdateService solrIndexService;
    
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
        final BatchJobBean batchJob = new BatchJobBean();
        batchJob.setJobName(String.format("Re-process archived uploads for all institutions on %s", coreName));
        
        for (ArchiveInstitutionBean archivedInstitution : archiveService.getArchivedInstitutions(coreName, false))
        {
            batchJob.addChildJob(reprocessInstitutionAsync(solr, archivedInstitution.getInstitutionBean()));
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
        return reprocessVersionAsync(solr, institution, 
                archiveService.getLatestVersionKey(solr.getName(), institution.getInstitutionId()));
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
    public ReprocessJobBean reprocessVersionAsync(final SolrService solr, final IdaInstitutionBean institution, 
            final VersionKey version) throws ArchiveException
    {
        log.info("Start re-processing of version: {} for institution: {} on Solr core: {}", 
                version, institution, solr.getName());
        
        ReprocessJobBean reprocessJobBean = new ReprocessJobBean(solr, institution, version);
       
        jobExecutionService.executeAsynchronous(reprocessJobBean, new JobCallable<ReprocessJobBean>()
        {
            @Override
            public void call(ReprocessJobBean jobBean) throws Exception
            {
                List<TransformationBean> transformations =
                        reprocess(solr, institution, version);
                jobBean.getTransformations().addAll(transformations);
            }
        });
        
        return reprocessJobBean;
    }
   
    protected List<TransformationBean> reprocess(SolrService solr, IdaInstitutionBean institution, 
            VersionKey version) throws IOException, SolrServerException, TransformerException, ArchiveException
    {
        // prepare transformation beans
        List<TransformationBean> transformations = new ArrayList<>();
        
        ArchiveBaseVersionBean baseVersionBean = 
                archiveService.getArchivedBaseVersion(solr.getName(), institution.getInstitutionId(), version);
        
        TransformationBean baseTransformation = 
                new TransformationBean(solr, institution, baseVersionBean.getUploadFile(), false);
        baseTransformation.setOriginalVersion(baseVersionBean.getVersion());
        transformations.add(baseTransformation);
        
        for (ArchiveVersionBean updateBean : baseVersionBean.getUpdatesUpTo(version.getUpdateNumber()))
        {
            TransformationBean incrementalTransformation = 
                    new TransformationBean(solr, institution, updateBean.getUploadFile(), true);
            incrementalTransformation.setOriginalVersion(updateBean.getVersion());
            transformations.add(incrementalTransformation);
        }
        
        try
        {
            for (TransformationBean transformationBean : transformations)
            {
                processService.transform(transformationBean);
                solrIndexService.updateSolr(transformationBean, true);
            }

            // archive only after success
            for (TransformationBean transformationBean : transformations)
            {
                archiveService.archive(transformationBean, VersionOrigin.REPROCESS);
            }
        } finally
        {
            for (TransformationBean transformationBean : transformations)
            {
                processService.deleteProcessingFolder(transformationBean.getKey());
            }
        }
        return transformations;
    }
}
