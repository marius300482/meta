package de.idadachverband.upload;

import de.idadachverband.solr.SolrService;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;


/**
 * Created by boehm on 04.09.14.
 */
@Data
public class UploadFormBean
{
    private IdaInstitutionBean institution;
    private SolrService solr;
    private MultipartFile file;
}
