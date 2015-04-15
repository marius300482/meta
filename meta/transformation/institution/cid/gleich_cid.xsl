<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	xmlns:marc="http://www.loc.gov/MARC21/slim" 
	exclude-result-prefixes="xs xdt err fn marc">

	<xsl:output method="xml" indent="yes"/>


<xsl:template match="marc:record">	

		<xsl:variable name="id" select="substring-before(marc:controlfield[@tag='001'],':')" />
		<xsl:element name="add">
			<!--<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	-->
		
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		
			
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="doc">
		
	<!--allfields-->
				<field name="allfields">
					<xsl:value-of select="marc:datafield[@tag='100']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<xsl:value-of select="marc:datafield[@tag='509']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<xsl:value-of select="marc:datafield[@tag='245']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<xsl:value-of select="marc:datafield[@tag='245']/marc:subfield[@code='b']" /><xsl:text> </xsl:text>
					<xsl:value-of select="marc:datafield[@tag='700']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<xsl:value-of select="marc:datafield[@tag='500']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<!--<xsl:value-of select="marc:datafield[@tag='260']/marc:subfield[@code='c']" /><xsl:text> </xsl:text>-->
					<xsl:value-of select="marc:datafield[@tag='490']/marc:subfield[@code='a']" /><xsl:text> </xsl:text>
					<xsl:value-of select="substring(marc:controlfield[@tag='008'],8,4)" /><xsl:text> </xsl:text>
					<xsl:for-each select="marc:datafield[@tag='650']">
						<xsl:for-each select="marc:subfield[@code='a']">
							<xsl:value-of select="." />
							<xsl:text> </xsl:text>
							</xsl:for-each>
						</xsl:for-each>
					<xsl:for-each select="marc:datafield[@tag='690']">
						<xsl:for-each select="marc:subfield[@code='a']">
							<xsl:value-of select="." />
							<xsl:text> </xsl:text>
							</xsl:for-each>
						</xsl:for-each>
					</field>
		
	<!--Identifikator-->
				<field name="id">
					<xsl:value-of select="$id"></xsl:value-of>
					<xsl:text>cid</xsl:text>
					</field>

	<!--recordType-->
				<field name="recordtype"><xsl:text>library</xsl:text></field>

	<!--recordCreationDate-->
	
				<field name="recordCreationDate"><xsl:text>2015-03-11T08:41:18.508Z</xsl:text></field>
      				<field name="recordChangeDate"><xsl:text>2015-03-11T08:41:18.508Z</xsl:text></field>
				<!--<field name="recordCreationDate">
					<xsl:value-of select="current-dateTime()"/>
					</field>-->
					
	<!--recordChangeDate-->
				<!--<field name="recordChangeDate">
					<xsl:value-of select="current-dateTime()"/>
					</field>-->
	
	<!--institutionShortname-->			
				<field name="institution">
					<xsl:text>Cid Fraen an Gender</xsl:text>
					</field>
	
	<!--institutionFullname-->			
				<field name="institutionFull">
					<xsl:text>Frauen- und Genderbibliothek Cid</xsl:text>
					</field>
			
	<!--collection-->				
				<field name="collection"><xsl:text>Cid Fraen an Gender</xsl:text></field>
	
	<!--isil-->
				<field name="recordContentSource"><xsl:text>ZDB-LU-100</xsl:text></field>
	
	<!--linkToWebpage-->	
				<!--<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/luxemburg/cid-fraen-an-gender/</xsl:text></link>-->
	
	<!--geoLocation-->				
				<!--<geoLocation>
					<latitude>0</latitude>
					<longitude>0</longitude>
					</geoLocation>-->
	
				 <field name="typeOfRessource">
				 	<xsl:choose>
				 		
				 		<xsl:when test="marc:controlfield[@tag='FMT']='BK'">
				 			<xsl:text>text</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='CF'">
				 			<xsl:text>software, multimedia</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MU'">
				 			<xsl:text>audio</xsl:text>
				 			</xsl:when>
			 			<xsl:when test="marc:controlfield[@tag='FMT']='SE'">
				 			<xsl:text>text</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='VM'">
				 			<xsl:text>mixed material</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MX'">
				 			<xsl:text>mixed material</xsl:text>
				 			</xsl:when>
				 		<!--<xsl:otherwise>
				 			<xsl:value-of select="marc:datafield[@tag='949']/marc:subfield[@code='3']" />
				 			</xsl:otherwise>-->
				 		</xsl:choose>
				 	</field>
				 
				 <field name="format">
				 	<xsl:choose>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='BK'">
				 			<xsl:text>Buch</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='CF'">
				 			<xsl:text>Elektronische Medien</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MU'">
				 			<xsl:text>Tonträger</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='SE'">
				 			<xsl:text>Zeitschrift</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='VM'">
				 			<xsl:text>Visuelles Material</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MX'">
				 			<xsl:text>Gemischtes Material</xsl:text>
				 			</xsl:when>
				 		<!--<xsl:otherwise>
				 			<xsl:value-of select="marc:datafield[@tag='949']/marc:subfield[@code='3']" />
				 			</xsl:otherwise>-->
				 		</xsl:choose>
				 	</field>
	
				<xsl:apply-templates select="marc:controlfield[@tag='008']" />
	
