package de.idadachverband.transform;


import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.io.File;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import static de.idadachverband.transform.TransformationProgressState.*;
import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.when;

public class TransformationProgressServiceTest
{

    TransformationBean transformationBean = new TransformationBean();
    private TransformationProgressService cut = new TransformationProgressService();
    @Mock
    private Future<File> future;

    @Before
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        transformationBean.setFuture(future);
    }

    @Test
    public void getResultNotFound() throws Exception
    {
        TransformationProgressState actual = cut.getState(new TransformationBean());

        assertThat(actual, is(TransformationProgressState.NOTFOUND));
    }

    @Test
    public void getResultProcessing() throws Exception
    {

        when(future.isDone()).thenReturn(false);
        when(future.isCancelled()).thenReturn(false);

        cut.add(transformationBean);
        TransformationProgressState actual = cut.getState(transformationBean);

        assertThat(actual, is(PROCESSING));
    }

    @Test
    public void getResultCancelled() throws Exception
    {
        when(future.isDone()).thenReturn(false);
        when(future.isCancelled()).thenReturn(true);

        cut.add(transformationBean);
        TransformationProgressState actual = cut.getState(transformationBean);

        assertThat(actual, is(CANCELLED));
    }

    @Test
    public void getResultDone() throws Exception
    {
        when(future.isDone()).thenReturn(true);
        when(future.isCancelled()).thenReturn(false);

        cut.add(transformationBean);
        TransformationProgressState actual = cut.getState(transformationBean);

        assertThat(actual, is(DONE));
    }

    @Test
    public void getFileSucces() throws Exception
    {
        File expected = new File("");
        transformationBean.setTransformedFile(expected);
        cut.add(transformationBean);
        File actual = cut.getFile(transformationBean.getKey());

        assertThat(actual, is(expected));
    }

    @Test(expected = TransformedFileException.class)
    public void getFileFailure() throws Exception
    {
        when(future.get()).thenThrow(new ExecutionException(new Throwable()));
        cut.add(transformationBean);
        cut.getFile(transformationBean.getKey());
    }
}