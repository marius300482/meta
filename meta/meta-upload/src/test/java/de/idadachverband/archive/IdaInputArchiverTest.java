package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;

import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import static org.mockito.Mockito.*;
import static org.mockito.MockitoAnnotations.initMocks;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class IdaInputArchiverTest
{
    @InjectMocks
    private IdaInputArchiver cut;

    private Path input = Paths.get("input.xml");
    private Path target;

    @Mock
    private Path archivePath;

    @Mock
    private ZipService zipService;

    @BeforeMethod
    public void setUp() throws Exception
    {
        initMocks(this);
        target = Files.createTempDirectory("idaInputArchiverTest");
    }
    
    @AfterMethod
    public void cleanup()
    {
        Directories.delete(target);
    }    

    @Test
    public void archiveFile() throws Exception
    {
        Path path = cut.archiveFile(input, target);
        assertThat(path, equalTo(target.resolve("input.xml.zip")));
        verify(zipService, times(1)).zip(any(Path.class), any(Path.class));
    }
}