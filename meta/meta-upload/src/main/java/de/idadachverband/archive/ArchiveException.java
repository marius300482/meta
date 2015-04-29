package de.idadachverband.archive;

public class ArchiveException extends Exception
{
    private static final long serialVersionUID = 2941512952012547433L;
    
    public ArchiveException(String message, Exception e)
    {
        super(message, e);
    }
    
    public ArchiveException(String message)
    {
        super(message);
    }

}
