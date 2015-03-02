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
	<xsl:template match="STICHWORT">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


<xsl:template match="Objekt">	

<!--Umwandlungen werden nur bei diesem Objektarten durchgeführt-->
		<!--<xsl:if test="(Objektart[text()='Bücher u. Graue Literatur']) or (Objektart[text()='Beiträge in Sammelwerken'])">-->
		<!--<xsl:if test="Objektart[text()='Zeitschriften']">-->

		<xsl:variable name="id" select="Objektnummer" />
		<xsl:element name="record">
			<xsl:attribute name="id">
				<xsl:value-of select="$id" />
			</xsl:attribute>	
	
	
	
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="Objektnummer" />
					<xsl:text>stichwort</xsl:text>
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
							<xsl:text>Stichwort</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>STICHWORT, Archiv der Frauen- und Lesbenbewegung, Bibliothek · Dokumentation · Multimedia</xsl:text>
							</institutionFull>
			
<!--collection-->				<collection><xsl:text>Stichwort</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>AT-STICHWORT</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/oesterreich/stichwort/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>48.197364</latitude>
							<longitude>16.370382</longitude>
							</geoLocation>
			
</xsl:element>


	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		<!--
	0. Erklärung _ für einige Operationen wandle ich Angaben in Variablen um. FAUST kann das Datum nur
		auf eine Weise ausgeben [30.04.1982], so dass dieses nachträglich für MARC angepasst
		werden muss [820430] -->
	
		<!--Variable für die Ausgabe des Datums _ hier wird das Tagesdatum verwendet-->
			<xsl:variable name="date" select="Erfassungsdatum"/>
		<!--Variable für die Ausgabe des Änderungsdatums-->
			<xsl:variable name="change" select="Erfassungsdatum"/>
		<xsl:variable name="s_sachtitel" select="translate(in_x058x_[1], translate(.,'0123456789', ''), '')"/>






<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	










<!--Buch__________________________Monographie___________________________Sammelband-->


<xsl:if test="Objektart[text()='Bücher u. Graue Literatur']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format-->
				<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="enth_x132x_lt_x058x_!=''">
						<documentType>
							<xsl:text>Sammelband</xsl:text>
							</documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType>
						<xsl:text>Monografie</xsl:text>
							</documentType>
						</xsl:otherwise>
					</xsl:choose>

<!--TITLE-->
	
	<!--title-->
				<xsl:apply-templates select="Titel" />
				
<!--RESPONSIBLE-->
	
	<!--author-->
				<xsl:apply-templates select="Autorin_x032x_1" />
				<xsl:apply-templates select="Autorin_x032x_2" />
				<xsl:apply-templates select="et_al" />
	<!--editor-->
				<xsl:apply-templates select="Hg_x046x__x032x_von" />
	<!--contributor-->
				<xsl:apply-templates select="_x154x_bersetzung" />
	<!--series-->
				<xsl:apply-templates select="Reihe" />

<!--IDENTIFIER-->

	<!--isbn issn-->
				<xsl:apply-templates select="ISBN_x047x_ISSN" />

<!--PUBLISHING-->		

	<!--displayPublishDate-->
				<xsl:apply-templates select="Jahr" />
	<!--placeOfPublication-->
				<xsl:apply-templates select="Ort" />
	<!--publisher-->
				<xsl:apply-templates select="Verlag" />

<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="Seiten" />
				
<!--CONTENTRELATED INFORMATION-->
	
	<!--language-->
				<xsl:apply-templates select="Sprache" />
	<!--subjectTopic-->
				<xsl:apply-templates select="Schlagw_x148x_rter_x032x__x040x_autom_x046x__x032x_aus_x032x_Deskr_x046x__x041x_"></xsl:apply-templates>

<!--OTHER-->
	
	<!--shelfMark-->		
				<xsl:apply-templates select="Signatur" />

	</xsl:element>

	<xsl:if test="enth_x132x_lt_x058x_[1]!=''">
		<xsl:apply-templates select="enth_x132x_lt_x058x_[1]" />
		</xsl:if>
		
</xsl:if>

	
	
	


<!--Beiträge in Sammelwerken__________________________Beiträge in Sammelwerken___________________________Beiträge in Sammelwerken-->


