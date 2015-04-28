package de.idadachverband.result;

import de.idadachverband.job.JobBean;

/**
 * Created by boehm on 09.10.14.
 */
public class NopResultNotifier implements ResultNotifier
{
    @Override
    public void notify(JobBean transformationBean) throws NotificationException
    {

    }
}
