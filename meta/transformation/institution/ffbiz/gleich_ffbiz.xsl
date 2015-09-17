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
			<xsl:apply-templates select="Objekt[1]/erfasstam" />
			<xsl:apply-templates select="Objekt" />
		</xsl:element>
	</xsl:template>



<xsl:template match="erfasstam">
	
	<xsl:for-each select="document('thesaurus.xml')/Thesaurus//concept">
	
	<xsl:if test="(notation|broader='1.1') or
			(notation|broader='1.2') or
			(notation|broader='1.3') or
			(notation|broader='1.10')">
		
	
	<xsl:element name="record">
	
	<vufind>
			<id>
				<xsl:value-of select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
				<!--<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')" />-->
				<xsl:text>ffbiz</xsl:text>
				</id>
			<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
			<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
			<recordType>
				<xsl:choose>
					<xsl:when test="contains(broader,'.')">
						<xsl:text>systematics</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>archive</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
			</recordType>	
			</vufind>
	
	<institution>
			<institutionShortname><xsl:text>FFBIZ-Archiv</xsl:text></institutionShortname>
			<institutionFull><xsl:text>Frauenforschungs-, -bildungs- und -informationszentrum FFBIZ e.V.</xsl:text></institutionFull>
			<institutionID><xsl:text>ffbiz</xsl:text></institutionID>
			<collection><xsl:text>ffbiz</xsl:text></collection>
			<isil><xsl:text>DE-B1535</xsl:text></isil>
			</institution>
	
	<dataset>
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<xsl:if test="not(contains(broader,'.'))">
				<format><xsl:text>Bestandsübersicht</xsl:text></format>
				</xsl:if>
			
			<title><xsl:value-of select="prefTerm" /></title>
			<title_short><xsl:value-of select="prefTerm" /></title_short>
			</dataset>
	
	<functions>
		<xsl:variable name="broader" select="broader" />
			<hierarchyFields>
				
				<hierarchy_top_id>
					<xsl:choose>
						<xsl:when test="contains(broader,'.')">
							<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
							</xsl:otherwise>
						</xsl:choose>
					<xsl:text>ffbiz</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:choose>
						<xsl:when test="contains(broader,'.')">
							<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="prefTerm" />
							</xsl:otherwise>
						</xsl:choose>
					</hierarchy_top_title>
				
				
				<!--<hierarchy_top_id>
					<xsl:value-of select="//concept[not(broader)]/notation" />
					<xsl:text>ffbiz</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="//concept[not(broader)]/notation" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="//concept[not(broader)]/prefTerm" />
					</hierarchy_top_title>-->
				
				<xsl:if test="contains(broader,'.')">
					
					<hierarchy_parent_id>
						<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
						<xsl:text>ffbiz</xsl:text>
						</hierarchy_parent_id>
					
					<hierarchy_parent_title>
						<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
						</hierarchy_parent_title>
					
					</xsl:if>
				
				<!--<xsl:if test="broader">
				<xsl:variable name="broader" select="broader"></xsl:variable>
				<hierarchy_parent_id>
					<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
					<xsl:text>ffbiz</xsl:text>
					</hierarchy_parent_id>
				
				<hierarchy_parent_title>
					<xsl:value-of select="//concept[notation=$broader]/notation" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
					</hierarchy_parent_title>
					</xsl:if>-->
				
				<is_hierarchy_id>
					<xsl:value-of select="translate(prefTerm,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
					<!--<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')" />-->
					<xsl:text>ffbiz</xsl:text>
					</is_hierarchy_id>
				
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="contains(prefTerm,'/')">
							<xsl:value-of select="normalize-space(substring-after(prefTerm,'/'))" />
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="prefTerm" />
							</xsl:otherwise>
						</xsl:choose>
					
					</is_hierarchy_title>
				
				<hierarchy_sequence>
					<xsl:value-of select="translate(notation, translate(.,'0123456789', ''), '')" />
						</hierarchy_sequence>
						
					</hierarchyFields>
				
				
				</functions>
	
		</xsl:element>
		
		</xsl:if>
		
		</xsl:for-each>
		
		
	</xsl:template>





