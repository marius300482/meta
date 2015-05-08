package de.idadachverband.archive.bean;

import java.nio.file.Path;
import java.util.Date;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

@Getter
@Setter
public class ArchiveUpdateBean extends AbstractArchiveBean<ArchiveVersionBean, AbstractArchiveBean<?,?>>
{
    private int updateNumber;

    private Date date;
    
    private Path uploadFile, workingFormatFile, solrFormatFile;

    public ArchiveUpdateBean(
            String updateId, @NonNull ArchiveVersionBean parent)
    {
        super(updateId, parent);
    }  
}
