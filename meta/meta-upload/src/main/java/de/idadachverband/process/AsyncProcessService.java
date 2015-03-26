package de.idadachverband.process;

import de.idadachverband.archive.Archiver;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.ProcessFileConfiguration;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.result.NotificationException;
import de.idadachverband.result.ResultNotifier;
import de.idadachverband.solr.SolrReindexService;
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
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Date;
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

    final private ProcessFileConfiguration processFileConfiguration;

    final private Archiver archiver;

    final private SolrReindexService solrReindexService;


    @Inject
    public AsyncProcessService(IdaTransformer transformationStrategy,
                               WorkingFormatToSolrDocumentTransformer workingFormatTransformer,
                               ResultNotifier resultMailSender,
                               IdaInputArchiver idaInputArchiver,
                               ProcessFileConfiguration processFileConfiguration,
                               Archiver archiver,
                               SolrReindexService solrReindexService)
    {
        this.transformationStrategy = transformationStrategy;
        this.resultMailSender = resultMailSender;
        this.idaInputArchiver = idaInputArchiver;
        this.workingFormatTransformer = workingFormatTransformer;
        this.processFileConfiguration = processFileConfiguration;
        this.archiver = archiver;
        this.solrReindexService = solrReindexService;
    }

    /**
     * @param input              The input file to process
     * @param institution        The institution to which the file belongs
     * @param solr               The solr instance to update
     * @param transformationBean Bean holding process information
     * @return
     * @throws NotificationException
     */
    @Async
    public Future<Void> processAsynchronous(Path input, IdaInstitutionBean institution, SolrService solr, TransformationBean transformationBean) throws NotificationException
    {
        log.debug("Start asynchronous processing of: {}", transformationBean);
        AsyncResult<Void> asyncResult = new AsyncResult<>(null);
        final String key = transformationBean.getKey();
        try
        {
            Path path = idaInputArchiver.archiveFile(input, processFileConfiguration.getFolder(ProcessStep.upload, key));

            path = transformToWorkingFormat(path, institution, key);
            path = idaInputArchiver.archiveFile(path, processFileConfiguration.getFolder(ProcessStep.workingFormat, key));

            path = transformToSolrFormat(path, institution, key);
            path = idaInputArchiver.archiveFile(path, processFileConfiguration.getFolder(ProcessStep.solrFormat, key));

            transformationBean.setTransformedFile(path);
            upateSolr(solr, transformationBean, path, institution);

            archiver.archive(institution, transformationBean, solr.getName());
        } catch (Exception e)
        {
            log.warn("Transformation failed: ", e);
            transformationBean.setException(e);
        } finally
        {
            transformationBean.setEndTime(new Date());
            final String transformationMessagesFromUpload = transformationStrategy.getTransformationMessages();
            final String transformationMessagesToSolrFormat = workingFormatTransformer.getTransformationMessages();
            transformationBean.setTransformationMessages(" - Transformation to working format: "
                    + transformationMessagesFromUpload
                    + "\n - Transformation to solr format: "
                    + transformationMessagesToSolrFormat);
            resultMailSender.notify(transformationBean);
        }

        log.debug("* End of asynchronous processing of: {}", transformationBean);
        return asyncResult;
    }

    private Path transformToWorkingFormat(Path inputFile, IdaInstitutionBean institution, String key) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to working format", inputFile, institution);
        final long start = System.currentTimeMillis();
        final Path unzippedFile = idaInputArchiver.uncompressToTemporaryFile(inputFile);
        Path workingFormatFile = processFileConfiguration.getPath(unzippedFile.getFileName().toString(), ProcessStep.workingFormat, key);
        Files.createDirectories(workingFormatFile.getParent());
        log.debug("Transform: {} to: {}", unzippedFile, workingFormatFile);
        transformationStrategy.transform(unzippedFile, workingFormatFile, institution);
        Files.deleteIfExists(unzippedFile);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to working format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return workingFormatFile;
    }

    private Path transformToSolrFormat(Path inputFile, IdaInstitutionBean institution, String key) throws TransformerException, IOException
    {
        log.info("Start transformation of: {} for: {} to Solr format", inputFile, institution);
        final long start = System.currentTimeMillis();
        final Path unzippedFile = idaInputArchiver.uncompressToTemporaryFile(inputFile);
        Path solrFormatFile = processFileConfiguration.getPath(unzippedFile.getFileName().toString(), ProcessStep.solrFormat, key);
        Files.createDirectories(solrFormatFile.getParent());
        log.debug("Transform: {} to: {}", unzippedFile, solrFormatFile);
        workingFormatTransformer.transform(unzippedFile, solrFormatFile, institution);
        Files.deleteIfExists(unzippedFile);
        final long end = System.currentTimeMillis();
        log.info("Transformation of: {} for: {} to Solr format took: {} seconds", inputFile, institution, (end - start) / 1000);
        return solrFormatFile;
    }

    private void upateSolr(SolrService solr, TransformationBean transformationBean, Path inputFile, IdaInstitutionBean institution) throws IOException, SolrServerException
    {
        log.info("Start Solr update of core: {} for: {} with file: {}", solr, institution, inputFile);
        final long start = System.currentTimeMillis();

        final Path unzippedFile = idaInputArchiver.uncompressToTemporaryFile(inputFile);

        if (!institution.isIncrementalUpdate())
        {
            solr.deleteInstitution(institution.getInstitutionName());
        }

        String solrResult = "";
        try
        {
            solrResult = solr.update(unzippedFile);
        } catch (IOException | SolrServerException e)
        {
            log.warn("Update of solr {} failed for institution {}. Start rollback", solr, institution);
            final String result = solrReindexService.reindexInstitutionOnCore(institution.getInstitutionName(), solr);
            log.info("Result of reindexing is: {}", result);
            throw e;
        }
        Files.deleteIfExists(unzippedFile);
        transformationBean.setSolrResponse(solrResult);

        final long end = System.currentTimeMillis();
        log.info("Solr update of core: {} for: {} with file: {} took: {} seconds.", solr, institution, inputFile, (end - start) / 1000);

        log.debug("Solr result {}", solrResult);
    }
}
