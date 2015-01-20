package de.idadachverband.institution;

import de.idadachverband.transform.IdaTransformer;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.File;

/**
 * Encapsulates information of an institution required by the transformation process.
 * Created by boehm on 26.08.14.
 */
@Data
@AllArgsConstructor
public class IdaInstitutionBean
{
    /**
     * The name of the institution. No special characters or white spaces should be used.
     */
    private String institutionName;

    /**
     * Optional. Can hold information required by the transformation process
     */
    private File transformationRecipeFile;

    /**
     * Holds implementation of the transformation class to transform institution input to working format,
     */
    private IdaTransformer transformationStrategy;

    @Override
    public String toString()
    {
        return institutionName;
    }
}
