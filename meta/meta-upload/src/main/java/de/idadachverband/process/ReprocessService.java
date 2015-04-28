package de.idadachverband.process;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Path;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;

import org.apache.solr.client.solrj.SolrServerException;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.Archiver;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
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
    private Archiver archiver;
    
    @Inject
    private JobExecutionService jobExecutionService;
    
    @Inject
    private IdaInstitutionConverter idaInstitutionConverter;
    
    
    /**
     * Asynchronously re-processes latest uploads of all institution in a Solr core 
     * @param solr
     * @return batch job waiting for all re-processes jobs (one job per institution)
     * @throws FileNotFoundException
     */
    public BatchJobBean reprocessCoreAsync(SolrService solr) throws FileNotFoundException
    {
        final String coreName = solr.getName();
        final BatchJobBean batchJob = new BatchJobBean(String.format("Re-process archived uploads for all institutions on %s", coreName));
        for (String institutionName : archiveService.getInstitutionNames(coreName))
        {
            batchJob.addChildJob(reprocessInstitutionAsync(solr, idaInstitutionConverter.convert(institutionName)));
        }
        jobExecutionService.executeBatchAsynchronous(batchJob);
        return batchJob;
    }
    
    /**
     * Asynchronously re-processes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return the bean of the enqueued re-process job
     * @throws FileNotFoundException
     */
    public ReprocessJobBean reprocessInstitutionAsync(SolrService solr, IdaInstitutionBean institution) throws FileNotFoundException
    {
        return reprocessVersionAsync(solr, institution, 
                                     archiveService.getLatestVersionId(solr.getName(), institution.getInstitutionName()),
                                     ArchiveService.LATEST_UPDATE);
    }
    
    /**
     * Asynchronously re-processes a given upload version (up to a given incremental update) of an institution in a Solr core
     * @param solr
     * @param institution
     * @param versionId
     * @param upToUpdateId
     * @return the bean of the enqueued re-process job
     * @throws FileNotFoundException
     */
    public ReprocessJobBean reprocessVersionAsync(SolrService solr, IdaInstitutionBean institution, String versionId, String upToUpdateId) throws FileNotFoundException
    {
        final String coreName = solr.getName();
        final String institutionName = institution.getInstitutionName();
        log.info("Start re-processing of version: {}.{} for institution: {} on Solr core: {}", 
                versionId, upToUpdateId, institution.getInstitutionName(), solr.getName());
        
        Path versionFile = 
                archiveService.findFile(ProcessStep.upload, coreName, institutionName, versionId, ArchiveService.NO_UPDATE);
        int versionNumber = archiveService.getVersionNumber(versionId);
        ReprocessJobBean reprocessJobBean = new ReprocessJobBean(solr, institution, versionFile, versionNumber);
        
        for (String updateId : archiveService.getUpdateIdsUpTo(coreName, institutionName, versionId, upToUpdateId))
        {
            Path updateFile =
                    archiveService.findFile(ProcessStep.upload, coreName, institutionName, versionId, updateId);
            int updateNumber = archiveService.getUpdateNumber(updateId);
            reprocessJobBean.addIncrementalTransformation(updateFile, updateNumber);
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
    
    private void reprocess(ReprocessJobBean jobBean) throws IOException, SolrServerException, TransformerException
    {
        List<TransformationBean> transformationBatch = jobBean.getTransformations();
        try
        {
            for (TransformationBean transformationBean : transformationBatch)
            {
                processService.transform(transformationBean);
                processService.updateSolr(transformationBean);
            }

            // archive only after success
            for (TransformationBean transformationBean : transformationBatch)
            {
                archiver.archive(transformationBean);
            }
        } finally
        {
            for (TransformationBean transformationBean : transformationBatch)
            {
                processService.deleteProcessingFolder(transformationBean.getKey());
            }
            // do not delete archived transformation input
        }
        
    }
}
