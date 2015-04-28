package de.idadachverband.archive;

import de.idadachverband.archive.visitor.HashedFileNameFileVisitor;
import de.idadachverband.solr.SolrService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Set;

/**
 * Created by boehm on 30.10.14.
 */
@Controller
@RequestMapping("/archive")
public class ArchiveController
{
    private final Set<SolrService> solrServiceSet;
    private final ArchiveService archiveService;

    @Inject
    public ArchiveController(Set<SolrService> solrServiceSet, HashedFileNameFileVisitor fileVisitor, ArchiveService archiveService)
    {
        this.solrServiceSet = solrServiceSet;
        this.archiveService = archiveService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mav) throws IOException
    {
        mav.setViewName("archiveList");
        mav.addObject("archiveTree", archiveService.getArchiveTree());
        mav.addObject("solrSet", solrServiceSet);
        return mav;
    }
    
    @RequestMapping(value = "delete/{core}/{institution}/{version}", method = RequestMethod.GET)
    public String reprocessVersion(
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionName,
            @PathVariable("version") String versionId,
            ModelMap map) throws FileNotFoundException
    {
        archiveService.deleteVersion(coreName, institutionName, versionId);
        return "redirect:/archive";
    }
    
    @RequestMapping(value = "delete/{core}/{institution}/{version}/{update}", method = RequestMethod.GET)
    public String reprocessUpdate(
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionName,
            @PathVariable("version") String versionId,
            @PathVariable("update") String updateId,
            ModelMap map) throws FileNotFoundException
    {
        archiveService.deleteUpdate(coreName, institutionName, versionId, updateId);
        return "redirect:/archive";
    }
}
