<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" exclude-result-prefixes="xs xdt err fn" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors">
	<xsl:output method="xml" indent="yes"/><!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/><!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/><!--root knoten--><!--<xsl:template match="FrauenMediaTurm (FMT)">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
			</xsl:element>
		</xsl:template>--><!--root knoten-->
	<xsl:template match="FMT">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template><!--Der Objektknoten-->
	<xsl:template match="Datensatz"><!--<xsl:if test="Objektart_x058x_[text()='Zeitschriftenausgabe']">-->
		<xsl:variable name="id" select="Objektnummer_x058x_"/>
		<xsl:element name="record">
			<xsl:attribute name="id">
				<xsl:value-of select="$id"/>
			</xsl:attribute>
			
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->

<!--vufind_______________________________vufind_______________________________vufind-->

		<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="Objektnummer_x058x_"/>
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

		<xsl:element name="institution">
	
	<!--institutionShortname-->
				<institutionShortname>
					<xsl:text>FrauenMediaTurm</xsl:text>
					</institutionShortname>
	<!--institutionFullname-->
				<institutionFull>
					<xsl:text>FrauenMediaTurm, Das Archiv und Dokumentationszentrum</xsl:text>
					</institutionFull>
	<!--collection-->
				<collection>
					<xsl:text>FMT</xsl:text>
					</collection>
	<!--isil-->
				<isil>
					<xsl:text>DE-Kn184</xsl:text>
					</isil>
	<!--linkToWebpage-->
				<link>
					<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/frauenmediaturm/</xsl:text>
					</link>
	<!--geoLocation-->
				<geoLocation>
					<latitude>50.93252</latitude>
					<longitude>6.96420</longitude>
					</geoLocation>
			</xsl:element>


<!--dataset_______________________________dataset_______________________________dataset-->



<!--Buch__________________________Monographie___________________________Sammelband-->

		<xsl:if test="Objektart_x058x_[text()='Monographie']">
			<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
					<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
					<xsl:apply-templates select="Formen_x058x_"/>
					
					<!--<xsl:choose>
					<xsl:when test="Aufs_x132x_tze_x032x__x040x_Link_x041x__x058x_">
						<documentType>
							<xsl:text>Sammelband</xsl:text>
							</documentType>
						</xsl:when>
					<xsl:when test="*[.='Hochschulschrift']">
						<documentType>
							<xsl:text>Hochschulschrift</xsl:text>
							</documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType>
							<xsl:text>Monografie</xsl:text>
							</documentType>
						</xsl:otherwise>
				</xsl:choose>-->

<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:apply-templates select="Titel_x058x_"/>

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
					<xsl:apply-templates select="AutorInnen_x058x_"/>
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
	<!--entity Körperschaftsangaben-->
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
	<!--series Reiheninformation-->
					<xsl:apply-templates select="Zeitschr_x046x__x047x_Reihentitel_x058x_"/>
	<!--series Bandinformation-->
					<xsl:apply-templates select="Bandtitel_x058x_"/>
	<!--edition-->
					<xsl:apply-templates select="Ausgabe_x058x_"/>
	<!--volume-->
					<xsl:apply-templates select="Band_x058x_"/>
					
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISBN_x058x_"/>

<!--PUBLISHING-->

	<!--display publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr_x058x_"/>
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort_x058x_"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag_x058x_"/>

<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seiten_x058x_"/>
	<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/>
					
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache_x058x_"/>
	<!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Weitere_x032x_Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/>
	<!--description-->
					<xsl:apply-templates select="Sonstiges_x058x_"/>
					
<!--OTHER-->

	<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur_x058x_"/>
	
				</xsl:element>
				
	<!--END OF DATASETELEMENT-->

<!--HIERARCHY-->
				<xsl:if test="Aufs_x132x_tze_x032x__x040x_Link_x041x__x058x_">
					<xsl:element name="functions">
						<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')"/>
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:value-of select="Titel_x058x_[1]"/>
							</hierarchy_top_title>
							<is_hierarchy_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:value-of select="Titel_x058x_[1]"/>
							</is_hierarchy_title>
						</hierarchyFields>
					</xsl:element>
				</xsl:if>
			</xsl:if>
			
<!--Zeitschrift__________________________Zeitschrift___________________________Zeitschrift-->

		<xsl:if test="Objektart_x058x_[text()='Zeitschrift']">

			<xsl:element name="dataset">
			
