package de.idadachverband.solr;

import lombok.extern.slf4j.Slf4j;
import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    private final Path archivePath;
    private final SolrReindexService solrReindexService;

    @Inject
    public ReindexController(Path archivePath, SolrReindexService solrReindexService)
    {
        this.archivePath = archivePath;
        this.solrReindexService = solrReindexService;
    }

    @RequestMapping(value = "/reindex/{solrService}", method = RequestMethod.GET)
    public String reindexCore(@PathVariable("solrService") SolrService solrService,
                              ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", "");

        try
        {
            final String result = solrReindexService.reindexCore(solrService);
            map.addAttribute("result", result);
        } catch (IOException | SolrServerException e)
        {
            log.warn("Re-indexing of core {} failed", solrService.getName(), e);
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reindexFailureView";
        }

        return "redirect:/solr/reindexDone";
    }

    @RequestMapping(value = "/reindex/{solrService}/{institution}", method = RequestMethod.GET)
    public String reindexInstitution(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") String institutionName,
            ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", institutionName);

        try
        {
            final String result = solrReindexService.reindexInstitutionOnCore(institutionName, solrService);
            map.addAttribute("result", result);
        } catch (IOException | SolrServerException e)
        {
            log.warn("Re-indexing of core {} for institution {} failed", solrService.getName(), institutionName, e);
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reindexFailureView";
        }

        return "redirect:/solr/reindexDone";
    }

    @RequestMapping(value = "/reindexDone", method = RequestMethod.GET)
    public String reindexDone(@RequestParam("core") String core, @RequestParam("institution") String institution, ModelMap map)
    {
        map.addAttribute("core", core);
        map.addAttribute("institution", institution);
        return "reindexDoneView";
    }
}
