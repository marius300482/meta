package de.idadachverband.job;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;

import de.idadachverband.transform.TransformedFileException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
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

    public JobBean deleteJob(String jobId)
    {
        JobBean job = jobs.get(jobId);
        if (job != null && job.getProgressState() != PROCESSING)
        {
            return jobs.remove(job.getJobId());
        }
        return null;
    }
    
    public JobBean cancelJob(String jobId)
    {
        final JobBean job = jobs.get(jobId);
        if (job != null && job.getProgressState() == PROCESSING)
        {
            log.info("Trying to cancel job {}", job);
            final Future<?> future = job.getFuture();
            future.cancel(true);
            return job;
        }
        return null;
    }
    
    public List<JobBean> clear()
    {
        List<JobBean> removedJobs = new ArrayList<>();
        for (JobBean job : getStoppedJobs())
        {
            jobs.remove(job.getJobId());
            removedJobs.add(job);
        }
        return removedJobs;
    }
    
    public List<JobBean> getRunningJobs()
    {
        List<JobBean> result = new ArrayList<JobBean>();
        for (JobBean job : jobs.values())
        {
            if (job.getProgressState() == PROCESSING)
            {
                result.add(job);
            }
        }
        Collections.sort(result, new Comparator<JobBean>() {
            @Override
            public int compare(JobBean o1, JobBean o2)
            {
                return o1.getStartTime().compareTo(o2.getStartTime());
            }
        });
        return result;
    }
    
    public List<JobBean> getStoppedJobs()
    {
        List<JobBean> result = new ArrayList<JobBean>();
        for (JobBean job : jobs.values())
        {
            if (job.getProgressState() != PROCESSING)
            {
                result.add(job);
            }
        }
        Collections.sort(result, new Comparator<JobBean>() {
            @Override
            public int compare(JobBean o1, JobBean o2)
            {
                return o1.getStartTime().compareTo(o2.getStartTime());
            }
        });
        return result;
    }
}
