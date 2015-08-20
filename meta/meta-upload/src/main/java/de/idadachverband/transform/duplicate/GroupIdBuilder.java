package de.idadachverband.transform.duplicate;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;

import lombok.Cleanup;
import lombok.Getter;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.SequenceType;
import net.sf.saxon.value.StringValue;

import org.apache.commons.codec.digest.DigestUtils;


@Slf4j
public class GroupIdBuilder
{  
    @Getter
    private final List<FieldNormalizer> normalizers = new ArrayList<FieldNormalizer>();
    
    @Getter
    private final DuplicateLookupTable lookupTable;
    

    public GroupIdBuilder(@NonNull DuplicateLookupTable lookupTable)
    {
        this.lookupTable = lookupTable;
    }
    
    public String buildGroupId(String docId, String format, String... parts)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(format);       
        for (String part : parts)
        {
            sb.append('|');
            sb.append(part);
        }
                
        final String groupString = sb.toString();
        final String groupId = DigestUtils.md5Hex(groupString);
        
        if (log.isTraceEnabled())
        {
            log.trace("computing groupId: {} / groupString: \"{}\" for docId: {}, format: {}, parts: {}",
                    groupId, groupString, docId, format, Arrays.toString(parts));
        }
        return lookupTable.lookupGroupId(docId, groupId);
    }
    
    public void loadNormalizers(Path normalizerConfigPath) throws IOException
    {
        if (!Files.exists(normalizerConfigPath)) return;
        @Cleanup 
        InputStream in = Files.newInputStream(normalizerConfigPath, StandardOpenOption.READ);
        @Cleanup
        JsonReader reader = Json.createReader(in);
        JsonObject normalizerMap = reader.readObject();
        for (String normalizerName : normalizerMap.keySet()) 
        {
            FieldNormalizer.Builder builder = new FieldNormalizer.Builder();
            loadRecursively(builder, normalizerMap, normalizerName, 10);
            this.normalizers.add(builder.build(normalizerName));
        }
    }
    
    protected static void loadRecursively(FieldNormalizer.Builder builder, JsonObject normalizerMap, String normalizerName, int timeToLive)
    {
        if (timeToLive <= 0) return;
        
        JsonObject normalizerConfig = normalizerMap.getJsonObject(normalizerName);
        if (normalizerConfig != null)
        {
            String extendedNormalizerName = normalizerConfig.getString("extends", "");
            if (extendedNormalizerName != null && !extendedNormalizerName.isEmpty())
            {
                loadRecursively(builder, normalizerMap, extendedNormalizerName, timeToLive - 1);
            }
            builder.loadJson(normalizerConfig);
        }
    }
    
    public ExtensionFunctionDefinition asExtensionFunction()
    {
        return new ExtensionFunctionDefinition()
        {
            
            @Override
            public ExtensionFunctionCall makeCallExpression()
            {
                return new ExtensionFunctionCall()
                {
                    @Override
                    public Sequence call(XPathContext context, Sequence[] args)
                            throws XPathException
                    {
                        String id = args[0].head().getStringValue();
                        String format = args[1].head().getStringValue();
                        
                        String[] parts = new String[args.length - 2];
                        for (int i = 2; i < args.length; ++i)
                        {
                            parts[i - 2] =  args[i].head().getStringValue();
                        }
                      
                        return StringValue.makeStringValue(
                                buildGroupId(id, format, parts));
                    }
                };
            }
            
            @Override
            public SequenceType getResultType(SequenceType[] arg0)
            {
                return SequenceType.SINGLE_STRING;
            }
            
            @Override
            public StructuredQName getFunctionQName()
            {
                return new StructuredQName("ida", "http://ida-dachverband.de", "build-group-id");
            }
            
            @Override
            public SequenceType[] getArgumentTypes()
            {
                return new SequenceType[] {
                        SequenceType.SINGLE_STRING,
                        SequenceType.SINGLE_STRING,
                        SequenceType.SINGLE_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING,
                        SequenceType.OPTIONAL_STRING
                };
            }
            
            @Override
            public int getMinimumNumberOfArguments()
            {
                return 3;
            }
            
            @Override
            public int getMaximumNumberOfArguments()
            {
                return 10;
            }
        };
    }
}
