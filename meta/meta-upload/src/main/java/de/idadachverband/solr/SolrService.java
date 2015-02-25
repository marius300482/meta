package de.idadachverband.solr;

import de.idadachverband.utils.ZipService;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.request.ContentStreamUpdateRequest;
import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.util.NamedList;

import javax.inject.Inject;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by boehm on 26.08.14.
 */
@Slf4j
public class SolrService
{
    private final SolrServer server;

    @Getter
    private final String name;

    private final String url;

    @Inject
    private ZipService zipService;

    public SolrService(String name, String url)
    {
        this.name = name;
        this.url = url;
        this.server = new HttpSolrServer(url);
    }

    /**
     * Sends file to Solr server with update request
     *
     * @param input XML file
     * @return Result message of Solr
     * @throws IOException
     * @throws SolrServerException
     */
    public String update(Path input) throws IOException, SolrServerException
    {
        log.info("Update core: {} with file: {}", name, input);
        ContentStreamUpdateRequest request = new ContentStreamUpdateRequest("/update");
        request.addFile(input.toFile(), "text/xml");
        log.info("Send file {} with request {}{}", input, url, request.getPath());
        NamedList<Object> result = server.request(request);
        log.debug("Result for update of core: {} with: {} is:  {}", name, input, result);
        return result.toString();
    }

    /**
     * Deletes all documents of an institution.
     *
     * @param institution Name of institution
     * @return Response from Solr.
     * @throws IOException
     * @throws SolrServerException
     */
    public String deleteInstitution(String institution) throws IOException, SolrServerException
    {
        log.info("Delete all documents on core {} for institution {}", name, institution);
        final UpdateResponse updateResponse = server.deleteByQuery("institution:" + institution);
        final NamedList<Object> response = updateResponse.getResponse();
        log.info("Result of deleting all documents on core {} for institution {}: {}", name, institution, response);
        return response.toString();
    }

    /**
     * Deletes everything from Solr core and add files
     *
     * @param files to add
     * @throws IOException
     * @throws SolrServerException
     */
    public void reindex(List<Path> files) throws IOException, SolrServerException
    {
        log.info("Reindex on core: {} with: {}", name, files);
        deleteAll();
        Map<Path, Exception> failedUpdates = new HashMap<>();
        final Path tempDirectory = Files.createTempDirectory("index-");
        for (Path path : files)
        {
            final Path tmpPath = tempDirectory.resolve(path.getFileName());
            final Path file = zipService.unzip(path);
            try
            {
                update(file);
            } catch (SolrServerException e)
            {
                failedUpdates.put(path, e);
            } finally
            {
                Files.deleteIfExists(tmpPath);
            }
        }
        if (!failedUpdates.isEmpty())
        {
            throw new SolrServerException(failedUpdates.toString());
        }
    }

    /**
     * Delete all documents from Solr core.
     *
     * @throws IOException
     * @throws SolrServerException
     */
    public void deleteAll() throws IOException, SolrServerException
    {
        log.info("Delete all documents on core {}", name);
        final UpdateResponse updateResponse = server.deleteByQuery("*:*");
        log.info("Deleted all documents {}", updateResponse);
    }

    @Override
    public String toString()
    {
        return name;
    }
}
