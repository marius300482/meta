package de.idadachverband.archive;

import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import java.io.File;

import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.doReturn;

public class HashedFileServiceTest
{
    @Mock
    private HashService hashService;

    @Spy
    private HashedFileService cut = new HashedFileService(null, hashService);

    @Before
    public void setUp() throws Exception
    {
        MockitoAnnotations.initMocks(this);
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