package de.idadachverband.process;

import lombok.Getter;
import de.idadachverband.job.JobBean;
import de.idadachverband.transform.TransformationBean;

@Getter
public class ProcessJobBean extends JobBean
{
    private final TransformationBean transformation;
    
    public ProcessJobBean(TransformationBean transformation)
    {
        this.transformation = transformation;
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        transformation.buildResultMessage(sb);
    } 
}
