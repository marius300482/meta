package de.idadachverband.archive;

import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.archive.bean.ArchiveCoreBean;
import de.idadachverband.archive.bean.ArchiveInstitutionBean;
import de.idadachverband.archive.bean.ArchiveUpdateBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.process.ProcessStep;

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
    private IdaInputArchiver idaInputArchiver;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        processFilePath = Files.createTempDirectory("archiveTest");
        cut = new ArchiveService(
                new ArchiveConfiguration(archivePath, 1), 
                new ProcessFileConfiguration(processFilePath),
                new SimpleDateFormat("yyyyMMdd_HHmmss"), 
                idaInputArchiver, idaInstitutionConverter);
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
        List<String> actual = cut.getInstitutionNames("corename");
        assertThat(actual, containsInAnyOrder("institution1", "institution2"));
    }
    
    @Test
    public void getVersionIds() throws Exception
    {
        List<String> actual = cut.getVersionIds("corename", "institution2");
        assertThat(actual, is(equalTo(Arrays.asList("v0002_20150427_080000", "v0003_20150428_080000"))));
    }
    
    @Test
    public void getUpdateIds() throws Exception
    {
        List<String> actual = cut.getUpdateIds("corename", "institution1", "v0001_20150428_083025");
        assertThat(actual, is(equalTo(Arrays.asList("u0001_20150428_093025", "u0002_20150428_103025"))));
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
        final List<ArchiveCoreBean> cores = cut.getCores();
        assertThat(cores.size(), is(equalTo(1)));
        final ArchiveCoreBean core = cores.get(0);
        assertThat(core.getName(), is(equalTo("corename")));
        final ArchiveInstitutionBean institution1 = core.get("institution1");
        assertThat(institution1, is(notNullValue()));
        
        final List<ArchiveVersionBean> versions = institution1.getEntries();
        assertThat(versions.size(), is(1));

        final ArchiveVersionBean version = versions.get(0);
        assertThat(version.getUploadFile().getFileName().toString(), is(equalTo("update.zip")));
        
        final List<ArchiveUpdateBean> updates = version.getEntries();
        assertThat(updates.size(), is(2));
        final ArchiveUpdateBean update2 = updates.get(1);
        assertThat(update2.getUpdateNumber(), is(equalTo(2)));
        assertThat(update2.getUploadFile().getFileName().toString(), is(equalTo("iupdate2.zip")));
        
        final ArchiveVersionBean version2 = core.get("institution2").getEntries().get(1);
        assertThat(version2.getVersionNumber(), is(equalTo(3)));
        assertThat(version2.getUploadFile().getFileName().toString(), is(equalTo("update3.zip")));
    }
    
    @Test
    public void findFile() throws Exception
    {
        Path actual = cut.findFile(ProcessStep.upload, "corename", "institution1", "v0001_20150428_083025", ArchiveService.NO_UPDATE);
        assertThat(actual, is(equalTo(archivePath.resolve("corename/institution1/v0001_20150428_083025/upload/update.zip"))));
        
        actual = cut.findFile(ProcessStep.solrFormat, "corename", "institution1", "v0001_20150428_083025", "u0001_20150428_093025");
        assertThat(actual, is(equalTo(archivePath.resolve("corename/institution1/v0001_20150428_083025/incremental/u0001_20150428_093025/solr/iupdate1.zip"))));
    }
    
    @Test(expectedExceptions = ArchiveException.class)
    public void findFileFailsForMissingVersion() throws Exception
    {
        cut.findFile(ProcessStep.upload, "corename", "institution1", "v0004_20150501_083000", ArchiveService.NO_UPDATE);
    }
    
    @Test
    public void buildNextVersionId() throws Exception
    {
        String actual = cut.buildNextVersionId("corename", "institution2");
        assertThat(actual, startsWith("v0004_"));
    }
    
    @Test
    public void buildNextUpdateId() throws Exception
    {
        String actual = cut.buildNextUpdateId("corename", "institution1", "v0001_20150428_083025");
        assertThat(actual, startsWith("u0003_"));
    }

}