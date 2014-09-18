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
	
<!--<xsl:if test="Objektart_x058x_[text()='Zeitschriftenausgabe']">-->
	
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
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>FrauenMediaTurm, Das Archiv und Dokumentationszentrum</xsl:text>
							</institutionFull>
			
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


<xsl:if test="Objektart_x058x_[text()='Monographie']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>

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
				<xsl:if test="Hrsg_x046x__x047x_Mitarbeit_x058x_">
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
					</xsl:if>

<!--entity Körperschaftsangaben-->
				<xsl:if test="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
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
					<xsl:when test="contains(Formen_x058x_,'Hochschulschrift')">
						<format>
							<xsl:text>Hochschulschrift</xsl:text>
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
				<xsl:if test="Sprache_x058x_">
					<xsl:apply-templates select="Sprache_x058x_" />
					</xsl:if>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
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
<!--description-->
				<xsl:if test="Sonstiges_x058x_">
					<description>
						<xsl:value-of select="Sonstiges_x058x_" />
						</description>
					</xsl:if>

<!--edition-->
				<xsl:if test="Ausgabe_x058x_">
					<edition>
						<xsl:value-of select="Ausgabe_x058x_" />
						</edition>
					</xsl:if>

</xsl:element>	

<xsl:if test="Aufs_x132x_tze_x032x__x040x_Link_x041x__x058x_">
	<xsl:element name="functions">	
		<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')" />
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Titel_x058x_[1]" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Titel_x058x_[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
		</xsl:element>	
	</xsl:if>
</xsl:if>










<!--Artikel__________________________Artikel___________________________Artikel-->


<xsl:if test="Objektart_x058x_[text()='Aufsatz aus Sammelwerk']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>

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
				<xsl:if test="Hrsg_x046x__x047x_Mitarbeit_x058x_">
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
					</xsl:if>

<!--entity Körperschaftsangaben-->
				<xsl:if test="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
					</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Zeitschr_x046x__x047x_Reihentitel_x058x_">
					<series>
						<xsl:value-of select="Zeitschr_x046x__x047x_Reihentitel_x058x_"/>
						 </series>
						</xsl:if>

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
						</format>


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
				<xsl:if test="Sprache_x058x_">
					<xsl:apply-templates select="Sprache_x058x_" />
					</xsl:if>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
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


<xsl:element name="functions">
	<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')" />
	<xsl:variable name="obj" select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" />
	<xsl:variable name="title" select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_" />
		<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="$obj" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="$obj" /><xsl:text>fmt</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="$title" /></hierarchy_parent_title>
				
<!--				<hierarchy_top_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_" /></hierarchy_parent_title>
-->				
				<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_x058x_[1]" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"></xsl:value-of></hierarchy_sequence>
			</hierarchyFields>
	
</xsl:element>	
</xsl:if>









<!--Zeitschrift__________________________Zeitschrift___________________________Zeitschrift-->


<xsl:if test="Objektart_x058x_[text()='Zeitschrift']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>

<!--title Titelinformationen-->
				<xsl:if test="Zeitschriftentitel_x058x_[1]">
					<xsl:apply-templates select="Zeitschriftentitel_x058x_[1]"/>
					</xsl:if>

<!--formerTitle-->
				<xsl:if test="Fr_x129x_herer_x032x_Titel_x058x_">
					<xsl:for-each select="Fr_x129x_herer_x032x_Titel_x058x_">
						<formerTitle>
							<xsl:value-of select="." />						
							</formerTitle>
						</xsl:for-each>
					</xsl:if>
<!--upcomingTitle-->
				<xsl:if test="Sp_x132x_terer_x032x_Titel_x058x_">
					<xsl:for-each select="Sp_x132x_terer_x032x_Titel_x058x_">
						<upcomingTitle>
							<xsl:value-of select="." />
							</upcomingTitle>
						</xsl:for-each>
					</xsl:if>