<xsl:template match="Objekt">	
		<xsl:variable name="id" select="id" />
		
		<xsl:if test="not(objektart[text()='Zeitschriften'])">
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
					<xsl:when test="objektart[text()='Nachlässe']">
						<recordType>
							<xsl:text>archive</xsl:text>
							</recordType>
						</xsl:when>
					<xsl:otherwise>
						<recordType>
							<xsl:text>library</xsl:text>
							</recordType>
						</xsl:otherwise>
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
						
						<institutionID><xsl:text>ffbiz</xsl:text></institutionID>
						
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
			<!--<format><xsl:text>TEXT</xsl:text></format>-->

	<!--documentType-->
			<!--<documentType><xsl:text>Buch</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="Hauptsachtitel[1]" />			

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
			<xsl:apply-templates select="Auflage[1]" />
			
	<!--volume-->
			<xsl:apply-templates select="Band" />
			
	<!--Herkunft-->
			<!--<xsl:apply-templates select="Provenienz" />-->

<!--IDENTIFIER-->
	<!--ISBN-->
			<xsl:apply-templates select="ISBN" />

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
			<xsl:apply-templates select="Person" />
			<xsl:apply-templates select="Beitr_x132x_ge_x032x_von[1]" />
			
	<!--description-->
			<!--<xsl:apply-templates select="Bemerkung" />-->

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
			<!--<format><xsl:text>TEXT</xsl:text></format>-->

	<!--documentType-->
			<!--<documentType><xsl:value-of select="Bestand" /></documentType>-->
			<!--<documentType>Akte</documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="Titel[1]" />

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
			<!--<xsl:apply-templates select="Kontinent" />-->
			<!--<xsl:apply-templates select="Land_x047x_Region" />-->
			<xsl:apply-templates select="Person" />
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />	
				
	<!--description-->
			<xsl:apply-templates select="Enth_x132x_lt" />

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

	</xsl:element>
	
	<functions>
	
		<xsl:variable name="bestand" select="Bestand" />
		<xsl:variable name="broader" select="document('thesaurus.xml')/Thesaurus//concept[prefTerm=$bestand]/broader" />
		<xsl:variable name="name" select="document('thesaurus.xml')/Thesaurus//concept[notation=$broader]/prefTerm" />
		
		<hierarchyFields>
			
			<hierarchy_top_id>
				<xsl:value-of select="translate($name,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
				<xsl:text>ffbiz</xsl:text>
				</hierarchy_top_id>
			
			<hierarchy_top_title>
				<xsl:value-of select="$name" />
				</hierarchy_top_title>	
			
			<hierarchy_parent_id>
				<xsl:value-of select="translate(Bestand,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
				<xsl:text>ffbiz</xsl:text>
				</hierarchy_parent_id>
				
			<hierarchy_parent_title>
				<xsl:value-of select="Bestand" />
				</hierarchy_parent_title>
				
			<is_hierarchy_id>
				<xsl:value-of select="id" />	
				<xsl:text>ffbiz</xsl:text>
				</is_hierarchy_id>
				
			<is_hierarchy_title>
				<xsl:value-of select="Titel" />
				</is_hierarchy_title>
				
			<hierarchy_sequence>
				<xsl:value-of select="Titel" />
				</hierarchy_sequence>
						
			</hierarchyFields>
				
				
				</functions>
	
	
	</xsl:if>






	
	
	
	
	
	
	
	
	
	
	
	

<!--Ansichtskarten__________Ansichtskarten____________Ansichtskarten-->

<xsl:if test="objektart[text()='Ansichtskarten']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Bildmaterial</xsl:text></format>-->
				<format><xsl:text>Ansichtskarte</xsl:text></format>	
	<!--documentType-->
				<!--<documentType><xsl:value-of select="objektart" /></documentType>-->
				<!--<documentType><xsl:text>Ansichtskarte</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Einzeltitel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
			<xsl:apply-templates select="UrheberIn" />
	
	<!--edition-->
			<xsl:apply-templates select="Editions-Nr_x046x_[1]" />


<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
					
	<!--placeOfPublication Ortsangabe-->
	
	<!--publisher Verlagsangabe-->
			<xsl:apply-templates select="Druck_x047x_Verlag_x047x_Grafik" />		
	
	
	
