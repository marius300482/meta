package de.idadachverband.archive;

import org.testng.annotations.Test;

import java.io.File;

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
        File file = new File(name);
        String first = cut.getHashedFileName(file);
        String second = cut.getHashedFileName(file);
        assertThat(first, equalTo(second));
        assertThat(name, not(equalTo(first)));
    }
}