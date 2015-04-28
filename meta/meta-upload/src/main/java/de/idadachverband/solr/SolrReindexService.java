package de.idadachverband.solr;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.job.BatchJobBean;
import de.idadachverband.job.JobCallable;
import de.idadachverband.job.JobExecutionService;
import de.idadachverband.process.ProcessStep;
import lombok.extern.slf4j.Slf4j;

import org.apache.solr.client.solrj.SolrServerException;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by boehm on 25.02.15.
 */
@Named
@Slf4j
public class SolrReindexService
{
    private final ArchiveService archiveService;
    private final IdaInputArchiver idaInputArchiver;
    private final JobExecutionService jobExecutionService;
    private final IdaInstitutionConverter idaInstitutionConverter;

    @Inject
    public SolrReindexService(
            ArchiveService archiveService, 
            IdaInputArchiver idaInputArchiver, 
            JobExecutionService jobExecutionService, 
            IdaInstitutionConverter idaInstitutionConverter)
    {
        this.archiveService = archiveService;
        this.idaInputArchiver = idaInputArchiver;
        this.jobExecutionService = jobExecutionService;
        this.idaInstitutionConverter = idaInstitutionConverter;
    }
    
    /**
     * Asynchronously re-indexes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return the bean of the enqueued re-process job
     * @throws FileNotFoundException
     */
    public ReindexJobBean reindexInstitutionAsync(SolrService solr, IdaInstitutionBean institution) throws FileNotFoundException
    {
        final ReindexJobBean reindexJobBean = buildReindexJobBean(solr, institution);
        
        jobExecutionService.executeAsynchronous(reindexJobBean, new JobCallable<ReindexJobBean>()
        {
            @Override
            public void call(ReindexJobBean jobBean) throws Exception
            {
                reindex(jobBean);
            }
        });
        
        return reindexJobBean;
    }
    
    /**
     * Synchronously re-indexes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return
     * @throws IOException
     * @throws SolrServerException
     */
    public String rollbackInstitutionIndex(SolrService solr, IdaInstitutionBean institution) throws IOException, SolrServerException
    {
        ReindexJobBean reindexJobBean = buildReindexJobBean(solr, institution);
        // roll back synchronous
        reindex(reindexJobBean);
        return reindexJobBean.getResultMessage();
    }
    
    /**
     * Asynchronously re-indexes latest uploads of all institution in a Solr core 
     * @param solr
     * @return batch job waiting for all re-index jobs (one job per institution)
     * @throws FileNotFoundException
     */
    public BatchJobBean reindexCoreAsync(SolrService solr) throws FileNotFoundException
    {
        final String coreName = solr.getName();
        final BatchJobBean batchJob = new BatchJobBean(String.format("Re-index archived uploads for all institutions on %s", coreName));
        for (String institutionName : archiveService.getInstitutionNames(coreName))
        {
            batchJob.addChildJob(reindexInstitutionAsync(solr, idaInstitutionConverter.convert(institutionName)));
        }
        jobExecutionService.executeBatchAsynchronous(batchJob);
        return batchJob;
    }

    private ReindexJobBean buildReindexJobBean(SolrService solr,
            IdaInstitutionBean institution) throws FileNotFoundException
    {
        final String coreName = solr.getName();
        final String institutionName = institution.getInstitutionName();
        log.info("Start re-indexing of latest uploads for institution: {} on Solr core: {}", 
                institutionName, coreName);
        
        String versionId = archiveService.getLatestVersionId(coreName, institutionName);
        Path versionFile = 
                archiveService.findFile(ProcessStep.solrFormat, coreName, institutionName, versionId, ArchiveService.NO_UPDATE);
        int versionNumber = archiveService.getVersionNumber(versionId);
        ReindexJobBean reindexJobBean = new ReindexJobBean(solr, institution, versionFile, versionNumber);
        
        for (String updateId : archiveService.getUpdateIds(coreName, institutionName, versionId))
        {
            Path updateFile =
                    archiveService.findFile(ProcessStep.solrFormat, coreName, institutionName, versionId, updateId);
            int updateNumber = archiveService.getUpdateNumber(updateId);
            reindexJobBean.addIncrementalIndexRequest(updateFile, updateNumber);
        }
        return reindexJobBean;
    }
    
    
    private void reindex(ReindexJobBean jobBean) throws IOException, SolrServerException {
        for (IndexRequestBean indexRequest : jobBean.getIndexRequests())
        {
            updateSolr(indexRequest);
        }
    }
    
    private void updateSolr(IndexRequestBean indexRequest) throws IOException, SolrServerException
    {
        final SolrService solr = indexRequest.getSolrService();
        if (!indexRequest.isIncrementalUpdate())
        {
            final String institutionName = indexRequest.getInstitutionName();
            log.info("Delete institution: {} on Solr core: {}", institutionName, solr.getName());
            solr.deleteInstitution(institutionName);
        }   
        
        final Path path = indexRequest.getSolrInput();
        log.info("Path to reindex: {}", path);
        final Path temporaryFile = idaInputArchiver.uncompressToTemporaryFile(path);
        final String result = solr.update(temporaryFile);
        log.info("Result of reindex: {}", result);
        Files.deleteIfExists(temporaryFile);
        indexRequest.setSolrResponse(result);
    }
}
