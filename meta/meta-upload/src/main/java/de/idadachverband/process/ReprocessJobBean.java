package de.idadachverband.process;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.TransformationBean;

@EqualsAndHashCode(callSuper=true)
@Data
public class ReprocessJobBean extends ProcessJobBean
{
    private final List<TransformationBean> transformations = new ArrayList<>();
    
    private final int versionNumber;
    
    private int upToUpdateNumber;
    
    public ReprocessJobBean(
            SolrService solrService, 
            IdaInstitutionBean institution, 
            Path transformationInput,
            int version)
    {
        super(solrService, institution, transformationInput, "", false);
        this.transformations.add(transformation);
        this.versionNumber = version;
        this.upToUpdateNumber = 0;
    }
    
    public TransformationBean addIncrementalTransformation(Path incrementalInput, int updateNumber)
    {
        TransformationBean incrementalTransformation = 
                new TransformationBean(transformation.getSolrService(), transformation.getInstitution(), 
                        incrementalInput, true);
        this.transformations.add(incrementalTransformation);
        this.upToUpdateNumber = updateNumber;
        return incrementalTransformation;
    }

    @Override
    public String toString()
    {
        return String.format("Re-process archived upload: %s, %d.%d", getTransformation().getInstitutionName(), versionNumber, upToUpdateNumber);
    }
    
    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        for (TransformationBean transformationBean : transformations)
        {
            transformationBean.buildResultMessage(sb);
        }
    } 
    
    public String getVersion()
    {
        return String.format("%d.%d", versionNumber, upToUpdateNumber);
    }
    
}
