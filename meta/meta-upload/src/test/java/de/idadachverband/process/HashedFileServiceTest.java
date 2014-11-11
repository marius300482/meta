package de.idadachverband.process;

import de.idadachverband.archive.HashedFileService;
import org.junit.Before;
import org.junit.Test;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import java.io.File;

import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.doReturn;

public class HashedFileServiceTest
{
    @Spy
    private HashedFileService cut = new HashedFileService(null);

    @Before
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetHashedString() throws Exception
    {
        String name = "name";
        File file = new File(name);
        String first = cut.getHashedFileName(file);
        String second = cut.getHashedFileName(file);
        assertThat(first, equalTo(second));
        assertThat(name, not(equalTo(first)));
    }

    @Test
    public void testFindFile() throws Exception
    {
        String hashedFilename = "hashedFilename";
        String plainFilename = "plainFilename";
        doReturn(new File(plainFilename)).when(cut).findFile(hashedFilename);
        File expected = cut.findFile(hashedFilename);
        assertThat(expected.getName(), equalTo(plainFilename));
    }
}