<xsl:if test="Objektart[text()='Beiträge in Sammelwerken']">

<xsl:element name="dataset">

<!--FORMAT-->
	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format-->
				<format><xsl:text>Artikel</xsl:text></format>
	<!--documentType-->
				<documentType><xsl:text>Beiträge in Sammelwerken</xsl:text></documentType>
				
<!--TITLE-->
	
	<!--title-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->

	<!--author-->
				<xsl:apply-templates select="Autorin_x032x_1" />
				<xsl:apply-templates select="Autorin_x032x_2" />
				<xsl:apply-templates select="et_al" />
	<!--editor-->
				<xsl:apply-templates select="Hg_x046x__x032x_von" />
	<!--contributor-->
				<xsl:apply-templates select="_x154x_bersetzung" />
	<!--series-->
				<xsl:apply-templates select="Reihe" />

<!--IDENTIFIER-->

	<!--isbn issn-->
				<xsl:apply-templates select="ISBN_x047x_ISSN" />

<!--PUBLISHING-->

	<!--displayPublishDate-->
				<xsl:apply-templates select="Jahr" />
	<!--placeOfPublication-->
				<xsl:apply-templates select="Ort" />
	<!--publisher-->
				<xsl:apply-templates select="Verlag" />
	<!--sourceInfo-->
				<xsl:variable name="relatedID" select="translate(in_x058x_, translate(.,'0123456789', ''), '')" />
				<sourceInfo>
					<xsl:value-of select="//Objekt[Objektnummer=$relatedID]/Titel" />
					<!--<xsl:text> (</xsl:text>
					<xsl:value-of select="Jahr" />
					<xsl:text>)</xsl:text>
					<xsl:if test="Seiten!=''">
						<xsl:text>,</xsl:text>
						<xsl:value-of select="Seiten" />
						</xsl:if>-->
					
					</sourceInfo>
				
	
				
<!--PHYSICAL INFORMATION-->

	<!--physical-->
				<xsl:apply-templates select="Seiten" />

<!--CONTENTRELATED INFORMATION-->

	<!--language-->
				<xsl:apply-templates select="Sprache" />
	<!--subjectTopic-->
				<xsl:apply-templates select="Schlagw_x148x_rter_x032x__x040x_autom_x046x__x032x_aus_x032x_Deskr_x046x__x041x_"></xsl:apply-templates>

<!--OTHER-->

	<!--shelfMark-->		
				<xsl:apply-templates select="Signatur" />

</xsl:element>

<!--	<xsl:if test="in_x058x_[1]!=''">-->
		<xsl:apply-templates select="in_x058x_" />
		<!--</xsl:if>-->
		
</xsl:if>

	


<!--Zeitschriften__________________________Zeitschriften___________________________Zeitschriften-->


<xsl:if test="Objektart[text()='Zeitschriften']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format-->
				<format><xsl:text>Zeitschrift</xsl:text></format>
	<!--documentType-->
				<documentType><xsl:text>Zeitschriftenheft</xsl:text></documentType>

<!--TITLE-->

	<!--title-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->

	<!--author-->
				<xsl:apply-templates select="Autorin_x032x_1" />
				<xsl:apply-templates select="Autorin_x032x_2" />
				<xsl:apply-templates select="et_al" />
	<!--editor-->
				<xsl:apply-templates select="Hg_x046x__x032x_von" />
	<!--contributor-->
				<xsl:apply-templates select="_x154x_bersetzung" />
	<!--series-->
				<xsl:apply-templates select="Reihe" />

<!--IDENTIFIER-->

	<!--isbn issn-->
				<xsl:apply-templates select="ISBN_x047x_ISSN" />

<!--PUBLISHING-->

	<!--displayPublishDate-->
				<xsl:apply-templates select="Jahr" />
	<!--placeOfPublication-->
				<xsl:apply-templates select="Ort" />
	<!--publisher-->
				<xsl:apply-templates select="Verlag" />

