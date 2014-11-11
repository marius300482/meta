package de.idadachverband.archive;

import de.idadachverband.solr.SolrService;
import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.Set;

/**
 * Created by boehm on 30.10.14.
 */
@Controller
@RequestMapping("/archive")
public class ArchiveController
{
    private final Path archivePath;

    private final HashService hashService;

    private final Set<SolrService> solrServiceSet;

    @Inject
    public ArchiveController(Path archivePath, HashService hashService, Set<SolrService> solrServiceSet)
    {
        this.archivePath = archivePath;
        this.hashService = hashService;
        this.solrServiceSet = solrServiceSet;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mav) throws IOException
    {
        mav.setViewName("archiveList");
        final HashedFileNameFileVisitor hashedFileNameFileVisitor = new HashedFileNameFileVisitor(hashService);
        Files.createDirectories(archivePath);
        Files.walkFileTree(archivePath, hashedFileNameFileVisitor);
        final Map<String, Path> fileMap = hashedFileNameFileVisitor.getFileMap();
        mav.addObject("fileMap", fileMap);
        mav.addObject("solrSet", solrServiceSet);
        return mav;
    }

    @RequestMapping(value = "/reindex/{solrService}", method = RequestMethod.GET)
    public ModelAndView reindex(@PathVariable SolrService solrService, ModelAndView mav) throws IOException, SolrServerException
    {
        final Path solrPath = archivePath.resolve(solrService.getName());
        final ArchiveFileVisitor archiveFileVisitor = new ArchiveFileVisitor();
        Files.walkFileTree(solrPath, archiveFileVisitor);
        solrService.reindex(archiveFileVisitor.getPaths());

        return mav;
    }
}
