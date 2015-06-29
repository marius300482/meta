package de.idadachverband.transform.duplicate;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonReader;
import javax.json.JsonString;
import javax.json.JsonValue;
import javax.json.JsonWriter;

import lombok.Getter;

public class DuplicateLookupTable
{
    private final HashMap<String, String> documentToGroupId = new HashMap<String, String>();
    
    @Getter
    private boolean modified = false;
    
    public void assign(String documentId, String groupId)
    {
        this.documentToGroupId.put(documentId, groupId);
        this.modified = true;
    }
    
    public String getGroupId(String documentId)
    {
        return this.documentToGroupId.get(documentId);      
    }
    
    public void removeAssignment(String documentId)
    {
        if (this.documentToGroupId.remove(documentId) != null) {
            this.modified = true;
        }
    }
    
    public String lookupGroupId(String documentId, String originalGroupId)
    {
        final String groupId = this.documentToGroupId.get(documentId);
        if (groupId == null) 
        {
            return originalGroupId;
        }
        if (groupId.equals(originalGroupId)) 
        {
            removeAssignment(documentId);
        }
        return groupId;
    }
    
    public void load(Path inputPath) throws IOException 
    {
        if (!Files.exists(inputPath)) return;
        JsonReader reader = Json.createReader(Files.newInputStream(inputPath, StandardOpenOption.READ));
        JsonObject documentToGroupIdJson = reader.readObject();
        reader.close();
        // copy 
        for (Entry<String, JsonValue> entry : documentToGroupIdJson.entrySet())
        {
            this.documentToGroupId.put(entry.getKey(), ((JsonString) entry.getValue()).getString());
        }
    }
    
    public void store(Path outputPath) throws IOException 
    {
        JsonObjectBuilder documentToGroupIdBuilder = Json.createObjectBuilder();
        for (Entry<String, String> entry : this.documentToGroupId.entrySet())
        {
            documentToGroupIdBuilder.add(entry.getKey(), entry.getValue());
        }
        JsonWriter writer = Json.createWriter(     
                Files.newOutputStream(outputPath,  StandardOpenOption.CREATE, StandardOpenOption.WRITE));
        writer.writeObject(documentToGroupIdBuilder.build());
        writer.close();
    }
}
