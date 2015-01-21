package de.idadachverband.utils;

import org.testng.annotations.Test;

import java.io.File;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.endsWith;
import static org.hamcrest.Matchers.not;

public class ZipServiceTest
{

    private ZipService cut = new ZipService();

    @Test
    public void unzip() throws Exception
    {

    }

    @Test
    public void stripZipSuffixFromPath() throws Exception
    {
        String given = "prefix-6914983274941582260.zip";
        final String actual = cut.stripZipSuffixFromPath(new File(given));
        assertThat(actual, not(endsWith(".zip")));
    }

    @Test
    public void zip() throws Exception
    {

    }

    @Test
    public void zip1() throws Exception
    {

    }
}