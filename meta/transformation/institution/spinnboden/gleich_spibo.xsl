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
	<!--<xsl:template match="*[not(node())]"/>-->
	
<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>	


<!--root-Knoten-->	
	<!--<xsl:template match="Feministische-Litera_x044x__x032x_Monographien">-->
	<!--<xsl:template match="Feministische-Litera_x044x__x032x_Zeitschriften">-->
	<!--<xsl:template match="Feministische-Litera_x044x__x032x_Monographien">-->
	<xsl:template match="Spinnboden">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
			</xsl:element>
		</xsl:template>


	<xsl:template match="Objekt">	
	
<xsl:if test="objektart[text()='B - Buchtitel']">

		<xsl:variable name="id" select="id" />
		<xsl:element name="record">
			<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
			
		
		
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		<!--
	0. Erklärung _ für einige Operationen wandle ich Angaben in Variablen um. FAUST kann das Datum nur
		auf eine Weise ausgeben [30.04.1982], so dass dieses nachträglich für MARC angepasst
		werden muss [820430] -->
	
		<!--Variable für die Ausgabe des Datums-->
			<xsl:variable name="date" select="erfaßt_x032x_am_x058x_[1]"/>
		<!--Variable für die Ausgabe des Änderungsdatums-->
			<xsl:variable name="change" select="geändert_x032x_am_x058x_[1]"/>
		<!--Variable für das Tagesdatum-->
			<xsl:variable name="day" select="Tagesdatum"/>
		<!--Variable für die Verlinkung von Datensätzen-->
			<xsl:variable name="s_sachtitel" select="translate(s_x046x__x032x_ST[1], translate(.,'0123456789', ''), '')"/>
			









<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="$id" />
					<xsl:text>spinnboden</xsl:text>
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
							<xsl:text>Spinnboden</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Spinnboden - Lesbenarchiv und Bibliothek</xsl:text>
							</institutionFull>
			
<!--collection-->				<collection><xsl:text>Spinnboden</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-B1544</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/spinnboden/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.5353200</latitude>
							<longitude>13.3991900</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	










<!--B - Buchtitel__________________________B - Buchtitel___________________________B - Buchtitel-->

<xsl:if test="objektart[text()='B - Buchtitel']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>
					
<!--title Titelinformationen-->
				<xsl:if test="Buchtitel[1]">
					<xsl:apply-templates select="Buchtitel[1]"/>
					</xsl:if>	

				<xsl:if test="Originaltitel!=''">
					<xsl:for-each select="Originaltitel">
						<alternativeTitle>
							<xsl:value-of select="." />
							</alternativeTitle>
						</xsl:for-each>
					</xsl:if>
					
<!--author Autorinneninformation-->
				<xsl:if test="Autorin !=''">
					<xsl:for-each select="Autorin">
						<autorin>
							<xsl:value-of select="." />
							</autorin>
						</xsl:for-each>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="HerausgeberIn !=''">
					<xsl:for-each select="HerausgeberIn">
						<hrsg>
							<xsl:value-of select="." />
							</hrsg>
						</xsl:for-each>
					</xsl:if>

<!--contributor Beteiligte Personen-->
				<xsl:if test="_x154x_bersetzerIn!=''">
					<xsl:for-each select="_x154x_bersetzerIn">
						<contibutor>
							<xsl:value-of select="."></xsl:value-of>
							</contibutor>
						</xsl:for-each>
					</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Reihentitel!=''">
					<reihe>
						<xsl:value-of select="Reihentitel"/>
					</reihe>
				</xsl:if>
			
<!--format Objektartinformationen-->
					<xsl:choose>
						<xsl:when test="not(s_x046x__x032x_Einzeltitel_x032x_-B)">
							<format>
								<xsl:text>Monographie</xsl:text>
							</format>
						</xsl:when>
						<xsl:otherwise>
							<format>
								<xsl:text>Sammelband</xsl:text>
							</format>
						</xsl:otherwise>
					</xsl:choose>
					
