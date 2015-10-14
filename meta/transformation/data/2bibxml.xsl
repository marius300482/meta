<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Dec 03 09:17:59 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	xmlns:ida="http://ida-dachverband.de"
	
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	<xsl:preserve-space elements="*" />
	
	<xsl:template match="catalog">
	
	<add>
	
		<xsl:for-each select="record">
		
		<doc>
		

<!--solr-->
		
			<!--<field name="allfields"><xsl:value-of select="normalize-space(string(.))"/></field>--><!-- ALLFIELDS alle Inhalte werden in ein Feld geschrieben -->
			<field name="allfields">
				<!--<xsl:value-of select="normalize-space(string(.))"/>-->
				<xsl:value-of select="dataset/format"/><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/documentType" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/title_short[normalize-space()]"/><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/title_sub[normalize-space()]"/><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/formerTitle"><xsl:value-of select="." /></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/upcomingTitle"><xsl:value-of select="." /></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/author"><xsl:value-of select="." /></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/editor"><xsl:value-of select="." /></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/contributor"><xsl:value-of select="." /></xsl:for-each><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/entity"/><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/reviewer"/><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/series" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/isbn" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/issn" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/issue" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/zdbId" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/displayPublishDate" /><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/subjectTopic[text()!='']"><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/subjectGeographic[text()!='']"><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each><xsl:text> </xsl:text>
				<xsl:for-each select="dataset/subjectPerson[text()!='']"><xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/description" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/listOfContents" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/sourceInfo" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/specificMaterialDesignation" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/collectionHolding" /><xsl:text> </xsl:text>
				<xsl:value-of select="dataset/annotations" /><xsl:text> </xsl:text>
                    			</field>
<!--vufind-->
		
			<field name="id"><xsl:value-of select="vufind/id" /></field>
		
			<field name="recordtype"><xsl:value-of select="vufind/recordType" /></field>
			
			<field name="recordCreationDate"><xsl:value-of select="vufind/recordCreationDate" /></field>

			<field name="recordChangeDate"><xsl:value-of select="vufind/recordChangeDate" /></field>
			
			
		
<!--institution-->
		
			<field name="institution"><xsl:value-of select="institution/institutionShortname" /></field>
			
			<field name="institutionFull"><xsl:value-of select="institution/institutionFull" /></field>
			
			<field name="institutionID"><xsl:value-of select="institution/institutionID" /></field>
			
			<field name="collection"><xsl:value-of select="institution/collection" /></field>
			
			<field name="recordContentSource"><xsl:value-of select="institution/isil" /></field>
			
			<field name="latitude"><xsl:value-of select="institution/geoLocation/latitude" /></field>
			
			<field name="longitude"><xsl:value-of select="institution/geoLocation/longitude" /></field>
			
			<xsl:apply-templates select="institution/location[string-length() != 0]" />
		
