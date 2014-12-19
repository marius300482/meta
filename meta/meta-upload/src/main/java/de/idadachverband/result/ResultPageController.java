package de.idadachverband.result;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by boehm on 02.10.14.
 */
@RequestMapping("/result")
@Controller
public class ResultPageController
{
    @RequestMapping("success")
    public String success(@RequestParam("result") String result, ModelMap map)
    {
        map.addAttribute("result", result);
        return "uploadSuccess";
    }

    @RequestMapping("failure")
    public String failure(ModelMap map)
    {
        return "uploadFailure";
    }
}
