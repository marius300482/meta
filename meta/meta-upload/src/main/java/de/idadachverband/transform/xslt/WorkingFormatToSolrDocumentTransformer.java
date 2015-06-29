package de.idadachverband.transform.xslt;

import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.transform.duplicate.DuplicateLookupTable;
import de.idadachverband.transform.duplicate.FieldNormalizer;
import de.idadachverband.transform.duplicate.GroupIdBuilder;
import lombok.Cleanup;
import lombok.extern.slf4j.Slf4j;

import javax.xml.transform.TransformerException;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

/**
 * Created by boehm on 15.01.15.
 */
@Slf4j
public class WorkingFormatToSolrDocumentTransformer extends AbstractXsltTransformer
{
    final private String gleichXsl;

    final private String duplicateTable;
    
    final private String normalizerConfig;
    
    private GroupIdBuilder groupIdBuilder = null; 
    
    public WorkingFormatToSolrDocumentTransformer(String gleichXsl, String duplicateTable, String normalizerConfig) throws IOException
    {
        this.gleichXsl = gleichXsl;
        this.duplicateTable = duplicateTable;
        this.normalizerConfig = normalizerConfig;
    }

    @Override
    public void transform(Path input, Path outputFile, IdaInstitutionBean institutionBean) throws TransformerException, IOException
    {
        try
        {
            if (this.groupIdBuilder == null) initGroupIdBuilder();
            
            @Cleanup
            InputStream in = Files.newInputStream(input, StandardOpenOption.READ);
            @Cleanup
            OutputStream out = Files.newOutputStream(outputFile, StandardOpenOption.CREATE, StandardOpenOption.WRITE);

            transformInstitution(in, out, Paths.get(gleichXsl));
        } catch (UnsupportedOperationException e)
        {
            log.warn("Transformation failed", e);
            throw e;
        }

        log.info("Transformed to Solr format: {}", outputFile);
    }
    
    protected void initGroupIdBuilder() throws IOException
    {
        DuplicateLookupTable lookupTable = new DuplicateLookupTable();
        lookupTable.load(Paths.get(duplicateTable));
        
        this.groupIdBuilder = new GroupIdBuilder(lookupTable);
        this.groupIdBuilder.loadNormalizers(Paths.get(normalizerConfig));
        
        // register xsl extension functions
        register(groupIdBuilder.asExtensionFunction());
        for (FieldNormalizer normalizer : groupIdBuilder.getNormalizers())
        {
            register(normalizer.asExtensionFunction());
        }
    }
}
