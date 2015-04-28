package de.idadachverband.job;

import java.util.Date;
import java.util.concurrent.Future;

import javax.inject.Inject;
import javax.inject.Named;

import lombok.extern.slf4j.Slf4j;

import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;

import de.idadachverband.result.NotificationException;
import de.idadachverband.result.ResultNotifier;

@Named
@Slf4j
/**
 * Helper needed because Spring requires a separate service for @Async method calls.
 * @author rpr
 *
 */
public class AsyncExecutionHelperService
{
    @Inject
    private ResultNotifier resultMailSender;
    
    @Async    
    public <B extends JobBean> Future<Void> executeAsFuture(B jobBean, JobCallable<B> callable)
    {   
        log.debug("Start asynchronous processing of: {}", jobBean);
        AsyncResult<Void> asyncResult = new AsyncResult<>(null);
        try
        {
            callable.call(jobBean);
        }
        catch (Exception e)
        {
            log.warn("Execution of {} failed: ", jobBean, e);
            jobBean.setException(e);
        } finally
        {
            jobBean.setEndTime(new Date());
            try
            {
                resultMailSender.notify(jobBean);
            } catch (NotificationException e)
            {
                log.warn("Notifcation for {} failed: ", jobBean, e);
            }
        }
        
        log.debug("* End of asynchronous processing of: {}", jobBean);
        return asyncResult;
    }
}