<!--dataset-->
			
			<xsl:apply-templates select="dataset/typeOfRessource" />
    			
    			<xsl:apply-templates select="dataset/format" />
    			
    			<xsl:apply-templates select="dataset/documentType[1]" />
    	
    	<!--Titelangaben-->
    	
			<field name="title"><xsl:value-of select="dataset/title[normalize-space()]"/></field>
                   	 	
            		<xsl:apply-templates select="dataset/title_sub" />
            		
            		<xsl:apply-templates select="dataset/title_short" />
    			
    			<xsl:apply-templates select="dataset/formerTitle" />
    			
    			<xsl:apply-templates select="dataset/upcomingTitle" />
    			
    			<xsl:apply-templates select="dataset/alternativeTitle" />
    			
    	<!--beteiligte Personen-->	
    			<xsl:if test="dataset/author[1]">
				<field name="author"><xsl:value-of select="dataset/author[1]" /></field>
				</xsl:if>
		
			<xsl:for-each select="dataset/author[position()>=2]">
				<field name="author_additional"><xsl:value-of select="." /></field>
				</xsl:for-each>
			
    			<xsl:apply-templates select="dataset/editor" />
    			
			<xsl:apply-templates select="dataset/contributor" />
			
			<xsl:apply-templates select="dataset/contributorNoFacet" />
    			
    			<xsl:apply-templates select="dataset/entity" />
    			
    			<xsl:apply-templates select="dataset/reviewer" />
    			
    			<xsl:apply-templates select="dataset/series" />
    			
    			<xsl:apply-templates select="dataset/seriesNr" />
    			
    			<xsl:apply-templates select="dataset/provenance" />
    			
    			<!--<xsl:if test="dataset/isbn">
				<field name="isbn">	<xsl:value-of select="dataset/isbn" /></field>
				</xsl:if>-->
			<xsl:apply-templates select="dataset/isbn" />
			
			<!--<xsl:if test="dataset/issn">
				<field name="issn">	<xsl:value-of select="dataset/issn" /></field>
				</xsl:if>-->
			<xsl:apply-templates select="dataset/issn" />
			
			<xsl:apply-templates select="dataset/zdbId" />
			
			<xsl:apply-templates select="dataset/annotation" />
			
    			<xsl:apply-templates select="dataset/collectionHolding" />
    			
    			<xsl:apply-templates select="dataset/displayPublishDate[1]" />	
    			
    			<xsl:apply-templates select="dataset/publishDate[1]" />
    			<!--
    			<xsl:if test="dataset/publishDate">
                    			<field name="publishDate"><xsl:value-of select="dataset/publishDate"/></field>
                			</xsl:if>-->
                		
                		<xsl:if test="dataset/timeSpan">
                    			<field name="timeSpanStart"><xsl:value-of select="dataset/timeSpan/timeSpanStart"/></field>
                    			<field name="timeSpanEnd"><xsl:value-of select="dataset/timeSpan/timeSpanEnd"/></field>
                			</xsl:if>
    			
    			<xsl:apply-templates select="dataset/placeOfPublication" />
			
			<xsl:apply-templates select="dataset/publisher" />
			
			<xsl:apply-templates select="dataset/physical" />
			
			<xsl:apply-templates select="dataset/dimension" />
			
			<xsl:apply-templates select="dataset/runTime" />
    			
			<xsl:apply-templates select="dataset/specificMaterialDesignation" />
    			
			<xsl:for-each select="dataset/language">
				<xsl:variable name="test" select="." />
					<field name="language">
						<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$test]/@name"/>
						</field>
					<field name="language_code">
						<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$test]/@code"/>
						</field>
				</xsl:for-each>
			
			<xsl:apply-templates select="dataset/language_code" />
			
			<xsl:apply-templates select="dataset/subjectTopic" />
			
                		
                		<!--<xsl:variable name="topic" select="dataset/subjectTopic" />
                		<xsl:if test="document('../anreicherung/thesaurus.xml')/root/term/usedTerm=$topic">
                			<xsl:for-each select="document('../anreicherung/thesaurus.xml')/root/term[usedTerm=$topic]/translatedTerm">
                				<field name="translatedTerm">
                					<xsl:value-of select="@lang"/>
                					<xsl:text>: </xsl:text>
                					<xsl:value-of select="."/>
                					<xsl:text> (</xsl:text>
                					<xsl:value-of select="../usedTerm"/>		
                					<xsl:text>)</xsl:text>
                					</field>
                				</xsl:for-each>
                			</xsl:if>-->
                		
                		<xsl:apply-templates select="dataset/subjectGeographic" />
                		
                		<xsl:apply-templates select="dataset/subjectPerson" />
                			
                		<xsl:apply-templates select="dataset/subjectName" />
                		
                		<xsl:apply-templates select="dataset/description" />
                		
                		<xsl:apply-templates select="dataset/shelfMark[1]" />
                		
                		<xsl:apply-templates select="dataset/issue" />
			
			<xsl:apply-templates select="dataset/volume" />
			
			<xsl:if test="dataset/project">
				<xsl:for-each select="distinct-values(tokenize(dataset/project, ' '))">
					<xsl:if test=".!=''">
						<field name="project"><xsl:value-of select="." /></field>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			
			<xsl:apply-templates select="dataset/url" />
			
			<xsl:if test="dataset/relatedTo">
				<field name="relatedTo">
					<xsl:value-of select="dataset/relatedTo"/>
					</field>
				</xsl:if>
			
			<xsl:apply-templates select="dataset/sourceInfo" />
			
			<xsl:apply-templates select="dataset/listOfContents" />
			
			<field name="groupID">
			<!-- 
			     The groupID field is build using ida:build-group-id(<doc-id>,<format>,<normalized field>,<normalized field>,...) 
			     Normalizer functions ida:normalize-<field-name>(<field value>) are configured in /meta/transformation/data/normalizers.json
			-->
				<xsl:choose>
					<xsl:when test="dataset/format = 'Buch' or dataset/format = 'Artikel'">
						<xsl:variable name="author">
							<xsl:choose>
								<xsl:when test="dataset/author[1]">
									<xsl:value-of select="ida:normalize-author(dataset/author[1])"/>
								</xsl:when>
								<xsl:when test="dataset/editor[1]">
									<xsl:value-of select="ida:normalize-author(dataset/editor[1])"/>
								</xsl:when>
								<xsl:when test="dataset/contributor[1]">
									<xsl:value-of select="ida:normalize-author(dataset/contributor[1])"/>
								</xsl:when>
								<xsl:when test="dataset/publisher[1]">
									<xsl:value-of select="ida:normalize-author(dataset/publisher[1])"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="title">
							<xsl:choose>
								<xsl:when test="dataset/title_short[1] and dataset/title_sub[1]">
									<xsl:value-of select="ida:normalize-title(concat(dataset/title_short[1], ' ', dataset/title_sub[1]))"/>
								</xsl:when>
								<xsl:when test="dataset/title[1]">
									<xsl:value-of select="ida:normalize-title(dataset/title[1])"/>
								</xsl:when>
								<xsl:when test="dataset/title_short[1]">
									<xsl:value-of select="ida:normalize-title(dataset/title_short[1])"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="ida:build-group-id(vufind/id, dataset/format, $author, $title)"/>		
					</xsl:when>
					<xsl:when test="dataset/format = 'Zeitschrift'">
						<xsl:variable name="title">
							<xsl:choose>
								<xsl:when test="dataset/title_short[1]">
									<xsl:value-of select="ida:normalize-title(dataset/title_short[1])"/>
								</xsl:when>
								<xsl:when test="dataset/title[1]">
									<xsl:value-of select="ida:normalize-title(dataset/title[1])"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="issue">
							<xsl:choose>
								<xsl:when test="dataset/issue[1]">
									<xsl:value-of select="dataset/issue[1]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="publishDate">
							<xsl:choose>
								<xsl:when test="dataset/displayPublishDate[1]">
									<xsl:value-of select="dataset/displayPublishDate[1]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="''"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="ida:build-group-id(vufind/id, dataset/format, $title, $publishDate, $issue)"/>		
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="vufind/id"/>
					</xsl:otherwise>
				</xsl:choose>
			</field>
				
			<xsl:apply-templates select="dataset/edition" />
			
			
			
			<!--<xsl:apply-templates select="dataset/provenance" />-->
			
	<!--Anreicherung Artikel-->
			<!--<xsl:if test="dataset/format='Artikel'">
			<xsl:variable name="test" select="functions/hierarchyFields/hierarchy_parent_id" />
			
				<xsl:if test="//record[@id=$test]/dataset/displayPublishDate">
					<field name="displayPublishDate"><xsl:value-of select="//record[@id=$test]/dataset/displayPublishDate"/></field>
					</xsl:if>
				<xsl:if test="//record[@id=$test]/dataset/placeOfPublication">
					<field name="placeOfPublication"><xsl:value-of select="//record[@id=$test]/dataset/placeOfPublication"/></field>
					</xsl:if>
				<xsl:if test="//record[@id=$test]/dataset/publisher">
					<field name="publisher"><xsl:value-of select="//record[@id=$test]/dataset/publisher"/></field>
					</xsl:if>
				<xsl:if test="//record[@id=$test]/functions/systematikFields/systematik_parent_id">
					<field name="systematik_parent_id"><xsl:value-of select="//record[@id=$test]/functions/systematikFields/systematik_parent_id"/></field>
					</xsl:if>
				<xsl:if test="//record[@id=$test]/functions/systematikFields/systematik_parent_title">
					<field name="systematik_parent_title"><xsl:value-of select="//record[@id=$test]/functions/systematikFields/systematik_parent_title"/></field>
					</xsl:if>
				
				<xsl:if test="(not(dataset/language)) and (not(dataset/language_code))">
				<xsl:choose>
					<xsl:when test="//record[@id=$test]/dataset/language">
						<xsl:for-each select="//record[@id=$test]/dataset/language">
						<xsl:variable name="language" select="." />
							<xsl:choose>
								<xsl:when test="$language">
									<field name="language">
									<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$language]/@name"/>
										</field>
									<field name="language_code">
									<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$language]/@code"/>
										</field>
									</xsl:when>
								</xsl:choose>					
							</xsl:for-each>
						</xsl:when>
					<xsl:otherwise>
						<field name="language">
							<xsl:text>o. A.</xsl:text>
							</field>
						</xsl:otherwise>	
						</xsl:choose>
						</xsl:if>
				</xsl:if>-->
				
	
	
		
