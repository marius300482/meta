package de.idadachverband.archive;

import javax.inject.Inject;
import javax.inject.Named;
import java.nio.file.Path;

/**
 * Created by boehm on 19.02.15.
 */
@Named
public class ArchiveConfiguration extends AbstractArchiveConfiguration
{
    @Inject
    public ArchiveConfiguration(Path archivePath)
    {
        super(archivePath);
    }

}