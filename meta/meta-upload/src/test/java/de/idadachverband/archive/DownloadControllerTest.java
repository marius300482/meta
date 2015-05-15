package de.idadachverband.archive;

import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.access.AccessDeniedException;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.process.ProcessStep;
import de.idadachverband.user.UserService;

import javax.servlet.http.HttpServletResponse;

import java.io.FileNotFoundException;
import java.nio.file.Path;
import java.util.Collections;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.notNullValue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class DownloadControllerTest
{
    @InjectMocks
    private DownloadController cut;
    
    @Mock
    private ArchiveService archiveService;
    
    @Mock
    private UserService userService;

//    @Mock
//    private HashedFileService hashedFileService;

    @Mock
    private HttpServletResponse response;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        when(userService.isAdmin()).thenReturn(true);
    }

    @Test(expectedExceptions = IllegalArgumentException.class)
    public void downloadWithInvalidStep() throws Exception
    {
        cut.download("wrongFormat", "core", "institution", "version", "update", response);
    }
    
    @Test
    public void downloadSuccess() throws Exception
    {
        when(archiveService.findFile(ProcessStep.upload, "core", "institution", "version", "update")).thenReturn(mock(Path.class));

        FileSystemResource actual = cut.download("upload", "core", "institution", "version", "update", response);
        assertThat(actual, notNullValue());
    }

    @Test(expectedExceptions = FileNotFoundException.class)
    public void downloadFailure() throws Exception
    {
        when(archiveService.findFile(ProcessStep.upload, "core", "institution", "version", "update")).thenThrow(FileNotFoundException.class);
        FileSystemResource actual = cut.download("upload", "core", "institution", "version", "update", response);
    }
    
    @Test(expectedExceptions = AccessDeniedException.class)
    public void downloadWrongInstitution() throws ArchiveException
    {
        when(userService.isAdmin()).thenReturn(false);
        when(userService.getInstitutionIds()).thenReturn(Collections.singleton("otherInstitution"));
        cut.download("upload", "core", "institution", "version", "update", response);
    }

}