<!--PHYSICAL INFORMATION-->

	<!--physical-->
				<xsl:apply-templates select="Seiten" />
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="Reihe" />
					<!--<xsl:text> (</xsl:text>
					<xsl:value-of select="Jahr" />
					<xsl:text>)</xsl:text>
					<xsl:value-of select="Band-Nr_x046x_" />-->
					</sourceInfo>

<!--CONTENTRELATED INFORMATION-->
	
	<!--language-->
				<xsl:apply-templates select="Sprache" />
	<!--subjectTopic-->
				<xsl:apply-templates select="Schlagw_x148x_rter_x032x__x040x_autom_x046x__x032x_aus_x032x_Deskr_x046x__x041x_"></xsl:apply-templates>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue-->
				<xsl:apply-templates select="Band-Nr_x046x_" />
	<!--volume-->
				<xsl:apply-templates select="Jg_x046x_" />

<!--OTHER-->

	<!--shelfMark-->		
				<xsl:apply-templates select="Signatur" />

</xsl:element>

	<xsl:if test="enth_x132x_lt_x058x_[1]!=''">
		<xsl:apply-templates select="enth_x132x_lt_x058x_[1]" />
		</xsl:if>
		
</xsl:if>





<!--Artikel in Zeitschriften__________________________Artikel in Zeitschriften___________________________Artikel in Zeitschriften-->


<xsl:if test="Objektart[text()='Artikel in Zeitschriften']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format-->
				<format><xsl:text>Artikel</xsl:text></format>
	<!--documentType-->
				<documentType><xsl:text>Artikel in Zeitschriften</xsl:text></documentType>

<!--TITLE-->
	
	<!--title-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->

	<!--author-->
				<xsl:apply-templates select="Autorin_x032x_1" />
				<xsl:apply-templates select="Autorin_x032x_2" />
				<xsl:apply-templates select="et_al" />
	<!--editor-->
				<xsl:apply-templates select="Hg_x046x__x032x_von" />
	<!--contributor-->
				<xsl:apply-templates select="_x154x_bersetzung" />
	<!--series-->
				<xsl:apply-templates select="Reihe" />

<!--IDENTIFIER-->

	<!--isbn issn-->
				<xsl:apply-templates select="ISBN_x047x_ISSN" />

<!--PUBLISHING-->		

	<!--displayPublishDate-->
				<xsl:apply-templates select="Jahr" />
	<!--placeOfPublication-->
				<xsl:apply-templates select="Ort" />
	<!--publisher-->
				<xsl:apply-templates select="Verlag" />
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="Reihe" />
					<!--<xsl:text> (</xsl:text>
					<xsl:value-of select="Jahr" />
					<xsl:text>)</xsl:text>
					<xsl:value-of select="Band-Nr_x046x_" />
					<xsl:text>, </xsl:text>
					<xsl:value-of select="Seiten" />-->
					</sourceInfo>
	
<!--PHYSICAL INFORMATION-->

	<!--physical-->
				<xsl:apply-templates select="Seiten" />

<!--CONTENTRELATED INFORMATION-->

	<!--language-->
				<xsl:apply-templates select="Sprache" />
	<!--subjectTopic-->
				<xsl:apply-templates select="Schlagw_x148x_rter_x032x__x040x_autom_x046x__x032x_aus_x032x_Deskr_x046x__x041x_"></xsl:apply-templates>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->
				<xsl:apply-templates select="Jg_x046x_" />
	<!--volume Band-->
				<xsl:apply-templates select="Band-Nr_x046x_" />
<!--OTHER-->

	<!--shelfMark-->		
				<xsl:apply-templates select="Signatur" />

</xsl:element>

<!--	<xsl:if test="in_x058x_[1]!=''">-->
		<xsl:apply-templates select="in_x058x_" />
		<!--</xsl:if>-->
		
</xsl:if>

	


			
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->

		</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>
	
	
