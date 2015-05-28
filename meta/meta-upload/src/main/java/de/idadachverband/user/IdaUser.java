package de.idadachverband.user;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.SolrService;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by boehm on 23.09.14.
 */
@Data
@EqualsAndHashCode(of = "username")
public class IdaUser
{
    private final String username;
     
    private final Set<IdaInstitutionBean> institutionsSet = new HashSet<IdaInstitutionBean>();

    private final Set<SolrService> solrServiceSet = new HashSet<SolrService>();
    
    private String email;

    private boolean admin;
    
    @Override
    public String toString()
    {
        return username;
    }
}
