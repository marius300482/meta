package de.idadachverband.archive;

import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import de.idadachverband.process.ProcessStep;
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
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionId,
            @PathVariable("version") String version,
            HttpServletResponse response) throws ArchiveException
    {
        if (!userService.isAdmin() && !userService.getInstitutionIds().contains(institutionId)) 
        {
            log.warn("User {} tried to access file of institution {}.", userService.getUsername(), institutionId);
            throw new AccessDeniedException(institutionId);
        }
        
        ProcessStep step = ProcessStep.valueOf(stepName);
        Path path = archiveService.findFile(step, coreName, institutionId, VersionKey.parse(version));
        response.setContentType("application/zip");
        response.setHeader("content-Disposition", "attachment; filename=" + path.getFileName());

        return new FileSystemResource(path.toString());
    }
}