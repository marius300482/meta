package de.idadachverband.archive;

import lombok.Getter;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by boehm on 25.02.15.
 */
public class ArchiveBean
{
    @Getter
    private final Path folder;

    @Getter
    private Map<ArchiveBean, List<Path>> archive =
            new HashMap<>();

    public ArchiveBean(Path folder)
    {
        this.folder = folder;
    }

    public void add(ArchiveBean archiveBean, List<Path> paths)
    {
        archive.put(archiveBean, paths);
    }

    @Override
    public String toString()
    {
        return folder + " " + archive.keySet();
    }
}
