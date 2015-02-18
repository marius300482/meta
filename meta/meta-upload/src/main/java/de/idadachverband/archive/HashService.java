package de.idadachverband.archive;

import lombok.Setter;
import org.springframework.util.DigestUtils;

import javax.inject.Named;
import java.nio.file.Path;

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
     * @param path to get hashed filename for
     * @return the hashed filename as input for {@code findFile}
     */
    public String getHashedFileName(Path path)
    {
        return DigestUtils.md5DigestAsHex(path.toString().getBytes()) + suffix;
    }
}
