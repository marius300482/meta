package de.idadachverband.user;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.inject.Named;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Utility class to get UserDetails
 * Created by boehm on 13.11.14.
 */
@Named
@Slf4j
public class UserService
{

    @Value("${result.mail.from}")
    private String mailFrom;
    
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

    public String getEmail()
    {
        String email = mailFrom;

        UserDetails userDetails = null;
        try
        {
            userDetails = getUserDetails();
        } catch (AuthenticationNotFoundException e)
        {
            log.warn("Did not find email for user {}", email, userDetails);
            return email;
        }

        final Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
        for (GrantedAuthority authority : authorities)
        {
            if (authority.getAuthority().contains("@"))
            {
                log.debug("Found email {} for user {}", email, userDetails);
                return authority.getAuthority();
            }
        }
        log.warn("Did not find email for user {}", email, userDetails);
        return email;
    }

    public List<GrantedAuthority> getAuthorities()
    {

        UserDetails userDetails;
        try
        {
            userDetails = getUserDetails();
        } catch (AuthenticationNotFoundException e)
        {
            return Collections.emptyList();
        }

        List<GrantedAuthority> authorities = new ArrayList<>();

        final Collection<? extends GrantedAuthority> foundAuthorities = userDetails.getAuthorities();

        for (GrantedAuthority authority : foundAuthorities)
        {
            if (!authority.getAuthority().contains("@"))
            {
                authorities.add(authority);
            }
        }
        return authorities;
    }
    
    public Set<String> getRoles()
    {
        UserDetails userDetails;
        try
        {
            userDetails = getUserDetails();
        } catch (AuthenticationNotFoundException e)
        {
            return Collections.emptySet();
        }

        Set<String> roles = new HashSet<String>(2);

        final Collection<? extends GrantedAuthority> foundAuthorities = userDetails.getAuthorities();

        for (GrantedAuthority authority : foundAuthorities)
        {
            String roleName = authority.getAuthority(); 
            if (!roleName.contains("@"))
            {
                roles.add(roleName);
            }
        }
        return roles;
    }
    
    public boolean isAdmin()
    {
        return getRoles().contains("admin");
    }
    
    public Set<String> getInstitutionIds() 
    {
        Set<String> roles = getRoles();
        roles.remove("admin");
        return roles;
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
