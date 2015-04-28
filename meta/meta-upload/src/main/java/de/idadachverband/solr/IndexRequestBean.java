package de.idadachverband.solr;

import java.nio.file.Path;
import java.util.UUID;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "key")
public class IndexRequestBean
{
    private final String key;
    private final SolrService solrService;
    private final IdaInstitutionBean institution;
    private final boolean incrementalUpdate;
    
    private Path solrInput;
    private String solrResponse;
    
    public IndexRequestBean(SolrService solrService, IdaInstitutionBean institution, boolean incrementalUpdate)
    {
        this.key = UUID.randomUUID().toString();
        this.solrService = solrService;
        this.institution = institution;
        this.incrementalUpdate = incrementalUpdate;
    }
    
    public String getCoreName()
    {
        return solrService.getName();
    }
    
    public String getInstitutionName() 
    {
        return institution.getInstitutionName();
    }
    
    public String getResultMessage() 
    {
        StringBuilder sb = new StringBuilder();
        buildResultMessage(sb);
        return sb.toString();
    }

    public void buildResultMessage(StringBuilder sb)
    {
        sb.append("Solr result: ");
        sb.append(solrResponse);
        sb.append('\n');
    }
}
