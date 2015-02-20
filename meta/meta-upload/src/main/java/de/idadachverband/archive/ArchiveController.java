package de.idadachverband.archive;

import de.idadachverband.archive.visitor.HashedFileNameFileVisitor;
import de.idadachverband.solr.SolrService;
import org.springframework.stereotype.Controller;
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

    private final Set<SolrService> solrServiceSet;

    private final HashedFileNameFileVisitor fileVisitor;

    @Inject
    public ArchiveController(Path archivePath, Set<SolrService> solrServiceSet, HashedFileNameFileVisitor fileVisitor)
    {
        this.archivePath = archivePath;
        this.solrServiceSet = solrServiceSet;
        this.fileVisitor = fileVisitor;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView list(ModelAndView mav) throws IOException
    {
        mav.setViewName("archiveList");
        Files.createDirectories(archivePath);
        Files.walkFileTree(archivePath, fileVisitor);
        final Map<String, Path> fileMap = fileVisitor.getFileMap();
        mav.addObject("fileMap", fileMap);
        mav.addObject("solrSet", solrServiceSet);
        return mav;
    }
}
