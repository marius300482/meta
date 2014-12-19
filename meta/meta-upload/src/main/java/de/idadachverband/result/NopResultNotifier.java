package de.idadachverband.result;

import de.idadachverband.transform.TransformationBean;

/**
 * Created by boehm on 09.10.14.
 */
public class NopResultNotifier implements ResultNotifier
{
    @Override
    public void notify(TransformationBean transformationBean) throws NotificationException
    {

    }
}
