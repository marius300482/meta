package de.idadachverband.result;

import de.idadachverband.transform.TransformationBean;

/**
 * Notifies initiator of process about result
 * Created by boehm on 09.10.14.
 */
public interface ResultNotifier
{
    /**
     * @param transformationBean
     * @throws NotificationException
     */
    void notify(TransformationBean transformationBean) throws NotificationException;
}