<!--functions-->
		
		<xsl:if test="functions/loan/loanStatus">
			<field name="loanStatus"><xsl:text>true</xsl:text></field>
		</xsl:if>
		
		<xsl:if test="functions/loan/loanReturn">
			<field name="loanReturn"><xsl:value-of select="functions/loan/loanReturn"/></field>
		</xsl:if>
		
		
		<xsl:if test="functions/systematikFields/systematik_parent_id">
			<xsl:for-each select="functions/systematikFields/systematik_parent_id">
				<field name="systematik_parent_id"><xsl:value-of select="." /></field>
			</xsl:for-each>
		</xsl:if>
		
		<xsl:if test="functions/systematikFields/systematik_parent_title">
			<xsl:for-each select="functions/systematikFields/systematik_parent_title">
				<field name="systematik_parent_title"><xsl:value-of select="." /></field>
			</xsl:for-each>
		</xsl:if>
		
		<xsl:if test="functions/hierarchyFields/hierarchy_top_id">
			<xsl:for-each select="functions/hierarchyFields/hierarchy_top_id">
				<field name="hierarchy_top_id"><xsl:value-of select="." /></field>
			</xsl:for-each>
		</xsl:if>		
			
		<xsl:if test="functions/hierarchyFields/hierarchy_top_title">
			<xsl:for-each select="functions/hierarchyFields/hierarchy_top_title">
				<field name="hierarchy_top_title"><xsl:value-of select="."/></field>
			</xsl:for-each>
		</xsl:if>
		
		 <xsl:if test="functions/hierarchyFields/hierarchy_parent_id">
		 	 <field name="hierarchy_parent_id"><xsl:value-of select="functions/hierarchyFields/hierarchy_parent_id"/></field>
		 </xsl:if>
		<xsl:if test="functions/hierarchyFields/hierarchy_parent_title">
			<field name="hierarchy_parent_title"><xsl:value-of select="functions/hierarchyFields/hierarchy_parent_title"/></field>
		</xsl:if>
		<xsl:if test="functions/hierarchyFields/is_hierarchy_id">
			 <field name="is_hierarchy_id"><xsl:value-of select="functions/hierarchyFields/is_hierarchy_id"/></field>
		</xsl:if>
		<xsl:if test="functions/hierarchyFields/is_hierarchy_title">
			<field name="is_hierarchy_title"><xsl:value-of select="functions/hierarchyFields/is_hierarchy_title"/></field>
		</xsl:if>
		<xsl:if test="functions/hierarchyFields/hierarchy_sequence">
			<field name="hierarchy_sequence"><xsl:value-of select="functions/hierarchyFields/hierarchy_sequence"/></field>
		</xsl:if>

	
	

	</doc>
	
	
	
	</xsl:for-each>
	<commit/>
 	<!--<optimize/>-->
	
