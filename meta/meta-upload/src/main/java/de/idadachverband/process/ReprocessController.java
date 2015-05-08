package de.idadachverband.process;

import javax.inject.Inject;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.ArchiveService;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.BatchJobBean;
import de.idadachverband.solr.SolrService;

@Slf4j
@Controller
@RequestMapping("/process")
public class ReprocessController
{
    private final ReprocessService reprocessService;
    
    @Inject
    public ReprocessController(ReprocessService reprocessService)
    {
        this.reprocessService = reprocessService;
    }
    
    @RequestMapping(value = "reprocess/{solrService}", method = RequestMethod.GET)
    public String reprocessCore(
            @PathVariable("solrService") SolrService solrService,
            ModelMap map) throws ArchiveException
    {
        BatchJobBean jobBean = reprocessService.reprocessCoreAsync(solrService);
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", "ALL");
        map.addAttribute("version", "LATEST");
        map.addAttribute("jobId", jobBean.getJobId());

        return "redirect:/process/reprocessing";
    }
    
    @RequestMapping(value = "reprocess/{solrService}/{institution}", method = RequestMethod.GET)
    public String reprocessInstitution(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") IdaInstitutionBean institution,
            ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", institution.getInstitutionName());
        map.addAttribute("version", "LATEST");
        
        try 
        {
            ReprocessJobBean jobBean = reprocessService.reprocessInstitutionAsync(solrService, institution);
            map.addAttribute("version", jobBean.getVersionString());
            map.addAttribute("jobId", jobBean.getJobId());
        } catch (ArchiveException e)
        {
            log.warn("Re-processing of core {} for institution {} failed", solrService, institution, e);
            map.addAttribute("exception", e.getClass().getSimpleName());
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reprocessFailureView";
        }
        return "redirect:/process/reprocessing";
    }
    
    @RequestMapping(value = "reprocess/{solrService}/{institution}/{version}", method = RequestMethod.GET)
    public String reprocessVersion(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") IdaInstitutionBean institution,
            @PathVariable("version") String versionId,
            ModelMap map) 
    {
       return reprocessUpdate(solrService, institution, versionId, ArchiveService.NO_UPDATE, map);
    }
    
    @RequestMapping(value = "reprocess/{solrService}/{institution}/{version}/{update}", method = RequestMethod.GET)
    public String reprocessUpdate(
            @PathVariable("solrService") SolrService solrService,
            @PathVariable("institution") IdaInstitutionBean institution,
            @PathVariable("version") String versionId,
            @PathVariable("update") String upToUpdateId,
            ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        map.addAttribute("institution", institution.getInstitutionName());
        map.addAttribute("version", versionId+"."+upToUpdateId);
        try
        {
            ReprocessJobBean jobBean = reprocessService.reprocessVersionAsync(solrService, institution, versionId, upToUpdateId);
            map.addAttribute("version", jobBean.getVersionString());
            map.addAttribute("jobId", jobBean.getJobId());
        } catch (ArchiveException e)
        {
            log.warn("Re-processing of upload {}.{} for institution {} on core {} failed", 
                    versionId, upToUpdateId, institution, solrService, e);
            map.addAttribute("exception", e.getClass().getSimpleName());
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reprocessFailureView";
        }
        return "redirect:/process/reprocessing";
    }
    
    @RequestMapping(value = "/reprocessing", method = RequestMethod.GET)
    public String reindexing(
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
        return "reprocessingView";
    }
}
