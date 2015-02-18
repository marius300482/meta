package de.idadachverband.transform;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.nio.file.Path;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.Future;

/**
 * Bean to hold transformation details.
 * Created by boehm on 09.10.14.
 */
@Data
@EqualsAndHashCode(of = "key")
public class TransformationBean
{
    private final String key;
    private final Date startTime;
    private final String institutionName;
    private final String originalFileName;
    private Path transformedFile;
    private Future<?> future;
    private String solrResponse;
    private Exception exception;
    private String transformationMessages;
    private Date endTime;
    private TransformationProgressState progressState;

    public TransformationBean(String institutionName, String originalFileName)
    {
        this.institutionName = institutionName;
        this.originalFileName = originalFileName;
        startTime = new Date();
        this.key = UUID.randomUUID().toString();
    }

    public TransformationProgressState getProgressState()
    {
        return TransformationProgressState.getState(this);
    }

    public String toString()
    {
        return String.format("%s, %s: %tc", getOriginalFileName(), getInstitutionName(), getStartTime());
    }

}
