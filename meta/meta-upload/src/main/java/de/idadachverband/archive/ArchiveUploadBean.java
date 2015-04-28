package de.idadachverband.archive;

import java.util.Date;

import lombok.Getter;

@Getter
public class ArchiveUploadBean extends ArchiveBean
{
    private final int version;
    private final Date date;
    
    private final String uploadFileName;

    public ArchiveUploadBean(String name, int version, Date date,
            String uploadFileName)
    {
        super(name);
        this.version = version;
        this.date = date;
        this.uploadFileName = uploadFileName;
    }
}
