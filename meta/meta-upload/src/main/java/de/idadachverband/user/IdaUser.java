package de.idadachverband.user;

import de.idadachverband.solr.SolrService;
import de.idadachverband.upload.IdaInstitutionBean;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.Set;

/**
 * Created by boehm on 23.09.14.
 */
public class IdaUser extends User
{

    @Getter
    @Setter
    private Set<IdaInstitutionBean> institutionSet;
    @Getter
    @Setter
    private Set<SolrService> solrServiceSet;
    @Getter
    @Setter
    private String email;

    @Getter
    @Setter
    private boolean admin;

    public IdaUser(String username, String password, Collection<? extends GrantedAuthority> authorities)
    {
        super(username, password, authorities);
    }
}