<!--FORMAT-->

	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
					<format><xsl:text>Zeitschrift</xsl:text></format>
					
	<!--documentType-->
					<xsl:apply-templates select="Zeitschriftentyp_x058x_"/>
					<xsl:apply-templates select="Formen_x058x_"/>
					<xsl:apply-templates select="Materialart_x058x_"/>
					<xsl:apply-templates select="andere_x032x_Materialart_x058x_"/>
					
<!--TITLE-->
	
	<!--title Titelinformationen-->
					<xsl:apply-templates select="Zeitschriftentitel_x058x_"/>
	<!--formerTitle-->
					<xsl:apply-templates select="Fr_x129x_herer_x032x_Titel_x058x_"/>
	<!--upcomingTitle-->
					<xsl:apply-templates select="Sp_x132x_terer_x032x_Titel_x058x_"/>
	<!--alternativeTitle-->

<!--RESPONSIBLE-->

	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
	<!--entity Körperschaftsangaben-->
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
					
<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:apply-templates select="ISSN_x058x_"/>
	<!--ZDBID-->
					<xsl:apply-templates select="ZDB-ID_x058x_"/>
					
<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="Erstersch_x046x_-Jahr_x058x_">
							<timeSpan>
								<timeSpanStart>
									<xsl:value-of select="Erstersch_x046x_-Jahr_x058x_"/>
								</timeSpanStart>
								<timeSpanEnd/>
							</timeSpan>
						</xsl:when>
						<xsl:when test="Bestand_x058x_">
							<timeSpan>
								<timeSpanStart>
									<xsl:value-of select="substring-before(Bestand_x058x_,':')"/>
								</timeSpanStart>
								<timeSpanEnd/>
							</timeSpan>
						</xsl:when>
					</xsl:choose>
	<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort_x058x_"/>
	<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag_x058x_"/>
					
<!--PHYSICAL INFORMATION-->

	<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/>
	<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Begleitmaterial_x058x_"/>

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache_x058x_"/>
	<!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Weitere_x032x_Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Themen_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/>
	<!--description-->
					<xsl:if test="Bestand_x058x_">
						<description>
							<xsl:value-of select="Bestand_x058x_"/>
							<xsl:text> - Bezug: </xsl:text>
							<xsl:value-of select="Bezug_x058x_"/>
							</description>
					</xsl:if>

<!--OTHER-->

	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur_x058x_"/>
				</xsl:element>
		
	<!--END OF DATASETELEMENT-->
	
<!--HIERARCHY-->
				<xsl:variable name="rel" select="Signatur_x058x_"/><!--<xsl:if test="//Datensatz/Zeitschriftenhefte_x032x__x040x_Link_x041x__x058x_=Zeitschriftentitel_x058x_">
		<xsl:element name="functions">
		<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')" />
			<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Zeitschriftentitel_x058x_[1]" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="Objektnummer_x058x_" /><xsl:text>fmt</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Zeitschriftentitel_x058x_[1]" /></is_hierarchy_title>
					
					<hierarchy_sequence><xsl:value-of select="substring(Zeitschriftentitel_x058x_[1],1,3)"></xsl:value-of></hierarchy_sequence>
			</hierarchyFields>	
			</xsl:element>	
		</xsl:if>-->
				<xsl:if test="Artikel_x032x__x040x_Link_x041x__x058x_">
					<xsl:element name="functions"><!--<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')" />-->
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:value-of select="Zeitschriftentitel_x058x_[1]"/>
							</hierarchy_top_title>
							<is_hierarchy_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:value-of select="Zeitschriftentitel_x058x_[1]"/>
							</is_hierarchy_title><!--<hierarchy_sequence><xsl:value-of select="substring(Zeitschriftentitel_x058x_[1],1,3)"></xsl:value-of></hierarchy_sequence>-->
						</hierarchyFields>
					</xsl:element>
				</xsl:if>
			</xsl:if>
			


<!--Ausgabe__________________________Ausgabe___________________________Ausgabe-->

		<xsl:if test="Objektart_x058x_[text()='Zeitschriftenausgabe']">
			<xsl:element name="dataset">

<!--VARIABLES-->
					<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')"/>
					<xsl:variable name="top" select="substring-before(Heft_x032x__x040x_Link_x041x__x058x_,':')"/>
					
