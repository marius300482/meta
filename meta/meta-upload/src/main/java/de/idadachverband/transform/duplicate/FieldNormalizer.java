package de.idadachverband.transform.duplicate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonString;
import javax.json.JsonValue;

import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.SequenceType;
import net.sf.saxon.value.StringValue;

import org.apache.commons.lang3.StringUtils;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.extern.slf4j.Slf4j;

import com.google.common.base.CharMatcher;
import com.google.common.base.Joiner;
import com.google.common.base.Splitter;
import com.google.common.collect.Lists;

@Slf4j
public class FieldNormalizer
{
    private final String name;
    
    private final Splitter tokenizer;
        
    private final Joiner composer;

    private final String[] originalStrings;

    private final String[] replacementStrings;

    private final List<String> stopWords;
    
    private final boolean lowercase;
    
    private final boolean stripAccents;

    public FieldNormalizer(String name, Builder builder)
    {
        if (log.isDebugEnabled())
        {
            log.debug("Build FieldNormalizer: {} using: {}", name, builder);
        }
        
        this.name = name;
        switch (builder.tokenizeOn) {
        case LETTERS_AND_DIGITS:
            this.tokenizer = Splitter.on(
                    CharMatcher.JAVA_LETTER_OR_DIGIT.negate())
                    .omitEmptyStrings();
            break;

        case LETTERS:
            this.tokenizer = Splitter
                    .on(CharMatcher.JAVA_LETTER.negate())
                    .omitEmptyStrings();
            break;

        case DIGITS:
            this.tokenizer = Splitter
                    .on(CharMatcher.JAVA_DIGIT.negate())
                    .omitEmptyStrings();
            break;
        case ALL_BUT_WHITESPACES:
        default:
            this.tokenizer = Splitter
                    .on(CharMatcher.WHITESPACE)
                    .omitEmptyStrings();
            break;
        }

        this.composer = Joiner.on(' ');
        this.originalStrings = builder.originalStrings.toArray(new String[builder.originalStrings.size()]);
        this.replacementStrings = builder.replacementStrings.toArray(new String[builder.replacementStrings.size()]);
        this.stopWords = new ArrayList<String>(builder.stopWords);
        this.lowercase = builder.lowercase;
        this.stripAccents = builder.stripAccents;
    }
    
    public String normalize(String input)
    {
        String output = input;
        if (lowercase)
        {
            output = output.toLowerCase();
        }
        if (originalStrings.length > 0)
        {
            output = StringUtils.replaceEach(output, originalStrings, replacementStrings);
        }
        if (stripAccents)
        {
            output = StringUtils.stripAccents(output);
        }
        LinkedList<String> tokens = Lists.newLinkedList(
                tokenizer.split(output));
        tokens.removeAll(stopWords);
        output = composer.join(tokens);
        if (log.isDebugEnabled())
        {
            log.debug("normalize-{}: input: \"{}\", output: \"{}\"", name, input, output);
        }
        return output;
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
                    public Sequence call(XPathContext context, Sequence[] arguments)
                            throws XPathException
                    {
                        final String input = arguments[0].head().getStringValue(); 
                        final String output = normalize(input);
                        return StringValue.makeStringValue(output);
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
                return new StructuredQName("ida", "http://ida-dachverband.de", "normalize-" + name);
            }
            
            @Override
            public SequenceType[] getArgumentTypes()
            {
                return new SequenceType[] { SequenceType.SINGLE_STRING };
            }
        };
    }
    
    @Accessors(fluent = true, chain = true)
    @Data
    public static class Builder
    {
        private final List<String> originalStrings = new ArrayList<String>();
        
        private final List<String> replacementStrings = new ArrayList<String>();

        private final Set<String> stopWords = new HashSet<String>();
        
        private String extendedNormalizerName = "";
        
        private CharacterSet tokenizeOn = CharacterSet.LETTERS_AND_DIGITS;
        
        private boolean lowercase = true;
        
        private boolean stripAccents = true;
        
        public Builder loadJson(JsonObject configObject)
        {
            JsonObject replacementsObject = configObject.getJsonObject("replacements");
            if (replacementsObject != null)
            {
                for (Entry<String, JsonValue> entry : replacementsObject.entrySet())
                {
                    originalStrings.add(entry.getKey());
                    replacementStrings.add(((JsonString) entry.getValue()).getString());
                }
            }                
            
            JsonArray stopWordsArray = configObject.getJsonArray("stopWords");
            if (stopWordsArray != null)
            {
                for (int i = 0; i < stopWordsArray.size(); ++i) 
                {
                    stopWords.add(stopWordsArray.getString(i));
                }
            }
            
            if (configObject.containsKey("lowercase")) 
            {
                lowercase = configObject.getBoolean("lowercase");
            }
            
            if (configObject.containsKey("stripAccents")) 
            {
                stripAccents = configObject.getBoolean("stripAccents");
            }
            
            if (configObject.containsKey("tokenizeOn"))
            {
                tokenizeOn = CharacterSet.valueOf(configObject.getString("tokenizeOn"));
            }
            return this;
        }
        
        public Builder addReplacements(Collection<String> originalStrings, Collection<String> replacementStrings)
        {
            if (originalStrings.size() != replacementStrings.size())
            {
                throw new IllegalArgumentException("Sizes of originalStrings and replacementStrings do not match");
            }
            this.originalStrings.addAll(originalStrings);
            this.replacementStrings.addAll(replacementStrings);
            return this;
        }
        
        public Builder addStopWords(Collection<String> stopWords)
        {
            this.stopWords.addAll(stopWords);
            return this;
        }
        
        public FieldNormalizer build(String name)
        {
            return new FieldNormalizer(name, this);
        }
    }
   
    public enum CharacterSet
    {
        LETTERS_AND_DIGITS,
        LETTERS,
        DIGITS,
        ALL_BUT_WHITESPACES
    }
}
