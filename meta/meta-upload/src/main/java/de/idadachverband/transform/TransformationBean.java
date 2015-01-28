package de.idadachverband.transform;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.File;
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
    private File transformedFile;
    private Future<?> future;
    private String solrResponse;
    private Exception exception;
    private String transformationMessages;
    private Date endTime;
    private TransformationProgressState progressState;

    public TransformationBean(String institutionName)
    {
        this.institutionName = institutionName;
        startTime = new Date();
        this.key = UUID.randomUUID().toString();
    }

    public TransformationProgressState getProgressState()
    {
        return TransformationProgressState.getState(this);
    }

    public String toString()
    {
        return String.format("%s: %tc", getInstitutionName(), getStartTime());
    }

}
