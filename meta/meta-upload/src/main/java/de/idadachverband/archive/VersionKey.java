package de.idadachverband.archive;

import lombok.EqualsAndHashCode;
import lombok.Getter;

/**
 * Composite key for upload versions
 * 
 * @author rpr
 *
 */
@Getter
@EqualsAndHashCode(of = {"baseNumber", "updateNumber"})
public class VersionKey implements Comparable<VersionKey>
{
    public static final VersionKey NO_VERSION = new VersionKey(0, 0);
    
    protected static final String BASE_PREFIX = "v";
    protected static final String UPDATE_PREFIX = "u";
    protected static final String NO_UPDATE = "u0000";
    
    private final String baseId;
    private final String updateId;

    private final int baseNumber;
    private final int updateNumber;
    
    public VersionKey(String versionId, String updateId) throws ArchiveException
    {
        this.baseId = versionId;
        this.updateId = updateId;
        this.baseNumber = parseId(versionId, BASE_PREFIX);
        this.updateNumber = parseId(updateId, UPDATE_PREFIX);
    }
    
    public VersionKey(String versionId) throws ArchiveException
    {
        this.baseId = versionId;
        this.updateId = NO_UPDATE;
        this.baseNumber = parseId(versionId, BASE_PREFIX);
        this.updateNumber = 0;
    }
    
    public VersionKey(int baseNumber, int updateNumber)
    {
        this.baseNumber = baseNumber;
        this.updateNumber = updateNumber;
        this.baseId = String.format("%s%04d", BASE_PREFIX, baseNumber);
        this.updateId = String.format("%s%04d", UPDATE_PREFIX, updateNumber);
    }
    
    private static int parseId(String id, String prefix) throws ArchiveException 
    {
        try 
        {
            return Integer.parseInt(id.substring(prefix.length(), prefix.length() + 4));            
        } catch (Exception e)
        {
            throw new ArchiveException("Invalid version id: " + id, e);
        }
    }

    @Override
    public String toString()
    {
        return baseNumber + "." + updateNumber;
    }
    
    public boolean isBaseVersion() 
    {
        return updateNumber == 0;
    }
    
    public static VersionKey parse(String versionString) throws ArchiveException
    {
        if (versionString.isEmpty())
        {
            return NO_VERSION;
        }
        try 
        {
            String[] parts = versionString.split("\\.");
            int baseNumber = Integer.parseInt(parts[0]);
            int updateNumber = Integer.parseInt(parts[1]);
            return new VersionKey(baseNumber, updateNumber);
        } catch (Exception e)
        {
            throw new ArchiveException("Invalid version: " + versionString, e);
        }
        
    }

    @Override
    public int compareTo(VersionKey o)
    {
        int versionDiff = Integer.compare(this.baseNumber, o.baseNumber); 
        return (versionDiff != 0) 
                ? versionDiff
                : Integer.compare(this.updateNumber, o.updateNumber);
    }
}
