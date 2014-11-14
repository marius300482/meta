package de.idadachverband.institution;

import org.springframework.core.convert.converter.Converter;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.Set;

/**
 * Provides {@link IdaInstitutionBean} from name of institution
 * Created by boehm on 23.09.14.
 */
@Named
final public class IdaInstitutionConverter implements Converter<String, IdaInstitutionBean>
{
    @Inject
    private Set<IdaInstitutionBean> institutionSet;

    @Override
    public IdaInstitutionBean convert(String name)
    {
        for (IdaInstitutionBean institution : institutionSet)
        {
            if (institution.getName().equals(name))
            {
                return institution;
            }
        }
        throw new IllegalArgumentException("Did not find institution with name " + name);
    }
}
