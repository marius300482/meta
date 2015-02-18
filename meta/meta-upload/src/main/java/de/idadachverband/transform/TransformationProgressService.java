package de.idadachverband.transform;

import lombok.Getter;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Named;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import static de.idadachverband.transform.TransformationProgressState.PROCESSING;

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
    @Getter
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
        return TransformationProgressState.getState(transformationBean);
    }

    /**
     * Should be called when state is @see DONE because it blocks until transformation is finished.
     *
     * @param key
     * @return
     * @throws TransformedFileException
     */
    public Path getFile(String key) throws TransformedFileException
    {
        try
        {
            TransformationBean transformationBean = tranformations.get(key);
            Future<?> future = transformationBean.getFuture();
            future.get();
            @NonNull
            Path path = transformationBean.getTransformedFile();
            return path;
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

    public void setException(String key, Exception e)
    {
        tranformations.get(key).setException(e);
    }

    public Map<String, TransformationBean> clear()
    {
        Map<String, TransformationBean> removedTransformations = new HashMap<>();
        for (String key : tranformations.keySet())
        {
            final TransformationProgressState state = tranformations.get(key).getProgressState();
            if (state != PROCESSING)
            {
                removedTransformations.put(key, tranformations.remove(key));
            }
        }
        return removedTransformations;
    }

    private void removeResultFromMap(String key)
    {
        tranformations.remove(key);
        log.debug("Map after removal '{}'.", tranformations.keySet());
    }
}
