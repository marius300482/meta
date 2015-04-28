package de.idadachverband.solr;

import de.idadachverband.archive.ArchiveService;
import de.idadachverband.archive.IdaInputArchiver;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.institution.IdaInstitutionConverter;
import de.idadachverband.job.JobExecutionService;

import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import static org.mockito.Mockito.*;

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
    
    @Mock
    private IdaInstitutionBean institution;

    private SolrReindexService cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
        final Path archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        cut = new SolrReindexService(archiveService, idaInputArchiver, jobExecutionService, idaInstitutionConverter);
    }

    @Test
    public void reindexCore() throws Exception
    {
        final SolrService solrService = mock(SolrService.class);
        final String coreName = "corename";
        when(solrService.getName()).thenReturn(coreName);
        when(idaInputArchiver.uncompressToTemporaryFile(Mockito.any(Path.class))).thenReturn(Files.createTempFile(this.getClass().getSimpleName(), ".tmp"));
        final String institutionName = "institution1";
        when(institution.getInstitutionName()).thenReturn(institutionName);
        final ArrayList<Path> solrFiles = new ArrayList<>();
        final Path archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        final Path solr = archivePath.resolve(coreName).resolve(institutionName).resolve("solr");
        solrFiles.add(solr.resolve("update.zip"));
        solrFiles.add(solr.resolve("incremental").resolve("a.zip"));
        solrFiles.add(solr.resolve("incremental").resolve("b.zip"));

        //when(archiveService.findLatestSolrFiles(coreName, institutionName)).thenReturn(solrFiles);

        cut.rollbackInstitutionIndex(solrService, institution);

        verify(solrService, times(1)).deleteInstitution(institutionName);
        verify(idaInputArchiver, times(3)).uncompressToTemporaryFile(Mockito.any(Path.class));

        verify(solrService, times(3)).update(Mockito.any(Path.class));
    }
}