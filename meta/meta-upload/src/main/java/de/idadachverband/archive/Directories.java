package de.idadachverband.archive;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

import lombok.extern.slf4j.Slf4j;
import de.idadachverband.archive.visitor.DeletingFileVisitor;

@Slf4j
public class Directories
{
    public static List<Path> listFiles(Path dir, boolean files)
    {
        List<Path> pathList = new ArrayList<>();
        try (final DirectoryStream<Path> paths = Files.newDirectoryStream(dir))
        {
            for (Path path : paths)
            {
                if (shouldBeAdded(files, dir))
                {
                    pathList.add(path);
                }
            }
        } catch (IOException e)
        {
            log.warn("Error while listing {}", dir, e);
        }
        return pathList;
    }
    
    private static boolean shouldBeAdded(boolean files, Path path)
    {
        return (files && Files.isRegularFile(path)) ||
                (!files && Files.isDirectory(path));
    }
    
    public static Path findFirstFile(Path dir) throws IOException
    {
        final DirectoryStream<Path> paths = Files.newDirectoryStream(dir);
        for (Path path : paths)
        {
            if (Files.isRegularFile(path))
            {
               return path;
            }
        }
        log.error("Directory {} contains no files", dir);
        throw new FileNotFoundException(dir + " is empty");
    }
    
    public static List<String> listDirectoryNames(Path dir)
    {
        List<String> pathList = new ArrayList<>();
        if (Files.exists(dir)) {
            try (final DirectoryStream<Path> paths = Files.newDirectoryStream(dir))
            {
                for (Path path : paths)
                {
                    if (Files.isDirectory(path))
                    {
                        pathList.add(path.getFileName().toString());
                    }
                }
            } catch (IOException e)
            {
                log.warn("Error while listing {}", dir, e);
            }
        }
       
        return pathList;
    }
    
    public static void delete(Path dir)
    {
        try 
        {
            Files.walkFileTree(dir, DeletingFileVisitor.INSTANCE);
        } catch (IOException e)
        {
            log.warn("Error while deleting {}", dir, e);
        }
    }
}