<!--alternativeTitle-->

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg_x046x__x047x_Mitarbeit_x058x_">
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
					</xsl:if>

<!--entity Körperschaftsangaben-->
				<xsl:if test="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
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

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Zeitschrift</xsl:text>
						</format>

<!--ISBN / ISSN-->
				<xsl:if test="ISSN_x058x_">
					<isbn>
						<xsl:value-of select="ISSN_x058x_"/>
						</isbn>
					</xsl:if>

<!--ZDBID-->
				<xsl:if test="ZDB-ID_x058x_">
					<xsl:for-each select="ZDB-ID_x058x_">
						<zdbId>
							<xsl:value-of select="substring-before(.,';')"/>
							</zdbId>
						</xsl:for-each>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache_x058x_">
					<xsl:apply-templates select="Sprache_x058x_" />
					</xsl:if>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Themen_x058x_">
					<xsl:for-each select="Themen_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Zeitschriftentyp_x058x_">
					<xsl:for-each select="Zeitschriftentyp_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
					
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				<xsl:if test="Freie_x032x_Schlagworte_x058x_">
					<xsl:for-each select="Freie_x032x_Schlagworte_x058x_">
						<subjectTopic>
							<xsl:value-of select="." />
							</subjectTopic>
						</xsl:for-each>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Regionen_x058x_">
					<xsl:for-each select="Regionen_x058x_">
						<subjectGeographic><xsl:value-of select="." /></subjectGeographic>
						</xsl:for-each>
					</xsl:if>
					
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen_x058x_">
					<xsl:for-each select="Personen_x058x_">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>
						</xsl:for-each>
					</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Signatur_x058x_">
					<shelfMark>
						<xsl:value-of select="Signatur_x058x_"></xsl:value-of>
						</shelfMark>
					</xsl:if>

<!--description-->
				<xsl:if test="Bestand_x058x_">
					<description>
						<xsl:value-of select="Bestand_x058x_" />
						<xsl:text> - Bezug: </xsl:text>
						<xsl:value-of select="Bezug_x058x_" />
						</description>
					</xsl:if>
</xsl:element>


<xsl:element name="functions">
	<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')" />
		<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Zeitschriftentitel_x058x_[1]" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Zeitschriftentitel_x058x_[1]" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Zeitschriftentitel_x058x_[1],1,3)"></xsl:value-of></hierarchy_sequence>
			</hierarchyFields>
	
</xsl:element>	

</xsl:if>









<!--Ausgabe__________________________Ausgabe___________________________Ausgabe-->


<xsl:if test="Objektart_x058x_[text()='Zeitschriftenausgabe']">

<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')" />

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>

<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Titel_x058x_">
						<title>
							<xsl:value-of select="Titel_x058x_" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr_x058x_" />
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_" />
							</title>
						<title_short>
							<xsl:value-of select="Titel_x058x_" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr_x058x_" />
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_" />
							</title_short>
						</xsl:when>
					<xsl:when test="Zeitschrift_x032x__x040x_Link_x041x__x058x_">
						<title>
							<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr_x058x_" />
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_" />
							</title>
						<title_short>
							<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr_x058x_" />
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_" />
							</title_short>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_" />						
							</title>
						</xsl:otherwise>
					</xsl:choose>
<!--author Autorinneninformation-->
				<xsl:if test="AutorInnen_x058x_[1]">
					<xsl:for-each select="AutorInnen_x058x_">
						<author><xsl:value-of select="." /></author>
						</xsl:for-each>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg_x046x__x047x_Mitarbeit_x058x_">
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
					</xsl:if>

<!--entity Körperschaftsangaben-->
				<xsl:if test="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
					</xsl:if>

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Zeitschriftenheft</xsl:text>
						</format>

<!--ISBN / ISSN-->
				<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/ISSN_x058x_">
					<issn>
						<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/ISSN_x058x_"/>
						</issn>
					</xsl:if>

