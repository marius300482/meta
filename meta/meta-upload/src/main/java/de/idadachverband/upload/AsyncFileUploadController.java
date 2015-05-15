package de.idadachverband.upload;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessJobBean;
import de.idadachverband.process.ProcessService;
import de.idadachverband.solr.SolrService;
import de.idadachverband.user.UserService;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
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
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
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
    private IdaInstitutionConverter idaInstitutionConverter;

    @Inject
    private Set<SolrService> solrServiceSet;

    @Inject
    private SolrService defaultSolrUpdater;

    @Inject
    private ProcessService processService;

    @Inject
    private SimpleDateFormat dateFormat;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView prepareUploadForm()
    {
        ModelAndView mav = new ModelAndView("uploadform");
        Map<String, IdaInstitutionBean> allInstitutions = 
                idaInstitutionConverter.getInstitutionsMap();
        
        if (userService.isAdmin())
        {
            mav.addObject("institutions", allInstitutions);
            mav.addObject("solrServices", solrServiceSet);
            mav.addObject("allowIncremental", true);
            mav.addObject("incrementalDefault", true);
        } else
        {
            final Set<String> institutionIds = userService.getInstitutionIds();
            final Map<String, IdaInstitutionBean> filteredInstitutions = new HashMap<>(1);
            for (Entry<String, IdaInstitutionBean> entry : allInstitutions.entrySet())
            {
                if (institutionIds.contains(entry.getKey()))
                {
                    filteredInstitutions.put(entry.getKey(), entry.getValue());
                }
            }
            mav.addObject("institutions", filteredInstitutions);
            mav.addObject("solrServices", Collections.singleton(defaultSolrUpdater));
            
            if (institutionIds.size() == 1)
            {
                IdaInstitutionBean idaInstitutionBean = idaInstitutionConverter.convert(institutionIds.iterator().next());                
                mav.addObject("allowIncremental", idaInstitutionBean.isIncrementalUpdateAllowed());
                mav.addObject("incrementalDefault", idaInstitutionBean.isIncrementalUpdate());
            } else
            {
                mav.addObject("allowIncremental", true);
                mav.addObject("incrementalDefault", true);
            }
        }
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
    public Callable<String> handleFormUpload(@ModelAttribute final UploadFormBean uploadFormBean,
                                             @AuthenticationPrincipal final Authentication authentication, final RedirectAttributes map)
    {
        log.info("Attempt to process uploaded file: {}", uploadFormBean);
        return new Callable<String>()
        {
            @Override
            public String call()
            {
                MultipartFile file = uploadFormBean.getFile();
                log.info("User: {} uploaded file: {}", authentication.getName(), file);
                Path tmpPath;
                try
                {
                    IdaInstitutionBean institution = uploadFormBean.getInstitution();
                    SolrService solr = uploadFormBean.getSolr();

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
