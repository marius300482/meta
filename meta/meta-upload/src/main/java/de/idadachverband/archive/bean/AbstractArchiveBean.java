package de.idadachverband.archive.bean;

import lombok.Data;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by boehm on 25.02.15.
 */
@Data
public abstract class AbstractArchiveBean
        <P extends AbstractArchiveBean<?, ?>, C extends AbstractArchiveBean<?, ?>>
{
    protected final String name;

    protected final P parent;
    protected final List<C> entries = new ArrayList<>();
    
    public void add(C child)
    {
        entries.add(child);
    }
    
    /**
     * @return this archive elements' request path
     */
    public Path getPath()
    {
        return (parent == null)
                ? Paths.get(name)
                : parent.getPath().resolve(name);
    }
    
    @Override
    public String toString() 
    {
        return name;
    }
    
    public C get(String childName)
    {
        // use linear search instead of a map access since sorted entries are more important than a fast get()
        for (C child : entries)
        {
            if (child.name.equals(childName)) {
                return child;
            }
        }
        return null;
    }

    @Override
    public boolean equals(Object obj)
    {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        AbstractArchiveBean<?,?> other = (AbstractArchiveBean<?,?>) obj;
        return getPath().equals(other.getPath());
    }

    @Override
    public int hashCode()
    {
        return getPath().hashCode();
    }
    
}
