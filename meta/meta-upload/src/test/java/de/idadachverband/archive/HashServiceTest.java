package de.idadachverband.archive;

import org.testng.annotations.Test;

import java.nio.file.Path;
import java.nio.file.Paths;

import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.equalTo;

public class HashServiceTest
{
    private HashService cut = new HashService();

    @Test
    public void testGetHashedString() throws Exception
    {
        String name = "institutionName";
        Path file = Paths.get(name);
        String first = cut.getHashedFileName(file);
        String second = cut.getHashedFileName(file);
        assertThat(first, equalTo(second));
        assertThat(name, not(equalTo(first)));
    }
}