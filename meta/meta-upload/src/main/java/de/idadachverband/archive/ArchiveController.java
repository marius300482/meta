package de.idadachverband.archive;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

/**
 * Created by boehm on 30.10.14.
 */
@Controller
@RequestMapping("/archive")
public class ArchiveController
{
    private final ArchiveService archiveService;

    @Inject
    public ArchiveController(ArchiveService archiveService)
    {
        this.archiveService = archiveService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mav) throws ArchiveException
    {
        mav.setViewName("archiveList");
        mav.addObject("coreList", archiveService.getArchivedCores());
        return mav;
    }
    
    @RequestMapping(value = "delete/{core}/{institution}/{version:.+}", method = RequestMethod.GET)
    public String deleteVersion(
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionId,
            @PathVariable("version") String version,
            ModelMap map) throws ArchiveException 
    {
        archiveService.deleteVersion(coreName, institutionId, VersionKey.parse(version));
        return "redirect:/archive";
    }
}
