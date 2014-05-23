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
	
	<xsl:template match="katalog">
	
	<add>
	
		<xsl:for-each select="datensatz">
		
		<doc>
		
	
	
		<field name="id"><xsl:value-of select="id" /></field>
		
		<field name="recordtype"><xsl:value-of select="recordType" /></field>
		
		<field name="institution"><xsl:value-of select="institution" /></field>
			
		<field name="collection"><xsl:value-of select="collection" /></field>
		
		<field name="recordContentSource"><xsl:value-of select="recordContentSource" /></field>
		
		<field name="recordCreationDate"><xsl:value-of select="recordCreationDate" /></field>

		<field name="recordChangeDate"><xsl:value-of select="recordChangeDate" /></field>
		
		<field name="typeOfRessource"><xsl:value-of select="typeOfRessource" /></field>
		
	<!-- ALLFIELDS alle Inhalte werden in ein Feld geschrieben -->
                	<field name="allfields">
                    		<xsl:value-of select="normalize-space(string(.))"/>
                	</field>
                	
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
		<xsl:if test="objektart">              
			<field name="format">
				<xsl:value-of select="objektart"/>
			</field>
		</xsl:if>	

	<!-- AUTHOR --> 
		<!--<xsl:if test="autorin">
			<xsl:for-each select="autorin">
				<field name="author"><xsl:value-of select="." /></field>
			</xsl:for-each>
		</xsl:if>-->
		
		<xsl:if test="autorin[1]">
			<field name="author"><xsl:value-of select="autorin[1]" /></field>
		</xsl:if>
		<xsl:if test="autorin[2]">
			<field name="author_additional"><xsl:value-of select="autorin[2]" /></field>
		</xsl:if>
		<xsl:if test="autorin[3]">
			<field name="author_additional"><xsl:value-of select="autorin[3]" /></field>
		</xsl:if>
		<xsl:if test="autorin[4]">
			<field name="author_additional"><xsl:value-of select="autorin[4]" /></field>
		</xsl:if>

	<!-- Editors -->
		<xsl:if test="hrsg[normalize-space()]">
                    		<xsl:for-each select="hrsg">
	                    		<field name="editor">
           	             		<xsl:value-of select="."/>
                    			</field>
                    		</xsl:for-each>
                	</xsl:if>
	
	<!--Person-->
		<xsl:if test="person">
			<xsl:for-each select="person">
				<field name="person">
					<xsl:value-of select="." />
				</field>
			</xsl:for-each>
		</xsl:if>
	
	<!-- TITLE -->
		<xsl:if test="titel[normalize-space()]">
			<field name="title">
                        		<xsl:value-of select="titel[normalize-space()]"/>
                    		</field>
                    	</xsl:if>
                    	<xsl:if test="titel_sub">
			<field name="title_sub">
                        		<xsl:value-of select="titel_sub[normalize-space()]"/>
                    		</field>
                    	</xsl:if>
                    	<xsl:if test="titel_short">
		      	<field name="title_short">
                        		<xsl:value-of select="titel_short[normalize-space()]"/>
                    		</field>
		</xsl:if>
	
	<!-- PUBLISHER -->
		<xsl:if test="verlag[normalize-space()]">
                    		<field name="publisher">
                        		<xsl:value-of select="verlag"/>
                    		</field>
                	</xsl:if>
                	
	<!-- PUBLISHDATE -->
                	<xsl:if test="jahr">
                    		<field name="publishDate">
                        		<xsl:value-of select="jahr"/>
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
		<xsl:if test="ort[normalize-space()]">
                    		<field name="placeOfPublication">
                        		<xsl:value-of select="ort"/>
                    		</field>
                	</xsl:if>

	<!-- Topic -->
                	<xsl:if test="topic">
                		<xsl:for-each select="topic">
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
		<xsl:if test="isbn">
			<field name="isbn">
				<xsl:value-of select="isbn" />
			</field>
		</xsl:if>
		
	<!--ISSN-->	
		<xsl:if test="issn">
			<field name="issn">
				<xsl:value-of select="issn" />
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
		<xsl:if test="seitenangabe">
			<field name="physical">
				<xsl:value-of select="seitenangabe" />
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
		<xsl:if test="signatur">
			<field name="signatur">
				<xsl:value-of select="signatur" />
			</field>
		</xsl:if>
		
	<!--Hierarchie-->
		<xsl:if test="hierarchy_top_id">
			<field name="hierarchy_top_id"><xsl:value-of select="hierarchy_top_id" /></field>
		</xsl:if>			
		<xsl:if test="hierarchy_top_title">
			<field name="hierarchy_top_title"><xsl:value-of select="hierarchy_top_title"/></field>
		</xsl:if>
		 <xsl:if test="hierarchy_parent_id">
		 	 <field name="hierarchy_parent_id"><xsl:value-of select="hierarchy_parent_id"/></field>
		 </xsl:if>
		<xsl:if test="hierarchy_parent_title">
			<field name="hierarchy_parent_title"><xsl:value-of select="hierarchy_parent_title"/></field>
		</xsl:if>
		<xsl:if test="is_hierarchy_id">
			 <field name="is_hierarchy_id"><xsl:value-of select="is_hierarchy_id"/></field>
		</xsl:if>
		<xsl:if test="is_hierarchy_title">
			<field name="is_hierarchy_title"><xsl:value-of select="is_hierarchy_title"/></field>
		</xsl:if>

	</doc>
	
	
	
	</xsl:for-each>
	<commit/>
 	<optimize/>
	
</add>
</xsl:template>


	

</xsl:stylesheet>
