package de.idadachverband.result;

import de.idadachverband.archive.HashService;
import de.idadachverband.transform.TransformationProgressService;
import de.idadachverband.transform.TransformationProgressState;
import de.idadachverband.transform.TransformedFileException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import java.io.File;
import java.util.concurrent.ExecutionException;

import static de.idadachverband.transform.TransformationProgressState.DONE;
import static de.idadachverband.transform.TransformationProgressState.FAILURE;

/**
 * Created by boehm on 11.11.14.
 */
@Controller
@Slf4j
public class ResultStateController
{
    @Inject
    private HashService hashService;

    @Inject
    private TransformationProgressService transformationProgressService;

    @RequestMapping(value = "getResult", produces = "application/json")
    @ResponseBody
    public String getResult(@RequestParam("result") String key) throws ExecutionException, InterruptedException
    {
        log.debug("Query for result of job '{}'.", key);

        TransformationProgressState state = transformationProgressService.getState(key);

        JsonObjectBuilder result = Json.createObjectBuilder();
        result.add("key", key);

        if (state == DONE)
        {
            try
            {
                File file = transformationProgressService.getFile(key);
                String hashedFileName = hashService.getHashedFileName(file);
                result.add("filename", hashedFileName);
            } catch (TransformedFileException e)
            {
                state = FAILURE;
                result.add("exception", e.toString());
            }
        }
        if (state == FAILURE)
        {
            Exception e = transformationProgressService.getException(key);
            if (e != null)
            {
                result.add("exception", e.toString());
            } else
            {
                result.add("exception", "Unknown failure");
            }
        }

        result.add("state", String.valueOf(state));

        JsonObject jsonObject = result.build();
        log.debug("Result of job is {}", jsonObject);
        return jsonObject.toString();
    }
}