<!--PHYSICAL INFORMATION-->
	
	<!--dimension Ausmaße-->
				<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />	
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Bemerkung" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="Bildbeschreibung"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />


	</xsl:element>
	</xsl:if>













<!--Fotografien________Fotografien____________Fotografien-->

<xsl:if test="objektart[text()='Fotografien']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Bildmaterial</xsl:text></format>	-->
				<format><xsl:text>Fotografie</xsl:text></format>			
	<!--documentType-->
				<!--<documentType><xsl:value-of select="objektart" /></documentType>-->
				<!--<documentType><xsl:text>Fotografie</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Einzeltitel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
			<xsl:apply-templates select="UrheberIn" />
	
	<!--provenance Privinienz-->
			<xsl:apply-templates select="Provenienz" />
			
<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
			<xsl:apply-templates select="freie_x032x_Datumseingabe" />

	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	

<!--PHYSICAL INFORMATION-->
	
	<!--dimension Ausmaße-->
				<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />	
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Bemerkung[1]" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="Bildbeschreibung"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>
	</xsl:if>
	




<!--Buttons und Sticker________Buttons und Sticker____________Buttons und Sticker-->

<xsl:if test="objektart[text()='Buttons und Sticker']">

<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Bildmaterial</xsl:text></format>	-->
				<format><xsl:text>Objekte</xsl:text></format>			
	<!--documentType-->
				<!--<documentType><xsl:value-of select="objektart" /></documentType>-->
				<documentType><xsl:text>Buttons und Sticker</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Anlass_x047x_Ereignis_x047x_Thema" />

<!--RESPONSIBLE-->

	<!--entity Körperschaft / Organisation-->
			<xsl:apply-templates select="Veranstalt_x046x__x047x_Hrsg_x046x_" />
	
	<!--provenance Privinienz-->
			<xsl:apply-templates select="Provenienz" />
			
<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />
			
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	

<!--PHYSICAL INFORMATION-->
	
	<!--dimension Ausmaße-->
				<xsl:apply-templates select="Format" />	
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Farben" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="Bildbeschreibung"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>
	</xsl:if>
	
	
	
	
	
	
	
	
	
	
	
	
	

<!--Filme________Filme____________Filme-->

<xsl:if test="objektart[text()='Filme']">

<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Film</xsl:text></format>	-->
				<format><xsl:text>Film</xsl:text></format>		
	<!--documentType-->
				<!--<documentType><xsl:value-of select="objektart" /></documentType>-->
				<!--<documentType><xsl:text>Film</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Filmtitel" />

<!--RESPONSIBLE-->
	
	<!--provenance Privinienz-->
			<xsl:apply-templates select="Provenienz" />



<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />
			

<!--PHYSICAL INFORMATION-->
	
	<!--runTime Laufzeit CD-->
				<xsl:apply-templates select="L_x132x_nge" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
			<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="Bemerkung[1]"/>	
	
<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>
	</xsl:if>
	

















<!--Audios________Audios____________Audios-->

<xsl:if test="objektart[text()='Audios']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>ton</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Tonträger</xsl:text></format>	-->
				<format><xsl:text>Tonträger</xsl:text></format>		
	<!--documentType-->
				<xsl:if test="Tontr_x132x_ger">
					<documentType>
						<xsl:value-of select="Tontr_x132x_ger" />
						</documentType>
					</xsl:if>
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel_x047x_Thema" />

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--provenance Privinienz-->
			<xsl:apply-templates select="Provenienz" />
	<!--contributor Beteiligte Personen-->
			<xsl:apply-templates select="SprecherIn_x047x_S_x132x_ngerIn" />
		<!--contributor Beteiligte Personen-->
			<xsl:apply-templates select="Regie_x047x_Erstellung" />		
	

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />
			
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="Beschreibung"/>	
		
<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>
	</xsl:if>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


<!--Autographen________Autographen____________Autographen-->

<xsl:if test="objektart[text()='Autographen']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
			<!--<format><xsl:text>Autograf</xsl:text></format>-->
			<format><xsl:text>Autograf</xsl:text></format>

	<!--documentType-->
			<!--<documentType><xsl:text>Autograf</xsl:text></documentType>	-->
					
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Enth_x132x_lt" />

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Jahr_x047x_Datierung" />
	
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	
			
