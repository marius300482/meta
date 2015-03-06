package de.idadachverband.solr;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServerException;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

/**
 * Created by boehm on 25.02.15.
 */
@Named
@Slf4j
public class SolrReindexService
{
    private final ArchiveService archiveService;
    private final IdaInputArchiver idaInputArchiver;

    @Inject
    public SolrReindexService(ArchiveService archiveService, IdaInputArchiver idaInputArchiver)
    {
        this.archiveService = archiveService;
        this.idaInputArchiver = idaInputArchiver;
    }

    public String reindexInstitutionOnCore(String ínstitutionName, SolrService solrService) throws IOException, SolrServerException
    {
        log.info("Reindex institution: {} on Solr core: {}", ínstitutionName, solrService.getName());
        solrService.deleteInstitution(ínstitutionName);

        final List<Path> solrFiles = archiveService.findSolrFiles(ínstitutionName, solrService.getName());
        return reindex(solrService, solrFiles);
    }

    public String reindexCore(SolrService solrService) throws IOException, SolrServerException
    {
        log.info("Reindex Solr core: {}", solrService.getName());
        solrService.deleteAll();
        final List<Path> solrFiles = archiveService.findSolrFiles(solrService.getName());
        log.info("Reindex content of folder: {}", solrFiles);
        return reindex(solrService, solrFiles);
    }

    private String reindex(SolrService solrService, List<Path> solrFiles) throws IOException, SolrServerException
    {
        log.info("Path to reindex: {}", solrFiles);
        StringBuffer resultStringBuffer = new StringBuffer();
        for (Path path : solrFiles)
        {
            log.debug("Reindex path: {}", path);
            final String result = addToSolr(path, solrService);
            resultStringBuffer.append(result);
            resultStringBuffer.append("\\\n");
        }
        return resultStringBuffer.toString();
    }

    private String addToSolr(Path path, SolrService solrService) throws IOException, SolrServerException
    {
        final Path temporaryFile = idaInputArchiver.uncompressToTemporaryFile(path);
        final String result = solrService.update(temporaryFile);
        log.info("Result of reindex: {}", result);
        Files.deleteIfExists(temporaryFile);
        return result;
    }
}
