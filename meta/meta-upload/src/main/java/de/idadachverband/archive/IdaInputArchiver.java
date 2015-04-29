package de.idadachverband.archive;

import de.idadachverband.utils.ZipService;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.inject.Named;

/**
 * Archives Solr input files.
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
    public IdaInputArchiver(ZipService zipService)
    {
        super(zipService);
    }
}