<!--ZDBID-->
				<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
					<xsl:for-each select="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
						<zdbId>
							<xsl:value-of select="substring-before(.,';')"/>
							</zdbId>
						</xsl:for-each>
					</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Signatur_x058x_">
					<shelfMark>
						<xsl:value-of select="Signatur_x058x_"></xsl:value-of>
						</shelfMark>
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

<!--issue Heft-->
				<xsl:if test="Heft_x058x_">
					<issue>
						<xsl:value-of select="Heft_x058x_"/>
						</issue>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seiten_x058x_">
					<physical>
						<xsl:value-of select="Seiten_x058x_" />
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache_x058x_">
					<xsl:apply-templates select="Sprache_x058x_" />
					</xsl:if>
		
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				<xsl:if test="Freie_x032x_Schlagworte_x058x_">
					<xsl:for-each select="Freie_x032x_Schlagworte_x058x_">
						<subjectTopic>
							<xsl:value-of select="." />
							</subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Regionen_x058x_">
					<xsl:for-each select="Regionen_x058x_">
						<subjectGeographic><xsl:value-of select="." /></subjectGeographic>
						</xsl:for-each>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen_x058x_">
					<xsl:for-each select="Personen_x058x_">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>
						</xsl:for-each>
					</xsl:if>
					
<!--description-->
				<xsl:if test="Inhaltsverzeichnis_x058x_[1]">
					<xsl:for-each select="tokenize(Inhaltsverzeichnis_x058x_[1], '&lt;p/&gt;')">
						<listOfContents>
							<xsl:value-of select="normalize-space(.)"/>
							</listOfContents>
						</xsl:for-each>
					</xsl:if>

</xsl:element>

<xsl:element name="functions">
	<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')" />
		<hierarchyFields>
				<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="Titel_x058x_">
							<xsl:value-of select="Titel_x058x_" />
							</xsl:when>
						<xsl:when test="Zeitschrift_x032x__x040x_Link_x041x__x058x_">
							<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_" />						
								</xsl:otherwise>
						</xsl:choose>
					</is_hierarchy_title>
				
				<!--<hierarchy_sequence><xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"></xsl:value-of></hierarchy_sequence>-->
			</hierarchyFields>
			</hierarchyFields>
	
	</xsl:element>	

</xsl:if>










<!--Artikel aus EMMA__________________________Artikel aus EMMA__________________________Artikel aus EMMA-->


<xsl:if test="Objektart_x058x_[text()='Artikel aus EMMA']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>


<!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
						</format>

<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>

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

<!--display / publishDate Jahresangabe-->
				<xsl:if test="Jahr_x058x_">
					<displayPublishDate>
						<xsl:value-of select="Jahr_x058x_" />
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="Jahr_x058x_" />
						</publishDate>
					</xsl:if>

<!--issue Heft-->
				<xsl:if test="Heft_x058x_">
					<issue>
						<xsl:value-of select="Heft_x058x_"/>
						</issue>
					</xsl:if>

<!--volume Jahrgang-->
				<xsl:if test="Jg_x046x__x047x_Vol_x046x__x058x_">
					<volume>
						<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
						</volume>
					</xsl:if>	


<!--physical Seitenangabe-->
				<xsl:if test="Seiten_x058x_">
					<physical>
						<xsl:value-of select="Seiten_x058x_" />
						</physical>
					</xsl:if>	

<!--language Sprachangaben-->
				<xsl:if test="Sprache_x058x_">
					<xsl:apply-templates select="Sprache_x058x_" />
					</xsl:if>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				<xsl:if test="Freie_x032x_Schlagworte_x058x_">
					<xsl:for-each select="Freie_x032x_Schlagworte_x058x_">
						<subjectTopic>
							<xsl:value-of select="." />
							</subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Regionen_x058x_">
					<xsl:for-each select="Regionen_x058x_">
						<subjectGeographic><xsl:value-of select="." /></subjectGeographic>
						</xsl:for-each>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen_x058x_">
					<xsl:for-each select="Personen_x058x_">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>
						</xsl:for-each>
					</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Signatur_x058x_">
					<shelfMark>
						<xsl:value-of select="Signatur_x058x_"></xsl:value-of>
						</shelfMark>
					</xsl:if>
	</xsl:element>

