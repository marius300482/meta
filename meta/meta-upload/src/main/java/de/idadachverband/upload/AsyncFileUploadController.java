package de.idadachverband.upload;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessService;
import de.idadachverband.solr.SolrService;
import de.idadachverband.transform.TransformationBean;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
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
    private IdaInstitutionConverter idaInstitutionConverter;

    @Inject
    private Set<IdaInstitutionBean> institutionsSet;

    @Inject
    private Set<SolrService> solrServiceSet;

    @Inject
    private SolrService defaultSolrUpdater;

    @Inject
    private ProcessService processService;

    @Inject
    private SimpleDateFormat dateFormat;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView prepareUploadForm(@AuthenticationPrincipal Authentication authentication)
    {
        ModelAndView mav = new ModelAndView("uploadform");

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        GrantedAuthority authority = (GrantedAuthority) authorities.toArray()[0];

        if ("admin".equals(authority.getAuthority()))
        {
            mav.addObject("institutions", institutionsSet);
            mav.addObject("solrServices", solrServiceSet);
        } else
        {
            Set<IdaInstitutionBean> idaInstitutions = new HashSet<>(1);
            IdaInstitutionBean idaInstitutionBean = idaInstitutionConverter.convert(authority.getAuthority());
            idaInstitutions.add(idaInstitutionBean);
            mav.addObject("institutions", idaInstitutions);
            Set<SolrService> solrServices = new HashSet<>(1);
            solrServices.add(defaultSolrUpdater);
            mav.addObject("solrServices", solrServices);
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
                File tempFile;
                try
                {
                    IdaInstitutionBean institution = uploadFormBean.getInstitution();
                    SolrService solr = uploadFormBean.getSolr();

                    tempFile = moveToTempFile(file, institution.getInstitutionName());

                    TransformationBean transformationBean = processService.process(tempFile, institution, solr, file.getOriginalFilename());
                    map.addAttribute("result", transformationBean.getKey());

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

    private File moveToTempFile(MultipartFile file, String institutionName) throws IOException
    {
        final String prefix = institutionName + "-" + dateFormat.format(new Date()) + "-upload-";
        final String suffix = file.getContentType().toLowerCase().equals("application/zip") ? ".tmp.zip" : ".tmp";
        File tempFile = File.createTempFile(prefix, suffix);
        file.transferTo(tempFile);
        log.debug("Moved uploaded file: {} to: {}", file, tempFile);
        return tempFile;
    }
}
