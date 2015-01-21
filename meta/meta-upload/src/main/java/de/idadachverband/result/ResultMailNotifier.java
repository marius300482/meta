package de.idadachverband.result;

import de.idadachverband.transform.TransformationBean;
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

    private final UserService userService;
    @Value("${result.mail.from}")
    private String mailFrom;
    @Value("${result.mail.subject}")
    private String subject;

    @Inject
    public ResultMailNotifier(MailSender mailSender, Configuration freemarkerMailConfiguration, UserService userService)
    {
        this.mailSender = mailSender;
        this.freemarkerMailConfiguration = freemarkerMailConfiguration;
        this.userService = userService;
    }

    public void notify(TransformationBean transformationBean) throws NotificationException
    {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(userService.getEmail());
        email.setSubject(subject);
        email.setFrom(mailFrom);

        Map<String, Object> model = new HashMap();
        model.put("user", userService.getUsername());
        model.put("t", transformationBean);
        final String result = transformationBean.getException() == null ? "Success" : "Failure";
        model.put("result", result);

        try
        {
            final String text = FreeMarkerTemplateUtils.processTemplateIntoString(freemarkerMailConfiguration.getTemplate("result-mail.ftl"), model);
            email.setText(text);
            log.debug("Send mail {}", email);
            mailSender.send(email);
        } catch (IOException | TemplateException | MailException e)
        {
            log.warn("Failed to send mail {} for transformation {}", email, transformationBean, e);
            throw new NotificationException(e);
        }
    }
}