<xsl:element name="functions">
	<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_" />
		<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
					<xsl:text>(</xsl:text><xsl:value-of select="Jahr_x058x_" /><xsl:text>)</xsl:text>
					<xsl:value-of select="Heft_x058x_" />
					</hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
					<xsl:text>(</xsl:text><xsl:value-of select="Jahr_x058x_" /><xsl:text>)</xsl:text>
					<xsl:value-of select="Heft_x058x_" />
					</hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_x058x_[1]" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"></xsl:value-of></hierarchy_sequence>
			</hierarchyFields>
	
	</xsl:element>	
</xsl:if>










<!--Zeitschriftenartikel__________________________Zeitschriftenartikel__________________________Zeitschriftenartikel-->


<xsl:if test="Objektart_x058x_[text()='Zeitschriftenartikel']">

<xsl:element name="dataset">

<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_" />

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
						</format>
			
<!--documentType-->
				<xsl:if test="Formen_x058x_">
					<documentType>
						<xsl:value-of select="Formen_x058x_" />
						</documentType>
					</xsl:if>
					
<!--author Autorinneninformation-->
				<xsl:if test="AutorInnen_x058x_[1]">
					<xsl:for-each select="AutorInnen_x058x_">
						<author><xsl:value-of select="." /></author>
						</xsl:for-each>
					</xsl:if>

<!--title Titelinformationen-->
				<xsl:if test="Titel_x058x_[1]">
					<xsl:apply-templates select="Titel_x058x_[1]"/>
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

<!--issue Heft-->
				<xsl:if test="Heft_x058x_">
					<issue>
						<xsl:value-of select="Heft_x058x_"/>
						</issue>
					</xsl:if>

<!--volume Jahrgang-->
				<xsl:if test="Jg_x046x__x047x_Vol_x046x__x058x_">
					<volume>
						<xsl:value-of select="Jg_x046x__x047x_Vol_x046x__x058x_"/>
						</volume>
					</xsl:if>	

<!--physical Seitenangabe-->
				<xsl:if test="Seiten_x058x_">
					<physical>
						<xsl:value-of select="Seiten_x058x_" />
						</physical>
					</xsl:if>	

<!--ISBN / ISSN-->
				<xsl:choose>
					<xsl:when test="Heft_x032x__x040x_Link_x041x__x058x_">
						<issn>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/ISBN_x058x_"></xsl:value-of>
							</issn>
						</xsl:when>
					<xsl:when test="ISBN_x058x_">
						<isbn>
							<xsl:value-of select="ISBN_x058x_" />
							</isbn>
						</xsl:when>
					<xsl:when test="ISSN_x058x_">
						<issn>
							<xsl:value-of select="ISSN_x058x_" />
							</issn>
						</xsl:when>
					</xsl:choose>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Hauptschlagworte_x058x_">
					<xsl:for-each select="Hauptschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:if test="Nebenschlagworte_x058x_">
					<xsl:for-each select="Nebenschlagworte_x058x_">
						<subjectTopic><xsl:value-of select="." /></subjectTopic>
						</xsl:for-each>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Regionen_x058x_">
					<xsl:for-each select="Regionen_x058x_">
						<subjectGeographic><xsl:value-of select="." /></subjectGeographic>
						</xsl:for-each>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen_x058x_">
					<xsl:for-each select="Personen_x058x_">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>
						</xsl:for-each>
					</xsl:if>					

