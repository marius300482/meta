package de.idadachverband.transform;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.File;
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
    private File transformedFile;
    private Future<?> future;
    private String solrResponse;
    private Exception exception;
    private String transformationMessages;

    public TransformationBean()
    {
        this.key = UUID.randomUUID().toString();
    }
}
