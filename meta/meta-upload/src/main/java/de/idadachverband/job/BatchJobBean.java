package de.idadachverband.job;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=true)
@Data
public class BatchJobBean extends JobBean
{
    private final String info;
    
    private final List<JobBean> childJobBeans = new ArrayList<>();
    
    public void addChildJob(JobBean jobBean) 
    {
        this.childJobBeans.add(jobBean);
    }

    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        for (JobBean jobBean : this.childJobBeans)
        {
            jobBean.buildResultMessage(sb);
        }
    } 
    
    @Override
    public String toString()
    {
        return info;
    }
}
