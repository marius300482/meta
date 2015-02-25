package de.idadachverband.archive;

import javax.inject.Inject;
import javax.inject.Named;
import java.nio.file.Path;

/**
 * Created by boehm on 20.02.15.
 */
@Named
public class ProcessFileConfiguration extends AbstractArchiveConfiguration
{
    @Inject
    public ProcessFileConfiguration(Path processBasePath)
    {
        super(processBasePath);
    }
}
