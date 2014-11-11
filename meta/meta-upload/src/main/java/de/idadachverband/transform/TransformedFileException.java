package de.idadachverband.transform;

/**
 * Created by boehm on 02.10.14.
 */
public class TransformedFileException extends Exception
{
    public TransformedFileException(Exception e)
    {
        super(e);
    }

    public TransformedFileException(String s)
    {
        super(s);
    }
}
