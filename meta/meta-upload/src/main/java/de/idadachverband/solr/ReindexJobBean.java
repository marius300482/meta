package de.idadachverband.solr;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobBean;

@EqualsAndHashCode(callSuper=true)
@Data
public class ReindexJobBean extends JobBean
{
    private final IndexRequestBean indexRequest;
    
    private final List<IndexRequestBean> indexRequests = new ArrayList<>();
    
    private final int versionNumber;
    
    private int upToUpdateNumber;
    
    
    public ReindexJobBean(SolrService solrService, IdaInstitutionBean institution, Path solrInput, int versionNumber) 
    {
        indexRequest = new IndexRequestBean(solrService, institution, false);
        indexRequest.setSolrInput(solrInput);
        indexRequests.add(indexRequest);
        this.versionNumber = versionNumber;
        this.upToUpdateNumber = 0;
    }
    
    public IndexRequestBean addIncrementalIndexRequest(Path solrInput, int updateNumber)
    {
        final IndexRequestBean incrementalIndexRequest = 
                new IndexRequestBean(indexRequest.getSolrService(), indexRequest.getInstitution(), true);
        incrementalIndexRequest.setSolrInput(solrInput);
        this.indexRequests.add(incrementalIndexRequest);
        this.upToUpdateNumber = updateNumber;
        return incrementalIndexRequest;
    }
    
    @Override
    public String toString()
    {
        return String.format("Re-index archived upload: %s, %d.%d", indexRequest.getInstitutionName(), versionNumber, upToUpdateNumber);
    }
    
    public String getVersion()
    {
        return String.format("%d.%d", versionNumber, upToUpdateNumber);
    }
}
