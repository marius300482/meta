package de.idadachverband.archive;

import de.idadachverband.test.AbstractIdaSpringTests;
import org.mockito.InjectMocks;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import javax.inject.Inject;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;


@WebAppConfiguration
public class ArchiveControllerIT extends AbstractIdaSpringTests
{
    @Inject
    private WebApplicationContext wac;

    private MockMvc mockMvc;

    @InjectMocks
    private ArchiveController cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        mockMvc = webAppContextSetup(wac).build();
    }

    @AfterMethod
    public void tearDown() throws Exception
    {

    }

    @Test
    public void testList() throws Exception
    {
        mockMvc.perform(get("/archive"))
                .andExpect(status().isOk())
                .andExpect(view().name("archiveList"));

    }
}