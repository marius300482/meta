package de.idadachverband.solr;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.BatchJobBean;

import javax.inject.Inject;

import java.io.IOException;
import java.nio.file.Path;

/**
 * Created by boehm on 11.11.14.
 */
@Slf4j
@Controller
@RequestMapping("/solr")
public class ReindexController
{
    private final SolrReindexService solrReindexService;

    @Inject
    public ReindexController(Path archivePath, SolrReindexService solrReindexService)
    {
        this.solrReindexService = solrReindexService;
    }

    @RequestMapping(value = "/reindex/{solrService}", method = RequestMethod.GET)
    public String reindexCore(@PathVariable("solrService") SolrService solrService,
                              ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", "ALL");

        try
        {
            final BatchJobBean jobBean = solrReindexService.reindexCoreAsync(solrService);
            map.addAttribute("jobId", jobBean.getJobId());
        } catch (IOException e)
        {
            log.warn("Re-indexing of core {} failed", solrService.getName(), e);
            map.addAttribute("exception", e.getClass().getSimpleName());
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reindexFailureView";
        }

        return "redirect:/solr/reindexing";
    }

    @RequestMapping(value = "/reindex/{solrService}/{institution}", method = RequestMethod.GET)
    public String reindexInstitution(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") IdaInstitutionBean institution,
            ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", institution.getInstitutionName());

        try
        {
            ReindexJobBean reindexJobBean = solrReindexService.reindexInstitutionAsync(solrService, institution);
            map.addAttribute("jobId", reindexJobBean.getJobId());
        } catch (IOException e)
        {
            log.warn("Re-indexing of core {} for institution {} failed", solrService.getName(), institution.getInstitutionName(), e);
            map.addAttribute("exception", e.getClass().getSimpleName());
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reindexFailureView";
        }

        return "redirect:/solr/reindexing";
    }
    
    @RequestMapping(value = "/reindexing", method = RequestMethod.GET)
    public String reindexDone(
            @RequestParam("core") String core, 
            @RequestParam("institution") String institution,
            @RequestParam("jobId") String jobId, 
            ModelMap map)
    {
        map.addAttribute("core", core);
        map.addAttribute("institution", institution);
        map.addAttribute("jobId", jobId);
        return "reindexingView";
    }
}
