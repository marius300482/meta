package de.idadachverband.archive;

import static org.mockito.Mockito.when;

import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.archive.bean.ArchiveCoreBean;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.archive.bean.ArchiveBaseVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessStep;
import de.idadachverband.user.UserService;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class ArchiveServiceTest
{
    private ArchiveService cut;
    private Path archivePath, processFilePath;
    
    @Mock
    private IdaInstitutionConverter idaInstitutionConverter;
    
    @Mock
    private IdaInstitutionBean institutionBean1, institutionBean2;
    
    @Mock
    private IdaInputArchiver idaInputArchiver;
    
    @Mock
    private UserService userService;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        processFilePath = Files.createTempDirectory("archiveTest");
        when(userService.getUsername()).thenReturn("testUser");
        cut = new ArchiveService(
                new ArchiveConfiguration(archivePath, 1), 
                new ProcessFileConfiguration(processFilePath),
                new SimpleDateFormat("yyyyMMdd_HHmmss"), 
                idaInputArchiver, idaInstitutionConverter, userService);
    }
    
    @AfterClass
    public void cleanup() throws Exception
    {
        Directories.delete(processFilePath);
    }
    
    
    @Test
    public void getCoreNames() throws Exception
    {
        List<String> actual = cut.getCoreNames();
        assertThat(actual, is(equalTo(Collections.singletonList("corename"))));
    }
    
    @Test
    public void getInstitutionNames() throws Exception
    {
        List<String> actual = cut.getInstitutionIds("corename");
        assertThat(actual, containsInAnyOrder("institution1", "institution2"));
    }
    
    @Test
    public void getVersionIds() throws Exception
    {
        List<String> actual = cut.getBaseIds("corename", "institution2");
        assertThat(actual, is(equalTo(Arrays.asList("v0002", "v0003"))));
    }
    
    @Test
    public void getUpdateIds() throws Exception
    {
        List<String> actual = cut.getUpdateIds("corename", "institution1", "v0001");
        assertThat(actual, is(equalTo(Arrays.asList("u0001", "u0002"))));
    }
    
//    @Test
//    public void getUpdateIdsUpTo() throws Exception
//    {
//        List<String> actual = cut.getUpdateIdsUpTo("corename", "institution1", "v0001_20150428_083025", "u0001_20150428_093025");
//        assertThat(actual, is(equalTo(Arrays.asList("u0001_20150428_093025"))));
//    }

    @Test
    public void getArchiveTree() throws Exception
    {
        when(idaInstitutionConverter.convert("institution1")).thenReturn(institutionBean1);
        when(institutionBean1.getInstitutionId()).thenReturn("institution1");
        when(idaInstitutionConverter.convert("institution2")).thenReturn(institutionBean2);
        when(institutionBean2.getInstitutionId()).thenReturn("institution2");
        
        final List<ArchiveCoreBean> cores = cut.getArchivedCores();
        assertThat(cores.size(), is(equalTo(1)));
        final ArchiveCoreBean core = cores.get(0);
        assertThat(core.getCoreName(), is(equalTo("corename")));
        final ArchiveInstitutionBean institution1 = core.find("institution1");
        assertThat(institution1.getInstitutionId(), is(equalTo("institution1")));
        
        final List<ArchiveBaseVersionBean> versions = institution1.getBaseVersions();
        assertThat(versions.size(), is(1));

        final ArchiveBaseVersionBean version = versions.get(0);
        assertThat(version.getUploadFile().getFileName().toString(), is(equalTo("update.zip")));
        
        final List<ArchiveVersionBean> updates = version.getIncrementalUpdates();
        assertThat(updates.size(), is(2));
        final ArchiveVersionBean update2 = updates.get(1);
        assertThat(update2.getUpdateNumber(), is(equalTo(2)));
        assertThat(update2.getUploadFile().getFileName().toString(), is(equalTo("iupdate2.zip")));
        
        final ArchiveBaseVersionBean version2 = core.find("institution2").getBaseVersions().get(1);
        assertThat(version2.getBaseNumber(), is(equalTo(3)));
        assertThat(version2.getUploadFile().getFileName().toString(), is(equalTo("update3.zip")));
    }
    
    @Test
    public void findFile() throws Exception
    {
        Path actual = cut.findFile(ProcessStep.upload, "corename", "institution1", new VersionKey(1,0));
        assertThat(actual, is(equalTo(archivePath.resolve("corename/institution1/v0001/upload/update.zip"))));
        
        actual = cut.findFile(ProcessStep.solrFormat, "corename", "institution1", new VersionKey(1,1));
        assertThat(actual, is(equalTo(archivePath.resolve("corename/institution1/v0001/incremental/u0001/solr/iupdate1.zip"))));
    }
    
    @Test(expectedExceptions = ArchiveException.class)
    public void findFileFailsForMissingVersion() throws Exception
    {
        cut.findFile(ProcessStep.upload, "corename", "institution1", new VersionKey(4,0));
    }
    
    @Test
    public void createNextBaseVersionKey() throws Exception
    {
        VersionKey actual = cut.createNextVersionKey("corename", "institution2", false);
        assertThat(actual, is(equalTo(new VersionKey(4,0))));
    }
    
    @Test
    public void createNextIncrementalVersionKey() throws Exception
    {
        VersionKey actual = cut.createNextVersionKey("corename", "institution1", true);
        assertThat(actual, is(equalTo(new VersionKey(1,3))));
    }

}