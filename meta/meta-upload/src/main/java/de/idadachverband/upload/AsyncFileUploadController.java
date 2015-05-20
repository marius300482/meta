package de.idadachverband.upload;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.process.ProcessService;
import de.idadachverband.solr.SolrService;
import de.idadachverband.user.AuthenticationNotFoundException;
import de.idadachverband.user.IdaUser;
import de.idadachverband.user.UserService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;

/**
 * Created by boehm on 23.09.14.
 */
@Controller
@RequestMapping(value = "/upload")
@Slf4j
public class AsyncFileUploadController
{
    @Inject
    private UserService userService;
    
    @Inject
    private ProcessService processService;

    @Inject
    private SimpleDateFormat dateFormat;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView prepareUploadForm() throws AuthenticationNotFoundException
    {
        ModelAndView mav = new ModelAndView("uploadform");
        IdaUser user = userService.getUser();
        
        Map<String, IdaInstitutionBean> institutionsMap = new HashMap<String, IdaInstitutionBean>();
        boolean allowIncremental = false;
        boolean incrementalDefault = false;
        for (IdaInstitutionBean institution : user.getInstitutionsSet())
        {
            institutionsMap.put(institution.getInstitutionId(), institution);
            allowIncremental = (institution.isIncrementalUpdateAllowed()) ? true : allowIncremental;
            incrementalDefault = (institution.isIncrementalUpdate()) ? true : incrementalDefault;
        }
        
        mav.addObject("institutions", institutionsMap);
        mav.addObject("solrServices", user.getSolrServiceSet());
        mav.addObject("allowIncremental", allowIncremental);
        mav.addObject("incrementalDefault", incrementalDefault);      
        mav.addObject("transformation", new UploadFormBean());

        return mav;
    }


    /**
     * TODO Should check authorization for user
     *
     * @param uploadFormBean
     * @param authentication
     * @param map
     * @return
     */
    @RequestMapping(method = RequestMethod.POST)
    public Callable<String> handleFormUpload(@ModelAttribute final UploadFormBean uploadFormBean, final RedirectAttributes map)
    {
        log.info("Attempt to process uploaded file: {}", uploadFormBean);
        return new Callable<String>()
        {
            @Override
            public String call()
            {
                MultipartFile file = uploadFormBean.getFile();
                IdaUser user = userService.getUser(); 
                log.info("User: {} uploaded file: {}", user, file);
                Path tmpPath;
                try
                {
                    IdaInstitutionBean institution = uploadFormBean.getInstitution();
                    SolrService solr = uploadFormBean.getSolr();
                    if (!user.getSolrServiceSet().contains(solr) || !user.getInstitutionsSet().contains(institution))
                    {
                        throw new AccessDeniedException(solr.getName() + "/" + institution.getInstitutionId());
                    }
                    if (uploadFormBean.isIncremental() && !institution.isIncrementalUpdateAllowed())
                    {
                        throw new IllegalArgumentException("Institution " + institution + " does not support incremental updates!");
                    }

                    tmpPath = moveToTempFile(file, institution.getInstitutionId());

                    ProcessJobBean jobBean = 
                            processService.processAsync(tmpPath, institution, solr, file.getOriginalFilename(), uploadFormBean.isIncremental());
                    map.addAttribute("jobId", jobBean.getJobId());

                    return "redirect:result/success";
                } catch (IOException e)
                {
                    log.warn("Transformation of file {} failed", file, e);
                    map.addFlashAttribute("cause", e.getCause());
                    map.addFlashAttribute("message", e.getMessage());
                    map.addFlashAttribute("stacktrace", e.getStackTrace());
                    return "redirect:result/failure";
                }
            }
        };
    }

    private Path moveToTempFile(MultipartFile file, String institutionName) throws IOException
    {
        final String prefix = institutionName + "-" + dateFormat.format(new Date()) + "-upload-";
        final String suffix = file.getContentType().toLowerCase().equals("application/zip") ? ".tmp.zip" : ".tmp";
        Path tmpPath = Files.createTempFile(prefix, suffix);
        file.transferTo(tmpPath.toFile());
        log.debug("Moved uploaded file: {} to: {}", file, tmpPath);
        return tmpPath;
    }
}
