package de.idadachverband.admin;

import de.idadachverband.transform.TransformationBean;
import de.idadachverband.transform.TransformationProgressService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
import java.util.concurrent.Future;

@Controller
@RequestMapping(value = "/transformations")
@Slf4j
public class StatusPageController
{
    @Inject
    private TransformationProgressService progressService;

    @RequestMapping(value = "status", method = RequestMethod.GET)
    public ModelAndView success(HttpServletRequest request)
    {
        ModelAndView modelAndView = new ModelAndView("transformations");
        // This is the only way to avoid a NPE, if not a ModelAttribute.
        Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
        if (inputFlashMap != null)
        {
            modelAndView.addObject("removedTransformations", inputFlashMap.get("removedTransformations"));
        }
        final Map<String, TransformationBean> transformations = progressService.getTranformations();
        modelAndView.addObject("transformations", transformations);

        return modelAndView;
    }

    @RequestMapping(value = "clear", method = RequestMethod.GET)
    public String clear(RedirectAttributes redirectAttributes)
    {
        final Map<String, TransformationBean> removedTransformations = progressService.clear();
        log.info("Removed transformation {}", removedTransformations);
        // do redirect to not clear again on F5
        redirectAttributes.addFlashAttribute("removedTransformations", removedTransformations);
        return "redirect:status";
    }

    @RequestMapping(value = "/cancel/{key}", produces = "application/json", method = RequestMethod.GET)
    @ResponseBody
    public String cancel(@PathVariable("key") String key)
    {
        log.debug("Trying to cancel transformation with key {}", key);
        JsonObjectBuilder result = Json.createObjectBuilder();
        result.add("success", false);
        final TransformationBean transformation = progressService.getTransformation(key);
        log.info("Trying to cancel transformation {}", transformation);
        final Future<?> future = transformation.getFuture();
        if (!future.isDone())
        {
            final boolean cancel = future.cancel(true);
            if (cancel)
            {
                result.add("success", true);
            }
        }
        return result.build().toString();
    }

}
