package de.idadachverband.solr;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.BatchJobBean;

import javax.inject.Inject;

import java.nio.file.Path;

/**
 * Created by boehm on 11.11.14.
 */
@Slf4j
@Controller
@RequestMapping("/solr")
public class ReindexController
{
    private final SolrUpdateService solrUpdateService;

    @Inject
    public ReindexController(Path archivePath, SolrUpdateService solrUpdateService)
    {
        this.solrUpdateService = solrUpdateService;
    }

    @RequestMapping(value = "/reindex/{solrService}", method = RequestMethod.GET)
    public String reindexCore(@PathVariable("solrService") SolrService solrService,
                              ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", "ALL");
        map.addAttribute("version", "LATEST");
        
        try
        {
            final BatchJobBean jobBean = solrUpdateService.reindexCoreAsync(solrService);
            map.addAttribute("jobId", jobBean.getJobId());
        } catch (ArchiveException e)
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
        map.addAttribute("version", "LATEST");

        try
        {
            ReindexJobBean reindexJobBean = solrUpdateService.reindexInstitutionAsync(solrService, institution);
            map.addAttribute("jobId", reindexJobBean.getJobId());
            map.addAttribute("version", reindexJobBean.getVersion().toString());
        } catch (ArchiveException e)
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
    
    @RequestMapping(value = "/reindex/{solrService}/{institution}/{version:.+}", method = RequestMethod.GET)
    public String reindexVersion(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") IdaInstitutionBean institution,
            @PathVariable("version") String version,
            ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", institution.getInstitutionName());
        map.addAttribute("version", version);

        try
        {
            ReindexJobBean reindexJobBean = 
                    solrUpdateService.reindexVersionAsync(solrService, institution, VersionKey.parse(version));
            map.addAttribute("jobId", reindexJobBean.getJobId());
        } catch (ArchiveException e)
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
            @RequestParam("version") String version, 
            @RequestParam("jobId") String jobId, 
            ModelMap map)
    {
        map.addAttribute("core", core);
        map.addAttribute("institution", institution);
        map.addAttribute("version", version);
        map.addAttribute("jobId", jobId);
        return "reindexingView";
    }
}
