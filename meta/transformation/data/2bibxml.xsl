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
	
	<!--Metaumwandlungsdatei für Bibliotheksdaten. In diesem Format kann die Darstellung
	in VuFind besser angepasst werden. Verlinkungen zwischen Datensätzen können einfacher hergestellt werden.-->
	
	
	
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
		
<!--institution-->
		
			<field name="institution"><xsl:value-of select="institution/institutionShortname" /></field>
			
			<field name="collection"><xsl:value-of select="institution/collection" /></field>
			
			<field name="recordContentSource"><xsl:value-of select="institution/isil" /></field>
		
<!--dataset-->
		
			<xsl:if test="typeOfRessource">
				<field name="typeOfRessource"><xsl:value-of select="dataset/typeOfRessource" /></field>
    			</xsl:if>
    			
    			<field name="format"><xsl:value-of select="dataset/format"/></field>
    			
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
    			
    			<xsl:if test="series">
				<field name="series"><xsl:value-of select="series" /></field>
			</xsl:if>
    			
    			<xsl:if test="dataset/isbn">
				<field name="isbn">	<xsl:value-of select="dataset/isbn" /></field>
			</xsl:if>
    			
    			<xsl:if test="dataset/displayPublishDate">
    				<field name="displayPublishDate"><xsl:value-of select="dataset/displayPublishDate"></xsl:value-of></field>
    			</xsl:if>
    			
    			<xsl:if test="dataset/publishDate">
                    			<field name="publishDate"><xsl:value-of select="dataset/publishDate"/></field>
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
                		
                		<xsl:if test="dataset/subjectGeographic">
                			<xsl:for-each select="dataset/subjectGeographic[text()!='']">
                    				<field name="subjectGeographic"><xsl:value-of select="."/></field>
                    			</xsl:for-each>
                		</xsl:if>
                		
                		<xsl:if test="dataset/shelfMark">
				<field name="signatur"><xsl:value-of select="dataset/shelfMark" /></field>
			</xsl:if>
	
			<xsl:if test="dataset/seriesNr">
				<field name="seriesNr"><xsl:value-of select="dataset/seriesNr" /></field>
			</xsl:if>
			
			<xsl:if test="dataset/project">
				<xsl:for-each select="distinct-values(tokenize(dataset/project, ';'))">
					<xsl:if test=".!=''">
						<field name="project"><xsl:value-of select="." /></field>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
	
	<!--Person-->
		<xsl:if test="dataset/person">
			<xsl:for-each select="dataset/person">
				<field name="person">
					<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:if>
                	
                	
           <!-- PUBLISHDATE -->
                	<xsl:if test="laufzeit">
                    		<field name="laufzeit">
                        		<xsl:value-of select="laufzeit"/>
                    		</field>
                	</xsl:if>
                	
           <!-- PUBLISHDATE CA -->
                	<xsl:if test="circa-jahr">
                    		<field name="circa-jahr">
                        		<xsl:value-of select="circa-jahr"/>
                    		</field>
                	</xsl:if>
                	
	<!--Enthält-->
		<xsl:if test="enthaelt">
			<field name="description">
				<xsl:value-of select="enthaelt" />
			</field>
		</xsl:if>

	<!--Enthält-->
		<xsl:if test="url">
			<field name="url">
				<xsl:value-of select="url" />
			</field>
		</xsl:if>
	
	<!-- Artikel -->
               	<!--<xsl:if test="artikel">
			<xsl:for-each select="artikel">
			<xsl:variable name="rel" select="."></xsl:variable>
                    			<field name="contents">
                    				<xsl:value-of select="//datensatz[@id=$rel]/id"></xsl:value-of>
                    				<xsl:text>||</xsl:text>
                        			<xsl:value-of select="//datensatz[@id=$rel]/titel"/>
                        			<xsl:if test="//datensatz[@id=$rel]/jahr">
                        				<xsl:text> (</xsl:text>
                        				<xsl:value-of select="//datensatz[@id=$rel]/jahr" />
                        				<xsl:text>)</xsl:text>
                        			</xsl:if>
                        			<xsl:if test="//datensatz[@id=$rel]/heft">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="//datensatz[@id=$rel]/heft" />                        			
                        			</xsl:if>
                        			<xsl:if test="//datensatz[@id=$rel]/seitenangabe">
                        				<xsl:text>, </xsl:text>
                        				<xsl:value-of select="//datensatz[@id=$rel]/seitenangabe"></xsl:value-of>
                        			</xsl:if>
                    			</field>
                    		</xsl:for-each>
                	</xsl:if>   -->
                	
          <!-- Artikel -->
               	<!--<xsl:if test="ausgabe">
			<xsl:for-each select="ausgabe">
			<xsl:variable name="rel" select="." />
                    			<field name="contents">
                    				<xsl:value-of select="//datensatz[@id=$rel]/id"></xsl:value-of>
                    				<xsl:text>||</xsl:text>
                        			<xsl:value-of select="//datensatz[@id=$rel]/titel"/>
                        			<xsl:if test="//datensatz[@id=$rel]/jahr">
                        				<xsl:text> (</xsl:text>
                        				<xsl:value-of select="//datensatz[@id=$rel]/jahr" />
                        				<xsl:text>)</xsl:text>
                        			</xsl:if>
                        			<xsl:if test="//datensatz[@id=$rel]/heft">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="//datensatz[@id=$rel]/heft" />                        			
                        			</xsl:if>
                    			</field>
                    		</xsl:for-each>
                	</xsl:if>   -->
	
	<!--Ausgangsobjekt ermitteln-->
		<!--<xsl:if test="relatedItem">
		<xsl:variable name="rel" select="relatedItem"></xsl:variable>
			<field name="toHost">
                    				<xsl:value-of select="//datensatz[@id=$rel]/id"></xsl:value-of>
                    				<xsl:text>||</xsl:text>
                        			<xsl:value-of select="//datensatz[@id=$rel]/titel"/>
                        			<xsl:if test="//datensatz[@id=$rel]/jahr">
                        				<xsl:text> (</xsl:text>
                        				<xsl:value-of select="//datensatz[@id=$rel]/jahr" />
                        				<xsl:text>)</xsl:text>
                        			</xsl:if>
                        			<xsl:if test="//datensatz[@id=$rel]/heft">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="//datensatz[@id=$rel]/heft" />                        			
                        			</xsl:if>
                    			</field>
		</xsl:if>-->
	
		<!--Ausgangsobjekt einfügen-->
		<!--<xsl:if test="relatedItem">
			<xsl:variable name="rel" select="relatedItem"></xsl:variable>
			<field name="hostItem">
                    				<xsl:value-of select="//datensatz[@id=$rel]/titel"/>
                    				<xsl:if test="//datensatz[@id=$rel]/hrsg">
                    					<xsl:text> | Hrsg. </xsl:text>
                    					<xsl:for-each select="//datensatz[@id=$rel]/hrsg">
                    						<xsl:value-of select="."/><xsl:text>; </xsl:text>
                    					</xsl:for-each>
                    				</xsl:if>
                    				<xsl:if test="(//datensatz[@id=$rel]/isbn) or (//datensatz[@id=$rel]/issn)">
                    				<xsl:text> | </xsl:text>
                    				<xsl:value-of select="//datensatz[@id=$rel]/isbn"/>
                    				<xsl:value-of select="//datensatz[@id=$rel]/issn"/>
                    				</xsl:if>
                    				<xsl:text> | </xsl:text>
                    				<xsl:value-of select="//datensatz[@id=$rel]/id"></xsl:value-of>
			</field>
		</xsl:if>	-->
		
	<!--ISBN / ISSN-->
		
		
	<!--ISSN-->	
		<xsl:if test="dataset/issn">
			<field name="issn">
				<xsl:value-of select="dataset/issn" />
			</field>
		</xsl:if>
		
	<!--ZDBID-->	
		<xsl:if test="zdbid">
			<xsl:for-each select="zdbid">
				<field name="zdbid">
					<xsl:value-of select="." />
				</field>
			</xsl:for-each>
			</xsl:if>
		
	<!--Ausgabe-->
		<xsl:if test="heft">
			<field name="edition">
				<xsl:value-of select="heft" />
			</field>
		</xsl:if>
	
	
		
		
<!--functions-->

		<xsl:if test="functions/hierarchyFields/hierarchy_top_id">
			<field name="hierarchy_top_id"><xsl:value-of select="functions/hierarchyFields/hierarchy_top_id" /></field>
		</xsl:if>			
		<xsl:if test="functions/hierarchyFields/hierarchy_top_title">
			<field name="hierarchy_top_title"><xsl:value-of select="functions/hierarchyFields/hierarchy_top_title"/></field>
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
