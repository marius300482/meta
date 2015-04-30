package de.idadachverband.job;

import lombok.Getter;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;

import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.transform.TransformedFileException;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import static de.idadachverband.job.JobProgressState.PROCESSING;

/**
 * Provides details about progress of transformation.
 * Use {@see add} first.
 * <p/>
 * TODO: Finished transformations should be removed from map at some time
 * Created by boehm on 02.10.14.
 */
@Named
@Slf4j
public class JobProgressService
{
    @Getter
    final private Map<String, JobBean> jobs = new ConcurrentHashMap<>();

    /**
     * @param jobBean to be watched
     */
    public void add(JobBean jobBean)
    {
        jobs.put(jobBean.getJobId(), jobBean);
    }

    /**
     * @param jobBean
     * @return State of transformation
     */
    public JobProgressState getState(JobBean jobBean)
    {
        return getState(jobBean.getJobId());
    }

    /**
     * Get current state by jobId
     *
     * @param jobId of transformation
     * @return State of transformation
     */
    public JobProgressState getState(String jobId)
    {
        JobBean jobBean = jobs.get(jobId);
        return JobProgressState.getState(jobBean);
    }

    /**
     * blocks until job is finished.
     *
     * @param jobId
     * @return
     * @throws TransformedFileException
     */
    public void waitFor(String jobId) throws TransformedFileException
    {
        try
        {
            JobBean processJobBean = jobs.get(jobId);
            Future<?> future = processJobBean.getFuture();
            future.get();
        } catch (InterruptedException | ExecutionException e)
        {
            throw new TransformedFileException(e);
        }
    }

    public JobBean getJob(String jobId)
    {
        return jobs.get(jobId);
    }

    public Exception getException(String jobId)
    {
        return jobs.get(jobId).getException();
    }

    public void setException(String jobId, Exception e)
    {
        jobs.get(jobId).setException(e);
    }

    public Map<String, JobBean> clear()
    {
        Map<String, JobBean> removedTransformations = new HashMap<>();
        for (String jobId : jobs.keySet())
        {
            final JobProgressState state = jobs.get(jobId).getProgressState();
            if (state != PROCESSING)
            {
                removedTransformations.put(jobId, jobs.remove(jobId));
            }
        }
        return removedTransformations;
    }

//    private void removeResultFromMap(String jobId)
//    {
//        jobs.remove(jobId);
//        log.debug("Map after removal '{}'.", jobs.jobIdSet());
//    }
}
