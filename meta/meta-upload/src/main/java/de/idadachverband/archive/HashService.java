package de.idadachverband.archive;

import lombok.Setter;
import org.springframework.util.DigestUtils;

import javax.inject.Named;
import java.io.File;

/**
 * Created by boehm on 11.11.14.
 */
@Named
public class HashService
{
    @Setter
    private String suffix = ".zip";

    /**
     * Hashed filename is based on original filename.
     *
     * @param file to get hashed filename for
     * @return the hashed filename as input for {@code findFile}
     */
    public String getHashedFileName(File file)
    {
        return DigestUtils.md5DigestAsHex(file.getName().getBytes()) + suffix;
    }
}
