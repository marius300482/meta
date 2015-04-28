package de.idadachverband.job;

import java.util.Date;
import java.util.UUID;
import java.util.concurrent.Future;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "jobId")
public class JobBean
{

    private final String jobId;
    private final Date startTime;
    private Future<?> future;
    private Exception exception;
    private Date endTime;
    private String result;

    public JobBean()
    {
        this.jobId = UUID.randomUUID().toString();
        this.startTime = new Date();
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
}