<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" exclude-result-prefixes="xs xdt err fn" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors">
	<xsl:output method="xml" indent="yes"/>
	<!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="genderbib">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


<!--Template Deskriptoren-->
	<xsl:template match="Deskriptoren1" name="deskriptor" priority="1">
		<xsl:choose>
			<xsl:when test="(contains(.[1], ';')) and (.[1]!='')">
				<xsl:for-each select="tokenize(.[1], ';')">
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)"/>
					</subjectTopic>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test=".[1] and (.[1]!='')">
				<subjectTopic>
					<xsl:value-of select=".[1]"/>
				</subjectTopic>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>	

<!--Template Personen-->
	<xsl:template match="Personen">
		<xsl:choose>
			<xsl:when test="(contains(.[1], ';')) and (.[1]!='')">
				<xsl:for-each select="tokenize(.[1], ';')">
					<subjectPerson>
						<xsl:value-of select="normalize-space(.)"/>
					</subjectPerson>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test=".[1] and (.[1]!='')">
				<subjectPerson>
					<xsl:value-of select=".[1]"/>
				</subjectPerson>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Autorin-->	
	<xsl:template match="Autorin[1]">
		<xsl:choose>
			<xsl:when test="contains(.[1], ';')">
				<xsl:for-each select="tokenize(.[1], ';')">
					<author>
						<xsl:value-of select="normalize-space(.)"/>
					</author>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test=".[1]">
				<author>
					<xsl:value-of select="."/>
				</author>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Herausgeberinnen-->
	<xsl:template match="Hrsg_[1]">
		<xsl:choose>
			<xsl:when test="contains(.[1], ';')">
				<xsl:for-each select="tokenize(.[1], ';')">
					<editor>
						<xsl:value-of select="normalize-space(.)"/>
					</editor>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<editor>
					<xsl:value-of select="."/>
				</editor>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--Template Titel-->
	<xsl:template match="Titel">
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
	
<!--Template Einzeltitel-->
	<xsl:template match="Einzeltitel[1]">
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

<!--Template Sachtitel-->
	<xsl:template match="Sachtitel[1]">
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

<!--Template Ortsangabe-->
	<xsl:template match="Ort[1]">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(.[1], 'o.A.'))">
				<placeOfPublication>
					<xsl:text>o.A.</xsl:text>
				</placeOfPublication>
			</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(.[1], ';')">
						<xsl:for-each select="tokenize(.[1], ';')">
							<placeOfPublication>
								<xsl:value-of select="normalize-space(.)"/>
							</placeOfPublication>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<placeOfPublication>
							<xsl:value-of select="normalize-space(.[1])"/>
						</placeOfPublication>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Erscheinungs Ortsangabe-->
	<xsl:template match="Ersch_-ort[1]">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(.[1], 'o.A.'))">
				<placeOfPublication>
					<xsl:text>o.A.</xsl:text>
				</placeOfPublication>
			</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(.[1], ';')">
						<xsl:for-each select="tokenize(.[1], ';')">
							<placeOfPublication>
								<xsl:value-of select="normalize-space(.)"/>
							</placeOfPublication>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<placeOfPublication>
							<xsl:value-of select="normalize-space(.[1])"/>
						</placeOfPublication>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Verlagsangabe-->
	<xsl:template match="Verlag[1]">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(.[1], 'o.A.'))">
				<publisher>
					<xsl:text>o.A.</xsl:text>
				</publisher>
			</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(.[1], ';')">
						<xsl:for-each select="tokenize(.[1], ';')">
							<publisher>
								<xsl:value-of select="normalize-space(.)"/>
							</publisher>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<publisher>
							<xsl:value-of select="normalize-space(.[1])"/>
						</publisher>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Jahr-->
	<xsl:template match="Jahr[1]">
		<xsl:variable name="jear" select=".[1]" />
			<xsl:choose>
				<xsl:when test="string-length($jear) &gt; 7">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')" />
					</publishDate>
					<publishDate>
						<xsl:value-of select="substring-after(.[1], '/')" />
					</publishDate>
				</xsl:when>
				<xsl:when test="Jahr[1]=''">
					<publishDate>
						<xsl:text>o.A.</xsl:text>
					</publishDate>
				</xsl:when>
				<xsl:when test="(contains(.[1], '[')) or (contains(.[1], '(')) or (contains(.[1], 'ca'))">
					<publishDate>
						<xsl:value-of select="normalize-space(translate(.[1], translate(.,'0123456789', ''), ''))"/>
					</publishDate>
				</xsl:when>
				<xsl:when test="matches(.[1],'[a-z]')">
					<publishDate>
						<xsl:text>o.A.</xsl:text>
					</publishDate>
				</xsl:when>
				<xsl:when test="(matches(.[1],'/'))">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')" />
					</publishDate>
					<publishDate>
						<xsl:value-of select="substring(.[1], 1,2)"></xsl:value-of>
						<xsl:value-of select="substring-after(.[1], '/')" />
					</publishDate>
				</xsl:when>
				<xsl:otherwise>
					<publishDate>
						<xsl:value-of select=".[1]"/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

