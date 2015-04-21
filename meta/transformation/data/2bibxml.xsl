<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Dec 03 09:17:59 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
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
				<xsl:value-of select="dataset/title[normalize-space()]"/><xsl:text> </xsl:text>
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
                    				
				</field><!-- ALLFIELDS alle Inhalte werden in ein Feld geschrieben -->
<!--vufind-->
		
			<field name="id"><xsl:value-of select="vufind/id" /></field>
		
			<field name="recordtype"><xsl:value-of select="vufind/recordType" /></field>
			
			<field name="recordCreationDate"><xsl:value-of select="vufind/recordCreationDate" /></field>

			<field name="recordChangeDate"><xsl:value-of select="vufind/recordChangeDate" /></field>
			
			
		
<!--institution-->
		
			<field name="institution"><xsl:value-of select="institution/institutionShortname" /></field>
			
			<field name="institutionFull"><xsl:value-of select="institution/institutionFull" /></field>
			
			<field name="collection"><xsl:value-of select="institution/collection" /></field>
			
			<field name="recordContentSource"><xsl:value-of select="institution/isil" /></field>
		
<!--dataset-->
		
			<xsl:if test="dataset/typeOfRessource">
				<field name="typeOfRessource"><xsl:value-of select="dataset/typeOfRessource" /></field>
    				</xsl:if>
    			
    			<xsl:apply-templates select="dataset/format" />
    			
    			<xsl:if test="dataset/documentType">
    				<field name="documentType"><xsl:value-of select="dataset/documentType" /></field>
    				</xsl:if>
    	
    	<!--Titelangaben-->
    	
			<field name="title"><xsl:value-of select="dataset/title[normalize-space()]"/></field>
                   	 	
            		<xsl:if test="dataset/title_sub">
				<field name="title_sub"><xsl:value-of select="dataset/title_sub[normalize-space()]"/></field>
				</xsl:if>
			
			<xsl:if test="dataset/title_short">
				<field name="title_short"><xsl:value-of select="dataset/title_short[normalize-space()]"/></field>
				</xsl:if>
    			
    			<xsl:if test="dataset/formerTitle">
                   	 		<xsl:for-each select="dataset/formerTitle">
                   	 			<!--<field name="formerTitle">--><!--geändert 18.09.14 MZ-->
                   	 			<field name="title_old">
           					<xsl:value-of select="." />
	                   	 			</field>
                   	 			</xsl:for-each>
                   	 		</xsl:if>
                   	 		
                   	 	<xsl:if test="dataset/upcomingTitle">
                   	 		<xsl:for-each select="dataset/upcomingTitle">
                   	 			<!--<field name="upcomingTitle">--><!--18.09.14 geändert MZ-->
                   	 			<field name="title_new">
           					<xsl:value-of select="." />
	                   	 			</field>
                   	 			</xsl:for-each>
                   	 		</xsl:if>
                   	 	
                   	 	<xsl:if test="dataset/alternativeTitle">
                   	 		<xsl:for-each select="dataset/alternativeTitle">
                   	 			<!--<field name="alternativeTitle">--><!--18.09.14 geändert MZ-->
                   	 			<field name="title_alt">
                   	 				<xsl:value-of select="." />
                   	 				</field>
                   	 			</xsl:for-each>
                   	 		</xsl:if>
    			
    	<!--beteiligte Personen-->	
    			<xsl:if test="dataset/author[1]">
				<field name="author"><xsl:value-of select="dataset/author[1]" /></field>
				</xsl:if>
		
			<xsl:for-each select="dataset/author[position()>=2]">
				<field name="author_additional"><xsl:value-of select="." /></field>
				</xsl:for-each>
			
    			<xsl:if test="dataset/editor[normalize-space()]">
                    			<xsl:for-each select="dataset/editor">
	                    			<field name="editor">
           	             			<xsl:value-of select="."/>
                    				</field>
                    				</xsl:for-each>
                			</xsl:if>
    			
			<xsl:apply-templates select="dataset/contributor" />
			
			<xsl:apply-templates select="dataset/contributorNoFacet" />
    			
    			<xsl:if test="dataset/entity">
    				<field name="entity"><xsl:value-of select="dataset/entity"/></field>
    				</xsl:if>
    			
    			<xsl:if test="dataset/reviewer">
    				<field name="reviewer"><xsl:value-of select="dataset/reviewer"/></field>
    				</xsl:if>
    			
    			<xsl:if test="dataset/series">
				<field name="series"><xsl:value-of select="dataset/series" /></field>
				</xsl:if>
				
			<xsl:if test="dataset/seriesNr">
				<field name="seriesNr"><xsl:value-of select="dataset/seriesNr" /></field>
				</xsl:if>
    			
    			<xsl:apply-templates select="dataset/provenance" />
    			
    			<!--<xsl:if test="dataset/isbn">
				<field name="isbn">	<xsl:value-of select="dataset/isbn" /></field>
				</xsl:if>-->
			<xsl:apply-templates select="dataset/isbn" />
			
			<!--<xsl:if test="dataset/issn">
				<field name="issn">	<xsl:value-of select="dataset/issn" /></field>
				</xsl:if>-->
			<xsl:apply-templates select="dataset/issn" />
			
			<xsl:if test="dataset/zdbId">
				<field name="zdbId"><xsl:value-of select="dataset/zdbId" /></field>
				</xsl:if>
    			
    			<xsl:if test="dataset/displayPublishDate">
    				<field name="displayPublishDate"><xsl:value-of select="dataset/displayPublishDate"></xsl:value-of></field>
    				</xsl:if>
    			
    			<xsl:apply-templates select="dataset/publishDate[1]" />
    			<!--
    			<xsl:if test="dataset/publishDate">
                    			<field name="publishDate"><xsl:value-of select="dataset/publishDate"/></field>
                			</xsl:if>-->
                		
                		<xsl:if test="dataset/timeSpan">
                    			<field name="timeSpanStart"><xsl:value-of select="dataset/timeSpan/timeSpanStart"/></field>
                    			<field name="timeSpanEnd"><xsl:value-of select="dataset/timeSpan/timeSpanEnd"/></field>
                			</xsl:if>
    			
    			<xsl:if test="dataset/placeOfPublication">
                    			<xsl:for-each select="dataset/placeOfPublication">
                    				<field name="placeOfPublication"><xsl:value-of select="."/></field>
                    				</xsl:for-each>
                			</xsl:if>
			
			<xsl:apply-templates select="dataset/publisher" />
			
    			
    			<xsl:if test="dataset/physical">
				<field name="physical"><xsl:value-of select="dataset/physical" /></field>
				</xsl:if>
			
			
			<xsl:if test="dataset/dimension">
				<xsl:for-each select="dataset/dimension">
					<field name="dimension"><xsl:value-of select="." /></field>
					</xsl:for-each>
				</xsl:if>
			
			<xsl:if test="dataset/runTime">
				<field name="runTime"><xsl:value-of select="dataset/runTime" /></field>
				</xsl:if>
    			
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
			
			<xsl:if test="dataset/subjectTopic">
                			<xsl:for-each select="dataset/subjectTopic[text()!='']">
                    				<field name="topic"><xsl:value-of select="."/></field>
                    				</xsl:for-each>
                			</xsl:if>
                		
                		<xsl:variable name="topic" select="dataset/subjectTopic" />
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
                			</xsl:if>
                		
                		
                		<xsl:if test="dataset/subjectGeographic">
                			<xsl:for-each select="dataset/subjectGeographic[text()!='']">
                    				<field name="subjectGeographic"><xsl:value-of select="."/></field>
                    				</xsl:for-each>
                				</xsl:if>
                		
                		<xsl:if test="dataset/subjectPerson">
                			<xsl:for-each select="dataset/subjectPerson[text()!='']">
                    				<field name="subjectPerson"><xsl:value-of select="."/></field>
                    				</xsl:for-each>
                			</xsl:if>
                			
                		<xsl:apply-templates select="dataset/subjectName" />
                		
                		<xsl:if test="dataset/description">
                			<field name="description">
                				<xsl:value-of select="dataset/description" />
                				</field>
                			</xsl:if>
                		
                		<xsl:if test="dataset/shelfMark">
				<field name="signatur"><xsl:value-of select="dataset/shelfMark" /></field>
				</xsl:if>
			
			<xsl:if test="dataset/issue">
				<xsl:for-each select="dataset/issue">
					<field name="issue"><xsl:value-of select="." /></field>
					</xsl:for-each>
				</xsl:if>
			
			<xsl:if test="dataset/volume">
				<xsl:for-each select="dataset/volume">
					<field name="volume"><xsl:value-of select="." /></field>
					</xsl:for-each>
				</xsl:if>
				
			<!--<xsl:if test="dataset/description">
				<xsl:for-each select="dataset/description">
					<field name="description"><xsl:value-of select="." /></field>
					</xsl:for-each>
				</xsl:if>-->
			
			<xsl:if test="dataset/project">
				<xsl:for-each select="distinct-values(tokenize(dataset/project, ' '))">
					<xsl:if test=".!=''">
						<field name="project"><xsl:value-of select="." /></field>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			
			<xsl:if test="dataset/url">
				<field name="url">
					<xsl:value-of select="dataset/url" />
					</field>
				</xsl:if>
			
			<xsl:if test="dataset/relatedTo">
				<field name="relatedTo">
					<xsl:value-of select="dataset/relatedTo"/>
					</field>
				</xsl:if>
			
			<xsl:if test="dataset/sourceInfo">
				<xsl:for-each select="dataset/sourceInfo">
					<field name="sourceInfo">
						<xsl:value-of select="." />
						</field>
					</xsl:for-each>
				</xsl:if>
			
			<xsl:if test="dataset/listOfContents">
				<xsl:for-each select="dataset/listOfContents">
				<field name="listOfContents">
					<xsl:value-of select="." />
					</field>
					</xsl:for-each>
				</xsl:if>
				
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
	
	<xsl:template match="format">
		<field name="format"><xsl:value-of select="."/></field>
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
		<xsl:for-each select=".">
			<field name="contributor">
				<xsl:value-of select="." />
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
	

</xsl:stylesheet>
