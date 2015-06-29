package de.idadachverband.result;

import de.idadachverband.job.JobBean;
import de.idadachverband.user.IdaUser;
import de.idadachverband.user.UserService;
import freemarker.template.Configuration;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import javax.inject.Inject;
import javax.inject.Named;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Sends notification of result to logged in user.
 * Created by boehm on 02.10.14.
 */
@Named
@Slf4j
public class ResultMailNotifier implements ResultNotifier
{

    private final MailSender mailSender;

    private final Configuration freemarkerMailConfiguration;

    @Value("${result.mail.from}")
    private String mailFrom;
    @Value("${result.mail.subject}")
    private String subject;

    @Inject
    public ResultMailNotifier(MailSender mailSender, Configuration freemarkerMailConfiguration)
    {
        this.mailSender = mailSender;
        this.freemarkerMailConfiguration = freemarkerMailConfiguration;
    }

    public void notify(JobBean jobBean) throws NotificationException
    {
        String result = "";
        switch (jobBean.getProgressState()) 
        {
            case FAILURE: 
                result = "Failure";
                break;
            case CANCELLED:
                result = "Cancelled";
                break;
            default:
                result = "Success";    
        }
        
        IdaUser user = jobBean.getUser();
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(user.getEmail());
        email.setSubject(subject + " (" + result + ")");
        email.setFrom(mailFrom);

        Map<String, Object> model = new HashMap<>();
        model.put("user", user.getUsername());
        model.put("t", jobBean);
        model.put("result", result);
        model.put("message", jobBean.getResultMessage());

        try
        {
            final String text = FreeMarkerTemplateUtils.processTemplateIntoString(freemarkerMailConfiguration.getTemplate("result-mail.ftl"), model);
            email.setText(text);
            log.debug("Send mail {}", email);
            mailSender.send(email);
        } catch (IOException | TemplateException | MailException e)
        {
            log.warn("Failed to send mail {} for job {}", email, jobBean, e);
            throw new NotificationException(e);
        }
    }
}