<!--display / publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="Jahr[1]=''">
							<jahr>
								<xsl:text>o.A.</xsl:text>
							</jahr>
						</xsl:when>
						<xsl:otherwise>
							<jahr>
								<xsl:value-of select="Jahr[1]"/>
							</jahr>
						</xsl:otherwise>
					</xsl:choose>
					
<!--placeOfPublication Ortsangabe-->	
					<xsl:choose>
						<xsl:when test="Ort=''">
							<ort>
								<xsl:text>o.A.</xsl:text>
							</ort>
						</xsl:when>
						<xsl:otherwise>
							<ort>
								<xsl:value-of select="Ort[1]"/>
							</ort>
						</xsl:otherwise>
					</xsl:choose>
					
<!--publisher Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="not(Verlag)">
							<verlag>
								<xsl:text>o.A.</xsl:text>
							</verlag>
						</xsl:when>
						<xsl:otherwise>
							<verlag>
								<xsl:value-of select="Verlag[1]"/>
							</verlag>
						</xsl:otherwise>
					</xsl:choose>
					
<!--physical Seitenangabe-->
					<xsl:if test="Umfang !=''">
						<seitenangabe>
							<xsl:value-of select="normalize-space(substring-before(Umfang[1], 'S'))"/>
						</seitenangabe>
					</xsl:if>

<!--dimensions Weitere Angaben zum Inhalt-->		
				<xsl:if test="Ausstattung[1]!=''">
					<dimension>
						<xsl:value-of select="Ausstattung[1]" />
						</dimension>
					</xsl:if>		
			
<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache!=''">
						<language>
							<xsl:value-of select="Sprache" />
							</language>
						</xsl:when>
					<xsl:otherwise>
						<language>
							<xsl:text>o.A.</xsl:text>
							</language>
						</xsl:otherwise>	
					</xsl:choose>					
				
<!--subjectTopic Deskriptoren-->				
				<xsl:if test="Deskriptoren!=''">
					<xsl:for-each select="Deskriptoren">
						<subjectTopic>
							<xsl:value-of select="." />
							</subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Kategorie!=''">
					<subjectTopic>
						<xsl:value-of select="Kategorie" />
						</subjectTopic>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen!=''">
					<xsl:for-each select="Personen">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>
						</xsl:for-each>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts!=''">
					<xsl:for-each select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts">
						<subjectGeographic>
							<xsl:value-of select="." />
							</subjectGeographic>
						</xsl:for-each>
					</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Signatur!=''">
					<shelfMark>
						<xsl:value-of select="Signatur"></xsl:value-of>
						</shelfMark>
					</xsl:if>
			
<!--description Beschreibung-->
				<xsl:if test="Annotation[1]!=''">
					<description>
						<xsl:value-of select="Annotation[1]" />
						</description>
					</xsl:if>
</xsl:element>	

<xsl:if test="s_x046x__x032x_Einzeltitel_x032x_-B">
	<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="$id" /><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Buchtitel[1]" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="$id" /><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Buchtitel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
		</xsl:element>	
	</xsl:if>
</xsl:if>


</xsl:element> <!--ClosingTag Datensatzelement-->

</xsl:if>

</xsl:template>



<!--Templates-->	

			<xsl:template match="Buchtitel[1]">
				<xsl:choose>
					
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					
					<xsl:when test="contains(.,'.')">
					<xsl:variable name="subtitle" select="normalize-space(substring-after(., '.'))" />
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="substring-before(.,'.')" />
							</title_short>
						<xsl:if test="$subtitle!=''">
						<title_sub>
							<xsl:choose>
								<xsl:when test="contains($subtitle,'.')">
									<xsl:value-of select="normalize-space(substring-before($subtitle, '.'))"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$subtitle" />
									</xsl:otherwise>
								</xsl:choose>
							</title_sub>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="."/>
								</title>
							<title_short>
								<xsl:value-of select="."/>
								</title_short>
							</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>



</xsl:stylesheet>