<!--Templates-->
		
		<xsl:template match="Band-Nr_x046x_">
				<issue>
					<xsl:value-of select="." />
					</issue>
			
			<!--<xsl:choose>
				<xsl:when test="../Objektart='Zeitschriften'">
					<issue>
						<xsl:value-of select="." />
						</issue>
					</xsl:when>
				<xsl:when test="../Objektart=''Artikel in Zeitschriften'">
					<issue>
						<xsl:value-of select="." />
						</issue>
					</xsl:when>
				</xsl:choose>-->
			</xsl:template>
		
		<xsl:template match="Jg_x046x_">
			<volume>
				<xsl:value-of select="." />
				</volume>
			</xsl:template>
		
		<xsl:template match="in_x058x_">
			<xsl:variable name="relatedID" select="translate(., translate(.,'0123456789', ''), '')" />
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="$relatedID" /><xsl:text>stichwort</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="//Objekt[Objektnummer=$relatedID]/Titel" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID" /><xsl:text>stichwort</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="//Objekt[Objektnummer=$relatedID]/Titel" /></hierarchy_parent_title>
					
					
					<is_hierarchy_id><xsl:value-of select="../Objektnummer" /><xsl:text>stichwort</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Titel" /></is_hierarchy_title>
				
					<hierarchy_sequence>
						<xsl:value-of select="normalize-space(substring(../Titel,1,3))"/>
						</hierarchy_sequence>
				
					</hierarchyFields>
				</functions>
			</xsl:template>
		
		<xsl:template match="Schlagw_x148x_rter_x032x__x040x_autom_x046x__x032x_aus_x032x_Deskr_x046x__x041x_">
			<xsl:for-each select=".">
				<subjectTopic>
					<xsl:value-of select="." />
					</subjectTopic>
				</xsl:for-each>
			</xsl:template>
		
		<xsl:template match="enth_x132x_lt_x058x_">
			<xsl:variable name="relatedID" select="translate(., translate(.,'0123456789', ''), '')" />
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="../Objektnummer" /><xsl:text>stw</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Titel" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="../Objektnummer" /><xsl:text>stw</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Titel" /></is_hierarchy_title>
				
					</hierarchyFields>
				</functions>
			</xsl:template>
		
		<xsl:template match="ISBN_x047x_ISSN">
			<xsl:choose>
				<xsl:when test="../Objektart='Bücher u. Graue Literatur'">
					<isbn>
						<xsl:value-of select="." />
						</isbn>
					</xsl:when>
				<xsl:when test="../Objektart='Zeitschriften'">
					<issn>
						<xsl:value-of select="." />
						</issn>
					</xsl:when>
				</xsl:choose>
			</xsl:template>
		
		<xsl:template match="Verlag">
			<publisher>
				<xsl:value-of select="." />
				</publisher>
			</xsl:template>
		
		<xsl:template match="Ort">
			<placeOfPublication>
				<xsl:value-of select="." />
				</placeOfPublication>
			</xsl:template>
		
		<xsl:template match="_x154x_bersetzung">
			<xsl:for-each select=".">
				<contributor>
					<xsl:value-of select="." />
					<xsl:text> [Übers.]</xsl:text>
					</contributor>
				</xsl:for-each>
			</xsl:template>
		
		<xsl:template match="Sprache">
			<xsl:if test="contains(.,'deutsch')">
				<language>deutsch</language>
				</xsl:if>
			<xsl:if test="contains(.,'engl.')">
				<language>englisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'franz.')">
				<language>französisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'ital.')">
				<language>italienisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'finn.')">
				<language>finnisch</language></xsl:if>
			<xsl:if test="contains(.,'niederländ.')">
				<language>niederländisch</language></xsl:if>
			<xsl:if test="contains(.,'dän.')">
				<language>dänisch</language></xsl:if>
			<xsl:if test="contains(.,'bask.')">
				<language>baskisch</language></xsl:if>
			<xsl:if test="contains(.,'türk.')">
				<language>türkisch</language></xsl:if>
			<xsl:if test="contains(.,'tschech.')">
				<language>tschechisch</language></xsl:if>
			<xsl:if test="contains(.,'serb..')">
				<language>serbisch</language></xsl:if>
			<xsl:if test="contains(.,'poln.')">
				<language>polnisch</language></xsl:if>
			<xsl:if test="contains(.,'slowak.')">
				<language>slowakisch</language></xsl:if>
			<xsl:if test="contains(.,'ungar.')">
				<language>ungarisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'span.')">
				<language>spanisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'russ.')">
				<language>russisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'slowen.')">
				<language>slowenisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'norweg.')">
				<language>norwegisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'schwed.')">
				<language>schwedisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'japan.')">
				<language>japanisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'ohne')">
				<language>o.A.</language>
				</xsl:if>
			<xsl:if test="contains(.,'katalan.')">
				<language>katalanisch</language>
				</xsl:if>
			<xsl:if test="contains(.,'lat.')">
				<language>latein</language>
				</xsl:if>
			<xsl:if test="contains(.,'mhd.')">
				<language>mittelhochdeutsch</language>
				</xsl:if>
			<xsl:if test="contains(.,'portug.')">
				<language>portugiesisch</language>
				</xsl:if>	
			<xsl:if test="contains(.,'portug.')">
				<language>portugiesisch</language>
				</xsl:if>				
			
			</xsl:template>
		
		<xsl:template match="Seiten">
			<physical>
				<xsl:value-of select="." />
				</physical>
			</xsl:template>
		
		<xsl:template match="Jahr">
			<displayPublishDate>
				<xsl:value-of select="." />
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
				</publishDate>
			</xsl:template>
		
		<xsl:template match="Reihe">
			<series>
				<xsl:value-of select="." />
				</series>
			</xsl:template>
		
		<xsl:template match="Hg_x046x__x032x_von">
			<xsl:for-each select=".">
				<xsl:choose>
					<xsl:when test="contains(.,'/')">
						<editor>
							<xsl:value-of select="normalize-space(substring-before(.,'/'))" />
							</editor>
						</xsl:when>
					<xsl:when test="(contains(.,'N, N.')) or (contains(.,'N., N.'))">
					<!--<editor>
						<xsl:text>o.A.</xsl:text>
						</editor>-->
					</xsl:when>
					<xsl:otherwise>
						<editor>
							<xsl:value-of select="." />
							</editor>
							</xsl:otherwise>
					</xsl:choose>
				
				</xsl:for-each>
			</xsl:template>
		
		<xsl:template match="Titel">
						<title>
							<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(replace(.,'_',''))"/>	
							</title_short>
			
			<!--<xsl:choose>
				<xsl:when test="contains(., '.')">
					<title>
						<xsl:value-of select="."/>
						</title>
					<title_short>
						<xsl:value-of select="normalize-space(substring-before(., '.'))"/>
						</title_short>
					<xsl:if test="substring-after(.,'.')!=''">
					<title_sub>
						<xsl:value-of select="normalize-space(substring-after(., '.'))"/>
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
					</xsl:choose>-->
			</xsl:template>
		
		<xsl:template match="et_al">
			<xsl:for-each select=".">
				<xsl:choose>
					<xsl:when test="contains(.,'Hg.')">
						<editor>
							<xsl:value-of select="normalize-space(substring-before(.,'/'))" />
							</editor>
						</xsl:when>
					<xsl:otherwise>
						<author>
							<xsl:value-of select="." />
							</author>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:template>
		
		<xsl:template match="Autorin_x032x_2">
			<xsl:choose>
				<xsl:when test="contains(.,'Hg.')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'/'))" />
						</editor>
					</xsl:when>
				<xsl:when test="(contains(.,'N, N.')) or (contains(.,'N., N.'))">
					<!--<author>
						<xsl:text>o.A.</xsl:text>
						</author>-->
					</xsl:when>
				<xsl:otherwise>
					<author>
						<xsl:value-of select="." />
						</author>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:template>
		
		<xsl:template match="Autorin_x032x_1">
			<xsl:choose>
				<xsl:when test="contains(.,'Hg.')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'/'))" />
						</editor>
					</xsl:when>
				<xsl:when test="(contains(.,'N, N.')) or (contains(.,'N., N.'))">
					<!--<author>
						<xsl:text>o.A.</xsl:text>
						</author>-->
					</xsl:when>
				<xsl:otherwise>
					<author>
						<xsl:value-of select="." />
						</author>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:template>
		
		<xsl:template match="Signatur">
			<shelfMark>
				<xsl:value-of  select="." />
				<xsl:text> </xsl:text>
				<xsl:value-of select="../Sign_x046x_-Nr_x046x_" />
				</shelfMark>
			</xsl:template>
		
		

</xsl:stylesheet>
