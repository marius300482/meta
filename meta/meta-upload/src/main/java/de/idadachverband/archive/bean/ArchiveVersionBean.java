package de.idadachverband.archive.bean;

import java.nio.file.Path;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import de.idadachverband.archive.ArchiveException;
import de.idadachverband.archive.VersionKey;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "version")
@ToString(of = "version", includeFieldNames = false)
public class ArchiveVersionBean implements Comparable<ArchiveVersionBean>
{
    protected final VersionKey version;
        
    private Path uploadFile, workingFormatFile, solrFormatFile;
    
    private Date date = new Date();
    
    private VersionOrigin origin;
    
    private String userName;
    
    private VersionKey originalVersion;
   
    
    public String getDescription()
    {
        switch (origin) {
        case UPLOAD:
            return "user '" + userName + "' uploaded file '" + uploadFile.getFileName() + "'";
        case REINDEX:
            return "user '" + userName + "' re-indexed archived upload version " + originalVersion;
        case REPROCESS:
            return "user '" + userName + "' re-processed archived upload version " + originalVersion;
        default:
            return "";
        }
    } 
    
    public void storeProperties(Properties properties, SimpleDateFormat dateFormat)
    {
        properties.setProperty("origin", origin.toString());
        properties.setProperty("user", userName);
        properties.setProperty("date", dateFormat.format(date));
        if (originalVersion != VersionKey.NO_VERSION) {
            properties.setProperty("originalVersion", originalVersion.toString());
        }
    }
    
    public void loadProperties(Properties properties, SimpleDateFormat dateFormat) throws ParseException, ArchiveException
    {
        this.origin = VersionOrigin.valueOf(properties.getProperty("origin"));
        this.userName = properties.getProperty("user");
        this.date = dateFormat.parse(properties.getProperty("date"));
        this.originalVersion = VersionKey.parse(properties.getProperty("originalVersion", ""));  
    }

    @Override
    public int compareTo(ArchiveVersionBean o)
    {
        return this.version.compareTo(o.version);
    }
    
    public int getBaseNumber()
    {
        return version.getBaseNumber();
    }
    
    public int getUpdateNumber()
    {
        return version.getUpdateNumber();
    }
}
