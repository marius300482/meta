package de.idadachverband.archive;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Provides access to files based on hashed file names.
 *
 * @author boehm
 */
@Slf4j
@Controller
public class DownloadController
{
    @Setter
    @Inject
    private HashedFileService archiveHashedFileService;

    /**
     * @param filename
     * @return
     * @throws FileNotFoundException
     */
    @RequestMapping(value = "/files/{filename:.+}", method = RequestMethod.GET)
    @ResponseBody
    public FileSystemResource download(@PathVariable("filename") String filename, HttpServletResponse response) throws IOException
    {
        if ((null == filename) || (filename.trim().length() == 0))
        {
            log.warn("Found no file for empty filename");
            throw new FileNotFoundException();
        }
        File path = archiveHashedFileService.findFile(filename);
        response.setContentType("application/zip");
        response.setHeader("content-Disposition", "attachment; filename=" + path.getName());

        return new FileSystemResource(path);
    }
}
