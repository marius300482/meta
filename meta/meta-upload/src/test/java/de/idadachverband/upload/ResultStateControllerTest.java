package de.idadachverband.upload;

import de.idadachverband.archive.VersionKey;
import de.idadachverband.job.JobProgressService;
import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.result.ResultStateController;
import de.idadachverband.transform.TransformationBean;

import org.hamcrest.Matchers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import javax.json.Json;
import javax.json.JsonObject;

import java.io.StringReader;
import java.nio.file.Paths;
import java.util.UUID;

import static de.idadachverband.job.JobProgressState.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.mockito.Mockito.when;

public class ResultStateControllerTest
{

    @Mock
    private JobProgressService processService;
    
    @Mock
    private ProcessJobBean processJobBean;
    
    @Mock
    private TransformationBean transformation;

    @InjectMocks
    private ResultStateController cut;

    private String jobId;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        jobId = UUID.randomUUID().toString();
    }

    @Test
    public void getResultNotFound() throws Exception
    {
        when(processService.getState(jobId)).thenReturn(NOTFOUND);

        String actual = cut.getResult(jobId);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(NOTFOUND.toString()));
        assertThat(jsonObject.getString("jobId"), Matchers.is(jobId));
    }

    @Test
    public void getResultProcessing() throws Exception
    {
        when(processService.getState(jobId)).thenReturn(PROCESSING);

        String actual = cut.getResult(jobId);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(PROCESSING.toString()));
        assertThat(jsonObject.getString("jobId"), Matchers.is(jobId));
    }

    @Test
    public void getResultDone() throws Exception
    {
        when(processService.getState(jobId)).thenReturn(SUCCESS);
        when(processService.getJob(jobId)).thenReturn(processJobBean);
        when(processJobBean.getTransformation()).thenReturn(transformation);
        when(transformation.getCoreName()).thenReturn("corename");
        when(transformation.getInstitutionId()).thenReturn("institution");
        when(transformation.getArchivedVersion()).thenReturn(new VersionKey(1,0));

        String actual = cut.getResult(jobId);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(SUCCESS.toString()));
        assertThat(jsonObject.getString("jobId"), Matchers.is(jobId));
        assertThat(jsonObject.getString("path"), Matchers.equalTo(Paths.get("corename", "institution", "1.0").toString()));
    }
}