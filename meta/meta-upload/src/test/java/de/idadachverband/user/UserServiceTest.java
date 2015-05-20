package de.idadachverband.user;

import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.solr.SolrService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Set;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;
import static org.mockito.Mockito.*;

public class UserServiceTest
{

    private final String email = "testuser@ida.de";
    private final String role = "admin";
    
    private UserService cut;
    
    @Mock
    private UserDetails userDetails;
   
    @Mock 
    private SolrService solrService;
    
    @Mock
    private IdaInstitutionBean institution;
    
    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        when(solrService.getName()).thenReturn("core");
        when(institution.getInstitutionId()).thenReturn("institution");
        
        cut = Mockito.spy(new UserService(Collections.singleton(institution), Collections.singleton(solrService), solrService));       
        
        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

        authorities.add(new SimpleGrantedAuthority(role));
        authorities.add(new SimpleGrantedAuthority(email));
        authorities.add(new SimpleGrantedAuthority("#core"));
        authorities.add(new SimpleGrantedAuthority("institution"));

        doReturn(userDetails).when(cut).getUserDetails();

        when(userDetails.getAuthorities()).thenReturn((Collection) authorities);
    }

    @Test
    public void getUsernameNoAuthentication() throws Exception
    {
        doThrow(AuthenticationNotFoundException.class).when(cut).getUserDetails();
        final String username = cut.getUsername();
        assertThat(username, is(""));
    }

    @Test
    public void getUsername() throws Exception
    {
        final String expected = "testuser";
        when(userDetails.getUsername()).thenReturn(expected);
        final String actual = cut.getUsername();
        assertThat(actual, is(expected));
    }

    @Test
    public void getEmail() throws Exception
    {
        // when
        final String actual = cut.getUser().getEmail();

        // then
        assertThat(actual, is(email));
    }
    
    @Test 
    void getInstitutionsSet()
    {
        final Set<IdaInstitutionBean> actual = cut.getUser().getInstitutionsSet();
        
        assertThat(actual, equalTo(Collections.singleton(institution)));
    }
    
    @Test 
    void getSolrServiceSet()
    {
        final Set<SolrService> actual = cut.getUser().getSolrServiceSet();
        
        assertThat(actual, equalTo(Collections.singleton(solrService)));
    }
}
