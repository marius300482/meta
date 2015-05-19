package de.idadachverband.archive.bean;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.institution.IdaInstitutionBean;

@Getter
@RequiredArgsConstructor
@ToString(of = "institutionBean", includeFieldNames = false)
public class ArchiveInstitutionBean
{
    private final IdaInstitutionBean institutionBean;
    
    private List<ArchiveBaseVersionBean> baseVersions = new ArrayList<>();
    
    public String getInstitutionId()
    {
        return institutionBean.getInstitutionId();
    }
    
    public String getInstitutionName()
    {
        return institutionBean.getInstitutionName();
    }

    public ArchiveBaseVersionBean getLatestVersion()
    {
        return (baseVersions.isEmpty())
                ? null
                : baseVersions.get(baseVersions.size() - 1);
    }
    
    public ArchiveBaseVersionBean find(VersionKey version)
    {
        for (ArchiveBaseVersionBean baseVersion : baseVersions)
        {
            if (baseVersion.getVersion().equals(version))
            {
                return baseVersion;
            }
        }
        return null;
    }
}
