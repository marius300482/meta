package de.idadachverband.job;

import java.util.concurrent.Future;

import javax.inject.Inject;
import javax.inject.Named;

import lombok.extern.slf4j.Slf4j;

@Named
@Slf4j
public class JobExecutionService
{   
    @Inject
    private JobProgressService jobProgressService;
    
    @Inject
    private AsyncExecutionHelperService asyncExecutionService;
    
    public <B extends JobBean> void executeAsynchronous(B jobBean, JobCallable<B> callable)
    {
        if (jobBean.getProgressState() != JobProgressState.NOTSTARTED)
        {
            throw new IllegalArgumentException(jobBean + " was started before");
        }
        jobProgressService.add(jobBean);
        
        log.debug("= Call async method for: {}", jobBean);
        Future<?> voidFuture = asyncExecutionService.executeAsFuture(jobBean, callable);
        jobBean.setFuture(voidFuture);
        log.debug("= Async method returned for: {}", jobBean);
    }     
    
    public void executeBatchAsynchronous(BatchJobBean batchJob) 
    {
        executeAsynchronous(batchJob, new JobCallable<BatchJobBean>()
                {
            @Override
            public void call(BatchJobBean jobBean) throws Exception
            {
                for (JobBean childJob : jobBean.getChildJobBeans())
                {
                    jobProgressService.waitFor(childJob.getJobId());
                }
            }
        });
    }
}
