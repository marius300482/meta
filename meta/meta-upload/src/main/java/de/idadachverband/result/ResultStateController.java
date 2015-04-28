package de.idadachverband.result;

import de.idadachverband.job.JobBean;
import de.idadachverband.job.JobProgressService;
import de.idadachverband.job.JobProgressState;
import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.concurrent.ExecutionException;

import static de.idadachverband.job.JobProgressState.DONE;
import static de.idadachverband.job.JobProgressState.FAILURE;

/**
 * Created by boehm on 11.11.14.
 */
@RequestMapping("/result")
@Controller
@Slf4j
public class ResultStateController
{
//    @Inject
//    private HashService hashService;

    @Inject
    private JobProgressService jobProgressService;

    @RequestMapping(value = "getResult", produces = "application/json")
    @ResponseBody
    public String getResult(@RequestParam("result") String key) throws ExecutionException, InterruptedException
    {
        log.debug("Query for result of job '{}'.", key);

        JobProgressState state = jobProgressService.getState(key);

        JsonObjectBuilder result = Json.createObjectBuilder();
        result.add("key", key);

        if (state == DONE)
        {
            JobBean jobBean = jobProgressService.getJob(key);
            if (jobBean != null && jobBean instanceof ProcessJobBean)
            {
                TransformationBean transformationBean = ((ProcessJobBean) jobBean).getTransformation();
                Path path = Paths.get(
                        transformationBean.getCoreName(), 
                        transformationBean.getInstitutionName(), 
                        transformationBean.getArchivedVersionId(), 
                        transformationBean.getArchivedUpdateId());
                result.add("path", path.toString());
            }
        }
        if (state == FAILURE)
        {
            Exception e = jobProgressService.getException(key);
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
