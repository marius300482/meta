package de.idadachverband.result;

import de.idadachverband.job.JobBean;

/**
 * Notifies initiator of process about result
 * Created by boehm on 09.10.14.
 */
public interface ResultNotifier
{
    /**
     * @param jobBean
     * @throws NotificationException
     */
    void notify(JobBean jobBean) throws NotificationException;
}
