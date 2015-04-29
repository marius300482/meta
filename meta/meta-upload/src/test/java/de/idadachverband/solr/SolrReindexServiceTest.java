package de.idadachverband.solr;

import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;

import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.bean.ArchiveUpdateBean;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.job.JobExecutionService;

public class SolrReindexServiceTest
{
    @Mock
    private IdaInputArchiver idaInputArchiver;

    @Mock
    private ArchiveService archiveService;
    
    @Mock
    private JobExecutionService jobExecutionService;
    
    @Mock
    private IdaInstitutionConverter idaInstitutionConverter;
    
    private final String coreName = "corename";
    
    @Mock 
    private SolrService solrService;
    
    private final String institutionName = "institution1";
    
    @Mock
    private IdaInstitutionBean institution;
    
    @Mock
    private ArchiveVersionBean versionBean;
    
    @Mock
    private ArchiveUpdateBean updateBean1, updateBean2;

    private SolrReindexService cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        //final Path archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        when(institution.getInstitutionName()).thenReturn(institutionName);
        when(solrService.getName()).thenReturn(coreName);
        when(idaInputArchiver.uncompressToTemporaryFile(Mockito.any(Path.class))).thenReturn(Paths.get("uncompressed.tmp"));
        
        cut = new SolrReindexService(archiveService, idaInputArchiver, jobExecutionService);
    }

    @Test
    public void reindexInstitution() throws Exception
    {
        final Path versionPath = Paths.get("update.xml");
        final Path updatePath1 = Paths.get("iupdate1.xml");
        final Path updatePath2 = Paths.get("iupdate2.xml");
        when(archiveService.getVersion(coreName, institutionName, ArchiveService.LATEST_VERSION)).thenReturn(versionBean);
        when(versionBean.getSolrFormatFile()).thenReturn(versionPath);
        when(versionBean.getVersionNumber()).thenReturn(1);
        when(versionBean.getEntries()).thenReturn(Arrays.asList(updateBean1, updateBean2));
        when(updateBean1.getSolrFormatFile()).thenReturn(updatePath1);
        when(updateBean1.getUpdateNumber()).thenReturn(1);
        when(updateBean2.getSolrFormatFile()).thenReturn(updatePath2);
        when(updateBean2.getUpdateNumber()).thenReturn(2);
        
        cut.reindexInstitution(solrService, institution);

        verify(solrService, times(1)).deleteInstitution(institutionName);
        verify(idaInputArchiver).uncompressToTemporaryFile(versionPath);
        verify(idaInputArchiver).uncompressToTemporaryFile(updatePath1);
        verify(idaInputArchiver).uncompressToTemporaryFile(updatePath2);

        verify(solrService, times(3)).update(Mockito.any(Path.class));
    }
}