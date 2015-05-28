package de.idadachverband.admin;

import de.idadachverband.job.JobBean;
import de.idadachverband.job.JobProgressService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/jobs")
@Slf4j
public class StatusPageController
{
    @Inject
    private JobProgressService progressService;

    @RequestMapping(value = "status", method = RequestMethod.GET)
    public ModelAndView success(HttpServletRequest request)
    {
        ModelAndView modelAndView = new ModelAndView("jobs");
        // This is the only way to avoid a NPE, if not a ModelAttribute.
        Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
        if (inputFlashMap != null)
        {
            modelAndView.addObject("removedJobs", inputFlashMap.get("removedJobs"));
        }
        modelAndView.addObject("runningJobs", progressService.getRunningJobs());
        modelAndView.addObject("stoppedJobs", progressService.getStoppedJobs());

        return modelAndView;
    }

    @RequestMapping(value = "clear", method = RequestMethod.GET)
    public String clear()
    {
        final List<JobBean> removedJobs = progressService.clear();
        log.info("Removed jobs {}", removedJobs);
        // do redirect to not clear again on F5
        return "redirect:status";
    }

    @RequestMapping(value = "/cancel/{jobId}", method = RequestMethod.GET)
    public String cancel(@PathVariable("jobId") String jobId)
    {
        log.debug("Trying to cancel job {}", jobId);
        progressService.cancelJob(jobId);
        return "redirect:/jobs/status";
    }

    @RequestMapping(value = "/delete/{jobId}", method = RequestMethod.GET)
    public String delete(@PathVariable("jobId") String jobId)
    {
        log.debug("Trying to delete job {}", jobId);
        progressService.deleteJob(jobId);
        return "redirect:/jobs/status";
    }
}