</add>
</xsl:template>
	
	<xsl:template match="annotation">
		<field name="annotation"><xsl:value-of select="."/></field>
		</xsl:template>
	
	<xsl:template match="collectionHolding">
		<field name="collectionHolding"><xsl:value-of select="."/></field>
		</xsl:template>
	
	<xsl:template match="format">
		<field name="format"><xsl:value-of select="."/></field>
		</xsl:template>
	
	<xsl:template match="typeOfRessource">
		<field name="typeOfRessource"><xsl:value-of select="."/></field>
		</xsl:template>
	
	<xsl:template match="documentType">
		<field name="documentType">
			<xsl:for-each select="../documentType">
				<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text>			
				</xsl:for-each>
			</field>
		</xsl:template>
	
	<xsl:template match="publishDate">
		<xsl:variable name="the_max">
     			<xsl:for-each select="../publishDate">
       			<xsl:sort data-type="number" order="descending"/>
       				<xsl:if test="position()=1">
       					<xsl:value-of select="."/>
       					</xsl:if>
     				</xsl:for-each>
   			</xsl:variable>
		<!--<xsl:variable name="the_min">
     			<xsl:for-each select="../publishDate">
       				<xsl:sort data-type="number" order="ascending"/>
       				<xsl:if test="position()=1">
       					<xsl:value-of select="."/>
       					</xsl:if>
     				</xsl:for-each>
   			</xsl:variable>-->
		
		<field name="publishDateSort">
				<xsl:value-of select="$the_max" />
				</field>
		<!--<field name="publishDateMin">
				<xsl:value-of select="$the_min" />
				</field>-->
		</xsl:template>
	
	<xsl:template match="provenance">
		<xsl:for-each select=".">
			<field name="provenance">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="subjectName">
		<xsl:for-each select=".">
			<field name="subjectName">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="specificMaterialDesignation">
		<xsl:for-each select=".">
			<field name="specificMaterialDesignation">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="contributor">
		<xsl:for-each select="tokenize(.,';')">
			<field name="contributor">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="contributorNoFacet">
		<xsl:for-each select=".">
			<field name="contributorNoFacet">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="issn">
		<xsl:for-each select=".">
			<field name="issn">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="isbn">
		<xsl:for-each select=".">
			<field name="isbn">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="zdbId">
		<xsl:for-each select=".">
			<field name="zdbId">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="language_code">
		
		<xsl:for-each select=".">
		<xsl:variable name="test" select="." />
			<field name="language">
				<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@code=$test]/@name"/>
				</field>
			<field name="language_code">
				<xsl:value-of select="."/>
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="edition">
		<field name="edition">
			<xsl:value-of select="." />
			</field>
		</xsl:template>
		
	<xsl:template match="publisher">
		<field name="publisher">
			<xsl:value-of select="." />
			</field>
		</xsl:template>
	
	<xsl:template match="location">
		<field name="location">
			<xsl:value-of select="." />
			</field>
		</xsl:template>
	
	<xsl:template match="series">
		<xsl:for-each select=".">
			<field name="series">
				<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="seriesNr">
		<xsl:for-each select=".">
			<field name="seriesNr">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="displayPublishDate">
		<field name="displayPublishDate">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>

	<xsl:template match="placeOfPublication">
		<xsl:for-each select=".">
			<field name="placeOfPublication">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="physical">
		<field name="physical">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
	
	<xsl:template match="dimension">
		<xsl:for-each select=".">
			<field name="dimension">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="runTime">
		<field name="runTime">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
		
	<xsl:template match="entity">
		<field name="entity">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
		
	<xsl:template match="reviewer">
		<field name="reviewer">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
		
	<xsl:template match="editor">
		<xsl:for-each select=".">
			<field name="editor">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="title_sub">
		<field name="title_sub">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
		
	<xsl:template match="title_short">
		<field name="title_short">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
	
	<xsl:template match="formerTitle">
		<xsl:for-each select=".">
			<field name="title_old">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="upcomingTitle">
		<xsl:for-each select=".">
			<field name="title_new">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="alternativeTitle">
		<xsl:for-each select=".">
			<field name="title_alt">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="subjectTopic">
		<xsl:for-each select=".[text()!='']">
			<field name="topic">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			
			<!--<xsl:variable name="topic" select="." />
			
				<xsl:copy-of select="document('../anreicherung/thesaurus.xml')/root/term[usedTerm=$topic]/field">
				</xsl:copy-of>-->
				
			
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="subjectGeographic">
		<xsl:for-each select=".[text()!='']">
			<field name="subjectGeographic">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="subjectPerson">
		<xsl:for-each select=".[text()!='']">
			<field name="subjectPerson">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="description">
		<field name="description">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
	
	<xsl:template match="shelfMark">
		<field name="shelfMark">
			<xsl:for-each select="../shelfMark">
				<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text>			
				</xsl:for-each>
			</field>
		</xsl:template>
	
	<xsl:template match="issue">
		<xsl:for-each select=".[text()!='']">
			<field name="issue">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="volume">
		<xsl:for-each select=".[text()!='']">
			<field name="volume">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="url">
		<field name="url">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
		
	<xsl:template match="sourceInfo">
		<xsl:for-each select=".[text()!='']">
			<field name="sourceInfo">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="listOfContents">
		<xsl:for-each select=".[text()!='']">
			<field name="listOfContents">
				<xsl:value-of select="normalize-space(.)" />
				</field>
			</xsl:for-each>
		</xsl:template>
	
</xsl:stylesheet>
