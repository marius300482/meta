package de.idadachverband.archive;

import lombok.extern.slf4j.Slf4j;
import org.springframework.util.DigestUtils;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;

/**
 * Allows to use hashes to not expose the file system.
 */
@Named
@Slf4j
public class HashedFileService
{
    private final Path archivePath;

    private final String suffix = ".zip";

    /**
     * @param archivePath Root of archive
     */
    @Inject
    public HashedFileService(Path archivePath)
    {
        this.archivePath = archivePath;
    }

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

    /**
     * Finds file based on hashed filename
     *
     * @param hashedFilename to look for
     * @return file with matching hashedFilename
     * @throws FileNotFoundException
     */
    public File findFile(String hashedFilename) throws IOException
    {
        final Map<String, Path> files = getFiles();
        for (String s : files.keySet())
        {
            if (hashedFilename.equals(s))
            {
                final Path path = files.get(s);
                log.debug("Found file {} for hash {}", path, hashedFilename);
                return path.toFile();
            }
        }
        log.warn("Found no file for hash {}", hashedFilename);
        throw new FileNotFoundException();
    }

    protected Map<String, Path> getFiles() throws IOException
    {
        final HashedFileNameFileVisitor hashedFileNameFileVisitor = new HashedFileNameFileVisitor(this);
        Files.walkFileTree(archivePath, hashedFileNameFileVisitor);
        return hashedFileNameFileVisitor.getFileMap();
    }
}