<!--sourceInfo-->	
				<xsl:if test="In_x032x_Zeitschrift_x058x_">
					<xsl:for-each select="In_x032x_Zeitschrift_x058x_">
						<sourceInfo>
							<xsl:value-of select="." />
							</sourceInfo>	
						</xsl:for-each>
					</xsl:if>				
			
	</xsl:element>

<xsl:if test="Heft_x032x__x040x_Link_x041x__x058x_">
<xsl:element name="functions">
	<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_" />
		<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
					<xsl:text> </xsl:text><xsl:value-of select="Heft_x058x_" />
					<xsl:text>/</xsl:text><xsl:value-of select="Jahr_x058x_" />
					</hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_" />
					<xsl:text> </xsl:text><xsl:value-of select="Heft_x058x_" />
					<xsl:text>/</xsl:text><xsl:value-of select="Jahr_x058x_" />
					</hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_x058x_[1]" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"></xsl:value-of></hierarchy_sequence>
			</hierarchyFields>
	
	</xsl:element>	
</xsl:if>
</xsl:if>



</xsl:element>

<!--</xsl:if>-->

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

<!--Template ZeitschriftenTitel-->
	<xsl:template match="Zeitschriftentitel_x058x_">
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

<!--Template Herausgeberinnen Mitarbeiterinnen-->
	<xsl:template match="Hrsg_x046x__x047x_Mitarbeit_x058x_">
		<xsl:for-each select=".">
				<xsl:choose>
					<xsl:when test="(contains(.,'[Red.]')) 
					or (contains(.,'[Übers.]')) 
					or (contains(.,'[Mitarb.]')) 
					or (contains(.,'[Einl..]')) 
					or (contains(.,'[Vorw.]'))">
						<contributor>
							<xsl:value-of select="."></xsl:value-of>
							</contributor>
						</xsl:when>
					<xsl:when test="contains(.,'[Hrsg.]')">
						<editor>
							<xsl:value-of select="normalize-space(substring-before(.,'['))"></xsl:value-of>
							</editor>
						</xsl:when>
					</xsl:choose>
					</xsl:for-each>
		</xsl:template>

<!--Template Körperschaften entity-->
	<xsl:template match="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="contains(.,'[Hrsg.]')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'['))"></xsl:value-of>
						</editor>
					<entity>
						<xsl:value-of select="normalize-space(substring-before(.,'['))"></xsl:value-of>
					</entity>
					</xsl:when>
				<xsl:otherwise>
					<entity>
						<xsl:value-of select="."></xsl:value-of>
						</entity>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:template>

<!--Template Sprache_x058x_-->
	<xsl:template match="Sprache_x058x_">
		<xsl:if test="contains(.,'dt.')">
			<language>deutsch</language>
			</xsl:if>
		<xsl:if test="contains(.,'chines.')">
			<language>chinesisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'engl.')">
			<language>englisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'ital.')">
			<language>italienisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'japan.')">
			<language>japanisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'niederländ.')">
			<language>niederländisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'poln.')">
			<language>polnisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'rumän.')">
			<language>rumänisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'russ.')">
			<language>russisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'span.')">
			<language>spanisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'franz.')">
			<language>französisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'hebr.')">
			<language>hebräisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'lat.')">
			<language>latein</language>
			</xsl:if>
		<xsl:if test="contains(.,'schwed.')">
			<language>schwedisch</language>
			</xsl:if>
		<xsl:if test="contains(.,'lat.')">
			<language>latein</language>
			</xsl:if>			
		<xsl:if test="contains(.,'serbokroat.')">
			<language>serbokroatisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'türk.')">
			<language>türkisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'arab.')">
			<language>arabisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'pers.')">
			<language>persisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'serbokroat.')">
			<language>serbokroatisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'[Wiener Dialekt]')">
			<language>deutsch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'norweg.')">
			<language>norwegisch</language>
			</xsl:if>	
		<xsl:if test="contains(.,'slowen.')">
			<language>slowenisch</language>
			</xsl:if>	
		</xsl:template>

<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->




		
</xsl:stylesheet>
