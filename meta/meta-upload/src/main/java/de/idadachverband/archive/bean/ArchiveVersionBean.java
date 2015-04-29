package de.idadachverband.archive.bean;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import de.idadachverband.archive.ArchiveService;
import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

@Getter
@Setter
public class ArchiveVersionBean extends AbstractArchiveBean<ArchiveInstitutionBean, ArchiveUpdateBean>
{
    private int versionNumber;

    private Date date;
    
    private Path uploadFile, workingFormatFile, solrFormatFile;

    public ArchiveVersionBean(
            String versionId, @NonNull ArchiveInstitutionBean parent)
    {
        super(versionId, parent);
    }
    
    public ArchiveUpdateBean getLatestUpdate()
    {
        return (entries.isEmpty())
                ? null
                : entries.get(entries.size() - 1);
    }
    
    public List<ArchiveUpdateBean> getUpdatesUpTo(String updateId)
    {
        final ArrayList<ArchiveUpdateBean> updates = new ArrayList<>();
        
        if (!ArchiveService.NO_UPDATE.equals(updateId))
        {
            for (ArchiveUpdateBean update : entries) {
                updates.add(update);
                if (update.getName().equals(updateId))
                {
                    //stop here
                    break;
                }
            }
        }
        return updates;
    }
    
    public String getCoreName()
    {
        return parent.getCoreName();
    }
    
    public String getInstitutionName()
    {
        return parent.name;
    }
}
