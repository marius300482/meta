package de.idadachverband.archive.bean;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@RequiredArgsConstructor
@ToString(of = "coreName", includeFieldNames = false)
public class ArchiveCoreBean
{
    private final String coreName;
    
    private final List<ArchiveInstitutionBean> institutions = new ArrayList<>();
    
    public ArchiveInstitutionBean find(String institutionId)
    {
        for (ArchiveInstitutionBean institution : institutions)
        {
            if (institution.getInstitutionId().equals(institutionId))
            {
                return institution;
            }
        }
        return null;
    }
}