<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
				
	<!--description-->
				<xsl:apply-templates select="AdressatIn"/>	


<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>
	</xsl:if>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		


<!--Nachlässe________Nachlässe____________Nachlässe-->

<xsl:if test="objektart[text()='Nachlässe']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
			<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
			<format>
				<xsl:choose>
					<xsl:when test="Vorwort">
						<xsl:text>Nachlass / Vorlass</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>Akte</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</format>

	<!--documentType-->
<!--			<documentType>
				<xsl:choose>
					<xsl:when test="Vorwort">
						<xsl:text>Nachlass/Vorlass</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>Akte</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:choose>
					<xsl:when test="Vorwort">
						<xsl:apply-templates select="Bestand" />
						</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="Titel[1]" />
						</xsl:otherwise>
					</xsl:choose>

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="Bestandslaufzeit" />
			<!--<xsl:apply-templates select="Jahr_x047x_Datierung" />-->
			
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="Ort" />	

<!--PHYSICAL INFORMATION-->
	
	<!--dimension Ausmaße-->
				<xsl:apply-templates select="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm" />	
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Bemerkung" />
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="Umfang" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache" />
	
	<!--subject Deskriptoren-->
				<xsl:apply-templates select="Schlagworte_x032x_Archiv" />
				<!--<xsl:apply-templates select="Kontinent" />-->
				<!--<xsl:apply-templates select="Land_x047x_Region" />-->
				<xsl:apply-templates select="Person" />
	<!--description-->
				<xsl:apply-templates select="Vorwort"/>	
				<xsl:apply-templates select="Enth_x132x_lt"/>	
								
<!--OTHER-->

	<!--shelfMark Signatur-->
			<xsl:apply-templates select="Signatur" />

		</xsl:element>


	<functions>
	
		<xsl:variable name="bestand" select="Bestand" />
		<xsl:variable name="broader" select="document('thesaurus.xml')/Thesaurus//concept[prefTerm=$bestand]/broader" />
		<xsl:variable name="name" select="document('thesaurus.xml')/Thesaurus//concept[notation=$broader]/prefTerm" />
		
		<hierarchyFields>
			
			<hierarchy_top_id>
				<xsl:value-of select="translate($name,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
				<xsl:text>ffbiz</xsl:text>
				</hierarchy_top_id>
			
			<hierarchy_top_title>
				<xsl:value-of select="$name" />
				</hierarchy_top_title>	
			
			<!--<hierarchy_parent_id>
				<xsl:value-of select="translate($name,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:value-of>
				<xsl:text>ffbiz</xsl:text>
				</hierarchy_parent_id>
				
			<hierarchy_parent_title>
				<xsl:value-of select="$name" />
				</hierarchy_parent_title>-->
			
			<hierarchy_parent_id>
				<xsl:value-of select="translate(Bestand,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />	
				<xsl:text>ffbiz</xsl:text>
				</hierarchy_parent_id>
				
			<hierarchy_parent_title>
				<xsl:value-of select="Bestand" />
				</hierarchy_parent_title>
				
			<is_hierarchy_id>
				<xsl:value-of select="id" />	
				<xsl:text>ffbiz</xsl:text>
				</is_hierarchy_id>
				
			<is_hierarchy_title>
				<xsl:value-of select="Titel" />
				</is_hierarchy_title>
				
			<hierarchy_sequence>
				<xsl:value-of select="Titel" />
				</hierarchy_sequence>
						
			</hierarchyFields>
				
				
				</functions>


	</xsl:if>
















<!--Plakate________Plakate____________Plakate-->

