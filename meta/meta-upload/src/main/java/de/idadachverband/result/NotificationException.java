package de.idadachverband.result;

import org.springframework.mail.MailException;

/**
 * Created by boehm on 05.11.14.
 */
public class NotificationException extends Exception
{
    public NotificationException(MailException e)
    {
        super(e);
    }
}
