package de.idadachverband.job;

import java.util.Date;
import java.util.UUID;
import java.util.concurrent.Future;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@EqualsAndHashCode(of = "jobId")
public class JobBean
{
    private final String jobId;
    private final Date startTime;
    private String jobName;
    private Future<?> future;
    private Exception exception;
    private Date endTime;
    private String result;

    public JobBean()
    {
        this.jobId = UUID.randomUUID().toString();
        this.startTime = new Date();
        this.jobName = "";
    }

    public JobProgressState getProgressState()
    {
        return JobProgressState.getState(this);
    }   
    
    public String getResultMessage() 
    {
        StringBuilder sb = new StringBuilder();
        buildResultMessage(sb);
        return sb.toString();
    }

    public void buildResultMessage(StringBuilder sb)
    {
    }
    
    public String toString()
    {
        return jobName;
    }
}