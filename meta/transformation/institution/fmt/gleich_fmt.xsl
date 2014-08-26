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


<!--root knoten-->
	<xsl:template match="FMT">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
			</xsl:element>
		</xsl:template>

<!--Der Objektknoten-->

<xsl:template match="Datensatz" name="tokenize">	
		<xsl:variable name="id" select="Objektnummer_x058x_" />
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
					<xsl:value-of select="Objektnummer_x058x_" />
					<xsl:text>fmt</xsl:text>
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
							<xsl:text>FMT</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionsFullname>
							<xsl:text>FrauenMediaTurm, Das Archiv und Dokumentationszentrum</xsl:text>
							</institutionsFullname>
			
<!--collection-->				<collection><xsl:text>FMT</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-Kn184</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/frauenmediaturm/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>50.93252</latitude>
							<longitude>6.96420</longitude>
							</geoLocation>
			
</xsl:element>

<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	










<!--Buch__________________________Monographie___________________________Sammelband-->


<!--<xsl:if test="Objektart_x058x_[text()='Monographie']">-->

<!--Die Umwandlung für die Objektart "Buch" beinhaltet Monographien sowie Sammelbände. Sobald ein 
"Buch" die Referenz auf Einzeltitel über das Feld "s_Aufsatz" aufweist ist es ein Sammelband andernfalls
eine Monographie. Monographien und Sammelbäünde können ausgeliehen werden. Die Anzeige des Ausleihstatus wird über
den Datenbestand angezeigt-->

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Titel_x058x_[1]">
					<xsl:apply-templates select="Titel_x058x_[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="AutorInnen_x058x_[1]">
					<xsl:for-each select="AutorInnen_x058x_">
						<author><xsl:value-of select="." /></author>
						</xsl:for-each>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg_x046x__x047x_Mitarbeit_x058x_[1]">
					<xsl:for-each select="Hrsg_x046x__x047x_Mitarbeit_x058x_">
						<hrsg><xsl:value-of select="." /></hrsg>
						</xsl:for-each>
					</xsl:if>

<!--entity Körperschaftsangaben-->
				<xsl:if test="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
					<xsl:for-each select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
						<entity><xsl:value-of select="." /></entity>
						</xsl:for-each>
					</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Zeitschr_x046x__x047x_Reihentitel_x058x_">
					<series>
						<xsl:value-of select="Zeitschr_x046x__x047x_Reihentitel_x058x_"/>
						 </series>
						</xsl:if>

<!--format Objektartinformationen-->
				<xsl:choose>
					<xsl:when test="Aufs_x132x_tze_x032x__x040x_Link_x041x__x058x_">
						<format>
							<xsl:text>Sammelband</xsl:text>
							</format>
						</xsl:when>
					<xsl:otherwise>
						<format>
							<xsl:text>Monographie</xsl:text>
							</format>
						</xsl:otherwise>
				</xsl:choose>

<!--ISBN / ISSN-->
				<xsl:if test="ISBN_x058x_">
					<isbn>
						<xsl:value-of select="ISBN_x058x_"/>
						</isbn>
					</xsl:if>

<!--display / publishDate Jahresangabe-->
				<xsl:if test="Jahr_x058x_">
					<displayPublishDate>
						<xsl:value-of select="Jahr_x058x_" />
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="Jahr_x058x_" />
						</publishDate>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort_x058x_">
					<placeOfPublication>
						<xsl:value-of select="Ort_x058x_" />
						</placeOfPublication>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag_x058x_">
					<publisher>
						<xsl:value-of select="Verlag_x058x_" />
						</publisher>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seiten_x058x_">
					<physical>
						<xsl:value-of select="Seiten_x058x_" />
						</physical>
					</xsl:if>

<!--language Sprachangaben-->

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x__">
					<xsl:for-each select="Nebenschlagworte_x058x__">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Regionen_x058x_">
					<xsl:for-each select="Regionen_x058x_">
						<subjectGeographic><xsl:value-of select="." /></subjectGeographic>
						</xsl:for-each>
					</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Signatur_x058x_">
					<shelfMark>
						<xsl:value-of select="Signatur_x058x_"></xsl:value-of>
						</shelfMark>
					</xsl:if>


</xsl:element>

				
<!--</xsl:if>-->






</xsl:element>
</xsl:template>



<!--Templates-->










<!--Template Titel-->
	<xsl:template match="Titel_x058x_">
		<xsl:choose>
			<xsl:when test="contains(.[1], ':')">
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(.[1], ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ':'))"/>
					</title_sub>
				</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->




		
</xsl:stylesheet>
