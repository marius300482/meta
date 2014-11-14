package de.idadachverband.user;

import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.mockito.Mockito.*;

public class UserServiceTest
{

    private final String email = "testuser@ida.de";
    private final String role = "admin";
    @Spy
    private UserService cut;
    @Mock
    private UserDetails userDetails;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

        authorities.add(new SimpleGrantedAuthority(role));
        authorities.add(new SimpleGrantedAuthority(email));

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
        final String actual = cut.getEmail();

        // then
        assertThat(actual, is(email));
    }

    @Test
    public void getRoles() throws Exception
    {
        final List<GrantedAuthority> actual = cut.getRoles();

        assertThat(actual.size(), is(1));
        assertThat(actual.get(0).getAuthority(), is(role));
    }
}
