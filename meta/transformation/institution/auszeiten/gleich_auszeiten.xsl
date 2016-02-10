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
	<xsl:template match="auszeiten">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
			</xsl:element>
		</xsl:template>
		
	<xsl:template match="ausZeiten">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
			</xsl:element>
		</xsl:template>
		
			

<!--FAUST_______________________________FAUST______________________________FAUST-->
<!--FAUST_______________________________FAUST______________________________FAUST-->
<!--FAUST_______________________________FAUST______________________________FAUST-->
<!--FAUST_______________________________FAUST______________________________FAUST-->
<!--FAUST_______________________________FAUST______________________________FAUST-->
<!--FAUST_______________________________FAUST______________________________FAUST-->



<xsl:template match="datensatz">
	
	<xsl:if test="Objektart[text()='Buch']">

	<xsl:element name="record">
	

<!--vufind_______________________________vufind_______________________________vufind-->
<!--institution_______________________________institution_______________________________institution-->	

		<xsl:apply-templates select="Objektnummer" />
	
<!--dataset_______________________________dataset_______________________________dataset-->

		<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Verfasser" />
				
	<!--editor-->
				<xsl:apply-templates select="Herausgeber" />

	<!--series-->
				<xsl:apply-templates select="Reihe-Serie" />

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Laufzeit-Datierung-Jahr"/>
	
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Ersch__Ort"/>
	
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag" />

<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Kollation" />

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjects-->
				<xsl:apply-templates select="Sachbegriffe-KS"/>
				<xsl:apply-templates select="Orte"/>
				<xsl:apply-templates select="Personen"/>
				
<!--OTHER-->
	
	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	

			</xsl:element>
		</xsl:element>
	</xsl:if>
	</xsl:template>
	
	
	
	
	
<!--citavi_______________________________citavi_______________________________citavi-->
<!--citavi_______________________________citavi_______________________________citavi-->
<!--citavi_______________________________citavi_______________________________citavi-->
<!--citavi_______________________________citavi_______________________________citavi-->
<!--citavi_______________________________citavi_______________________________citavi-->
<!--citavi_______________________________citavi_______________________________citavi-->


<xsl:template match="object">
	
	<xsl:element name="record">
		
<!--vufind_______________________________vufind_______________________________vufind-->
<!--institution_______________________________institution_______________________________institution-->		
		
		<xsl:apply-templates select="objektnummer" />
			
<!--dataset_______________________________dataset_______________________________dataset-->

		<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Buch</xsl:text></format>		-->
				<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
				
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="titel" />
				
			
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="autorin" />
				<xsl:apply-templates select="autorin2" />
				<xsl:apply-templates select="autorin3" />
				
	<!--series-->
				<xsl:apply-templates select="untertitel1" />
				
	

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="isbn_issn" />				

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="datum"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="publikationsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="herausgeberin" />
				
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="seitenzahl" />
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				
				
	<!--subjects-->
				<xsl:apply-templates select="schlagwort"/>	
	
	<!--description-->
				<xsl:apply-templates select="untertitel4"/>	
	
<!--OTHER-->

	<!--volume-->
				<xsl:apply-templates select="band"/>	
	
	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
						
				
				
			</xsl:element>
	</xsl:element>







	
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->

			
		</xsl:template>


