package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;
import java.text.SimpleDateFormat;

/**
 * Archives Solr input files. By default zipped and historic files will be deleted.
 * Created by boehm on 30.10.14.
 */
@Named
@Slf4j
public class IdaInputArchiver extends AbstractIdaArchiver
{
    /**
     * @param zipService
     * @param dateFormat
     */
    @Inject
    public IdaInputArchiver(ZipService zipService, SimpleDateFormat dateFormat)
    {
        super(zipService, dateFormat);
    }
}
