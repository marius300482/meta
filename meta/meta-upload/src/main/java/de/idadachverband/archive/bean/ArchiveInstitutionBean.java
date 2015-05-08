package de.idadachverband.archive.bean;

import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Getter;
import lombok.NonNull;

@Getter
public class ArchiveInstitutionBean extends AbstractArchiveBean<ArchiveCoreBean, ArchiveVersionBean>
{
    private final IdaInstitutionBean institutionBean;
    
    public ArchiveInstitutionBean(IdaInstitutionBean institutionBean, @NonNull ArchiveCoreBean parent)
    {
        super(institutionBean.getInstitutionId(), parent);
        this.institutionBean = institutionBean;
    }
    
    public String getCoreName()
    {
        return parent.id;
    }
    
    public String getInstitutionName()
    {
        return institutionBean.getInstitutionName();
    }

    public ArchiveVersionBean getLatestVersion()
    {
        return (entries.isEmpty())
                ? null
                : entries.get(entries.size() - 1);
    }
}
