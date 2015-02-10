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
		
		<!--<xsl:if test="objektart[text()='Bibliothek']">-->
		<!--<xsl:if test="objektart[text()='Akten, Graue Materialien, ZD']">-->
		
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
				<xsl:choose>
					<xsl:when test="objektart[text()='Bibliothek']">
						<recordType>
							<xsl:text>library</xsl:text>
							</recordType>
						</xsl:when>
					<xsl:when test="objektart[text()='Akten, Graue Materialien, ZD']">
						<recordType>
							<xsl:text>archive</xsl:text>
							</recordType>
						</xsl:when>
					</xsl:choose>
				
				
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
			<xsl:apply-templates select="Einheitssachtitel" />
	

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="Verf_x046x_" />

	<!--editor Herausgeberinneninformationen-->
			<xsl:apply-templates select="Hrsg_x046x_" />

	<!--entity Körperschaft-->
			<xsl:apply-templates select="bet_x046x_KS" />
			<xsl:apply-templates select="Urheber" />

	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihe" />
			
	<!--edition Auflage-->
			<xsl:apply-templates select="Auflage" />
			
	<!--volume-->
			<xsl:apply-templates select="Band" />
			
	<!--Herkunft-->
			<xsl:apply-templates select="Provenienz" />

<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />

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
			
	<!--description-->
			<xsl:apply-templates select="Bemerkung" />

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />



</xsl:element>
		
</xsl:if>







<!--Akten, Graue Materialien, ZD__________Akten, Graue Materialien, ZD-->

<xsl:if test="objektart[text()='Akten, Graue Materialien, ZD']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
			<format><xsl:text>Akte</xsl:text></format>

	<!--documentType-->
			<documentType><xsl:value-of select="Bestand" /></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->

	<!--entity Körperschaft / Organisation-->
			<xsl:apply-templates select="Organisation" />
	
	<!--provenance Privinienz-->
			<xsl:apply-templates select="Provenienz" />
	
<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />
		
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	

	<!--blockingPeriod Sperrfrist-->
			<xsl:apply-templates select="Sperrfrist" />	

<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
			<xsl:apply-templates select="Umfang" />

<!--CONTENTRELATED INFORMATION-->
		
	<!--subject Deskriptoren-->
			<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
			<xsl:apply-templates select="Kontinent" />
			<xsl:apply-templates select="Land_x047x_Region" />
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />	
				
	<!--description-->
			<xsl:apply-templates select="Enth_x132x_lt" />

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

	</xsl:element>
	</xsl:if>


			
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->

		</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>
	
<!--Templates-->
	
	<xsl:template match="Sperrfrist">
		<blockingPeriod>
			<xsl:value-of select="." />
			</blockingPeriod>
		</xsl:template>
	
	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Land_x047x_Region">
		<subjectGeographic>
			<xsl:value-of select="." />
			</subjectGeographic>
		</xsl:template>
	
	<xsl:template match="Kontinent">
		<subjectGeographic>
			<xsl:value-of select="." />
			</subjectGeographic>
		</xsl:template>
	
	<xsl:template match="Enth_x132x_lt">
		<description>
			<xsl:value-of select="." />
			</description>
		</xsl:template>
	
	<xsl:template match="Organisation">
		<entity>
			<xsl:value-of select="." />
			</entity>
		</xsl:template>
	
	<xsl:template match="Provenienz">
		<provenance>
			<xsl:value-of select="." />
			</provenance>
		</xsl:template>
	
	<xsl:template match="Bemerkung">
		<description>
			<xsl:value-of select="." />
			</description>
		</xsl:template>
	
	<xsl:template match="Band">
		<volume>
			<xsl:value-of select="." />
			</volume>
		</xsl:template>
	
	<xsl:template match="Urheber">
		<contributor>
			<xsl:value-of select="." />
			</contributor>
		</xsl:template>
	
	<xsl:template match="bet_x046x_KS">
		<entity>
			<xsl:value-of select="." />
			</entity>
		</xsl:template>
	
	<xsl:template match="Reihe">
		<series>
			<xsl:value-of select="." />
			</series>
		</xsl:template>
	
	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="." />
			<xsl:if test="../Signatur-Nummerierung">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Signatur-Nummerierung" />
				</xsl:if>
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Schlagworte_x032x_Archiv">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
				</subjectTopic>
			</xsl:for-each>
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
		<xsl:choose>
			<xsl:when test="../objektart[text()='Bibliothek']">
				<physical>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
					</physical>
				</xsl:when>
			<xsl:when test="../objektart[text()='Akten, Graue Materialien, ZD']">
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:when>
			</xsl:choose>
		
		
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
	
	<xsl:template match="Jahr_x047x_Datierung">
		<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="normalize-space(substring-before(.,'-'))" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="normalize-space(substring-after(.,'-'))" /></timeSpanEnd>
					</timeSpan>
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="." />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>		
		<!--<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</publishDate>-->
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
	
	<xsl:template match="Einheitssachtitel">
		<alternativeTitle>
			<xsl:value-of  select="." />
				</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="Titel_x132x_nderungen">
		<alternativeTitle>
			<xsl:value-of  select="." />
				</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="." />
			</title>
		<title_short>
			<xsl:value-of select="." />
			</title_short>
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
