package de.idadachverband.job;


import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobProgressService;
import de.idadachverband.job.JobProgressState;
import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.solr.SolrService;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.io.File;
import java.util.concurrent.Future;

import static de.idadachverband.job.JobProgressState.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;
import static org.mockito.Mockito.when;

public class TransformationProgressServiceTest
{

    @Mock
    private SolrService solrService;
    @Mock
    private IdaInstitutionBean institutionBean;
    
    private ProcessJobBean jobBean = new ProcessJobBean(solrService, institutionBean, null, "", false);
    private JobProgressService cut = new JobProgressService();
    @Mock
    private Future<File> future;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        jobBean.setFuture(future);
    }

    @Test
    public void getResultNotFound() throws Exception
    {
        JobProgressState actual = cut.getState("");

        assertThat(actual, is(JobProgressState.NOTFOUND));
    }

    @Test
    public void getResultProcessing() throws Exception
    {

        when(future.isDone()).thenReturn(false);
        when(future.isCancelled()).thenReturn(false);

        cut.add(jobBean);
        JobProgressState actual = cut.getState(jobBean);

        assertThat(actual, is(PROCESSING));
    }

    @Test
    public void getResultCancelled() throws Exception
    {
        when(future.isDone()).thenReturn(false);
        when(future.isCancelled()).thenReturn(true);

        cut.add(jobBean);
        JobProgressState actual = cut.getState(jobBean);

        assertThat(actual, is(CANCELLED));
    }

    @Test
    public void getResultDone() throws Exception
    {
        when(future.isDone()).thenReturn(true);
        when(future.isCancelled()).thenReturn(false);

        cut.add(jobBean);
        JobProgressState actual = cut.getState(jobBean);

        assertThat(actual, is(DONE));
    }

//    @Test
//    public void getFileSucces() throws Exception
//    {
//        Path expected = Paths.get("");
//        jobBean.getTransformation().setTransformedFile(expected);
//        cut.add(jobBean);
//        Path actual = cut.getFile(jobBean.getJobId());
//
//        assertThat(actual, is(expected));
//    }

//    @Test(expectedExceptions = TransformedFileException.class)
//    public void getFileFailure() throws Exception
//    {
//        when(future.get()).thenThrow(new ExecutionException(new Throwable()));
//        cut.add(jobBean);
//        cut.getFile(jobBean.getJobId());
//    }
}