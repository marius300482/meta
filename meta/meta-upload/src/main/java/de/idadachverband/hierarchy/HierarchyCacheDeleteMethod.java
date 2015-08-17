package de.idadachverband.hierarchy;

import java.io.InputStream;
import java.net.URL;
import de.idadachverband.institution.IdaInstitutionBean;
import lombok.Cleanup;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
public class HierarchyCacheDeleteMethod
{
    private final String urlTemplate;
    
    private final String institutionIdPlaceholder;
    
    
    public void deleteHierarchyCache(IdaInstitutionBean institution)
    {
        String urlString = getDeleteMethodUrl(institution.getInstitutionId());
        try
        {
           URL url = new URL(urlString);
           log.info("Call GET method {} to delete hierarchy cache for {}", urlString, institution);
           @Cleanup
           InputStream input = url.openStream();
           input.close();
        }
        catch (Exception e)
        {
            log.error("Error calling GET method {} to delete hierarchy cache for {}", urlString, institution, e);
        }
    }
    
    private String getDeleteMethodUrl(String institutionId)
    {
        String urlString  = urlTemplate.replace(institutionIdPlaceholder, institutionId);
        return urlString;
    }
}
