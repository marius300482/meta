package de.idadachverband.archive;

import java.io.IOException;
import java.nio.file.Files;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

public class ArchiveConfigurationTest {

  public ArchiveConfiguration archiveConfiguration;
    
  @BeforeClass
  public void setup() throws IOException
  {
      archiveConfiguration = new ArchiveConfiguration(Files.createTempDirectory("ida-test-archive"), 1);
  }
  
  @AfterClass
  public void cleanup() 
  {
      Directories.delete(archiveConfiguration.getBasePath());
  }
  
  @Test(expectedExceptions = IllegalArgumentException.class)
  public void checkPathThrowsExceptionForIllegalPaths() {
     archiveConfiguration.checkPath(archiveConfiguration.getBasePath().resolve("../../dangerous"));
  }
}
