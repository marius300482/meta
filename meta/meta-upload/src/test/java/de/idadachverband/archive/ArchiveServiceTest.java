package de.idadachverband.archive;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.startsWith;

public class ArchiveServiceTest
{
    private ArchiveService cut;

    @BeforeMethod
    public void setUp() throws Exception
    {
        final Path archivePath = Paths.get(this.getClass().getClassLoader().getResource("archive").toURI());
        cut = new ArchiveService(new ArchiveConfiguration(archivePath, 1), new SimpleDateFormat());
    }

    @Test
    public void findReindexPaths() throws Exception
    {
//        final Map<String, Map<String, List<String>>> actual = cut.getArchiveTree();
//        assertThat(actual.keySet(), contains("corename"));
//        assertThat(actual.get("corename").keySet(), contains("institution1"));
    }

}