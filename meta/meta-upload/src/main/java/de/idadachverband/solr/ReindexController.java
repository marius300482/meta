package de.idadachverband.solr;

import de.idadachverband.archive.visitor.ArchiveFileVisitor;
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
import java.nio.file.Files;
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

    @Inject
    public ReindexController(Path archivePath)
    {
        this.archivePath = archivePath;
    }

    @RequestMapping(value = "/reindex/{solrService}", method = RequestMethod.GET)
    public String reindex(@PathVariable SolrService solrService, ModelMap map)
    {
        map.addAttribute("core", solrService.getName());
        final Path solrPath = archivePath.resolve(solrService.getName());
        final ArchiveFileVisitor archiveFileVisitor = new ArchiveFileVisitor();
        try
        {
            Files.walkFileTree(solrPath, archiveFileVisitor);
            solrService.reindex(archiveFileVisitor.getPaths());
        } catch (IOException | SolrServerException e)
        {
            log.warn("Re-indexing of core {} failed", solrService.getName(), e);
            map.addAttribute("cause", e.getCause());
            map.addAttribute("message", e.getMessage());
            map.addAttribute("stacktrace", e.getStackTrace());
            return "reindexFailureView";
        }

        return "redirect:../reindexDone";
    }

    @RequestMapping(value = "/reindexDone", method = RequestMethod.GET)
    public String reindexDone(@RequestParam("core") String core, ModelMap map)
    {
        map.addAttribute("core", core);
        return "reindexDoneView";
    }
}
