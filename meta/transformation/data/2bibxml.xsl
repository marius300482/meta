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
		
			<field name="allfields"><xsl:value-of select="normalize-space(string(.))"/></field><!-- ALLFIELDS alle Inhalte werden in ein Feld geschrieben -->
		
<!--vufind-->
		
			<field name="id"><xsl:value-of select="vufind/id" /></field>
		
			<field name="recordtype"><xsl:value-of select="vufind/recordType" /></field>
			
			<field name="recordCreationDate"><xsl:value-of select="vufind/recordCreationDate" /></field>

			<field name="recordChangeDate"><xsl:value-of select="vufind/recordChangeDate" /></field>
			
			<field name="leader">
				<!--<xsl:text>     </xsl:text>--><!--0-4-->
				<xsl:text>03008</xsl:text><!--0-4-->
					<xsl:text>n</xsl:text><!--5-->
					<xsl:choose><!--6-->
						<xsl:when test="dataset/format[text()='Video/DVD']">
							<xsl:text>g</xsl:text></xsl:when>
						<xsl:otherwise>
							<xsl:text>a</xsl:text></xsl:otherwise>
						</xsl:choose>
					<xsl:choose><!--7-->
						<xsl:when test="dataset/format[text()='Zeitschrift']"><xsl:text>s</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>m</xsl:text></xsl:otherwise>
						</xsl:choose>
					<xsl:text> </xsl:text><!--8-->
					<xsl:text> </xsl:text><!--9-->
					<xsl:text>2</xsl:text><!--10-->
					<xsl:text>2</xsl:text><!--11-->
					<!--<xsl:text>     </xsl:text>--><!--12-16-->
					<xsl:text>00181</xsl:text><!--12-16-->
					<xsl:text>u</xsl:text><!--17-->
					<xsl:text>u</xsl:text><!--18-->
					<xsl:text> </xsl:text><!--19-->
					<xsl:text>4500</xsl:text><!--20-23-->
			</field>
			
			<field name="controlfield">
					<!--00-05-->
					<xsl:value-of select="substring(vufind/recordCreationDate, 3,2)"/>
					<xsl:value-of select="substring(vufind/recordCreationDate, 6,2)"/>
					<xsl:value-of select="substring(vufind/recordCreationDate, 9,2)"/>
					<!--06-->
					<xsl:text>|</xsl:text>
					<!--07-10-->
					<xsl:choose>
						<xsl:when test="dataset/publishDate">
							<xsl:value-of select="dataset/publishDate"/>
							</xsl:when>
						<xsl:when test="dataset/timeSpan">
							<xsl:value-of select="dataset/timeSpan/timeSpanStart"/>
							</xsl:when>
						<xsl:otherwise>    </xsl:otherwise>
						</xsl:choose>
					<!--11-14-->
					<xsl:choose>
						<xsl:when test="dataset/timeSpan">
							<xsl:value-of select="dataset/timeSpan/timeSpanEnd"/>
							</xsl:when>
						<xsl:otherwise>
							<xsl:text>    </xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					<!--15-17-->
					<xsl:text> </xsl:text>
					<!--18-20-->
					<xsl:text>|||</xsl:text>
					<!--21-->
					<xsl:text>|</xsl:text>
					<!--22-->
					<xsl:text>|</xsl:text>
					<!--23-->
					<xsl:text>|</xsl:text>
					<!--24-27-->
					<xsl:text>||||</xsl:text>
					<!--28-->
					<xsl:text>|</xsl:text>
					<!--29-->
					<xsl:choose>
						<xsl:when test="(dataset/format[text()='Online-Artikel']) or (dataset/format[text()='Online-Zeitschrift '])">
							<xsl:text>m</xsl:text>
							</xsl:when>
						<xsl:otherwise>
							<xsl:text> </xsl:text>
							</xsl:otherwise>
					</xsl:choose>
					<!--30-31-->
					<xsl:text>||</xsl:text>
					<!--32-->
					<xsl:text>|</xsl:text>
					<!--33-->
					<xsl:text>|</xsl:text>
					<!--34-->
					<xsl:text>|</xsl:text>
					<!--35-37-->
					<xsl:variable name="lang1" select="dataset/language[1]"></xsl:variable>
					<xsl:choose>
						<xsl:when test="dataset/language!='o.A.'">
							<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$lang1]/@code"/>
							</xsl:when>
						<xsl:otherwise>
							<xsl:text>   </xsl:text>
							</xsl:otherwise>
					</xsl:choose>
					<!--38-39-->
					<xsl:text>||</xsl:text>
				</field>
		