<!--Template Sprachangabe-->
	<xsl:template match="Sprache[1]">
		<xsl:choose>
			<xsl:when test="not(.)">
				<language>
					<xsl:text>o.A.</xsl:text>
				</language>
			</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(.[1], ';')">
						<xsl:for-each select="tokenize(.[1], ';')">
							<language>
								<xsl:value-of select="lower-case(normalize-space(.))"/>
							</language>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<language>
							<xsl:value-of select="lower-case(normalize-space(.[1]))"/>
						</language>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

<!--Template Hierarchy-->
	<xsl:template match="Sign_[1]">
			<xsl:variable name="shelfMark1">
				<xsl:choose>
					<xsl:when test="substring(.[1],1,3)='III'">
						<xsl:text>III</xsl:text>
					</xsl:when>
					<xsl:when test="(substring(.[1],1,4)='XVII') and (not(substring(.[1],1,5)='XVIII'))">
						<xsl:text>XVII</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable> 
			
			<xsl:variable name="shelfMark2">	
				<xsl:choose>
					<xsl:when test="contains(.[1], '/')">
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))"></xsl:value-of>
						<xsl:value-of select="normalize-space(substring(substring-after(.[1], '/'),1,2))" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$shelfMark1" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
				<hierarchy_top_id>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark1]/vufind/id" />
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark1]/dataset/title"/>	
				</hierarchy_top_title>
				
				<hierarchy_parent_id>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/vufind/id" />
				</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/dataset/title"/>
				</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="../id"/>
					<xsl:text>genderbib</xsl:text>
				</is_hierarchy_id>
				
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="../Sachtitel[1]"><xsl:value-of select="../Sachtitel[1]"/></xsl:when>
						<xsl:when test="../Sachtitel[1]"><xsl:value-of select="../Titel[1]"/></xsl:when>
						<xsl:when test="../Sachtitel[1]"><xsl:value-of select="../Einzeltitel[1]"/></xsl:when>
						<xsl:when test="../Sammeltitel[1]"><xsl:value-of select="../Sammeltitel[1]"/></xsl:when>
					</xsl:choose>
					
				</is_hierarchy_title>
	</xsl:template>






<!--Der Objektknoten-->
	<xsl:template match="datensatz">
	
	<!--Umwandlungen werden nur bei diesem Objektarten durchgeführt-->
		<!--<xsl:if test="(objektart[text()='Buch/Einzeltitel']) or (objektart[text()='Zeitschrift/Einzeltitel']) or (objektart[text()='Zeitschrift/Heftitel']) or (objektart[text()='Buch']) or (objektart[text()='Zeitschrift'])">-->
		<xsl:if test="objektart[text()='Buch']">
		<!--<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">-->
		<!--<xsl:if test="contains(objektart, 'Einzeltitel')">-->
		<xsl:variable name="id" select="id"/><!--Umwandlungen werden nur bei diesem Objektarten durchgeführt-->
		
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/>
				</xsl:attribute>
				
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->