<!--FORMAT-->
	
	<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>				
	<!--format Objektartinformationen-->
					<format><xsl:text>Zeitschrift</xsl:text>
					</format>
	<!--documentType-->
					<documentType><xsl:text>Zeitschriftenheft</xsl:text></documentType>
					<xsl:apply-templates select="Formen_x058x_"/>
					
<!--TITLE-->

	<!--title Titelinformationen-->
					<xsl:choose>
						<xsl:when test="Titel_x058x_">
							<xsl:apply-templates select="Titel_x058x_"/>
						</xsl:when>
						<xsl:when test="Zeitschrift_x032x__x040x_Link_x041x__x058x_">
							<title>
								<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
							</title>
							<title_short>
								<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
							</title_short>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_"/>
							</title>
							<title_short>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschriftentitel_x058x_"/>
							</title_short>
						</xsl:otherwise>
					</xsl:choose>

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
					<xsl:apply-templates select="AutorInnen_x058x_"/>
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/>
	<!--entity Körperschaftsangaben-->
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/>
					
<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:choose>
						<xsl:when test="ISSN_x058x_">
							<xsl:apply-templates select="ISSN_x058x_"/>
						</xsl:when>
						<xsl:when test="//Datensatz[Signatur_x058x_=$rel]/ISSN_x058x_">
							<xsl:for-each select="//Datensatz[Signatur_x058x_=$rel]/ISSN_x058x_">
								<issn>
									<xsl:value-of select="."/>
								</issn>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose><!--
				
				<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/ISSN_x058x_">	
					</xsl:if>-->
	<!--ZDBID-->
					<xsl:choose>
						<xsl:when test="ZDB-ID_x058x_">
							<xsl:apply-templates select="ZDB-ID_x058x_"/>
						</xsl:when>
						<xsl:when test="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
							<xsl:for-each select="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
								<zdbId>
									<xsl:value-of select="substring-before(.,';')"/>
								</zdbId>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose><!--<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
					<xsl:for-each select="//Datensatz[Signatur_x058x_=$rel]/ZDB-ID_x058x_">
						<zdbId>
							<xsl:value-of select="substring-before(.,';')"/>
							</zdbId>
						</xsl:for-each>
					</xsl:if>-->
					
<!--PUBLISHING-->

	<!--display publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr_x058x_"/>
	<!--placeOfPublication-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/Ort_x058x_">
						<placeOfPublication>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Ort_x058x_"/>
							</placeOfPublication>
						</xsl:if>
	<!--publisher-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$rel]/Verlag_x058x_">
						<publisher>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Verlag_x058x_"/>
							</publisher>
					</xsl:if>
	<!--sourceInfo-->
					<sourceInfo>
						<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
						<!--<xsl:text> (</xsl:text>
						<xsl:value-of select="Jahr_x058x_"/>
						<xsl:text>)</xsl:text>
						<xsl:value-of select="Heft_x058x_"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="Seiten_x058x_"/>-->
					</sourceInfo>
					
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seiten_x058x_"/>
	<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/>
					
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache_x058x_"/>
	<!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Weitere_x032x_Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/>
	<!--listOfContents-->
					<xsl:if test="Inhaltsverzeichnis_x058x_[1]">
						<xsl:for-each select="Inhaltsverzeichnis_x058x_[1]">
							<listOfContents>
								<xsl:value-of select="normalize-space(.)"/>
							</listOfContents>
						</xsl:for-each>
					</xsl:if>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->
					<xsl:apply-templates select="Heft_x058x_"/>

<!--OTHER-->
	
	<!--SHELFMARK-->
					<xsl:apply-templates select="Signatur_x058x_"/>
				</xsl:element>
			
		<!--END OF DATASETELEMENT-->

<!--HIERARCHY-->
				<xsl:if test="Artikel_x032x__x040x_Link_x041x__x058x_">
					<xsl:element name="functions">
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:choose>
									<xsl:when test="Titel_x058x_">
										<xsl:value-of select="Titel_x058x_"/>
									</xsl:when>
									<xsl:when test="//DatensatzZeitschrift_x032x__x040x_Link_x041x__x058x_">
										<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
									</xsl:when>
								</xsl:choose>
							</hierarchy_top_title>
							<is_hierarchy_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:choose>
									<xsl:when test="Titel_x058x_">
										<xsl:value-of select="Titel_x058x_"/>
									</xsl:when>
									<xsl:when test="Zeitschrift_x032x__x040x_Link_x041x__x058x_">
										<xsl:value-of select="Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
									</xsl:when>
								</xsl:choose>
							</is_hierarchy_title>
						</hierarchyFields>
					</xsl:element>
				</xsl:if><!--<xsl:element name="functions">
	<xsl:variable name="rel" select="substring-before(Signatur_x058x_,':')" />
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
				
				</hierarchyFields>
	
	</xsl:element>	-->
			</xsl:if>
			

