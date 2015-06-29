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
	
	<xsl:template match="@*[.='']"/><!-- Leere Knoten werden entfernt-->
	
	<xsl:strip-space elements="*"/><!--Whitespace entfernen-->

	<xsl:template match="lette">
		<xsl:element name="catalog">
			<xsl:for-each select="object">

			
		<xsl:if test="mab331_hauptsachtitel">
					
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>	
	
	
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id" />
					<xsl:text>lette</xsl:text>
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
					<xsl:text>archive</xsl:text>
					</recordType>	
				
	</xsl:element>


<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


<xsl:element name="institution">
	
<!--institutionShortname-->			<institutionShortname>
							<xsl:text>Archiv des Lette-Vereins</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Archiv des Lette-Vereins</xsl:text>
							</institutionFull>
						
						<institutionID>
							<xsl:text>lette</xsl:text>
							</institutionID>
						
<!--collection-->				<collection><xsl:text>LetteVerein</xsl:text></collection>
	
<!--isil-->					<!--<isil><xsl:text>ISIL DE-Sa24</xsl:text></isil>-->
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/archiv-des-lette-vereins/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.4961700</latitude>
							<longitude>13.3412500</longitude>
							</geoLocation>
			
	</xsl:element>


	
	
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
	
			
			
			
		<!--<xsl:if test="typ2[text()='Archiv / Buchbestand']">-->
			
			<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<xsl:choose>
						<!--<xsl:when test="Dokumentart[text()=' Sammelwerk, Zeitschrift']">-->
						<xsl:when test="(contains(mab501_fussnote[1],'Hochschulschrift')) or (contains(mab501_fussnote[2],'Hochschulschrift'))">
							<format><xsl:text>Hochschulschrift</xsl:text></format>
							</xsl:when>
						<xsl:when test="contains(typ2,'Buchbestand')">
							<format><xsl:text>Buch</xsl:text></format>
							</xsl:when>
						<xsl:when test="contains(typ2,'Zeitschriften')">
							<format><xsl:text>Zeitschrift</xsl:text></format>
							</xsl:when>
						<xsl:otherwise>
							<format><xsl:text>Buch</xsl:text></format>
							</xsl:otherwise>
						</xsl:choose>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="mab331_hauptsachtitel[string-length() != 0]" />

<!--RESPONSIBLE-->
					
			<!--author-->
					<xsl:apply-templates select="mab359_verfasser[string-length() != 0]" />
			
			<!--entity-->
					<xsl:apply-templates select="mab200_koerperschaft[string-length() != 0]" />

<!--IDENTIFIER-->

			<!--isbn issn-->
					<xsl:apply-templates select="mab540a_isbn[string-length() != 0]" />
			
		
<!--PUBLISHING-->

			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="mab425_erscheinungsjahr[string-length() != 0]" />
			
			<!--sourceInfo-->
					<xsl:apply-templates select="mab45_gesamttitel_ansetzungsform[string-length() != 0]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="mab410_verlagsort[string-length() != 0]" />	
				
			<!--publisher-->
					<xsl:apply-templates select="mab412_verleger[string-length() != 0]" />

			<!--edition-->
					<xsl:apply-templates select="mab403_ausgabe[1][string-length() != 0]" />
					
<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="mab433_umfang[string-length() != 0]" />
					
			
<!--CONTENTRELATED INFORMATION-->
			
				
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="mab710_schlagwort[string-length() != 0]" />
					<xsl:apply-templates select="mab902_schlagwortkette[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="mab100_person[string-length() != 0]" />
			
			<!--description-->
					

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->
				
	<!--volume Band-->
				

<!--OTHER-->

			<!--shelfMark Signatur-->
					
			
						
				
						</xsl:element><!--closing tag dataset-->
					
					
					</xsl:element>
					</xsl:if>
				</xsl:for-each><!--closing tag for-each Schleife datansatz-->
			
		</xsl:element>
	
	</xsl:template>










<!--Templates-->	
			
			<xsl:template match="mab540a_isbn">
				<isbn>
					<xsl:value-of select="normalize-space(.)" />
					</isbn>
				</xsl:template>
			
			<xsl:template match="mab100_person">
				<subjectPerson>
					<xsl:value-of select="normalize-space(.)" />
					</subjectPerson>
				</xsl:template>
			
			<xsl:template match="mab902_schlagwortkette">
				<subjectTopic>
					<xsl:value-of select="normalize-space(substring(.,4,500))" />
					</subjectTopic>
				</xsl:template>
			
			<xsl:template match="mab45_gesamttitel_ansetzungsform">
				<sourceInfo>
					<xsl:value-of select="normalize-space(.)" />
					</sourceInfo>
				</xsl:template>
			
			<xsl:template match="mab403_ausgabe">
				<edition>
					<xsl:value-of select="normalize-space(.)" />
					</edition>
				</xsl:template>
			
			<xsl:template match="mab710_schlagwort">
				<subjectTopic>
					<xsl:value-of select="normalize-space(.)" />
					</subjectTopic>
				</xsl:template>
			
			<xsl:template match="mab433_umfang">
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:template>
			
			<xsl:template match="mab425_erscheinungsjahr">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(.)" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="substring(normalize-space(translate(., translate(.,'0123456789', ''), '')),1,4)" />
					</publishDate>	
				</xsl:template>
			
			<xsl:template match="mab412_verleger">
				<publisher>
					<xsl:value-of select="normalize-space(.)" />
					</publisher>
				</xsl:template>
			
			<xsl:template match="mab410_verlagsort">
				<placeOfPublication>
					<xsl:value-of select="normalize-space(.)" />
					</placeOfPublication>
				</xsl:template>
			
			<xsl:template match="mab200_koerperschaft">
				<entity>
					<xsl:value-of select="normalize-space(.)" />
					</entity>
				</xsl:template>
			
			<xsl:template match="mab359_verfasser">
				<xsl:for-each select="tokenize(.,';')">
					<author>
						<xsl:value-of select="normalize-space(.)" />
						</author>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="mab331_hauptsachtitel">
				<title>
					<xsl:value-of select="normalize-space(.)" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
					</title_short>
				<xsl:if test="../mab335_zusatz_hauptsachtitel[string-length() != 0]">
					<title_sub>
						<xsl:value-of select="normalize-space(.)" />
						</title_sub>
					</xsl:if>
				</xsl:template>
			
			
			
			
			
			
			
			
			
			
			
			
			
			


</xsl:stylesheet>