<!--
	0. Erklärung _ für einige Operationen wandle ich Angaben in Variablen um. FAUST kann das Datum nur
		auf eine Weise ausgeben [30.04.1982], so dass dieses nachträglich für MARC angepasst
		werden muss [820430] -->
				<!--Variable für die Ausgabe des Datums-->
				<xsl:variable name="date" select="erfaßt_am-"/>
				<!--Variable für die Ausgabe des Änderungsdatums-->
				<xsl:variable name="change" select="geändert_am-"/>
				<!--Variable für die Beziehung zum Sachtitel-->
				<xsl:variable name="s_sachtitel" select="translate(s__Sachtitel[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="s_sachtitel_pur" select="s__Sachtitel[1]"/>
				<xsl:variable name="s_ST" select="translate(s_ST, translate(.,'0123456789', ''), '')"/>
				<!--<xsl:variable name="z-titel" select="Sachtitel" />-->
				<xsl:variable name="z-titel" select="Sachtitel[1]"/>
				<xsl:variable name="zdbid" select="ZDB-ID"/>
				<xsl:variable name="zeit">
					<xsl:value-of select="Sachtitel[1]" />
					<xsl:value-of select="ZDB-ID" />
				</xsl:variable>
				<!--Variable für den Zeitschriftentitel-->
				<xsl:variable name="z-titel_collon" select="normalize-space(substring-before(Sachtitel[1], ':'))"/>
				<!--Variable für die Ausgabe/Zerlegung des Datums in Zeitschriften Hefttiteln-->
				<xsl:variable name="z-ausgabe" select="Ausgabe"/>
				<!--Variable für die Beziehung zur Ausgaben bei den Zeitschriften-->
				<xsl:variable name="s_ausgabe" select="s__Ausgabe"/>
				<!--Variable für die Verknüpfung von Orten-->
				<xsl:variable name="rel" select="s__Sachtitel"/>
				<!--Variable für die Verknüpfung von Orten-->
				<xsl:variable name="obj" select="objektart"/>
				<!--Variable für das aktuelle Datum-->
				<xsl:variable name="currentDate" select="current-date()"/>


<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
	
		<!--0. Erklärung _ Ein Identifikator der durch das Programm Faust vergeben wird um Tag "genderbib" erweitert.
		So kann es nich mit anderen IDs aus anderen Einrichtungen zum Konflikt kommen-->
				<id>
					<xsl:value-of select="id"/>
					<xsl:text>genderbib</xsl:text>
				</id>

	<!--recordCreationDate-->
	
		<!--0. Erklärung _ Wenn das Feld erfaßt_am nicht leer ist, wandle in die Form JJMMTT um 
		ist das Feld leer, nehme den Wert des Tagesdatums und wandle um in JJMMTT-->
				<xsl:choose>
					<!--Wenn "erfaßt_am" erfüllt, dann bitte in die richtige Form bringen-->
					<xsl:when test="erfaßt_am- !=''">
						<recordCreationDate>
							<xsl:value-of select="substring(erfaßt_am-[1],9,2)"/><!--jahr-->
							<xsl:value-of select="substring(erfaßt_am-[1],4,2)"/><!--monat-->
							<xsl:value-of select="substring(erfaßt_am-[1],1,2)"/><!--tag-->
						</recordCreationDate>
					</xsl:when>
					
					<!--CurrentDate angeben, wenn erfaßt_am nicht angegeben ist-->
					<xsl:otherwise>
						<recordCreationDate>
							<xsl:value-of select="format-date($currentDate, '[Y01][M01][D01]')" />
						</recordCreationDate>
					</xsl:otherwise>
				</xsl:choose>
				
	<!--recordChangeDate-->
	
				<recordChangeDate>
					<xsl:value-of select="format-date($currentDate, '[Y01][M01][D01]')" />
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
	
	<!--institutionShortname-->		<institutionShortname>
							<xsl:text>Genderbibliothek</xsl:text>
						</institutionShortname>
	
	<!--institutionFullname-->		<institutionsFullname>
							<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
						</institutionsFullname>
			
	<!--collection-->			<collection><xsl:text>Bibliothekskatalog</xsl:text></collection>
	
	<!--isil-->				<isil>
							<xsl:text>DE-B1542</xsl:text>
						</isil>
	
	<!--linkToWebpage-->		<link>
							<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text>
						</link>
	
	<!--geoLocation-->			<geoLocation>
							<latitude>52.520326</latitude>
							<longitude>13.394218799999976</longitude>
						</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->


