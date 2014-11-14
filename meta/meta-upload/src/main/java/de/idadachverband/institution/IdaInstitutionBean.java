package de.idadachverband.institution;

import de.idadachverband.transform.IdaTransformer;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.File;

/**
 * Created by boehm on 26.08.14.
 */
@Data
@AllArgsConstructor
public class IdaInstitutionBean
{
    private String name;
    private File xslFile;

    private IdaTransformer transformationStrategy;

    @Override
    public String toString()
    {
        return name;
    }
}
