package de.idadachverband.institution;

import org.springframework.core.convert.converter.Converter;

import javax.inject.Inject;
import javax.inject.Named;

import java.util.Map;

/**
 * Provides {@link IdaInstitutionBean} from institutionId of institution
 * Created by boehm on 23.09.14.
 */
@Named
public class IdaInstitutionConverter implements Converter<String, IdaInstitutionBean>
{
    @Inject
    private Map<String, IdaInstitutionBean> institutionsMap;
    
    @Override
    public IdaInstitutionBean convert(String id)
    {
        IdaInstitutionBean bean = institutionsMap.get(id);
        if (bean == null)
        {
            throw new IllegalArgumentException("Did not find institution with institutionId " + id);
        }
        return bean;
    }
}
