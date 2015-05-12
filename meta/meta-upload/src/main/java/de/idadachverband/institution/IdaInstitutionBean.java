package de.idadachverband.institution;

import de.idadachverband.transform.IdaTransformer;
import lombok.Data;

import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Encapsulates information of an institution required by the transformation process.
 * Created by boehm on 26.08.14.
 */
@Data
public class IdaInstitutionBean
{
    /**
     * The ID of the institution referencing the <institutionID> field in Solr.
     * No special characters or white spaces should be used.
     */
    private final String institutionId;
    
    /**
     * The name of the institution. 
     */
    private String institutionName;
    /**
     * Optional. Can hold information required by the transformation process
     */
    private Path transformationRecipeFile;
    /**
     * Holds implementation of the transformation class to transform institution input to working format,
     */
    private IdaTransformer transformationStrategy;
    /**
     * Controls, if incremental upload is possible. Defaults to false.
     */
    private boolean incrementalUpdateAllowed = false;
    /**
     * Do incremental upload by default.
     */
    private boolean incrementalUpdate = true;

    
    public IdaInstitutionBean(String institutionId, String institutionName, String transformationRecipeFile, IdaTransformer transformationStrategy)
    {
        this.institutionId = institutionId;
        this.institutionName = institutionName;
        this.transformationRecipeFile = Paths.get(transformationRecipeFile);
        this.transformationStrategy = transformationStrategy;
    }

    @Override
    public String toString()
    {
        return institutionName;
    }
}
