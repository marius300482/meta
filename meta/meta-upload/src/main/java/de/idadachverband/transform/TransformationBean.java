package de.idadachverband.transform;

import lombok.Getter;
import lombok.Setter;

import java.nio.file.Path;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.SolrUpdateBean;
import de.idadachverband.solr.SolrService;

/**
 * Bean to hold transformation details.
 * Created by boehm on 09.10.14.
 */
@Getter
@Setter
public class TransformationBean extends SolrUpdateBean
{
    private final Path transformationInput;
    
    private String transformationWorkingFormatMessages = "";
    
    private String transformationSolrFormatMessages = "";
      
    public TransformationBean(
                SolrService solrService, 
                IdaInstitutionBean institution, 
                Path transformationInput, 
                boolean incrementalUpdate)
    {
        super(solrService, institution, null, incrementalUpdate);
        this.transformationInput = transformationInput;
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        if (!transformationWorkingFormatMessages.isEmpty())
        {
            sb.append("Errors and warnings from transformation to working format: \n");
            sb.append(transformationWorkingFormatMessages);
            sb.append('\n');
        }
        if (!transformationSolrFormatMessages.isEmpty())
        {
            sb.append("Errors and warnings from transformation to Solr format: \n");
            sb.append(transformationSolrFormatMessages);
            sb.append('\n');
        }
        super.buildResultMessage(sb);
    }
}
