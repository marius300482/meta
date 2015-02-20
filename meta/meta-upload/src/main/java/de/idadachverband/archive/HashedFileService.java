package de.idadachverband.archive;

import de.idadachverband.archive.visitor.HashedFileNameFileVisitor;
import lombok.extern.slf4j.Slf4j;

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
    private final HashService hashService;

    /**
     * @param archivePath Root of archive
     */
    @Inject
    public HashedFileService(Path archivePath, HashService hashService)
    {
        this.archivePath = archivePath;
        this.hashService = hashService;
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
        final HashedFileNameFileVisitor hashedFileNameFileVisitor = new HashedFileNameFileVisitor(hashService);
        Files.walkFileTree(archivePath, hashedFileNameFileVisitor);
        return hashedFileNameFileVisitor.getFileMap();
    }
}