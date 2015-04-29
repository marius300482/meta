package de.idadachverband.process;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.Directories;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.ProcessFileConfiguration;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobCallable;
import de.idadachverband.job.JobExecutionService;
import de.idadachverband.solr.IndexRequestBean;
import de.idadachverband.solr.SolrReindexService;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.IdaTransformer;
import de.idadachverband.transform.TransformationBean;
import de.idadachverband.transform.xslt.WorkingFormatToSolrDocumentTransformer;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import javax.xml.transform.TransformerException;

import org.apache.solr.client.solrj.SolrServerException;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 * Created by boehm on 09.10.14.
 */
@Named
@Slf4j
public class ProcessService
{
    final private JobExecutionService jobExecutionService;
    
    final private IdaInputArchiver idaInputArchiver;

    final private WorkingFormatToSolrDocumentTransformer workingFormatTransformer;

    final private ProcessFileConfiguration processFileConfiguration;
    
    final private ArchiveService archiveService;

    final private SolrReindexService solrReindexService;


    @Inject
    public ProcessService(IdaTransformer transformationStrategy,
                               WorkingFormatToSolrDocumentTransformer workingFormatTransformer,
                               IdaInputArchiver idaInputArchiver,
                               ProcessFileConfiguration processFileConfiguration,
                               ArchiveService archiveService,
                               SolrReindexService solrReindexService,
                               JobExecutionService jobExecutionService)
    {
        this.idaInputArchiver = idaInputArchiver;
        this.workingFormatTransformer = workingFormatTransformer;
        this.processFileConfiguration = processFileConfiguration;
        this.archiveService = archiveService;
        this.solrReindexService = solrReindexService;
        this.jobExecutionService = jobExecutionService;
    }

    public ProcessJobBean processAsync(final Path input, final IdaInstitutionBean institution, final SolrService solr, String originalFileName, boolean incrementalUpdate) throws IOException
    {
        log.info("Start processing of: {} for institution: {} on Solr core: {}", originalFileName, institution.getInstitutionName(), solr.getName());
        final ProcessJobBean processJobBean = 
                new ProcessJobBean(solr, institution, input, originalFileName, incrementalUpdate);
        
        jobExecutionService.executeAsynchronous(processJobBean, new JobCallable<ProcessJobBean>()
        {
            @Override
            public void call(ProcessJobBean jobBean) throws Exception
            {
                process(jobBean.getTransformation());
            }
        });
        return processJobBean;
    }
    
    /**
     * @param input              The input file to process
     * @param institution        The institution to which the file belongs
     * @param solr               The solr instance to update
     * @param transformationBean Bean holding process information
     * @return
     * @throws IOException 
     * @throws TransformerException 
     * @throws SolrServerException 
     * @throws ArchiveException 
     */
    public void process(TransformationBean transformationBean) throws TransformerException, IOException, SolrServerException, ArchiveException
    {
        final String key = transformationBean.getKey();
        try
        {
            transform(transformationBean);
            
            updateSolr(transformationBean);

            archiveService.archive(transformationBean);
            
        } finally
        {
            deleteProcessingFolder(key);
            Files.deleteIfExists(transformationBean.getTransformationInput());
        }
    }
    
    public void transform(TransformationBean transformationBean) throws IOException, TransformerException
    {
        final String key = transformationBean.getKey();
        final IdaInstitutionBean institution = transformationBean.getInstitution();
        try
        {
            Path path = idaInputArchiver.uncompressFile(
                    transformationBean.getTransformationInput(), 
                    processFileConfiguration.getFolder(ProcessStep.upload, key));

            path = transformToWorkingFormat(path, institution, key);
            
            path = transformToSolrFormat(path, institution, key);
            
            transformationBean.setSolrInput(path);

        } finally
        {
            final String transformationMessagesFromUpload = institution.getTransformationStrategy().getTransformationMessages();
            final String transformationMessagesToSolrFormat = workingFormatTransformer.getTransformationMessages();
            transformationBean.setTransformationWorkingFormatMessages(transformationMessagesFromUpload);
            transformationBean.setTransformationSolrFormatMessages(transformationMessagesToSolrFormat);
        }
    }
    
    private Path transformToWorkingFormat(Path inputFile, IdaInstitutionBean institution, String key) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to working format", inputFile, institution);
        final long start = System.currentTimeMillis();
        Path workingFormatFile = processFileConfiguration.getFolder(ProcessStep.workingFormat, key).resolve(inputFile.getFileName());
        Files.createDirectories(workingFormatFile.getParent());
        log.debug("Transform: {} to: {}", inputFile, workingFormatFile);
        IdaTransformer transformationStrategy = institution.getTransformationStrategy();
        transformationStrategy.transform(inputFile, workingFormatFile, institution);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to working format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return workingFormatFile;
    }

    private Path transformToSolrFormat(Path inputFile, IdaInstitutionBean institution, String key) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to Solr format", inputFile, institution);
        final long start = System.currentTimeMillis();
        Path solrFormatFile = processFileConfiguration.getFolder(ProcessStep.solrFormat, key).resolve(inputFile.getFileName());
        Files.createDirectories(solrFormatFile.getParent());
        log.debug("Transform: {} to: {}", inputFile, solrFormatFile);
        workingFormatTransformer.transform(inputFile, solrFormatFile, institution);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to Solr format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return solrFormatFile;
    }

    public void updateSolr(IndexRequestBean indexRequestBean) throws IOException, SolrServerException, ArchiveException
    {
        final SolrService solr = indexRequestBean.getSolrService();
        final IdaInstitutionBean institution = indexRequestBean.getInstitution();
        final Path inputFile = indexRequestBean.getSolrInput();
        log.info("Start Solr update of core: {} for: {} with file: {}", solr, institution, inputFile);
        final long start = System.currentTimeMillis();
        
        if (!indexRequestBean.isIncrementalUpdate())
        {
            solr.deleteInstitution(institution.getInstitutionName());
        }

        String solrResult = "";
        try
        {
            solrResult = solr.update(inputFile);
        } catch (IOException | SolrServerException e)
        {
            log.warn("Update of solr {} failed for institution {}. Start rollback", solr, institution);
            final String result = solrReindexService.reindexInstitution(solr, institution);
            log.info("Result of reindexing is: {}", result);
            throw e;
        }
        indexRequestBean.setSolrResponse(solrResult);

        final long end = System.currentTimeMillis();
        log.info("Solr update of core: {} for: {} with file: {} took: {} seconds.", solr, institution, inputFile, (end - start) / 1000);

        log.debug("Solr result {}", solrResult);
    }
    
    public void deleteProcessingFolder(String key)
    {
        final Path path = processFileConfiguration.getBasePath().resolve(key);
        log.debug("Delete processing folder: {} for transformation: {}", path, key);
        Directories.delete(path);
    }

    
}