<xsl:if test="objektart[text()='Plakate']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Bildmaterial</xsl:text></format>-->
				<format><xsl:text>Plakat</xsl:text></format>				
	<!--documentType-->
				<!--<documentType><xsl:text>Plakat</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="Titel[1]" />

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
	
	<xsl:template match="Beitr_x132x_ge_x032x_von">
		<xsl:for-each select="../Beitr_x132x_ge_x032x_von">
			<contributor>
				<xsl:value-of select="normalize-space(substring-before(.,':'))" />
				</contributor>
			</xsl:for-each>	
		<!--<description>
			<xsl:for-each select="../Beitr_x132x_ge_x032x_von">
				<xsl:value-of select="." />
				</xsl:for-each>
			</description>-->
		
		<xsl:for-each select="../Beitr_x132x_ge_x032x_von">
			<listOfContents>
				<xsl:value-of select="." />
				</listOfContents>
			</xsl:for-each>
			
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="." />
			</isbn>
		</xsl:template>
	
	<xsl:template match="AdressatIn">
		<description>
			<xsl:text>AdressatIn: </xsl:text>
				<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Eigenh_x132x_nd_x046x__x032x_Unterschrift">
				<xsl:text> - Unterschrift: </xsl:text>
				<xsl:value-of select="normalize-space(../Eigenh_x132x_nd_x046x__x032x_Unterschrift)" />
				</xsl:if>
			<xsl:if test="../Karte">
				<xsl:text> - Karte: </xsl:text>
				<xsl:value-of select="normalize-space(../Karte)" />
				</xsl:if>
			</description>
		</xsl:template>
	
	<xsl:template match="Farben">
		<specificMaterialDesignation>
			<xsl:value-of select="normalize-space(.)" />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="Format">
		<dimension>
			<xsl:value-of select="normalize-space(.)" />
			</dimension>
		</xsl:template>
	
	<xsl:template match="Breite_x032x_x_x032x_H_x148x_he_x032x_in_x032x_cm">
		<dimension>
			<xsl:if test="../Format">
				<xsl:value-of select="../Format" />
				<xsl:text> - </xsl:text>
				</xsl:if>
			<xsl:value-of select="." />
			</dimension>
		</xsl:template>
	
	<xsl:template match="Beschreibung">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="Bildbeschreibung">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
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
	
	<xsl:template match="Vorwort">
		<description>
			<xsl:value-of select="." />
			<xsl:if test="../Enth_x132x_lt">
				<xsl:text> Enthält: </xsl:text>
				<xsl:value-of select="../Enthält"></xsl:value-of>
				</xsl:if>
			</description>
		</xsl:template>
	
	<xsl:template match="Enth_x132x_lt">
		<xsl:choose>
			<xsl:when test="../objektart[text()='Autographen']">
				<title>
					<xsl:value-of select="normalize-space(.)" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
					</title_short>
				</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(../Vorwort)">
				<description>
					<xsl:value-of select="." />
					</description>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
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
		<xsl:choose>
			<xsl:when test="../objektart[text()='Ansichtskarten']">
				<specificMaterialDesignation>
					<xsl:if test="../Bildfarbe"><xsl:value-of select="../Bildfarbe" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:value-of select="." />
					</specificMaterialDesignation>
				</xsl:when>
			<xsl:when test="../objektart[text()='Fotografien']">
				<specificMaterialDesignation>
					<xsl:if test="../Fototyp"><xsl:value-of select="../Fototyp" />
						<xsl:text> - </xsl:text>
						</xsl:if>					
					<xsl:if test="../Bildfarbe"><xsl:value-of select="../Bildfarbe" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:for-each select="../Bemerkung">
						<xsl:value-of select="." />
						<xsl:text> - </xsl:text>
						</xsl:for-each>
					<!--<xsl:value-of select="." />-->
					</specificMaterialDesignation>
				</xsl:when>
			<xsl:when test="../objektart[text()='Nachlässe']">
				<specificMaterialDesignation>
					<xsl:value-of select="." />
					</specificMaterialDesignation>
				</xsl:when>
			<xsl:when test="../objektart[text()='Filme']">
				<description>
					<xsl:for-each select="../Bemerkung">
						<xsl:value-of select="." />
						</xsl:for-each>
					<xsl:if test="../Erscheinungsform">
						<xsl:value-of select="../Erscheinungsform" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:if test="../Filmgenre">
						<xsl:value-of select="../Filmgenre" />
						<xsl:text> - </xsl:text>
						</xsl:if>					
					<xsl:value-of select="." />
					</description>
				</xsl:when>
			<xsl:otherwise>
				<description>
					<xsl:value-of select="." />
					</description>
				</xsl:otherwise>
			</xsl:choose>
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
	
	<xsl:template match="Editions-Nr_x046x_">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Signatur-Nummerierung">
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Signatur-Nummerierung" />
				</xsl:if>
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Person">
		<xsl:for-each select=".">
			<subjectPerson>
				<xsl:value-of select="." />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Schlagworte_x032x_Archiv">
		<xsl:for-each select=".">
			<!--<xsl:if test="not(contains(.,'Europa'))">-->
			<subjectTopic>
				<xsl:value-of select="." />
				</subjectTopic>
				<!--</xsl:if>-->
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
				<xsl:value-of select="lower-case(.)" />
				</language>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="L_x132x_nge">
		<runTime>
			<xsl:value-of select="normalize-space(.)" />
			</runTime>
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
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:otherwise>
			</xsl:choose>
		
		
		</xsl:template>
	
	<xsl:template match="Druck_x047x_Verlag_x047x_Grafik">
		<xsl:for-each select="tokenize(., ';')">
			<publisher>
				<xsl:value-of select="normalize-space(.)"/>
				</publisher>
			</xsl:for-each>
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
	
	<xsl:template match="freie_x032x_Datumseingabe">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="Bestandslaufzeit">
		<xsl:choose>	
			<xsl:when test="contains(.,'-')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					</publishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
					</publishDate>
				
				<!--<timeSpan>
					<timeSpanStart><xsl:value-of select="normalize-space(substring-before(.,'-'))" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="normalize-space(substring-after(.,'-'))" /></timeSpanEnd>
					</timeSpan>-->
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
	
	<xsl:template match="Jahr_x047x_Datierung">
		<xsl:choose>
			<xsl:when test="contains(.,'-')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-before(.,'-'))" />
					</publishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(.,'-'))" />
					</publishDate>
				<!--<timeSpan>
					<timeSpanStart><xsl:value-of select="normalize-space(substring-before(.,'-'))" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="normalize-space(substring-after(.,'-'))" /></timeSpanEnd>
					</timeSpan>-->
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
	
	<xsl:template match="Veranstalt_x046x__x047x_Hrsg_x046x_">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="."/>
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Regie_x047x_Erstellung">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="."/>
				<xsl:text> [Regie]</xsl:text>
				</contributor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="SprecherIn_x047x_S_x132x_ngerIn">
		<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="."/>
				<xsl:text> [Sprech.]</xsl:text>
				</contributor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Hrsg_x046x_">
		<xsl:for-each select=".">
			<editor>
				<xsl:value-of select="."/>
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="UrheberIn">
	<xsl:for-each select=".">	
		<xsl:choose>
			<xsl:when test="contains(.,'FotografIn unbekannt')">
				<contributorNoFacet>
					<xsl:value-of select="." />
					</contributorNoFacet>
				</xsl:when>
			<xsl:otherwise>
				<contributor>
					<xsl:value-of select="."/>
						<xsl:text> [Fotogr.]</xsl:text>
					</contributor>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!--<xsl:for-each select=".">
			<contributor>
				<xsl:value-of select="."/>
				<xsl:text> [Fotogr.]</xsl:text>
				</contributor>
			</xsl:for-each>-->
		</xsl:template>
	
	<xsl:template match="AutorIn">
		<xsl:for-each select=".">
			<author>
				<xsl:value-of select="."/>
				</author>
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
			<xsl:value-of select="replace(.,'_','')"/>
				</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="Titel_x132x_nderungen">
		<alternativeTitle>
			<xsl:value-of select="replace(.,'_','')"/>
				</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="Bestand">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Titel_x047x_Thema">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Titel_x032x_">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Filmtitel">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Anlass_x047x_Ereignis_x047x_Thema">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		</xsl:template>
	
	<xsl:template match="Einzeltitel">
		<title>
			<xsl:value-of select="replace(.,'_','')"/>
			<xsl:if test="../Untertitel!=''">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of select="replace(.,'_','')"/>
			</title_short>
		<xsl:if test="../Untertitel!=''">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
				</title_sub>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Hauptsachtitel">
		<title>
			<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
			<xsl:if test="../Untertitel!=''">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of select="replace(normalize-space(.),'_','')"/>
			</title_short>
		<xsl:if test="../Untertitel!=''">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
				</title_sub>
			</xsl:if>
		</xsl:template>
	
</xsl:stylesheet>