<!--TITLE-->	
	
	<!--title Titelinformationen-->		
				<xsl:apply-templates select="marc:datafield[@tag='245']" />
				<xsl:apply-templates select="marc:datafield[@tag='509']" />
	
<!--RESPONSIBLE-->	

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="marc:datafield[@tag='100']" />
				<xsl:apply-templates select="marc:datafield[@tag='700']" />
				<xsl:apply-templates select="marc:datafield[@tag='511']" />
				
	<!--entity Körperschaft-->
				<xsl:apply-templates select="marc:datafield[@tag='710']" />
				
	<!--series-->
				<xsl:apply-templates select="marc:datafield[@tag='490']" />
		
	<!--edition Ausgabe-->
				<xsl:apply-templates select="marc:datafield[@tag='250']" />
		
<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
				<xsl:apply-templates select="marc:datafield[@tag='020']" />

<!--PUBLISHING-->			

	<!--display / publishDate Jahresangabe-->
	<!--placeOfPublication Ortsangabe-->	
	<!--publisher Verlag-->
				<xsl:apply-templates select="marc:datafield[@tag='260']" />
	<!--sourceInfo Quelle-->
				<xsl:apply-templates select="marc:datafield[@tag='773']" />
				
<!--PHYSICAL INFORMATION-->	
	
	<!--physical Seitenangabe-->		
				<xsl:apply-templates select="marc:datafield[@tag='300']" />
			
				
<!--CONTENTRELATED INFORMATION-->	
				<xsl:apply-templates select="marc:datafield[@tag='650']" />
				<xsl:apply-templates select="marc:datafield[@tag='690']" />
				<xsl:apply-templates select="marc:datafield[@tag='600']" />
				
	<!--description Beschreibung-->
				<xsl:apply-templates select="marc:datafield[@tag='500'][1]" />
				
<!--OTHER-->
				
	<!--shelfMark Signatur-->	
				<xsl:apply-templates select="marc:datafield[@tag='691'][1]" />
				
				
</xsl:element>	