<!--Artikel__________________________Artikel___________________________Artikel-->

		<xsl:if test="Objektart_x058x_[text()='Aufsatz aus Sammelwerk']">
			<xsl:element name="dataset">
				
<!--VARIABLES-->
					<xsl:variable name="top" select="substring-before(Signatur_x058x_,'-a')"/>
					
<!--FORMAT-->
	<!--typeOfRessource-->
					<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource><!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format><!--documentType-->
					<xsl:apply-templates select="Formen_x058x_"/><!--TITLE--><!--title Titelinformationen-->
					<xsl:apply-templates select="Titel_x058x_"/><!--RESPONSIBLE--><!--author Autorinneninformation-->
					<xsl:apply-templates select="AutorInnen_x058x_"/><!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg_x046x__x047x_Mitarbeit_x058x_"/><!--entity Körperschaftsangaben-->
					<xsl:apply-templates select="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_"/><!--IDENTIFIER--><!--ISBN / ISSN / ZDBID-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/ISBN_x058x_">
						<xsl:for-each select="//Datensatz[Signatur_x058x_=$top]/ISBN_x058x_">
							<isbn>
								<xsl:value-of select="."/>
							</isbn>
						</xsl:for-each>
					</xsl:if><!--PUBLISHING--><!--display publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr_x058x_"/><!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort_x058x_"/><!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag_x058x_"/>
	
	<!--sourceInfo-->
					<sourceInfo>
						<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')"/>
						<xsl:variable name="title" select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_"/>
						<xsl:value-of select="$title"/>
						<!--<xsl:text> (</xsl:text>
						<xsl:value-of select="Jahr_x058x_"/>
						<xsl:text>)</xsl:text>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="Seiten_x058x_"/>-->
					</sourceInfo>
					
<!--PHYSICAL INFORMATION-->
	<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seiten_x058x_"/><!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/><!--CONTENTRELATED INFORMATION--><!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Weitere_x032x_Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/><!--OTHER--><!--SHELFMARK-->
					<xsl:apply-templates select="Signatur_x058x_"/>
				</xsl:element><!--END OF DATASETELEMENT--><!--HIERARCHY-->
				<xsl:element name="functions">
					<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-')"/>
					<xsl:variable name="obj" select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_"/>
					<xsl:variable name="title" select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_"/>
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:value-of select="$obj"/>
							<xsl:text>fmt</xsl:text>
						</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:value-of select="$title"/>
						</hierarchy_top_title>
						<hierarchy_parent_id>
							<xsl:value-of select="$obj"/>
							<xsl:text>fmt</xsl:text>
						</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:value-of select="$title"/>
						</hierarchy_parent_title>
						<is_hierarchy_id>
							<xsl:value-of select="Objektnummer_x058x_"/>
							<xsl:text>fmt</xsl:text>
						</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="Titel_x058x_[1]"/>
						</is_hierarchy_title>
						<hierarchy_sequence>
							<xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"/>
						</hierarchy_sequence>
					</hierarchyFields>
				</xsl:element>
			</xsl:if>
			


