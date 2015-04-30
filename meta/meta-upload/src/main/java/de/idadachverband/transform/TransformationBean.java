package de.idadachverband.transform;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.nio.file.Path;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.IndexRequestBean;
import de.idadachverband.solr.SolrService;

/**
 * Bean to hold transformation details.
 * Created by boehm on 09.10.14.
 */
@EqualsAndHashCode(callSuper=true)
@Data
public class TransformationBean extends IndexRequestBean
{
    private final Path transformationInput;
    
    private String transformationWorkingFormatMessages;
    
    private String transformationSolrFormatMessages;
   
    private String archivedVersionId;
   
    private String archivedUpdateId;
    
    public TransformationBean(
                SolrService solrService, 
                IdaInstitutionBean institution, 
                Path transformationInput, 
                boolean incrementalUpdate)
    {
        super(solrService, institution, incrementalUpdate);
        this.transformationInput = transformationInput;
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        super.buildResultMessage(sb);
        sb.append("Errors and warnings from transformation to working format: ");
        sb.append(transformationWorkingFormatMessages);
        sb.append('\n');
        sb.append("Errors and warnings from transformation to solr format: ");
        sb.append(transformationSolrFormatMessages);
        sb.append('\n');
    }
}