<!--Identifikator__________________local___________________Identifikator-->
	
		<!--
	1. Erklärung _ Verlinkungen im Bereich der Zeitschriften wird über den Titel durchgeführt-->
				<xsl:if test="(not(contains($z-titel, ':'))) and (objektart[text()='Zeitschrift'])">
					<z-titel>
						<xsl:value-of select="$z-titel"/>
					</z-titel>
				</xsl:if><!--
	2. Erklärung _ Verlinkung im Bereich der Zeitschriften über den Titel-->
				<xsl:if test="(contains($z-titel, ':')) and (objektart[text()='Zeitschrift'])">
					<z-titel-collon>
						<xsl:value-of select="$z-titel_collon"/>
					</z-titel-collon>
				</xsl:if>
				
				
		
				
<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->
				


<xsl:if test="objektart[text()='Buch']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Sachtitel[1]">
					<xsl:apply-templates select="Sachtitel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg_[1]">
					<xsl:apply-templates select="Hrsg_[1]" />
				</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
					</series>
				</xsl:if>
				<xsl:if test="Bd--ReihenNr_">
					<seriesNr>
						<xsl:value-of select="Bd--ReihenNr_"></xsl:value-of>
					</seriesNr>
				</xsl:if>
			
<!--format Objektartinformationen-->
				<xsl:choose>
					<xsl:when test="not(s__Aufsatz)">
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
				
<!--ISBN / ISSN-->
					<xsl:if test="ISBN !=''">
						<isbn>
							<xsl:value-of select="ISBN"/>
						</isbn>
					</xsl:if>
					
<!--displayDate-->
					<displayPublishDate>
						<xsl:value-of select="Jahr[1]" />
					</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]" />
				</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>
					
<!--physical Seitenangabe-->
					<xsl:if test="Seitenzahlen !=''">
						<physical>
							<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>
				
<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika" />
					</subjectGeographic>
				</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land" />
					</subjectGeographic>
				</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>
			
<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>
				
</xsl:element>

	<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<xsl:variable name="shelfMark1" select="normalize-space(substring-before(Sign_[1], '/'))" />
			<xsl:variable name="shelfMark2">
				<xsl:value-of select="normalize-space(substring-before(Sign_[1], '/'))"></xsl:value-of>
				<xsl:value-of select="normalize-space(substring(substring-after(Sign_[1], '/'),1,2))" />
			</xsl:variable>
			
			<xsl:apply-templates select="Sign_[1]" />
			
			<!--<xsl:if test="Sign_[1]">
				<hierarchy_top_id>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark1]/vufind/id" />
				</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark1]/dataset/title"/>	
				</hierarchy_top_title>
				
				<hierarchy_parent_id>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/vufind/id" />
				</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/dataset/title"/>
				</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="id"/>
					<xsl:text>genderbib</xsl:text>
				</is_hierarchy_id>
				
				<is_hierarchy_title>
					<xsl:value-of select="Sachtitel[1]"/>
				</is_hierarchy_title>
			</xsl:if>-->
			
			
		</xsl:element>
	
	</xsl:element>	
				
</xsl:if>

<!--Abschlussarbeit_____________________Abschlussarbeit_____________________Abschlussarbeit-->
<!--Abschlussarbeit_____________________Abschlussarbeit_____________________Abschlussarbeit-->
<!--Abschlussarbeit_____________________Abschlussarbeit_____________________Abschlussarbeit-->

<!--<xsl:if test="objektart[text()='Abschlussarbeit']">-->
<xsl:if test="(objektart[text()='Magistra/Magister Gender Studies']) or (objektart[text()='Abschlussarbeit'])">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Hochschularbeit</xsl:text>
				</format>