<!--Templates-->
	
	<xsl:template match="Reihe-Serie">
		<xsl:choose>
			<xsl:when test="contains(.,';')">
				<series>
					<xsl:value-of select="normalize-space(substring-before(.,';'))" />
					</series>
				<volume>
					<xsl:value-of select="normalize-space(substring-after(.,';'))" />
					</volume>
				</xsl:when>
			<xsl:otherwise>
				<series>
					<xsl:value-of select="normalize-space(.)" />
					</series>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="untertitel1">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>
	
	<xsl:template match="untertitel4">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="band">
		<volume>
			<xsl:value-of select="normalize-space(.)" />
			</volume>
		</xsl:template>
	
	<xsl:template match="Orte">
		<xsl:for-each select="tokenize(.,';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectGeographic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Personen">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Sachbegriffe-KS">
		<xsl:for-each select="tokenize(.,';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="schlagwort">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="contains(.,',')">
					<xsl:choose>
						<xsl:when test="(contains(.,'20. Jahrhundert')) or
									(contains(.,'Neuzeit, frühe')) or
									(contains(.,'Arbeit, unbezahlt')) or
									(contains(.,'Arbeitsamt, Berufsberatung'))">
							<subjectTopic>
								<xsl:value-of select="normalize-space(.)" />
								</subjectTopic>
							</xsl:when>
						<xsl:otherwise>
							<subjectPerson>
								<xsl:value-of select="normalize-space(.)" />
								</subjectPerson>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				<xsl:otherwise>
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)" />
						</subjectTopic>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Kollation">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="seitenzahl">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Ersch__Ort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="publikationsort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Laufzeit-Datierung-Jahr">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)" />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(.)" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="datum">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)" />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(.)" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="isbn_issn">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="herausgeberin">
		<xsl:for-each select=".">
			<publisher>
				<xsl:value-of select="normalize-space(.)" />
				</publisher>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Herausgeber">
		<xsl:for-each select="tokenize(.,';')">
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="autorin3">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="autorin2">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="autorin">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Verfasser">
		<xsl:for-each select="tokenize(.,';')">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="." />
			<xsl:if test="../Untertitel">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of select="." />
			</title_short>
		<xsl:if test="../Untertitel">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
				</title_sub>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="titel">
		<title>
			<xsl:value-of select="." />
			</title>
		<title_short>
			<xsl:value-of select="." />
			</title_short>
		
			<xsl:if test="../untertitel3">
				<title_sub>
					<xsl:value-of select="../untertitel3" />
					</title_sub>
				</xsl:if>
		</xsl:template>
	
<xsl:template match="objektnummer">
		
	<xsl:element name="vufind">
		
		<!--Identifikator-->
				<id>
					<xsl:text>0000</xsl:text>
					<xsl:value-of select="."/>
					<xsl:text>auszeiten</xsl:text>
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

	<xsl:element name="institution">
	
		<!--institutionShortname-->
				<institutionShortname>
					<xsl:text>ausZeiten</xsl:text>
					</institutionShortname>
		<!--institutionFullname-->
				<institutionFull>
					<xsl:text>ausZeiten, Bildung, Information, Forschung und Kommunikation für Frauen e.V.</xsl:text>
					</institutionFull>
	
				<institutionID>
					<xsl:text>auszeiten</xsl:text>
					</institutionID>
	
		<!--collection-->
				<collection>
					<xsl:text>auszeiten</xsl:text>
					</collection>
		<!--isil-->
				<isil>
					<xsl:text>Bm 55</xsl:text>
					</isil>
		<!--linkToWebpage-->
				<link>
					<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/auszeiten/</xsl:text>
					</link>
		<!--geoLocation-->
				<geoLocation>
					<latitude>51.5028450</latitude>
					<longitude>7.2127350</longitude>
					</geoLocation>
			</xsl:element>
		</xsl:template>

<xsl:template match="Objektnummer">
		
	<xsl:element name="vufind">
		
		<!--Identifikator-->
				<id>
					<xsl:value-of select="."/>
					<xsl:text>auszeiten</xsl:text>
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

	<xsl:element name="institution">
	
		<!--institutionShortname-->
				<institutionShortname>
					<xsl:text>ausZeiten</xsl:text>
					</institutionShortname>
		<!--institutionFullname-->
				<institutionFull>
					<xsl:text>ausZeiten, Bildung, Information, Forschung und Kommunikation für Frauen e.V.</xsl:text>
					</institutionFull>
	
				<institutionID>
					<xsl:text>auszeiten</xsl:text>
					</institutionID>
	
		<!--collection-->
				<collection>
					<xsl:text>auszeiten</xsl:text>
					</collection>
		<!--isil-->
				<isil>
					<xsl:text>Bm 55</xsl:text>
					</isil>
		<!--linkToWebpage-->
				<link>
					<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/auszeiten/</xsl:text>
					</link>
		<!--geoLocation-->
				<geoLocation>
					<latitude>51.5028450</latitude>
					<longitude>7.2127350</longitude>
					</geoLocation>
			</xsl:element>
		</xsl:template>


</xsl:stylesheet>
