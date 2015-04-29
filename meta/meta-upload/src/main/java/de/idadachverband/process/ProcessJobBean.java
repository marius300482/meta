package de.idadachverband.process;

import java.nio.file.Path;

import lombok.Data;
import lombok.EqualsAndHashCode;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobBean;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.TransformationBean;

@EqualsAndHashCode(callSuper=true)
@Data
public class ProcessJobBean extends JobBean
{
    protected final TransformationBean transformation;
    private final String originalFileName;
    
    public ProcessJobBean(
            SolrService solrService, 
            IdaInstitutionBean institution, 
            Path transformationInput, 
            String originalFileName, 
            boolean incrementalUpdate)
    {
        this.transformation = 
                new TransformationBean(solrService, institution, transformationInput, incrementalUpdate);
        this.originalFileName = originalFileName;
    }

    @Override
    public String toString()
    {
        return String.format("Process upload: %s, %s", originalFileName, transformation.getInstitutionName());
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        transformation.buildResultMessage(sb);
    } 
}