<!--documentType Dokumentinformation-->
				<xsl:if test="objektart[text()='Magistra/Magister Gender Studies']">
					<documentTyp>
						<xsl:text>Magistra/Magister Gender Studies</xsl:text>
					</documentTyp>
				</xsl:if>
				<xsl:if test="Dok-art">
					<documentTyp>
						<xsl:value-of select="Dok-art" />
					</documentTyp>
				</xsl:if>

<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]" />
				</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]" />
				</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
					</physical>
				</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika" />
					</subjectGeographic>
				</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land" />
					</subjectGeographic>
				</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>
</xsl:element>

</xsl:if>

<!--Artikel___________________________Artikel___________________________Artikel-->
<!--Artikel___________________________Artikel___________________________Artikel-->
<!--Artikel___________________________Artikel___________________________Artikel-->

<xsl:if test="objektart[text()='Artikel']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Einzeltitel!=''"><xsl:apply-templates select="Einzeltitel[1]" /></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Sammeltitel[1]" /></xsl:otherwise>
				</xsl:choose>
					
<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Artikel</xsl:text>
				</format>

<!--displayDate-->
					<displayPublishDate>
						<xsl:value-of select="Jahr[1]" />
					</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]" />
				</xsl:if>

<!--issue Heft-->
			<xsl:if test="Heft-Nr_">
				<issue>
					<xsl:value-of select="Heft-Nr_" />
				</issue>
			</xsl:if>

<!--volume Jahrgang-->
			<xsl:if test="Jg_">
				<xsl:for-each select="Jg_">
					<volume>
						<xsl:value-of select="." />
					</volume>
				</xsl:for-each>
			</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--physical Seitenangabe-->
					<xsl:if test="Seitenzahlen !=''">
						<physical>
							<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika" />
					</subjectGeographic>
				</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land" />
					</subjectGeographic>
				</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>

</xsl:element>

</xsl:if>

<!--Online-Artikel_________________________Online-Artikel_______________________Online-Artikel-->
<!--Online-Artikel_________________________Online-Artikel_______________________Online-Artikel-->
<!--Online-Artikel_________________________Online-Artikel_______________________Online-Artikel-->

<xsl:if test="objektart[text()='Online-Artikel']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Titel!=''"><xsl:apply-templates select="Titel[1]" /></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Sammeltitel[1]" /></xsl:otherwise>
				</xsl:choose>
					
<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>
				
<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
					</series>
				</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Artikel</xsl:text>
				</format>
					
<!--DisplayDate-->
				<xsl:choose>
					<xsl:when test="J_">
						<displayPublishDate>
							<xsl:value-of select="J_[1]" />
						</displayPublishDate>
					</xsl:when>
					<xsl:otherwise>
						<displayPublishDate>
							<xsl:value-of select="Jahr[1]" />
						</displayPublishDate>		
					</xsl:otherwise>
				</xsl:choose>
				
<!--publishDate Jahresangabe-->
				<xsl:choose>
					<xsl:when test="Jahr[1]"><xsl:apply-templates select="Jahr[1]" /></xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]" />
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>

<!--issue Heft-->
			<xsl:if test="H">
				<issue>
					<xsl:value-of select="H" />
				</issue>
			</xsl:if>

<!--volume Jahrgang-->
			<xsl:if test="Jg-">
				<volume>
					<xsl:value-of select="Jg-" />
				</volume>
			</xsl:if>


<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
					</physical>
				</xsl:if>

<!--runTime Laufzeit DVD-->

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika" />
					</subjectGeographic>
				</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land" />
					</subjectGeographic>
				</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>

<!--url Link zum Dokument-->
				<xsl:if test="Digitale_Dokumente">
					<url>
						<xsl:value-of select="Digitale_Dokumente" />
					</url>
				</xsl:if>

</xsl:element>

</xsl:if>

<!--Online-Zeitschrift_________________________Online-Zeitschrift_______________________Online-Zeitschrift-->
<!--Online-Zeitschrift_________________________Online-Zeitschrift_______________________Online-Zeitschrift-->
<!--Online-Zeitschrift_________________________Online-Zeitschrift_______________________Online-Zeitschrift-->

