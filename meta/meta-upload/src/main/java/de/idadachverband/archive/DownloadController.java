package de.idadachverband.archive;

import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.process.ProcessStep;
import de.idadachverband.solr.SolrService;
import de.idadachverband.user.IdaUser;
import de.idadachverband.user.UserService;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import java.nio.file.Path;

/**
 * Provides access to files based on hashed file names.
 *
 * @author boehm
 */
@Slf4j
@Controller
public class DownloadController
{    
    private ArchiveService archiveService;
    
    private UserService userService;
    
    @Inject
    public DownloadController(ArchiveService archiveService, UserService userService)
    {
        this.archiveService = archiveService;
        this.userService = userService;
    }
    
    @RequestMapping(value = "/files/{step}/{core}/{institution}/{version:.+}", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource downloadVersion(
            @PathVariable("step") String stepName, 
            @PathVariable("core") SolrService solr,
            @PathVariable("institution") IdaInstitutionBean institution,
            @PathVariable("version") String version,
            HttpServletResponse response) throws ArchiveException
    {
        IdaUser user = userService.getUser();
        if (!user.getSolrServiceSet().contains(solr) || !user.getInstitutionsSet().contains(institution)) 
        {
            log.warn("User {} tried to access file of {}, {}.", user, solr, institution);
            throw new AccessDeniedException(solr.getName() + "/" + institution.getInstitutionId());
        }
        
        ProcessStep step = ProcessStep.valueOf(stepName);
        Path path = archiveService.findFile(step, solr.getName(), institution.getInstitutionId(), VersionKey.parse(version));
        response.setContentType("application/zip");
        response.setHeader("content-Disposition", "attachment; filename=" + path.getFileName());

        return new FileSystemResource(path.toString());
    }
}