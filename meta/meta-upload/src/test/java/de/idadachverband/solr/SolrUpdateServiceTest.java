package de.idadachverband.solr;

import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;

import org.apache.solr.client.solrj.SolrServerException;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.archive.bean.ArchiveVersionBean;
import de.idadachverband.archive.bean.ArchiveBaseVersionBean;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.job.JobExecutionService;

public class SolrUpdateServiceTest
{
    final Path versionPath = Paths.get("update.xml");
    final Path updatePath1 = Paths.get("iupdate1.xml");
    final Path updatePath2 = Paths.get("iupdate2.xml");
	
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
    
    private final String institutionId = "institution1";
    
    @Mock
    private IdaInstitutionBean institution;
    
    @Mock
    private ArchiveBaseVersionBean versionBean;
    
    @Mock
    private ArchiveVersionBean updateBean1, updateBean2;

    private SolrUpdateService cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        
        when(institution.getInstitutionId()).thenReturn(institutionId);
        when(solrService.getName()).thenReturn(coreName);
        when(idaInputArchiver.uncompressToTemporaryFile(Mockito.any(Path.class))).thenReturn(Paths.get("uncompressed.tmp"));
        
        // archived versions
        when(versionBean.getSolrFormatFile()).thenReturn(versionPath);
        when(versionBean.getBaseNumber()).thenReturn(1);
        
        when(updateBean1.getSolrFormatFile()).thenReturn(updatePath1);
        when(updateBean1.getUpdateNumber()).thenReturn(1);
        when(updateBean2.getSolrFormatFile()).thenReturn(updatePath2);
        when(updateBean2.getUpdateNumber()).thenReturn(2);
        
        cut = new SolrUpdateService(archiveService, idaInputArchiver, jobExecutionService);
    }

    @Test
    public void reindexInstitution() throws Exception
    {
        VersionKey version = new VersionKey(1,2); 
        when(archiveService.getLatestVersionKey(coreName, institutionId)).thenReturn(version);
        when(archiveService.getArchivedBaseVersion(coreName, institutionId, version)).thenReturn(versionBean);
        when(versionBean.getUpdatesUpTo(2)).thenReturn(Arrays.asList(updateBean1, updateBean2));
        
        cut.reindexInstitution(solrService, institution);

        verify(solrService, times(1)).deleteInstitution(institutionId);
        verify(solrService, times(3)).update(Mockito.any(Path.class));
    }

    @Test
    public void updateSolrRollback() throws Exception 
    {
        VersionKey version = new VersionKey(1,0); 
        when(archiveService.getLatestVersionKey(coreName, institutionId)).thenReturn(version);
    	when(archiveService.getArchivedBaseVersion(coreName, institutionId, version)).thenReturn(versionBean);
    	
    	final Path invalidUpdatePath = Paths.get("invalidupdate.xml");
    	when(solrService.update(invalidUpdatePath)).thenThrow(new SolrServerException("updates fails"));
    	
    	SolrUpdateBean solrUpdate = new SolrUpdateBean(solrService, institution, invalidUpdatePath, false);
    	try 
    	{
    	    cut.updateSolr(solrUpdate, true);
    	} catch (SolrServerException e)
    	{
    	    // expected
    	}
    	
    	verify(solrService).update(invalidUpdatePath);
    	verify(solrService).update(versionPath); // rollback to archived version
    	verify(solrService, times(2)).deleteInstitution(institutionId);
    }
}