<xsl:if test="objektart[text()='Online-Zeitschrift']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Sachtitel[1], ':')">
							<title>
								<xsl:value-of select="Sachtitel[1]"/>
							</title>
							<title_short>
								<xsl:value-of select="normalize-space(substring-before(Sachtitel[1], ':'))"/>
							</title_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Sachtitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="Sachtitel[1]"/>
							</title>
							<title_short>
								<xsl:value-of select="Sachtitel[1]"/>
							</title_short>
						</xsl:otherwise>
					</xsl:choose>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>

<!--entity Körperschaft-->
				
<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
					</series>
				</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Zeitschrift</xsl:text>
				</format>
<!--ISBN / ISSN-->

				<xsl:if test="ISSN">
					<issn>
						<xsl:value-of select="ISSN" />
					</issn>
				</xsl:if>

<!--displayDate-->
				<xsl:choose>
					<xsl:when test="J_[2]">
						<displayPublishDate>
							<xsl:value-of select="J_[1]" />
							<xsl:text> - </xsl:text>
							<xsl:value-of select="J_[last()]" />
						</displayPublishDate>
					</xsl:when>
					<xsl:otherwise>
						<displayPublishDate>
							<xsl:value-of select="J_[1]" />
						</displayPublishDate>	
					</xsl:otherwise>
				</xsl:choose>	

<!--timeSpan Laufzeit / Publishdate-->
				<xsl:choose>
					<xsl:when test="J_[2]">
						<timeSpan>
							<timeSpanStart>
								<xsl:value-of select="J_[1]" />
							</timeSpanStart>
							<timeSpanEnd>
								<xsl:value-of select="J_[last()]" />
							</timeSpanEnd>
						</timeSpan>
					</xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]" />
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>	

<!--issue Heft-->
			<xsl:if test="H">
				<issue>
					<xsl:value-of select="H" />
				</issue>
			</xsl:if>

<!--volume Jahrgang-->
			<xsl:if test="Jg-">
				<xsl:for-each select="Jg-">
					<volume>
						<xsl:value-of select="." />
					</volume>
				</xsl:for-each>
			</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
			<xsl:if test="Geografika">
				<subjectGeographic>
					<xsl:value-of select="Geografika" />
				</subjectGeographic>
			</xsl:if>
			
			<xsl:if test="Land">
				<subjectGeographic>
					<xsl:value-of select="Land" />
				</subjectGeographic>
			</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>

<!--url Link zum Dokument-->
			<xsl:if test="Digitale_Dokumente">
				<url>
					<xsl:value-of select="Digitale_Dokumente" />
				</url>
			</xsl:if>

</xsl:element>

</xsl:if>

<!--Video/DVD____________________Video/DVD______________________________Video/DVD-->
<!--Video/DVD____________________Video/DVD______________________________Video/DVD-->
<!--Video/DVD____________________Video/DVD______________________________Video/DVD-->

<xsl:if test="objektart[text()='Video/DVD']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
					<xsl:text>Video</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Video / DVD</xsl:text>
				</format>

<!--displayDate-->
				<xsl:if test="Jahr">
					<displayPublishDate>
						<xsl:value-of select="Jahr" />
					</displayPublishDate>
				</xsl:if>	

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]" />
				</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--runTime Laufzeit DVD-->
				<xsl:if test="Laufzeit !=''">
					<runTime>
						<xsl:value-of select="Laufzeit"/>
					</runTime>
				</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]" />
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]" />
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika" />
					</subjectGeographic>
				</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land" />
					</subjectGeographic>
				</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen" />
				</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
					</shelfMark>
				</xsl:if>

</xsl:element>

</xsl:if>

<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->
<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->
<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->

<xsl:if test="objektart[text()='Zeitschrift']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
					<titel>
						<xsl:value-of select="Zeitschr_-Titel" />
					</titel>

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Zeitschrift</xsl:text>
					</format>

<!--ISBN / ISSN-->
					<xsl:if test="ISSN">
						<issn>
							<xsl:value-of select="ISSN" />
						</issn>
					</xsl:if>

					<xsl:if test="ZDB-ID">
						<zdbId>
							<xsl:value-of select="ZDB-ID"/>
						</zdbId>
					</xsl:if>

