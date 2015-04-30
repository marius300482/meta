package de.idadachverband.archive;

import lombok.extern.slf4j.Slf4j;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import de.idadachverband.process.ProcessStep;

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
    
    @Inject
    public DownloadController(ArchiveService archiveService)
    {
        this.archiveService = archiveService;
    }
    
    @RequestMapping(value = "/files/{step}/{core}/{institution}/{version}", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource downloadVersion(
            @PathVariable("step") String stepName, 
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionName,
            @PathVariable("version") String versionId,
            HttpServletResponse response) throws ArchiveException
    {
        return download(stepName, coreName, institutionName, versionId, ArchiveService.NO_UPDATE, response);
    }
    
    @RequestMapping(value = "/files/{step}/{core}/{institution}/{version}/{update}", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource download(
            @PathVariable("step") String stepName, 
            @PathVariable("core") String coreName,
            @PathVariable("institution") String institutionName,
            @PathVariable("version") String versionId,
            @PathVariable("update") String updateId,
            HttpServletResponse response) throws ArchiveException
    {
        ProcessStep step = ProcessStep.valueOf(stepName);
        Path path = archiveService.findFile(step, coreName, institutionName, versionId, updateId);
        response.setContentType("application/zip");
        response.setHeader("content-Disposition", "attachment; filename=" + path.getFileName());

        return new FileSystemResource(path.toString());
    }
}