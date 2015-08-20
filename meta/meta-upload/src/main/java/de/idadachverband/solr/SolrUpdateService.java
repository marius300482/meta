package de.idadachverband.solr;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.archive.bean.ArchiveBaseVersionBean;
import de.idadachverband.archive.bean.VersionOrigin;
import de.idadachverband.hierarchy.HierarchyCacheDeleteMethod;
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
    private final HierarchyCacheDeleteMethod hierarchyCacheDeleteMethod;
    
    @Inject
    public SolrUpdateService(
            ArchiveService archiveService, 
            IdaInputArchiver idaInputArchiver, 
            JobExecutionService jobExecutionService,
            HierarchyCacheDeleteMethod hierarchyCacheDeleteMethod)
    {
        this.archiveService = archiveService;
        this.idaInputArchiver = idaInputArchiver;
        this.jobExecutionService = jobExecutionService;
        this.hierarchyCacheDeleteMethod = hierarchyCacheDeleteMethod;
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
        return reindexVersionAsync(solr, institution, 
                archiveService.getLatestVersionKey(solr.getName(), institution.getInstitutionId()));
    }
    
    /**
     * Asynchronously re-indexes the latest upload of an institutions in a Solr core
     * @param solr
     * @param institution
     * @return the bean of the enqueued re-process job
     * @throws FileNotFoundException
     */
    public ReindexJobBean reindexVersionAsync(final SolrService solr, final IdaInstitutionBean institution, 
            final VersionKey version) throws ArchiveException
    {
        log.info("Start re-indexing of version: {} for institution: {} on Solr core: {}", 
                version, institution, solr);
        
        final ReindexJobBean reindexJobBean = new ReindexJobBean(solr, institution, version);
        
        jobExecutionService.executeAsynchronous(reindexJobBean, new JobCallable<ReindexJobBean>()
        {
            @Override
            public void call(ReindexJobBean jobBean) throws Exception
            {
                List<SolrUpdateBean> solrUpdates =
                        reindex(solr, institution, version, jobBean.getUser().getUsername());
                jobBean.getSolrUpdates().addAll(solrUpdates);
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
        VersionKey latestVersion = archiveService.getLatestVersionKey(solr.getName(), institution.getInstitutionId());
        if (latestVersion.isMissing())
        {
            log.warn("There is no archived version for institution: {} on Solr core: {}", institution.getInstitutionName(), solr.getName());
            return "No archived version!";
        }
        
        List<SolrUpdateBean> solrUpdates = reindex(solr, institution, 
                latestVersion, "");
        
        StringBuilder sb = new StringBuilder();
        for (SolrUpdateBean solrUpdate : solrUpdates)
        {
            solrUpdate.buildResultMessage(sb);
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

    protected List<SolrUpdateBean> reindex(SolrService solr, IdaInstitutionBean institution, VersionKey version, String username) throws IOException, SolrServerException, ArchiveException 
    {
        final String coreName = solr.getName();
        final String institutionId = institution.getInstitutionId();
        
        // prepare Solr updates
        final List<SolrUpdateBean> solrUpdates = new ArrayList<>();
        
        ArchiveBaseVersionBean baseVersionBean = archiveService.getArchivedBaseVersion(coreName, institutionId, version);
        SolrUpdateBean baseSolrUpdate = new SolrUpdateBean(solr, institution, baseVersionBean.getSolrFormatFile(), false);
        baseSolrUpdate.setOriginalVersion(baseVersionBean.getVersion());
        solrUpdates.add(baseSolrUpdate);
       
        for (ArchiveVersionBean updateBean : baseVersionBean.getUpdatesUpTo(version.getUpdateNumber()))
        {
            SolrUpdateBean incrementalSolrUpdate = 
                    new SolrUpdateBean(solr, institution, updateBean.getSolrFormatFile(), true);
            incrementalSolrUpdate.setOriginalVersion(updateBean.getVersion());
            solrUpdates.add(incrementalSolrUpdate);
        }
   
        // re-index
        for (SolrUpdateBean solrUpdate : solrUpdates)
        {
            updateSolr(solrUpdate, false);
        }
        
        // re-archive if this was not the latest version
        if (!version.equals(archiveService.getLatestVersionKey(coreName, institutionId)))
        {
            for (SolrUpdateBean solrUpdate : solrUpdates)
            {
                archiveService.rearchive(coreName, institutionId, solrUpdate.getOriginalVersion(), VersionOrigin.REINDEX, username);
            }
            archiveService.clearOldVersions(coreName, institutionId);
        }
        return solrUpdates;
    }
    
    public void updateSolr(SolrUpdateBean indexRequest, boolean rollbackOnError) throws IOException, SolrServerException, ArchiveException
    {
        final SolrService solr = indexRequest.getSolrService();
        final IdaInstitutionBean institution = indexRequest.getInstitution();
       
        Path inputFile = indexRequest.getSolrInput();
        
        log.info("Start Solr update of core: {} for: {} with file: {}", solr, institution, inputFile);
        final long start = System.currentTimeMillis();
        indexRequest.setSolrMessage("Updating...");
        
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
        
        try
        {
            String solrResult = solr.update(inputFile);
            log.debug("Solr result {}", solrResult);
        } 
        catch (Exception e)
        {
            if (rollbackOnError) {
                log.warn("Update of solr {} failed for institution {}. Start rollback.", solr, institution, e);
                final String rollbackResult = reindexInstitution(solr, institution);
                log.info("Result of rollback is: {}", rollbackResult);
                indexRequest.setSolrMessage(
                        String.format("Failure!\n%s\nSolr rollback: %s", e.getMessage(), rollbackResult));
            }
            else 
            {
                indexRequest.setSolrMessage(
                        String.format("Failure!\n%s", e.getMessage()));
            }
            throw new SolrServerException("Invalid update", e);
        } 
        finally
        {
            if (inputIsArchived) {
                Files.deleteIfExists(inputFile);
            }
        }
        hierarchyCacheDeleteMethod.deleteHierarchyCache(institution);
        
        final long end = System.currentTimeMillis();
        final long duration = (end - start) / 1000;
        log.info("Solr update of core: {} for: {} with file: {} took: {} seconds.", solr, institution, inputFile, duration);
        indexRequest.setSolrMessage(String.format("Finished in %d seconds.", duration));
    }
}
