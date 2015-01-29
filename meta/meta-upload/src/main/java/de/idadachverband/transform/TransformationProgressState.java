package de.idadachverband.transform;

import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.Future;

/**
 * Created by boehm on 02.10.14.
 */
@Slf4j
public enum TransformationProgressState
{
    DONE, NOTFOUND, PROCESSING, CANCELLED, FAILURE, NOTSTARTED;

    /**
     * Get current state by key
     *
     * @param transformationBean
     * @return State of transformation
     */
    public static TransformationProgressState getState(TransformationBean transformationBean)
    {
        if (transformationBean == null)
        {
            return NOTFOUND;
        }

        if (transformationBean.getException() != null)
        {
            log.debug("Transformation {} failed.", transformationBean);
            return FAILURE;
        }

        Future<?> future = transformationBean.getFuture();

        if (future == null)
        {
            log.warn("Probably not started '{}' in '{}'.", transformationBean);
            return NOTSTARTED;
        } else
        {
            if (future.isDone())
            {
                return DONE;
            } else
            {
                if (future.isCancelled())
                {
                    return CANCELLED;
                }
            }
        }
        return PROCESSING;
    }
}
