package de.idadachverband.job;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;

@Getter
public class BatchJobBean extends JobBean
{
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
}