<!--Artikel aus EMMA__________________________Artikel aus EMMA__________________________Artikel aus EMMA-->
			<xsl:if test="Objektart_x058x_[text()='Artikel aus EMMA']">
				<xsl:element name="dataset"><!--VARIABLES-->
					<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_"/>
					<xsl:variable name="top" select="substring-before(Heft_x032x__x040x_Link_x041x__x058x_,':')"/><!--FORMAT--><!--typeOfRessource-->
					<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource><!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format><!--documentType-->
					<xsl:apply-templates select="Formen_x058x_"/><!--TITLE--><!--title Titelinformationen-->
					<xsl:apply-templates select="Titel_x058x_"/><!--RESPONSIBLE--><!--author Autorinneninformation-->
					<xsl:apply-templates select="AutorInnen_x058x_"/><!--IDENTIFIER--><!--ISBN / ISSN / ZDBID-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/ZDB-ID_x058x_">
						<xsl:for-each select="//Datensatz[Signatur_x058x_=$top]/ZDB-ID_x058x_">
							<zdbId>
								<xsl:value-of select="substring-before(.,';')"/>
							</zdbId>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/ISSN_x058x_">
						<xsl:for-each select="//Datensatz[Signatur_x058x_=$top]/ISSN_x058x_">
							<issn>
								<xsl:value-of select="."/>
							</issn>
						</xsl:for-each>
					</xsl:if><!--PUBLISHING--><!--display publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr_x058x_"/><!--placeOfPublication-->
					<placeOfPublication>
						<xsl:value-of select="//Datensatz[Signatur_x058x_=$top]/Ort_x058x_"/>
					</placeOfPublication><!--publisher-->
					<publisher>
						<xsl:value-of select="//Datensatz[Signatur_x058x_=$top]/Verlag_x058x_"/>
					</publisher><!--sourceInfo-->
					<sourceInfo>
						<xsl:value-of select="In_x032x_Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
						<!--<xsl:text> (</xsl:text>
						<xsl:value-of select="Jahr_x058x_"/>
						<xsl:text>)</xsl:text>
						<xsl:value-of select="Heft_x058x_"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="Seiten_x058x_"/>-->
					</sourceInfo><!--PHYSICAL INFORMATION--><!--physical Seitenangabe-->
					<xsl:apply-templates select="Seiten_x058x_"/><!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/><!--CONTENTRELATED INFORMATION--><!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Weitere_x032x_Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/><!--DETAILS FOR JOURNAL RELATED CONTENT--><!--issue Heft-->
					<xsl:apply-templates select="Heft_x058x_"/><!--volume Jahrgang-->
					<xsl:apply-templates select="Jg_x046x__x047x_Vol_x046x__x058x_"/><!--OTHER--><!--SHELFMARK-->
					<xsl:apply-templates select="Signatur_x058x_"/>
				</xsl:element><!--END OF DATASETELEMENT--><!--HIERARCHY-->
				<xsl:element name="functions">
					<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_"/>
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_"/>
							<xsl:text>fmt</xsl:text>
						</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
							<xsl:text> (</xsl:text>
							<xsl:value-of select="Jahr_x058x_"/>
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_"/>
						</hierarchy_top_title>
						<hierarchy_parent_id>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_"/>
							<xsl:text>fmt</xsl:text>
						</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
							<xsl:text> (</xsl:text>
							<xsl:value-of select="Jahr_x058x_"/>
							<xsl:text>)</xsl:text>
							<xsl:value-of select="Heft_x058x_"/>
						</hierarchy_parent_title>
						<is_hierarchy_id>
							<xsl:value-of select="Objektnummer_x058x_"/>
							<xsl:text>fmt</xsl:text>
						</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="Titel_x058x_[1]"/>
						</is_hierarchy_title>
						<hierarchy_sequence>
							<xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"/>
						</hierarchy_sequence>
					</hierarchyFields>
				</xsl:element>
			</xsl:if>
			

<!--Zeitschriftenartikel__________________________Zeitschriftenartikel__________________________Zeitschriftenartikel-->

			<xsl:if test="(Objektart_x058x_[text()='Zeitschriftenartikel']) or   (Objektart_x058x_[text()='Artikel aus Hist. Frauenbewegungszeitschrift'])">
				<xsl:element name="dataset"><!--VARIABLES-->
					<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_"/>
					<xsl:variable name="top" select="substring-before(Heft_x032x__x040x_Link_x041x__x058x_,':')"/>
					<xsl:variable name="his" select="substring-before(Signatur_x058x_,'-a')"/><!--FORMAT--><!--typeOfRessource-->
					<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource><!--format Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format><!--documentType-->
					<xsl:apply-templates select="Formen_x058x_"/><!--TITLE--><!--title Titelinformationen-->
					<xsl:apply-templates select="Titel_x058x_"/><!--RESPONSIBLE--><!--author Autorinneninformation-->
					<xsl:apply-templates select="AutorInnen_x058x_"/><!--IDENTIFIER--><!--ISBN / ISSN / ZDBID-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/ZDB-ID_x058x_">
						<xsl:for-each select="//Datensatz[Signatur_x058x_=$top]/ZDB-ID_x058x_">
							<zdbId>
								<xsl:value-of select="substring-before(.,';')"/>
							</zdbId>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/ISSN_x058x_">
						<xsl:for-each select="//Datensatz[Signatur_x058x_=$top]/ISSN_x058x_">
							<issn>
								<xsl:value-of select="."/>
							</issn>
						</xsl:for-each>
					</xsl:if><!--PUBLISHING--><!--display publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr_x058x_"/><!--placeOfPublication-->
					<xsl:if test="//Datensatz[Signatur_x058x_=$top]/Ort_x058x_">
						<placeOfPublication>
							<xsl:value-of select="//Datensatz[Signatur_x058x_=$top]/Ort_x058x_"/>
						</placeOfPublication>
					</xsl:if><!--publisher-->
					<xsl:choose>
						<xsl:when test="Objektart_x058x_[text()='Zeitschriftenartikel']">
							<publisher>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$top]/Verlag_x058x_"/>
							</publisher>
						</xsl:when>
						<xsl:when test="Objektart_x058x_[text()='Artikel aus Hist. Frauenbewegungszeitschrift']">
							<publisher>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$his]/Verlag_x058x_"/>
							</publisher>
						</xsl:when>
					</xsl:choose><!--sourceInfo-->
					<sourceInfo>
						<xsl:value-of select="In_x032x_Zeitschrift_x032x__x040x_Link_x041x__x058x_"/>
						<!--<xsl:text> (</xsl:text>
						<xsl:value-of select="Jahr_x058x_"/>
						<xsl:text>)</xsl:text>
						<xsl:value-of select="Heft_x058x_"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="Seiten_x058x_"/>-->
					</sourceInfo><!--PHYSICAL INFORMATION--><!--physical Seitenangabe-->
					<xsl:apply-templates select="Seiten_x058x_"/><!--specificMaterialDesignation-->
					<xsl:apply-templates select="Beigaben_x058x_"/><!--CONTENTRELATED INFORMATION--><!--subjects-->
					<xsl:apply-templates select="Hauptschlagworte_x058x_"/>
					<xsl:apply-templates select="Nebenschlagworte_x058x_"/>
					<xsl:apply-templates select="Regionen_x058x_"/>
					<xsl:apply-templates select="Personen_x058x_"/>
					<xsl:apply-templates select="Freie_x032x_Schlagworte_x058x_"/>
					<xsl:apply-templates select="Eigennamen_x058x_"/><!--DETAILS FOR JOURNAL RELATED CONTENT--><!--issue Heft-->
					<xsl:apply-templates select="Heft_x058x_"/><!--volume Jahrgang-->
					<xsl:apply-templates select="Jg_x046x__x047x_Vol_x046x__x058x_"/><!--OTHER--><!--SHELFMARK-->
					<xsl:apply-templates select="Signatur_x058x_"/>
				</xsl:element><!--END OF DATASETELEMENT--><!--HIERARCHY-->
				<xsl:if test="In_x032x_Zeitschrift_x032x__x040x_Link_x041x__x058x_">
					<xsl:element name="functions"><!--<xsl:variable name="rel" select="Heft_x032x__x040x_Link_x041x__x058x_" />-->
						<xsl:variable name="rel" select="substring-before(Signatur_x058x_,'-a')"/>
						<hierarchyFields>
							<hierarchy_top_id>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</hierarchy_top_id>
							<hierarchy_top_title>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_"/><!--<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Zeitschrift_x032x__x040x_Link_x041x__x058x_" />-->
								<xsl:text> (</xsl:text>
								<xsl:value-of select="Jahr_x058x_"/>
								<xsl:text>)</xsl:text>
								<xsl:value-of select="Heft_x058x_"/>
							</hierarchy_top_title>
							<hierarchy_parent_id>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</hierarchy_parent_id>
							<hierarchy_parent_title>
								<xsl:value-of select="//Datensatz[Signatur_x058x_=$rel]/Titel_x058x_"/>
								<xsl:text> (</xsl:text>
								<xsl:value-of select="Jahr_x058x_"/>
								<xsl:text>)</xsl:text>
								<xsl:value-of select="Heft_x058x_"/>
							</hierarchy_parent_title>
							<is_hierarchy_id>
								<xsl:value-of select="Objektnummer_x058x_"/>
								<xsl:text>fmt</xsl:text>
							</is_hierarchy_id>
							<is_hierarchy_title>
								<xsl:value-of select="Titel_x058x_[1]"/>
							</is_hierarchy_title>
							<hierarchy_sequence>
								<xsl:value-of select="normalize-space(substring-before(Seiten_x058x_[1],'-'))"/>
							</hierarchy_sequence>
						</hierarchyFields>
					</xsl:element><!--END OF HIERARCHYELEMENT-->
				</xsl:if>
			</xsl:if>
		</xsl:element><!--</xsl:if>-->
	</xsl:template><!--Templates--><!--<xsl:template match="Erstersch_x046x_-Jahr_x058x_">
		<xsl:for-each select=".">
			<timeSpan>
				<timeSpanStart><xsl:value-of select="."></timeSpanStart>
				<timeSpanEnd/>
				</timeSpan>
			</xsl:for-each>
		</xsl:template>-->
	<xsl:template match="Sp_x132x_terer_x032x_Titel_x058x_">
		<xsl:for-each select=".">
			<upcomingTitle>
				<xsl:value-of select="."/>
			</upcomingTitle>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Fr_x129x_herer_x032x_Titel_x058x_">
		<xsl:for-each select=".">
			<formerTitle>
				<xsl:value-of select="."/>
			</formerTitle>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Ausgabe_x058x_">
		<edition>
			<xsl:value-of select="."/>
		</edition>
	</xsl:template>
	<xsl:template match="Sonstiges_x058x_">
		<description>
			<xsl:value-of select="."/>
		</description>
	</xsl:template>
	<xsl:template match="ISBN_x058x_">
		<xsl:for-each select=".">
			<isbn>
				<xsl:value-of select="."/>
			</isbn>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="ISSN_x058x_">
		<xsl:for-each select=".">
			<issn>
				<xsl:value-of select="."/>
			</issn>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="ZDB-ID_x058x_">
		<xsl:for-each select=".">
			<zdbId>
				<xsl:value-of select="substring-before(.,';')"/>
			</zdbId>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Bandtitel_x058x_">
		<series>
			<xsl:value-of select="."/>
		</series>
	</xsl:template>
	<xsl:template match="Zeitschr_x046x__x047x_Reihentitel_x058x_">
		<series>
			<xsl:value-of select="."/>
		</series>
	</xsl:template>
	<xsl:template match="Verlag_x058x_">
		<publisher>
			<xsl:value-of select="."/>
		</publisher>
	</xsl:template>
	<xsl:template match="Ort_x058x_">
		<placeOfPublication>
			<xsl:value-of select="."/>
		</placeOfPublication>
	</xsl:template>
	<xsl:template match="Signatur_x058x_">
			<shelfMark>
					<xsl:value-of select="."/>
				</shelfMark>
		
		<!--<xsl:choose>
			<xsl:when test="../Objektart_x058x_[text()='Zeitschriftenartikel']">
				<shelfMark>
					<xsl:value-of select="substring-before(.,'-a')"/>
				</shelfMark>
			</xsl:when>
			<xsl:when test="../Objektart_x058x_[text()='Artikel aus Hist. Frauenbewegungszeitschrift']">
				<shelfMark>
					<xsl:value-of select="substring-before(.,'-a')"/>
				</shelfMark>
			</xsl:when>
			<xsl:when test="../Objektart_x058x_[text()='Artikel aus EMMA']">
				<shelfMark>
					<xsl:value-of select="substring-before(.,'-a')"/>
				</shelfMark>
			</xsl:when>
			<xsl:when test="../Objektart_x058x_[text()='Zeitschriftenausgabe']">
				<shelfMark>
					<xsl:value-of select="."/>
				</shelfMark>
			</xsl:when>
		</xsl:choose>-->
	</xsl:template>
	<xsl:template match="Jahr_x058x_">
		<displayPublishDate>
			<xsl:value-of select="."/>
		</displayPublishDate>
		<publishDate>
			<xsl:value-of select="."/>
		</publishDate>
	</xsl:template>
	<xsl:template match="AutorInnen_x058x_">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="."/>
			</author>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Seiten_x058x_">
		<xsl:choose>
			<xsl:when test="contains(., ',')">
				<physical>
					<xsl:value-of select="normalize-space(substring-before(substring-after(.,','),'S.'))"></xsl:value-of>
					</physical>
				</xsl:when>
			<xsl:when test="contains(., 'S.')">
				<physical>
					<xsl:value-of select="normalize-space(substring-before(.,'S.'))" />
					</physical>
				</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</physical>
				</xsl:otherwise>
		</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Band_x058x_">
		<xsl:for-each select=".">
			<volume>
				<xsl:value-of select="."/>
			</volume>
		</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Jg_x046x__x047x_Vol_x046x__x058x_">
		<xsl:for-each select=".">
			<volume>
				<xsl:value-of select="."/>
			</volume>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Heft_x058x_">
		<xsl:for-each select=".">
			<issue>
				<xsl:value-of select="."/>
			</issue>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Begleitmaterial_x058x_">
		<xsl:for-each select=".">
			<specificMaterialDesignation>
				<xsl:value-of select="."/>
			</specificMaterialDesignation>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Beigaben_x058x_">
		<xsl:for-each select=".">
			<specificMaterialDesignation>
				<xsl:value-of select="."/>
			</specificMaterialDesignation>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Materialart_x058x_">
		<xsl:for-each select=".">
			<documentType>
				<xsl:value-of select="."/>
			</documentType>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Zeitschriftentyp_x058x_">
		<xsl:for-each select=".">
			<documentType>
				<xsl:value-of select="."/>
			</documentType>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Formen_x058x_">
		<xsl:for-each select=".">
			<documentType>
				<xsl:value-of select="."/>
			</documentType>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="andere_x032x_Materialart_x058x_">
		<xsl:for-each select=".">
			<documentType>
				<xsl:value-of select="."/>
			</documentType>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Themen_x058x_">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="."/>
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Hauptschlagworte_x058x_">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="."/>
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Nebenschlagworte_x058x_">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="."/>
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Freie_x032x_Schlagworte_x058x_">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="."/>
			</subjectTopic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Personen_x058x_">
		<xsl:for-each select=".">
			<subjectPerson>
				<xsl:value-of select="."/>
			</subjectPerson>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Weitere_x032x_Personen_x058x_">
		<xsl:for-each select=".">
			<subjectPerson>
				<xsl:value-of select="."/>
			</subjectPerson>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Regionen_x058x_">
		<xsl:for-each select=".">
			<subjectGeographic>
				<xsl:value-of select="."/>
			</subjectGeographic>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="Eigennamen_x058x_">
		<xsl:for-each select=".">
			<subjectName>
				<xsl:value-of select="."/>
			</subjectName>
		</xsl:for-each>
	</xsl:template><!--Template Titel-->
	<xsl:template match="Titel_x058x_">
		<xsl:choose>
			<xsl:when test="contains(.[1], ' : ')">
				<title>
					<xsl:value-of select="replace(.,'_','')"/><!--<xsl:value-of select=".[1]"/>-->
				</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(replace(.,'_','')[1], ' : '))"/><!--<xsl:value-of select="normalize-space(substring-before(.[1], ' : '))"/>-->
				</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ' : '))"/>
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
	</xsl:template><!--Template ZeitschriftenTitel-->
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
	</xsl:template><!--Template Herausgeberinnen Mitarbeiterinnen-->
	<xsl:template match="Hrsg_x046x__x047x_Mitarbeit_x058x_">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="(contains(.,'[Red.]'))       or (contains(.,'[Übers.]'))       or (contains(.,'[Mitarb.]'))       or (contains(.,'[Einl..]'))       or (contains(.,'[Vorw.]'))">
					<contributor>
						<xsl:value-of select="."/>
					</contributor>
				</xsl:when>
				<xsl:when test="contains(.,'[Hrsg.]')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'['))"/>
					</editor>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template><!--Template Körperschaften entity-->
	<xsl:template match="K_x148x_rpersch_x046x_Hrsg_x046x__x058x_">
		<xsl:for-each select=".">
			<xsl:choose>
				<xsl:when test="contains(.,'[Hrsg.]')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'['))"/>
					</editor>
					<entity>
						<xsl:value-of select="normalize-space(substring-before(.,'['))"/>
					</entity>
				</xsl:when>
				<xsl:otherwise>
					<entity>
						<xsl:value-of select="."/>
					</entity>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template><!--Template Sprache_x058x_-->
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
	</xsl:template><!--ENDE_____________________________ENDE___________________________________ENDE--><!--ENDE_____________________________ENDE___________________________________ENDE--><!--ENDE_____________________________ENDE___________________________________ENDE-->
</xsl:stylesheet>
