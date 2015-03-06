package de.idadachverband.archive;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.endsWith;

public class ArchiveServiceTest
{
    private ArchiveService cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        final Path archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        cut = new ArchiveService(new ArchiveConfiguration(archivePath));
    }

    @Test
    public void findReindexPaths() throws Exception
    {
        final Map<String, List<Path>> actual = cut.findReindexPaths();
        assertThat(actual.keySet(), contains("corename"));
        assertThat(actual.get("corename").get(0).toString(), endsWith("/institution1"));
    }

    @Test
    public void findFiles() throws Exception
    {

    }
}