package de.idadachverband.result;

import de.idadachverband.transform.TransformationBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * Created by boehm on 02.10.14.
 */
@Named
public class ResultMailNotifier implements ResultNotifier
{

    @Inject
    private MailSender mailSender;

    @Value("${result.mail.to}")
    private String mailTo;

    @Value("${result.mail.from}")
    private String mailFrom;

    @Value("${result.mail.subject}")
    private String subject;

    @Override
    public void notify(TransformationBean transformationBean) throws NotificationException
    {
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(mailTo);
        email.setSubject(subject);
        if (transformationBean.getException() == null)
        {
            email.setText("Erfolg " + transformationBean.getKey());
        } else
        {
            email.setText("Fehler " + transformationBean.getException());
        }
        email.setFrom(mailFrom);

        try
        {
            mailSender.send(email);
        } catch (MailException e)
        {
            throw new NotificationException(e);
        }
    }
}
