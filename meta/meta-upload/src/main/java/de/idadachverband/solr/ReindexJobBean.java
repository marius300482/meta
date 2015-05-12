package de.idadachverband.solr;

import java.util.List;

import lombok.Getter;
import lombok.NonNull;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobBean;

@Getter
public class ReindexJobBean extends JobBean
{
    private final List<IndexRequestBean> indexRequests;
    
    
    public ReindexJobBean(@NonNull List<IndexRequestBean> indexRequests) 
    {
        this.indexRequests = indexRequests;
        setJobName(String.format("Re-index latest archived upload: %s, %s", 
                getSolrService().getName(), getInstitution().getInstitutionName()));
    }
    
    public SolrService getSolrService() 
    {
        return indexRequests.get(0).getSolrService();
    }
    
    public IdaInstitutionBean getInstitution()
    {
        return indexRequests.get(0).getInstitution();
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        for (IndexRequestBean indexRequest : indexRequests)
        {
            indexRequest.buildResultMessage(sb);
        }
    }
}
