package de.idadachverband.upload;

import de.idadachverband.archive.HashService;
import de.idadachverband.result.ResultStateController;
import de.idadachverband.transform.TransformationProgressService;
import org.hamcrest.Matchers;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import javax.json.Json;
import javax.json.JsonObject;
import java.io.File;
import java.io.StringReader;
import java.util.UUID;

import static de.idadachverband.transform.TransformationProgressState.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.when;

public class ResultStateControllerTest
{

    @Mock
    private TransformationProgressService processService;

    @Mock
    private HashService hashService;

    @InjectMocks
    private ResultStateController cut;

    private String key;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        key = UUID.randomUUID().toString();
    }

    @Test
    public void getResultNotFound() throws Exception
    {
        when(processService.getState(key)).thenReturn(NOTFOUND);

        String actual = cut.getResult(key);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(NOTFOUND.toString()));
        assertThat(jsonObject.getString("key"), Matchers.is(key));
    }

    @Test
    public void getResultProcessing() throws Exception
    {
        when(processService.getState(key)).thenReturn(PROCESSING);

        String actual = cut.getResult(key);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(PROCESSING.toString()));
        assertThat(jsonObject.getString("key"), Matchers.is(key));
    }

    @Test
    public void getResultDone() throws Exception
    {
        when(processService.getState(key)).thenReturn(DONE);
        when(processService.getFile(key)).thenReturn(new File(""));

        String filename = "hashedFilename";
        when(hashService.getHashedFileName(any(File.class))).thenReturn(filename);

        String actual = cut.getResult(key);

        JsonObject jsonObject = Json.createReader(new StringReader(actual)).readObject();
        assertThat(jsonObject.getString("state"), Matchers.is(DONE.toString()));
        assertThat(jsonObject.getString("filename"), Matchers.is(filename));
        assertThat(jsonObject.getString("key"), Matchers.is(key));
    }
}