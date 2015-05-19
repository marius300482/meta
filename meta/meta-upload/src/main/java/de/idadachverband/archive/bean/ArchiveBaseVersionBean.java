package de.idadachverband.archive.bean;

import java.util.ArrayList;
import java.util.List;

import de.idadachverband.archive.VersionKey;
import lombok.Getter;

@Getter
public class ArchiveBaseVersionBean extends ArchiveVersionBean
{
    private final List<ArchiveVersionBean> incrementalUpdates = new ArrayList<>();

    public ArchiveBaseVersionBean(VersionKey version)
    {
        super(version);
    }
    
    public List<ArchiveVersionBean> getUpdatesUpTo(int updateNumber)
    {
       final ArrayList<ArchiveVersionBean> updates = new ArrayList<>();
        
       for (ArchiveVersionBean update : incrementalUpdates) 
       {
           if (update.getUpdateNumber() <= updateNumber) {
               updates.add(update);
           }
       }
       return updates;
    }
    
    public ArchiveVersionBean find(VersionKey version)
    {
        for (ArchiveVersionBean updateVersion : incrementalUpdates)
        {
            if (updateVersion.getVersion().equals(version))
            {
                return updateVersion;
            }
        }
        return null;
    }
}
