package de.idadachverband.archive.bean;

import lombok.NonNull;

public class ArchiveInstitutionBean extends AbstractArchiveBean<ArchiveCoreBean, ArchiveVersionBean>
{
    public ArchiveInstitutionBean(String institutionName, @NonNull ArchiveCoreBean parent)
    {
        super(institutionName, parent);
    }
    
    public String getCoreName()
    {
        return parent.name;
    }

    public ArchiveVersionBean getLatestVersion()
    {
        return (entries.isEmpty())
                ? null
                : entries.get(entries.size() - 1);
    }
}
