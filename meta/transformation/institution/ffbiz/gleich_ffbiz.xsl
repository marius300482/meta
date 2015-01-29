<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
	
<!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	
<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>	


<!--Der Hauptknoten-->	
	<xsl:template match="FFBIZ">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


<xsl:template match="Objekt">	
		<xsl:variable name="id" select="id" />
		
		<xsl:if test="objektart[text()='Bibliothek']">
		
		<xsl:element name="record">
			<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
		
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->



<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="$id" />
					<xsl:text>ffbiz</xsl:text>
					</id>

	<!--recordCreationDate-->
				<recordCreationDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordCreationDate>
					
	<!--recordChangeDate-->
				<recordChangeDate>
					<xsl:value-of select="current-dateTime()"/>
					</recordChangeDate>
	
	<!--recordType-->
				<recordType>
					<xsl:text>library</xsl:text>
					</recordType>
				
</xsl:element>












<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


<xsl:element name="institution">
	
<!--institutionShortname-->			<institutionShortname>
							<xsl:text>FFBIZ-Archiv</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.</xsl:text>
							</institutionFull>
			
<!--collection-->				<collection><xsl:text>FFBIZ</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-B1535</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/ffbiz/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.5209210</latitude>
							<longitude>13.4557330</longitude>
							</geoLocation>
			
</xsl:element>





<!--type of ressource_______________________________________________type of ressource-->
<!--type of ressource_______________________________________________type of ressource-->
<!--type of ressource_______________________________________________type of ressource-->
			<!--<typeOfRessource>
				<xsl:choose>
					<xsl:when test="objektart[text()='Bibliothek']">
						<xsl:text>text</xsl:text>
					</xsl:when>
					<xsl:when test="objektart[text()='Akten, Graue Materialien, ZD']">
						<xsl:text>text</xsl:text>
					</xsl:when>
				</xsl:choose>
			</typeOfRessource>-->


<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->

<xsl:if test="objektart[text()='Bibliothek']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
			<format><xsl:text>Buch</xsl:text></format>

	<!--documentType-->
			<documentType><xsl:text>Buch</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="Hauptsachtitel" />			

	<!--alternativeTitle-->
			<xsl:apply-templates select="Titel_x132x_nderungen" />

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="Verf_x046x_" />

	<!--editor Herausgeberinneninformationen-->
			<xsl:apply-templates select="Hrsg_x046x_" />

	<!--edition Auflage-->
			<xsl:apply-templates select="Auflage" />

<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Datum" />

	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Verlagsort" />	

	<!--publisher Verlagsangabe-->
			<xsl:apply-templates select="Verlag" />

<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
			<xsl:apply-templates select="Umfang" />

<!--CONTENTRELATED INFORMATION-->
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagwort_x032x_Bibliothek" />

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />



</xsl:element>
		
</xsl:if>


			
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->

		</xsl:element>
		</xsl:if>
	</xsl:template>
	
<!--Templates-->
		
	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Schlagwort_x032x_Bibliothek">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Sprache">
		<xsl:for-each select=".">
			<language>
				<xsl:value-of select="." />
				</language>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="." />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Verlagsort">
		<xsl:choose>
			<xsl:when test=".">
				<placeOfPublication>
					<xsl:value-of select="." />
					</placeOfPublication>
				</xsl:when>
			<xsl:otherwise>
				<placeOfPublication>
					<xsl:text>o.A.</xsl:text>
					</placeOfPublication>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Datum">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="Hrsg_x046x_">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="."/>
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Verf_x046x_">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="."/>
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Titel_x132x_nderungen">
		<alternativeTitle>
			<xsl:value-of  select="." />
				</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="Hauptsachtitel">
		<title>
			<xsl:value-of select="." />
			<xsl:if test="../Untertitel!=''">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of select="." />
			</title_short>
		<xsl:if test="../Untertitel!=''">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
				</title_sub>
			</xsl:if>
		</xsl:template>
	
</xsl:stylesheet>
