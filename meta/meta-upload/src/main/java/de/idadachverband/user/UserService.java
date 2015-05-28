package de.idadachverband.user;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.SolrService;

import javax.inject.Inject;
import javax.inject.Named;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Utility class to get UserDetails
 * Created by boehm on 13.11.14.
 */
@Named
@Slf4j
public class UserService
{
    public static final String ADMIN_ROLE = "admin"; 
     
    private Map<String, IdaInstitutionBean> institutionsMap;
    
    private Map<String, SolrService> solrServiceMap;

    private SolrService defaultSolrUpdater;

    @Value("${result.mail.from}")
    private String mailFrom;
    
    @Inject
    public UserService(Set<IdaInstitutionBean> institutionsSet,
            Set<SolrService> solrServiceSet, SolrService defaultSolrUpdater)
    {
        this.institutionsMap = new HashMap<String, IdaInstitutionBean>(institutionsSet.size());
        for (IdaInstitutionBean institution : institutionsSet) 
        {
            institutionsMap.put(institution.getInstitutionId(), institution);
        }
        this.solrServiceMap = new HashMap<String, SolrService>(solrServiceSet.size());
        for (SolrService solrService : solrServiceSet) 
        {
            solrServiceMap.put(solrService.getName(), solrService);
        }
        this.defaultSolrUpdater = defaultSolrUpdater;
    }

    public IdaUser getUser()
    {
        UserDetails userDetails = getUserDetails();
        IdaUser user = new IdaUser(userDetails.getUsername());
        
        for (GrantedAuthority authority : userDetails.getAuthorities())
        {
            String userDetail = authority.getAuthority();
            if (userDetail.equals(ADMIN_ROLE))
            {
                user.setAdmin(true);
                user.getInstitutionsSet().addAll(institutionsMap.values());
                user.getSolrServiceSet().addAll(solrServiceMap.values());
            }
            else if (userDetail.contains("@"))
            {
                user.setEmail(userDetail);
                log.debug("Found email {} for user {}", userDetail, user);
            }
            else if (userDetail.startsWith("#"))
            {
                String coreName = userDetail.substring(1);
                SolrService solrService = solrServiceMap.get(coreName);
                if (solrService != null)
                {
                    log.debug("Found solr service {} for user {}", solrService, user);
                    user.getSolrServiceSet().add(solrService);
                } else
                {
                    log.warn("Invalid solr core: {} in user roles.", coreName);
                }
            }
            else
            {
                IdaInstitutionBean institution = institutionsMap.get(userDetail);
                if (institution != null)
                {
                    log.debug("Found institution {} for user {}", institution, user);
                    user.getInstitutionsSet().add(institution);
                } else
                {
                    log.warn("Invalid institution ID: {} in user roles.", userDetail);
                }
            }
        }
        
        if (user.getEmail() == null)
        {
            user.setEmail(mailFrom);
            log.warn("Did not find email for user {}", user);
        }
        if (user.getSolrServiceSet().isEmpty())
        {
            user.getSolrServiceSet().add(defaultSolrUpdater);
            log.debug("Set default solr service {} for user {}", defaultSolrUpdater, user);
        }
        
        return user;
    }
    
    /**
     * @return username of authenticated user
     * @throws Exception
     */
    public String getUsername()
    {
        UserDetails userDetails;
        try
        {
            userDetails = getUserDetails();
        } catch (AuthenticationNotFoundException e)
        {
            return "";
        }
        final String username = userDetails.getUsername();
        log.debug("User name is {}", username);
        return username;
    }
      
    protected UserDetails getUserDetails() throws AuthenticationNotFoundException
    {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null)
        {
            log.warn("Can not find user!");
            throw new AuthenticationNotFoundException();
        }
        return (UserDetails) authentication.getPrincipal();
    }
}
