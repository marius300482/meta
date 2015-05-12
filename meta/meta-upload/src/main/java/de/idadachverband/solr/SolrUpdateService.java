package de.idadachverband.solr;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveUpdateBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.BatchJobBean;
import de.idadachverband.job.JobCallable;
import de.idadachverband.job.JobExecutionService;
import lombok.extern.slf4j.Slf4j;

import org.apache.solr.client.solrj.SolrServerException;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by boehm on 25.02.15.
 */
@Named
@Slf4j
public class SolrUpdateService
{
    private final ArchiveService archiveService;
    private final IdaInputArchiver idaInputArchiver;
    private final JobExecutionService jobExecutionService;
    @Inject
    public SolrUpdateService(
            ArchiveService archiveService, 
            IdaInputArchiver idaInputArchiver, 
            JobExecutionService jobExecutionService)
    {
        this.archiveService = archiveService;
        this.idaInputArchiver = idaInputArchiver;
        this.jobExecutionService = jobExecutionService;
    }
    
    /**
     * Asynchronously re-indexes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return the bean of the enqueued re-process job
     * @throws FileNotFoundException
     */
    public ReindexJobBean reindexInstitutionAsync(SolrService solr, IdaInstitutionBean institution) throws ArchiveException
    {
        log.info("Start re-indexing of latest uploads for institution: {} on Solr core: {}", 
                institution, solr);
        
        final ReindexJobBean reindexJobBean = new ReindexJobBean(
                getIndexRequests(solr, institution));
        
        jobExecutionService.executeAsynchronous(reindexJobBean, new JobCallable<ReindexJobBean>()
        {
            @Override
            public void call(ReindexJobBean jobBean) throws Exception
            {
                reindex(jobBean.getIndexRequests());
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
    public String reindexInstitution(SolrService solr, IdaInstitutionBean institution) throws ArchiveException, SolrServerException, IOException
    {
        final List<IndexRequestBean> indexRequests = getIndexRequests(solr, institution);
        reindex(indexRequests);
        
        StringBuilder sb = new StringBuilder();
        for (IndexRequestBean indexRequest : indexRequests)
        {
            indexRequest.buildResultMessage(sb);
        }
        return sb.toString();
    }
    
    /**
     * Asynchronously re-indexes latest uploads of all institution in a Solr core 
     * @param solr
     * @return batch job waiting for all re-index jobs (one job per institution)
     * @throws FileNotFoundException
     */
    public BatchJobBean reindexCoreAsync(SolrService solr) throws ArchiveException
    {
        final String coreName = solr.getName();
        final BatchJobBean batchJob = new BatchJobBean();
        batchJob.setJobName(String.format("Re-index archived uploads for all institutions on %s", coreName));
        
        for (ArchiveInstitutionBean archivedInstitution : archiveService.getArchivedInstitutions(coreName, false))
        {
            batchJob.addChildJob(reindexInstitutionAsync(solr, archivedInstitution.getInstitutionBean()));
        }
        jobExecutionService.executeBatchAsynchronous(batchJob);
        return batchJob;
    }

    protected List<IndexRequestBean> getIndexRequests(SolrService solr,
            IdaInstitutionBean institution) throws ArchiveException
    {
        final String coreName = solr.getName();
        final String institutionID = institution.getInstitutionId();
        
        final List<IndexRequestBean> indexRequests = new ArrayList<>();
        
        ArchiveVersionBean versionBean = archiveService.getVersion(coreName, institutionID, ArchiveService.LATEST_VERSION);
        IndexRequestBean indexRequest = new IndexRequestBean(solr, institution, false);
        indexRequest.setSolrInput(versionBean.getSolrFormatFile());
        indexRequests.add(indexRequest);
       
        for (ArchiveUpdateBean updateBean : versionBean.getEntries())
        {
            IndexRequestBean incrementalIndexRequest = new IndexRequestBean(solr, institution, true);
            incrementalIndexRequest.setSolrInput(updateBean.getSolrFormatFile());
            indexRequests.add(incrementalIndexRequest);
        }
        
        return indexRequests;
    }
    
    protected void reindex(List<IndexRequestBean> indexRequests) throws IOException, SolrServerException, ArchiveException 
    {
        for (IndexRequestBean indexRequest : indexRequests)
        {
            updateSolr(indexRequest, false);
        }
    }
    
    public void updateSolr(IndexRequestBean indexRequest, boolean rollbackOnError) throws IOException, SolrServerException, ArchiveException
    {
        final SolrService solr = indexRequest.getSolrService();
        final IdaInstitutionBean institution = indexRequest.getInstitution();
       
        Path inputFile = indexRequest.getSolrInput();
        
        log.info("Start Solr update of core: {} for: {} with file: {}", solr, institution, inputFile);
        final long start = System.currentTimeMillis();
        
        if (!indexRequest.isIncrementalUpdate())
        {
            log.info("Delete institution: {} on Solr core: {}", institution, solr.getName());
            solr.deleteInstitution(institution.getInstitutionId());
        }

        boolean inputIsArchived = idaInputArchiver.inputIsZip(inputFile);
        if (inputIsArchived)
        {
            inputFile = idaInputArchiver.uncompressToTemporaryFile(inputFile);
        }
        
        String solrResult = "";
        try
        {
            solrResult = solr.update(inputFile);
            
        } catch (Exception e)
        {
            if (rollbackOnError) {
                log.warn("Update of solr {} failed for institution {}. Start rollback", solr, institution);
                final String result = reindexInstitution(solr, institution);
                log.info("Result of reindexing is: {}", result);
            }
            throw new SolrServerException("Invalid update", e);
        } finally
        {
            if (inputIsArchived) {
                Files.deleteIfExists(inputFile);
            }
        }
        indexRequest.setSolrResponse(solrResult);

        final long end = System.currentTimeMillis();
        log.info("Solr update of core: {} for: {} with file: {} took: {} seconds.", solr, institution, inputFile, (end - start) / 1000);

        log.debug("Solr result {}", solrResult);
    }
}
