package de.idadachverband.job;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.Future;

/**
 * Created by boehm on 02.10.14.
 */
@Slf4j
public enum JobProgressState
{
    SUCCESS, NOTFOUND, PROCESSING, CANCELLED, FAILURE, NOTSTARTED;

    /**
     * Get current state by key
     *
     * @param jobBean
     * @return State of job
     */
    public static JobProgressState getState(JobBean jobBean)
    {
        if (jobBean == null)
        {
            return NOTFOUND;
        }

        Future<?> future = jobBean.getFuture();
        if (future == null)
        {
            log.warn("Probably not started '{}' in '{}'.", jobBean);
            return NOTSTARTED;
        } 
        else if (future.isCancelled())
        {
            return CANCELLED;
        }
        else if (future.isDone())
        {
            if (jobBean.getException() != null)
            {
                log.debug("Job {} failed.", jobBean);
                return FAILURE;
            }
            return SUCCESS;
        } 
        return PROCESSING;
    }
}
