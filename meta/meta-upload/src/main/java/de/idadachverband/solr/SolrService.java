package de.idadachverband.solr;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.request.ContentStreamUpdateRequest;
import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.util.NamedList;

import java.io.IOException;
import java.nio.file.Path;

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
        final UpdateResponse deletionResponse = server.deleteByQuery("institution:" + institution);
        final UpdateResponse commitResponse = server.commit();
        final String response = deletionResponse.getResponse() + ", " + commitResponse.getResponse();
        log.info("Result of deleting all documents on core {} for institution {}: {}", name, institution, response);
        return response;
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
        final UpdateResponse deletionResponse = server.deleteByQuery("*:*");
        final UpdateResponse commitResponse = server.commit();
        log.info("Deleted all documents, result: {}, {}", deletionResponse.getResponse(), commitResponse.getResponse());
    }

    @Override
    public String toString()
    {
        return name;
    }
}