<!--<commit/>
   <optimize/>-->

	</xsl:element>
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!--Templates-->
	
	<xsl:template match="marc:controlfield[@tag='008']">
		<field name="displayPublishDate">
			<xsl:value-of select="substring(.,8,4)" />
			</field>
		<field name="publishDateSort">
			<xsl:value-of select="substring(.,8,4)" />
			</field>
		<!--<field name="language_code">
			<xsl:value-of select="substring(.,36,3)"></xsl:value-of>
			</field>-->
		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='773']">
		<field name="sourceInfo"><xsl:value-of select="marc:subfield[@code='t']" /></field>
		<!--<xsl:if test="(not(../marc:datafield[@tag='260'])) and (marc:subfield[@code='1'])">
			<field name="displayPublishDate">
				<xsl:value-of select="marc:subfield[@code='1']"></xsl:value-of>
				</field>
			<field name="publishDateSort">
				<xsl:value-of select="translate(marc:subfield[@code='1'], translate(.,'0123456789', ''), '')" />
				</field>
			</xsl:if>	-->
		<xsl:if test="not(../marc:datafield[@tag='300'])">
			<field name="physical">
				<xsl:value-of select="normalize-space(substring-after(marc:subfield[@code='g'],'p.'))"></xsl:value-of>
				</field>
			</xsl:if>	
		<xsl:if test="marc:subfield[@code='4']">
			<field name="issue">
				<xsl:value-of select="marc:subfield[@code='4']" />
				</field>
			</xsl:if>			
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='250']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="edition"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='500']">
		<field name="description">
			<xsl:for-each select="../marc:datafield[@tag='500']/marc:subfield">		
				<xsl:value-of select="." /><xsl:text> </xsl:text>
				</xsl:for-each>
			</field>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='710']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="entity"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='691']">
		<field name="shelfMark"><xsl:for-each select="../marc:datafield[@tag='691']/marc:subfield[@code='8']">
			<xsl:value-of select="." /><xsl:text> / </xsl:text>
			</xsl:for-each>		</field>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='490']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="series"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='600']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="subjectPerson"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='690']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="topic"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='650']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<field name="topic"><xsl:value-of select="." /></field>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='300']">
		<xsl:if test="../marc:controlfield[@tag='FMT']='BK'">
			<field name="physical">
				<xsl:value-of select="normalize-space(substring-before(marc:subfield[@code='a'],'p.'))" />
					</field>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='MU'">
			<field name="physical">
				<xsl:value-of select="normalize-space(marc:subfield[@code='a'])" />
					<xsl:if test="marc:subfield[@code='e']">
						<xsl:text> + </xsl:text>
						<xsl:value-of select="marc:subfield[@code='e']" />
						</xsl:if>
				</field>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='CF'">
			<field name="physical">
				<xsl:value-of select="normalize-space(marc:subfield[@code='a'])" />
				</field>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='MX'">
			<field name="physical">
				<xsl:for-each select="marc:subfield">
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text>
					</xsl:for-each>
				</field>
			</xsl:if>
		<xsl:if test="marc:subfield[@code='c']">
			<field name="dimension">
				<xsl:value-of select="marc:subfield[@code='c']" />
				</field>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='260']">
		<!--<field name="displayPublishDate">
			<xsl:value-of select="marc:subfield[@code='c']" />
			</field>
		<field name="publishDateSort">
			<xsl:value-of select="translate(marc:subfield[@code='c'], translate(.,'0123456789', ''), '')" />
			</field>-->
		<field name="placeOfPublication">
			<xsl:value-of select="marc:subfield[@code='a']" />
			</field>
		<field name="publisher">
			<xsl:value-of select="marc:subfield[@code='b']" />
			</field>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='020']">
		<field name="isbn">
			<xsl:value-of select="normalize-space(.)" />
			</field>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='511']">
		<field name="contributor">
			<xsl:value-of select="marc:subfield[@code='a']" />
			</field>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='100']">
		<field name="author">
			<xsl:value-of select="marc:subfield[@code='a']" />
			<xsl:if test="marc:subfield[@code='b']">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="marc:subfield[@code='b']" />
					</xsl:if>
					</field>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='700']">
		<field name="contributor">
			<xsl:value-of select="marc:subfield[@code='a']" />
			<xsl:if test="marc:subfield[@code='b']">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="marc:subfield[@code='b']" />
					</xsl:if>
					</field>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='245']">
		<field name="title">
					<!--<xsl:value-of select="replace(replace(marc:subfield[@code='a'],'&gt;&gt;',''),'&lt;&lt;','')" /> XSLT 2.0-->
					<xsl:value-of select="translate(marc:subfield[@code='a'],'&gt;&gt;&lt;&lt;','')" />
					<xsl:if test="marc:subfield[@code='h']">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="marc:subfield[@code='h']" />
						<xsl:text>]</xsl:text>
						</xsl:if>
					<!--<xsl:value-of select="marc:subfield[@code='a']" />-->
					<xsl:if test="marc:subfield[@code='b']">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="marc:subfield[@code='b']" />
						</xsl:if>
					<xsl:if test="marc:subfield[@code='i']">
						<xsl:text> ; </xsl:text>
						<xsl:value-of select="translate(marc:subfield[@code='i'],'&gt;&gt;&lt;&lt;','')" />
						</xsl:if>
					</field>
				<xsl:if test="marc:subfield[@code='b']">
					<field name="title_sub">
						<!--<xsl:value-of select="marc:subfield[@code='b']" />-->
						<xsl:value-of select="translate(marc:subfield[@code='b'],'&gt;&gt;&lt;&lt;','')" />
						</field>
					</xsl:if>
				<field name="title_short">
					<xsl:value-of select="translate(marc:subfield[@code='a'],'&gt;&gt;&lt;&lt;','')" />
					<xsl:if test="marc:subfield[@code='h']">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="marc:subfield[@code='h']" />
						<xsl:text>]</xsl:text>
						</xsl:if>
					<!--<xsl:value-of select="marc:subfield[@code='a']" />--></field>

		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='509']">
		<field name="alternativeTitle">
			<xsl:value-of select="marc:subfield[@code='t']" />
			</field>
		</xsl:template>		
		
</xsl:stylesheet>