<!--displayDate-->
				<xsl:choose>
					<xsl:when test="J_[2]">
						<displayPublishDate>
							<xsl:value-of select="J_[1]" />
							<xsl:text> - </xsl:text>
							<xsl:value-of select="J_[last()]" />
						</displayPublishDate>
					</xsl:when>
					<xsl:otherwise>
						<displayPublishDate>
							<xsl:value-of select="J_[1]" />
						</displayPublishDate>	
					</xsl:otherwise>
				</xsl:choose>	

<!--timeSpan Laufzeit / Publishdate-->
				<xsl:choose>
					<xsl:when test="J_[2]">
						<timeSpan>
							<timeSpanStart>
								<xsl:value-of select="J_[1]" />
							</timeSpanStart>
							<timeSpanEnd>
								<xsl:value-of select="J_[last()]" />
							</timeSpanEnd>
						</timeSpan>
					</xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]" />
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>	
		
<!--issue Heft-->
			<!--<xsl:if test="H">
				<issue>
					<xsl:value-of select="H" />
				</issue>
			</xsl:if>-->

<!--volume Jahrgang-->
			<!--<xsl:if test="Jg-">
				<xsl:for-each select="Jg-">
					<volume>
						<xsl:value-of select="." />
					</volume>
				</xsl:for-each>
			</xsl:if>-->

<!--placeOfPublication Ortsangabe-->	
				<xsl:if test="Ersch_-ort[1]">
					<xsl:apply-templates select="Ersch_-ort[1]" />
				</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]" />
				</xsl:if>

<!--Relation herstellen-->
				<!--	<xsl:if test="s__Ausgabe!=''">
						<xsl:for-each select="s__Ausgabe">
							<xsl:element name="ausgabe">
								
								<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
							</xsl:element>
						</xsl:for-each>
					</xsl:if>	-->
					

				
</xsl:element>
					
</xsl:if>

<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->
<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->
<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->

<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>


<!--title Titelinformationen-->
					<titel>
						<xsl:value-of select="Sachtitel"></xsl:value-of>
						<xsl:if test="Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="Inhalt-Thema" />
						</xsl:if>
					</titel>
					<title_short>
						<xsl:value-of select="Sachtitel" />
					</title_short>
					<xsl:if test="Inhalt-Thema">
						<title_sub>
							<xsl:value-of select="Inhalt-Thema" />
						</title_sub>
					</xsl:if>

<!--author Autorinneninformation-->
<!--editor Herausgeberinneninformationen-->
<!--entity Körperschaft-->

<!--seriesninformation-->	
				<xsl:if test="Reihentitel!=''">
					<series>
						<xsl:value-of select="Reihentitel"/>
					</series>
				</xsl:if>

<!--format Objektartinformationen-->
					<format>
						<xsl:text>Zeitschriftenheft</xsl:text>
					</format>

<!--ISBN / ISSN-->
					<xsl:if test="//datensatz[Zeitschr_-Titel=$z-titel]/ISSN">
						<issn>
							<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/ISSN"/>
						</issn>
					</xsl:if>

<!--ZDB-ID-->
					<xsl:if test="//datensatz[Zeitschr_-Titel=$z-titel]/ZDB-ID">
						<zdbId>
							<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/ZDB-ID"/>
						</zdbId>
					</xsl:if>

<!--displayDate-->
					<xsl:choose>
						<xsl:when test="J_">
							<displayPublishDate>
								<xsl:value-of select="J_" />
							</displayPublishDate>	
						</xsl:when>
						<xsl:when test="not(J_)">				
							<displayPublishDate>
								<xsl:variable name="z-jahr1" select="substring-after($z-ausgabe,'(')"></xsl:variable>
								<xsl:value-of select="substring-before($z-jahr1,')')"></xsl:value-of>
							</displayPublishDate>
						</xsl:when>
					</xsl:choose>
					
