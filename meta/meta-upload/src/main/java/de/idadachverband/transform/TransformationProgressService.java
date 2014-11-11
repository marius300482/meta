package de.idadachverband.transform;

import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.io.File;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import static de.idadachverband.transform.TransformationProgressState.*;

/**
 * Provides details about progress of transformation.
 * Use {@see add} first.
 * <p/>
 * TODO: Finished transformations should be removed from map at some time
 * Created by boehm on 02.10.14.
 */
@Named
@Slf4j
public class TransformationProgressService
{
    final private Map<String, TransformationBean> tranformations = new ConcurrentHashMap<>();

    /**
     * @param transformationBean to be watched
     */
    public void add(TransformationBean transformationBean)
    {
        tranformations.put(transformationBean.getKey(), transformationBean);
    }

    /**
     * @param transformationBean
     * @return State of transformation
     */
    public TransformationProgressState getState(TransformationBean transformationBean)
    {
        return getState(transformationBean.getKey());
    }

    /**
     * Get current state by key
     *
     * @param key of transformation
     * @return State of transformation
     */
    public TransformationProgressState getState(String key)
    {
        TransformationBean transformationBean = tranformations.get(key);
        if (transformationBean == null)
        {
            log.warn("Can not find result '{}' in '{}'.", key, tranformations.keySet());
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
                log.info("Job '{}' is done. Remove from map", key);
                // removeResultFromMap(key);
                return DONE;
            } else
            {
                if (future.isCancelled())
                {
                    log.info("Job '{}' was cancelled. Remove from map", key);
                    // removeResultFromMap(key);
                    return CANCELLED;
                }
            }
        }
        return PROCESSING;
    }

    /**
     * Should be called when state is @see DONE because it blocks until transformation is finished.
     *
     * @param key
     * @return
     * @throws TransformedFileException
     */
    public File getFile(String key) throws TransformedFileException
    {
        try
        {
            TransformationBean transformationBean = tranformations.get(key);
            Future<?> future = transformationBean.getFuture();
            future.get();
            File file = transformationBean.getTransformedFile();
            // Force NPE
            file.getName();
            return file;
        } catch (InterruptedException | ExecutionException | NullPointerException e)
        {
            throw new TransformedFileException(e);
        }
    }

    public TransformationBean getTransformation(String key)
    {
        return tranformations.get(key);
    }

    public Exception getException(String key)
    {
        return tranformations.get(key).getException();
    }

    private void removeResultFromMap(String key)
    {
        tranformations.remove(key);
        log.debug("Map after removal '{}'.", tranformations.keySet());
    }
}
