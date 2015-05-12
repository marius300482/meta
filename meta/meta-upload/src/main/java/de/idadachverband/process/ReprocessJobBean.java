package de.idadachverband.process;

import java.util.List;

import lombok.Getter;
import lombok.NonNull;
import de.idadachverband.job.JobBean;
import de.idadachverband.transform.TransformationBean;

@Getter
public class ReprocessJobBean extends JobBean
{
    private final List<TransformationBean> transformations;
    
    private final String versionString;
    
    public ReprocessJobBean(
            @NonNull List<TransformationBean> transformations,
            String versionString)
    {
        this.transformations = transformations;
        this.versionString = versionString;
        setJobName(String.format("Re-process archived upload: %s, %s", 
                transformations.get(0).getInstitutionName(), versionString));
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        for (TransformationBean transformationBean : transformations)
        {
            transformationBean.buildResultMessage(sb);
        }
    }
    
}