<!--publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="J_">
							<publishDate>
								<xsl:value-of select="J_" />
							</publishDate>	
						</xsl:when>
						<xsl:when test="not(J_)">				
							<publishDate>
								<xsl:variable name="z-jahr1" select="substring-after($z-ausgabe,'(')"></xsl:variable>
								<xsl:value-of select="substring-before($z-jahr1,')')"></xsl:value-of>
							</publishDate>
						</xsl:when>
					</xsl:choose>
					

<!--issue Heft-->				
					<xsl:if test="H">
						<heft>
							<xsl:value-of select="H"></xsl:value-of>
						</heft>
					</xsl:if>
					
<!--volume Jahrgang-->
				
<!--placeOfPublication Ortsangabe-->	
					<xsl:choose>
						<xsl:when test="Ersch_-ort!=''">
							<placeOfPublication>
								<xsl:value-of select="Ersch_-ort[1]" />
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[Zeitschr_-Titel=$z-titel]/Ersch_-ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>

<!--publisher Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[ZDB-ID=$zdbid]">
							<publisher>
								<xsl:value-of select="//genderbib/datensatz[ZDB-ID=$zdbid]/Verlag[1]"></xsl:value-of>
							</publisher>
						</xsl:when>
						<xsl:when test="//genderbib/datensatz[Zeitschr_-Titel=$z-titel]">
							<publisher>
								<xsl:value-of select="//genderbib/datensatz[Zeitschr_-Titel=$z-titel]/Verlag[1]"></xsl:value-of>
							</publisher>
						</xsl:when>
					</xsl:choose>


</xsl:element>

<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<hierarchy_parent_id><xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/id[1]" /><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
			<hierarchy_parent_title><xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/Zeitschr_-Titel[1]" /></hierarchy_parent_title>
			
		</xsl:element>

</xsl:element>

</xsl:if>

<!--Einzeltitel______________________Einzeltitel_______________________Einzeltitel-->
<!--Einzeltitel______________________Einzeltitel_______________________Einzeltitel-->
<!--Einzeltitel______________________Einzeltitel_______________________Einzeltitel-->

<xsl:if test="(objektart[text()='Buch/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Buch')">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>
				
<!--title Titelinformationen-->
				<xsl:if test="Einzeltitel[1]">
					<xsl:apply-templates select="Einzeltitel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Artikel</xsl:text>
				</format>

<!--physical Seitenangabe-->
				<xsl:if test="Umfang !=''">
					<physical>
						<xsl:value-of select="Umfang"/>
					</physical>
				</xsl:if>
</xsl:element>

<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<hierarchy_parent_id><xsl:value-of select="$s_sachtitel"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
			<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$s_sachtitel]/Sachtitel"/></hierarchy_parent_title>
			
		</xsl:element>
	
	</xsl:element>

</xsl:if>


<!--ZeitschriftenEinzeltitel______________________ZeitschriftenEinzeltitel_______________________ZeitschriftenEinzeltitel-->
<!--ZeitschriftenEinzeltitel______________________ZeitschriftenEinzeltitel_______________________ZeitschriftenEinzeltitel-->
<!--ZeitschriftenEinzeltitel______________________ZeitschriftenEinzeltitel_______________________ZeitschriftenEinzeltitel-->

<xsl:if test="((objektart[text()='Zeitschrift/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Zeitschrift')) or ((objektart[text()='Zeitschrift/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Zeitschrift/Heftitel')) or ((objektart[text()='Zeitschrift/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Online-Zeitschrift'))">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Einzeltitel[1]">
					<xsl:apply-templates select="Einzeltitel[1]" />
				</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]" />
				</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]" />
				</xsl:if>

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Artikel</xsl:text>
				</format>

<!--physical Seitenangabe-->
				<xsl:if test="Umfang !=''">
					<physical>
						<xsl:value-of select="Umfang"/>
					</physical>
				</xsl:if>

</xsl:element>

<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<hierarchy_parent_id><xsl:value-of select="$s_sachtitel"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
			<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$s_sachtitel]/Sachtitel"/></hierarchy_parent_title>
			
		</xsl:element>

</xsl:element>
	
	



</xsl:if>


		</xsl:element>
		</xsl:if>
	</xsl:template>



</xsl:stylesheet>
