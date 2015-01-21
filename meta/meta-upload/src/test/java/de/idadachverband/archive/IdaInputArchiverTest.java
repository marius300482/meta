package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.*;
import static org.mockito.MockitoAnnotations.initMocks;

public class IdaInputArchiverTest
{

    @InjectMocks
    private IdaInputArchiver cut;
    private String institutionName = UUID.randomUUID().toString();

    private File input = new File(UUID.randomUUID().toString());

    @Mock
    private Path archivePath;

    @Mock
    private ZipService zipService;

    @BeforeMethod
    public void setUp() throws Exception
    {
        initMocks(this);
        when(archivePath.resolve(anyString())).thenReturn(Paths.get(UUID.randomUUID().toString()));

    }

    @Test
    public void archiveFile() throws Exception
    {
        cut.archiveFile(input, institutionName);
        verify(zipService, times(1)).zip(org.mockito.Matchers.any(File.class));
    }

    @Test
    public void readArchivedFile() throws Exception
    {

    }
}