package de.idadachverband.solr;

import org.springframework.core.convert.converter.Converter;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.Set;

/**
 * Provides {@link SolrService} from name of solr core.
 * <p/>
 * Created by boehm on 23.09.14.
 */
@Named
final public class IdaSolrConverter implements Converter<String, SolrService>
{

    @Inject
    private Set<SolrService> solrServiceSet;

    @Override
    public SolrService convert(String name)
    {
        for (SolrService solrService : solrServiceSet)
        {
            if (solrService.getName().equals(name))
            {
                return solrService;
            }
        }
        throw new IllegalArgumentException("Did not find solr process with name " + name);
    }
}
