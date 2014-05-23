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
	
	<!--Metaumwandlungsdatei für Bibliotheksdaten. In diesem Format kann die Darstellung
	in VuFind besser angepasst werden. Verlinkungen zwischen Datensätzen können einfacher hergestellt werden.-->
	
	<xsl:template match="catalog">
	
	<add>
	
		<xsl:for-each select="record">
		
		<doc>
		
	
	
		<field name="id"><xsl:value-of select="vufind/id" /></field>
		
		<field name="recordtype"><xsl:value-of select="vufind/recordType" /></field>
		
		<field name="institution"><xsl:value-of select="institution/institutionShortname" /></field>
			
		<field name="collection"><xsl:value-of select="institution/collection" /></field>
		
		<field name="recordContentSource"><xsl:value-of select="institution/isil" /></field>
		
		<field name="recordCreationDate"><xsl:value-of select="vufind/recordCreationDate" /></field>

		<field name="recordChangeDate"><xsl:value-of select="vufind/recordChangeDate" /></field>
		
		<field name="typeOfRessource"><xsl:value-of select="dataset/typeOfRessource" /></field>
		
	<!-- ALLFIELDS alle Inhalte werden in ein Feld geschrieben -->
                	<field name="allfields">
                    		<xsl:value-of select="normalize-space(string(.))"/>
                	</field>
                	
           <!--LANGUAGE-->	
           
                	<xsl:if test="dataset/language">
                    		<xsl:for-each select="dataset/language">
                            		<field name="language">
                            			<xsl:value-of select="."/>
                            		</field>
                    		</xsl:for-each>
                	</xsl:if>
                	
	<!-- LANGUAGE CODE -->                     
               	<xsl:if test="language_code">
                    		<xsl:for-each select="language_code">
                            		<field name="language_code">
                            			<xsl:value-of select="."/>
                            		</field>
                    		</xsl:for-each>
                	</xsl:if>
	
	<!-- LANGUAGE -->                     
               	<xsl:if test="language_code">
                    		<xsl:for-each select="language_code">
                            		<field name="language">
                            			<xsl:choose>
						<xsl:when test="(text()='Deutsch') or (text()='deutsch') or (text()='ger')">Deutsch</xsl:when>
						<xsl:when test="(text()='Englisch') or (text()='englisch') or (text()='eng')">Englisch</xsl:when>
						<xsl:when test="(text()='Französisch') or (text()='französisch') or (text()='fra')">Französisch</xsl:when>
						<xsl:when test="(text()='Italienisch') or (text()='italienisch') or (text()='ita')">Italienisch</xsl:when>
						<xsl:when test="(text()='Spanisch') or (text()='spanisch') or (text()='spa')">Spanisch</xsl:when>					
						<xsl:when test="(text()='Serbisch') or (text()='serbisch') or (text()='srp')">Serbisch</xsl:when>
						<xsl:when test="(text()='Tschechisch') or (text()='tschechisch') or (text()='cze')">Tschechisch</xsl:when>
						<xsl:when test="(text()='Griechisch') or (text()='griechisch') or (text()='gre')">Griechisch</xsl:when>
						<xsl:when test="(text()='Französisch') or (text()='französisch') or (text()='fre')">Französisch</xsl:when>
						<xsl:when test="(text()='Slowenisch') or (text()='slowenisch') or (text()='slv')">Slowenisch</xsl:when>
						<xsl:when test="(text()='Slowakisch') or (text()='slowakisch') or (text()='slo')">Slowakisch</xsl:when>
						<xsl:when test="(text()='Polnisch') or (text()='polnisch') or (text()='pol')">Polnisch</xsl:when>
						<xsl:when test="(text()='Ungarisch') or (text()='ungarisch') or (text()='hun')">Ungarisch</xsl:when>
						<xsl:when test="(text()='Russisch') or (text()='russisch') or (text()='rus')">Russisch</xsl:when>
						<xsl:when test="(text()='Türkisch') or (text()='türkisch') or (text()='tur')">Türkisch</xsl:when>
						<xsl:when test="(text()='Norwegisch') or (text()='norwegisch') or (text()='nno')">Norwegisch</xsl:when>
						<xsl:when test="(text()='Koreanisch') or (text()='koreanisch') or (text()='kor')">Koreanisch</xsl:when>
						<xsl:when test="(text()='Luxemburgisch') or (text()='luxemburgisch') or (text()='ltz')">Luxemburgisch</xsl:when>
						<xsl:when test="(text()='Kroatisch') or (text()='kroatisch') or (text()='hrv')">Kroatisch</xsl:when>
						<xsl:when test="(text()='Latein') or (text()='latein') or (text()='lat')">Latein</xsl:when>
						<xsl:when test="(text()='Dänisch') or (text()='dänisch') or (text()='dan')">Dänisch</xsl:when>
						<xsl:when test="text()='fin'">Finnisch</xsl:when>
						<xsl:when test="text()='nld'">Niederländisch</xsl:when>
						<xsl:when test="text()='eus'">Baskisch</xsl:when>
						<xsl:when test="text()='swe'">Schwedisch</xsl:when>
						<xsl:when test="text()='jpn'">Japanisch</xsl:when>
						<xsl:when test="text()='cat'">Katalanisch</xsl:when>
						<xsl:when test="text()='por'">Portugiesisch</xsl:when>
						<xsl:when test="text()='mhd'">Mittelhochdeutsch</xsl:when>
						<xsl:when test="text()='o.A.'">o.A.</xsl:when>
					</xsl:choose>
                            		</field>
                    		</xsl:for-each>
                	</xsl:if>
	
	<!-- FORMAT -->
		<xsl:if test="format">              
			<field name="format">
				<xsl:value-of select="format"/>
			</field>
		</xsl:if>	

	<!-- AUTHOR --> 
		<!--<xsl:if test="author">
			<xsl:for-each select="author">
				<field name="author"><xsl:value-of select="." /></field>
			</xsl:for-each>
		</xsl:if>-->
		
		<xsl:if test="dataset/author[1]">
			<field name="author"><xsl:value-of select="dataset/author[1]" /></field>
		</xsl:if>
		<xsl:if test="dataset/author[2]">
			<field name="author_additional"><xsl:value-of select="dataset/author[2]" /></field>
		</xsl:if>
		<xsl:if test="dataset/author[3]">
			<field name="author_additional"><xsl:value-of select="dataset/author[3]" /></field>
		</xsl:if>
		<xsl:if test="dataset/author[4]">
			<field name="author_additional"><xsl:value-of select="dataset/author[4]" /></field>
		</xsl:if>

	<!-- Editors -->
		<xsl:if test="dataset/editor[normalize-space()]">
                    		<xsl:for-each select="dataset/editor">
	                    		<field name="editor">
           	             		<xsl:value-of select="."/>
                    			</field>
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
	
	<!-- TITLE -->
		<xsl:if test="dataset/title[normalize-space()]">
			<field name="title">
                        		<xsl:value-of select="dataset/title[normalize-space()]"/>
                    		</field>
                    	</xsl:if>
                    	<xsl:if test="dataset/title_sub">
			<field name="title_sub">
                        		<xsl:value-of select="dataset/title_sub[normalize-space()]"/>
                    		</field>
                    	</xsl:if>
                    	<xsl:if test="dataset/title_short">
		      	<field name="title_short">
                        		<xsl:value-of select="dataset/title_short[normalize-space()]"/>
                    		</field>
		</xsl:if>
	
	<!-- PUBLISHER -->
		<xsl:if test="dataset/publisher[normalize-space()]">
                    		<field name="publisher">
                        		<xsl:value-of select="dataset/publisher"/>
                    		</field>
                	</xsl:if>
                	
	<!-- PUBLISHDATE -->
                	<xsl:if test="dataset/publishDate">
                    		<field name="publishDate">
                        		<xsl:value-of select="dataset/publishDate"/>
                    		</field>
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
	
	<!-- PlaceOfPublication -->
		<xsl:if test="dataset/placeOfPublication[normalize-space()]">
                    		<field name="placeOfPublication">
                        		<xsl:value-of select="dataset/placeOfPublication"/>
                    		</field>
                	</xsl:if>

	<!-- Topic -->
                	<xsl:if test="dataset/topic">
                		<xsl:for-each select="dataset/topic">
                    			<field name="topic">
					<xsl:value-of select="."/>
                    			</field>
                    		</xsl:for-each>
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
		<xsl:if test="dataset/isbn">
			<field name="isbn">
				<xsl:value-of select="dataset/isbn" />
			</field>
		</xsl:if>
		
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
		
	<!--Seitenangabe-->
		<xsl:if test="dataset/physical">
			<field name="physical">
				<xsl:value-of select="dataset/physical" />
			</field>
		</xsl:if>
		
		
	<!--Ausgabe-->
		<xsl:if test="heft">
			<field name="edition">
				<xsl:value-of select="heft" />
			</field>
		</xsl:if>
	
	<!--Ausgabe-->
		<xsl:if test="reihe">
			<field name="series">
				<xsl:value-of select="reihe" />
			</field>
		</xsl:if>
	
	<!--Format-->
	<xsl:if test="physical">
			<field name="physical">
				<xsl:value-of select="physical" />
			</field>
		</xsl:if>
	
	<!--Signatur-->
		<xsl:if test="dataset/shelfMark">
			<field name="signatur">
				<xsl:value-of select="dataset/shelfMark" />
			</field>
		</xsl:if>
		
	<!--Hierarchie-->
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

	</doc>
	
	
	
	</xsl:for-each>
	<commit/>
 	<optimize/>
	
</add>
</xsl:template>


	

</xsl:stylesheet>
