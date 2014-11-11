package de.idadachverband.archive;

import org.junit.Test;

import java.io.File;

import static org.hamcrest.CoreMatchers.not;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertThat;

public class HashServiceTest
{
    private HashService cut = new HashService();

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
}