<!--institution-->
		
			<field name="institution"><xsl:value-of select="institution/institutionShortname" /></field>
			
			<field name="collection"><xsl:value-of select="institution/collection" /></field>
			
			<field name="recordContentSource"><xsl:value-of select="institution/isil" /></field>
		
<!--dataset-->
		
			<xsl:if test="typeOfRessource">
				<field name="typeOfRessource"><xsl:value-of select="dataset/typeOfRessource" /></field>
    				</xsl:if>
    			
    			<field name="format"><xsl:value-of select="dataset/format"/></field>
    			
    			<xsl:if test="dataset/documentType">
    				<field name="documentType"></field>
    				</xsl:if>
    			
			<field name="title"><xsl:value-of select="dataset/title[normalize-space()]"/></field>
                   	 	
            		<xsl:if test="dataset/title_sub">
				<field name="title_sub"><xsl:value-of select="dataset/title_sub[normalize-space()]"/></field>
				</xsl:if>
			
			<xsl:if test="dataset/title_short">
				<field name="title_short"><xsl:value-of select="dataset/title_short[normalize-space()]"/></field>
				</xsl:if>
    			
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
    			
    			<xsl:if test="dataset/isbn">
				<field name="isbn">	<xsl:value-of select="dataset/isbn" /></field>
				</xsl:if>
			
			<xsl:if test="dataset/issn">
				<field name="issn">	<xsl:value-of select="dataset/issn" /></field>
				</xsl:if>
			
			<xsl:if test="dataset/zdbId">
				<field name="zdbId"><xsl:value-of select="dataset/zdbId" /></field>
				</xsl:if>
    			
    			<xsl:if test="dataset/displayPublishDate">
    				<field name="displayPublishDate"><xsl:value-of select="dataset/displayPublishDate"></xsl:value-of></field>
    				</xsl:if>
    			
    			<xsl:if test="dataset/publishDate">
                    			<field name="publishDate"><xsl:value-of select="dataset/publishDate"/></field>
                			</xsl:if>
                		
                		<xsl:if test="dataset/timeSpan">
                    			<field name="timeSpanStart"><xsl:value-of select="dataset/timeSpan/timeSpanStart"/></field>
                    			<field name="timeSpanEnd"><xsl:value-of select="dataset/timeSpan/timeSpanEnd"/></field>
                			</xsl:if>
    			
    			<xsl:if test="dataset/placeOfPublication">
                    			<xsl:for-each select="dataset/placeOfPublication">
                    				<field name="placeOfPublication"><xsl:value-of select="."/></field>
                    				</xsl:for-each>
                			</xsl:if>
			
			<xsl:if test="dataset/publisher[normalize-space()]">
				<field name="publisher"><xsl:value-of select="dataset/publisher"/></field>
                			</xsl:if>
    			
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
    			
			<xsl:for-each select="dataset/language">
				<xsl:variable name="test" select="." />
					<field name="language">
						<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$test]/@name"/>
						</field>
					<field name="language_code">
						<xsl:value-of select="document('../anreicherung/language.xml')/root/language[@use=$test]/@code"/>
						</field>
				</xsl:for-each>
			
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
				
			<xsl:if test="dataset/description">
				<xsl:for-each select="dataset/description">
					<field name="description"><xsl:value-of select="." /></field>
					</xsl:for-each>
				</xsl:if>
			
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
			
	<!--Anreicherung Artikel-->
			<xsl:if test="dataset/format='Artikel'">
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
							<xsl:text>o.A.</xsl:text>
							</field>
						</xsl:otherwise>	
						</xsl:choose>
				</xsl:if>
	
	
	
		
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
 	<optimize/>
	
</add>
</xsl:template>


	

</xsl:stylesheet>
