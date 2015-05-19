package de.idadachverband.solr;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import de.idadachverband.archive.VersionKey;
import de.idadachverband.institution.IdaInstitutionBean;
import de.idadachverband.job.JobBean;

@Getter
public class ReindexJobBean extends JobBean
{
    private final List<SolrUpdateBean> solrUpdates = new ArrayList<>();
   
    private final SolrService solrService;
    private final IdaInstitutionBean institution;
    private final VersionKey version;

    
    public ReindexJobBean(SolrService solrService,
            IdaInstitutionBean institution, VersionKey version)
    {
        this.solrService = solrService;
        this.institution = institution;
        this.version = version;
        setJobName(String.format("Re-index archived upload version %s for %s, %s", 
                version, getSolrService().getName(), getInstitution().getInstitutionName()));
    }
    
    @Override
    public void buildResultMessage(StringBuilder sb)
    {
        for (SolrUpdateBean solrUpdate : solrUpdates)
        {
            solrUpdate.buildResultMessage(sb);
        }
    }
}
