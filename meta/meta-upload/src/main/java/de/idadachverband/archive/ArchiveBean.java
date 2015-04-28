package de.idadachverband.archive;

import lombok.Getter;
import lombok.NonNull;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by boehm on 25.02.15.
 */
@Getter
public class ArchiveBean
{
    
    private ArchiveBean parent;
   
    private final String name;

    private final List<ArchiveBean> entries = new ArrayList<>();
    
    public ArchiveBean(@NonNull String name) 
    {
        this.name = name;
    }
    
    public Path getPath() 
    {
        return (parent == null)
                ? Paths.get(name)
                : parent.getPath().resolve(name);
    }
    
    public void add(ArchiveBean child)
    {
        entries.add(child);
        child.parent = this;
    }
    
    @Override
    public String toString() 
    {
        return name;
    }
    
}
