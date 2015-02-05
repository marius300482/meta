package de.idadachverband.institution;

import de.idadachverband.transform.IdaTransformer;
import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.io.File;

/**
 * Encapsulates information of an institution required by the transformation process.
 * Created by boehm on 26.08.14.
 */
@Data
@RequiredArgsConstructor
public class IdaInstitutionBean
{
    /**
     * The name of the institution. No special characters or white spaces should be used.
     */
    @NonNull
    private String institutionName;

    /**
     * Optional. Can hold information required by the transformation process
     */
    @NonNull
    private File transformationRecipeFile;

    /**
     * Holds implementation of the transformation class to transform institution input to working format,
     */
    @NonNull
    private IdaTransformer transformationStrategy;

    /**
     * Controls, if incremental upload is possible. Defaults to false.
     */
    private boolean incrementalUpdateAllowed = false;

    /**
     * Do incremental upload or not. Defaults to true.
     */
    private boolean incrementalUpdate = true;

    @Override
    public String toString()
    {
        return institutionName;
    }
}
