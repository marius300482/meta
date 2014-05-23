<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" exclude-result-prefixes="xs xdt err fn" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors">
	<xsl:output method="xml" indent="yes"/><!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/><!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/><!--Der Hauptknoten-->
	
	
<!--root knoten-->
	<xsl:template match="genderbib">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


	
<!--Der Objektknoten-->
	<xsl:template match="datensatz">
	
	<!--Umwandlungen werden nur bei diesem Objektarten durchgeführt-->
		<xsl:if test="(objektart[text()='Buch/Einzeltitel']) or (objektart[text()='Zeitschrift/Einzeltitel']) or (objektart[text()='Zeitschrift/Heftitel']) or (objektart[text()='Buch']) or (objektart[text()='Zeitschrift'])">
	
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
<!--dataset_______________________________dataset_______________________________dataset-->


	


		
<!--Identifikator__________________local___________________Identifikator-->
<!--Identifikator__________________local___________________Identifikator-->
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
				
				
<!--type of ressource_______________________________________________type of ressource-->
<!--type of ressource_______________________________________________type of ressource-->
<!--type of ressource_______________________________________________type of ressource-->

<!--
	0. Erklärung_ TypeOfRessource muss angegeben werden. Die Schreibweise könnte mit der or Anweisung kürzer sein-->
<!--				<typeOfRessource>
					<xsl:choose>
						<xsl:when test="objektart[text()='Buch']">
							<xsl:text>text</xsl:text>
						</xsl:when>
						<xsl:when test="objektart[text()='Buch/Einzeltitel']">
							<xsl:text>text</xsl:text>
						</xsl:when>
						<xsl:when test="objektart[text()='Zeitschrift/Heftitel']">
							<xsl:text>text</xsl:text>
						</xsl:when>
						<xsl:when test="objektart[text()='Zeitschrift/Einzeltitel']">
							<xsl:text>text</xsl:text>
						</xsl:when>
						<xsl:when test="objektart[text()='Zeitschrift']">
							<xsl:text>text</xsl:text>
						</xsl:when>
					</xsl:choose>
				</typeOfRessource>-->
		
				
<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->
<!--Buch________________Buch___________________________Buch-->
				


<xsl:if test="objektart[text()='Buch']">

<xsl:element name="dataset">

				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>

<!--Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Sachtitel[1], ':')">
							<title>
								<xsl:value-of select="Sachtitel"/>
							</title>
							<title_short>
								<xsl:value-of select="normalize-space(substring-before(Sachtitel[1], ':'))"/>
							</title_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Sachtitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<titlel>
								<xsl:value-of select="Sachtitel"/>
							</titlel>
							<titlel_short>
								<xsl:value-of select="Sachtitel"/>
							</titlel_short>
						</xsl:otherwise>
					</xsl:choose>

<!--authorneninformation-->
					<xsl:if test="Autorin !=''">
						<xsl:choose>
							<xsl:when test="contains(Autorin[1], ';')">
								<xsl:for-each select="tokenize(Autorin[1], ';')">
									<author>
										<xsl:value-of select="normalize-space(.)"/>
									</author>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="Autorin[1]">
								<author>
									<xsl:value-of select="Autorin"/>
								</author>
							</xsl:when>
						</xsl:choose>
					</xsl:if>

<!--Herausgeberinneninformationen-->
					<xsl:if test="Hrsg_ !=''">
						<xsl:choose>
							<xsl:when test="contains(Hrsg_[1], ';')">
								<xsl:for-each select="tokenize(Hrsg_, ';')">
									<editor>
										<xsl:value-of select="normalize-space(.)"/>
									</editor>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="Hrsg_">
								<xsl:for-each select="Hrsg_">
									<editor>
										<xsl:value-of select="."/>
									</editor>
								</xsl:for-each>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
	
<!--seriesninformation-->	
				<xsl:if test="reihenntitel!=''">
					<series>
						<xsl:value-of select="seriesntitel"/>
					</series>
				</xsl:if>
			
<!--Objektartinformationen-->
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
					
<!--ISBN-->
					<xsl:if test="ISBN !=''">
						<isbn>
							<xsl:value-of select="ISBN"/>
						</isbn>
					</xsl:if>
					
<!--Jahresangabe-->
					<xsl:choose>
						<xsl:when test="Jahr[1]=''">
							<publishDate>
								<xsl:text>o.A.</xsl:text>
							</publishDate>
						</xsl:when>
						<xsl:when test="(contains(Jahr[1], '[')) or (contains(Jahr[1], '('))">
							<publishDate>
								<xsl:value-of select="normalize-space(translate(Jahr[1], translate(.,'0123456789', ''), ''))"/>
							</publishDate>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="Jahr[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Ortsangabe-->
					<xsl:choose>
						<xsl:when test="(Ort[1]='') or (contains(Ort[1],'o.a.'))">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="Ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="not(Verlag)">
							<publisher>
								<xsl:text>o.A.</xsl:text>
							</publisher>
						</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="Verlag"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Seitenangaben-->
					<xsl:if test="Seitenzahlen !=''">
						<physical>
							<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>
				
				
<!--Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache=''">
						<language>
							<xsl:text>o.A.</xsl:text>
						</language>
					</xsl:when>
					<xsl:when test="Sprache[1]">
						<xsl:choose>
							<xsl:when test="contains(Sprache[1], ';')">
								<xsl:for-each select="tokenize(Sprache[1], ';')">
									<xsl:element name="language">
										<xsl:value-of select="normalize-space(.)"/>
									</xsl:element>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<xsl:element name="language">
									<xsl:value-of select="normalize-space(Sprache[1])"/>
								</xsl:element>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
				
<!--Deskriptoren Schlagworte Topics-->
				<xsl:choose>
					<xsl:when test="(contains(Deskriptoren1[1], ';')) and (Deskriptoren1[1]!='')">
						<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
							<topic>
								<xsl:value-of select="normalize-space(.)"/>
							</topic>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="Deskriptoren1[1] and (Deskriptoren1[1]!='')">
						<topic>
							<xsl:value-of select="Deskriptoren1[1]"/>
						</topic>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
				
<!--Signatur-->

				<shelfMark>
					<xsl:value-of select="Sign_[1]"/>
				</shelfMark>
				

</xsl:element>

	<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
			<hierarchy_top_title><xsl:value-of select="Sachtitel"/></hierarchy_top_title>
			
			<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
			<is_hierarchy_title><xsl:value-of select="Sachtitel"/></is_hierarchy_title>
		
		</xsl:element>
	
	</xsl:element>
			
<!--Die Angaben im Feld S__Aufsatz werden umgeschrieben und mit einem Attribut versehen-->
				<!--<xsl:if test="s__Aufsatz != ''">
					<xsl:for-each select="s__Aufsatz">
						<xsl:element name="artikel">
							<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:if>-->
				
				
				
</xsl:if>
				
<!--Buch/Einzeltitel________________Buch/Einzeltitel___________________________Buch/Einzeltitel-->
<!--Buch/Einzeltitel________________Buch/Einzeltitel___________________________Buch/Einzeltitel-->
<!--Buch/Einzeltitel________________Buch/Einzeltitel___________________________Buch/Einzeltitel-->
				
<xsl:if test="(objektart[text()='Buch/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Buch')">

<xsl:element name="dataset">

				<typeOfRessource>
						<xsl:text>text</xsl:text>
				</typeOfRessource>


<!--Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Einzeltitel[1], ':')">
							<title>
								<xsl:value-of select="Einzeltitel"/>
							</title>
							<title_short>
								<xsl:value-of select="normalize-space(substring-before(Einzeltitel[1], ':'))"/>
							</title_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Einzeltitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="Einzeltitel[1]"/>
							</title>
							<title_short>
								<xsl:value-of select="Einzeltitel[1]"/>
							</title_short>
						</xsl:otherwise>
					</xsl:choose>
					
<!--authorneninformation-->
					<xsl:if test="Autorin !=''">
						<xsl:choose>
							<xsl:when test="contains(Autorin[1], ';')">
								<xsl:for-each select="tokenize(Autorin[1], ';')">
									<author>
										<xsl:value-of select="normalize-space(.)"/>
									</author>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="Autorin[1]">
								<author>
									<xsl:value-of select="Autorin"/>
								</author>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
										
<!--Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format>
					
<!--ISBN-->
					<xsl:if test="//genderbib/datensatz[id=$s_sachtitel]/ISBN!=''">
						<isbn>
							<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/ISBN"/>
						</isbn>
					</xsl:if>
					
<!--Jahresangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Jahr[1]=''">
							<publishDate>
								<xsl:text>o.A.</xsl:text>
							</publishDate>
						</xsl:when>
						<xsl:when test="(contains(//genderbib/datensatz[id=$s_sachtitel]/Jahr[1], '[')) or (contains(//genderbib/datensatz[id=$s_sachtitel]/Jahr[1], '('))">
							<xsl:for-each select="//genderbib/datensatz[id=$s_sachtitel]/Jahr[1]">
								<publishDate>
									<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))"/>
								</publishDate>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/Jahr[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Ortsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Ort[1]=''">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:when test="contains(//genderbib/datensatz[id=$s_sachtitel]/Ort[1], 'o.a.')">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/Ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Verlag=''">
							<publisher>
								<xsl:text>o.A.</xsl:text>
							</publisher>
						</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/Verlag"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Seitenangaben-->
					<xsl:if test="Umfang !=''">
						<physical>
							<xsl:value-of select="Umfang"/>
						</physical>
					</xsl:if>
					
<!--Sprachangaben-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache=''">
							<language>
								<xsl:text>o.A.</xsl:text>
							</language>
						</xsl:when>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache[1]">
							<xsl:choose>
								<xsl:when test="contains(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
									<xsl:for-each select="tokenize(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
										<xsl:element name="language">
											<xsl:value-of select="normalize-space(.)"/>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="language">
										<xsl:value-of select="normalize-space(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1])"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					
<!--Deskriptoren Schlagworte Topics-->
					<xsl:choose>
						<xsl:when test="(contains(Deskriptoren1[1], ';')) and (Deskriptoren1[1]!='')">
							<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
								<topic>
									<xsl:value-of select="normalize-space(.)"/>
								</topic>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="Deskriptoren1[1] and (Deskriptoren1[1]!='')">
							<topic>
								<xsl:value-of select="Deskriptoren1[1]"/>
							</topic>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>

</xsl:element>

	<xsl:element name="functions">
		
		<xsl:element name="hierarchyFields">
		
			<hierarchy_top_id><xsl:value-of select="$s_sachtitel"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
			<hierarchy_top_title><xsl:value-of select="//datensatz[id=$s_sachtitel]/Sachtitel"/></hierarchy_top_title>
			
			<hierarchy_parent_id><xsl:value-of select="$s_sachtitel"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
			<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$s_sachtitel]/Sachtitel"/></hierarchy_parent_title>
		
			<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
			<is_hierarchy_title><xsl:value-of select="Einzeltitel"/></is_hierarchy_title>
			
		</xsl:element>
	
	</xsl:element>

<!--Relation herstellen-->
				<!--<xsl:if test="s__Sachtitel">
						<relatedItem>
							<xsl:value-of select="$s_sachtitel"/>
						</relatedItem>
					</xsl:if>-->
				</xsl:if>

<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->
<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->
<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->

<xsl:if test="objektart[text()='Zeitschrift']">
	
<!--Titelinformationen-->
					<titel>
						<xsl:value-of select="Zeitschr_-Titel" />
					</titel>

<!--Objektartinformationen-->
					<format>
						<xsl:text>Zeitschrift</xsl:text>
					</format>

<!--ISSN-->
					<xsl:if test="ISSN">
						<issn>
							<xsl:value-of select="ISSN" />
						</issn>
					</xsl:if>

<!--Laufzeit-->
				<xsl:choose>
					<xsl:when test="J_[2]!=''">
						<laufzeit>
							<xsl:value-of select="J_[1]" />
							<xsl:text> - </xsl:text>
							<xsl:value-of select="J_[last()]"></xsl:value-of>
						</laufzeit>
					</xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]" />
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>				
<!--Ortsangabe-->
					<placeOfPublication>
						<xsl:value-of select="Ersch_-ort[1]" />
					</placeOfPublication>

<!--Verlagsangabe-->
					<publisher>
						<xsl:value-of select="Verlag" />
					</publisher>

<!--Relation herstellen-->
					<xsl:if test="s__Ausgabe!=''">
						<xsl:for-each select="s__Ausgabe">
							<xsl:element name="ausgabe">
								<!--<xsl:attribute name="id" select="translate(., translate(.,'0123456789', ''), '')"/>-->
								<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
							</xsl:element>
						</xsl:for-each>
					</xsl:if>	
					

				
	
					
</xsl:if>

<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->
<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->
<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->

<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">

<!--Titelinformationen-->
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

<!--Objektartinformationen-->
					<format>
						<xsl:text>Zeitschriftenheft</xsl:text>
					</format>

<!--ISSN-->
					<issn>
						<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/ISSN"/>
					</issn>

<!--ISSN-->
					<xsl:if test="//datensatz[Zeitschr_-Titel=$z-titel]/ZDB-ID">
						<zdbid>
							<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/ZDB-ID"/>
						</zdbid>
					</xsl:if>

<!--Jahr-->
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
					

<!--Ausgabe-->					
					<xsl:if test="H">
						<heft>
							<xsl:value-of select="H"></xsl:value-of>
						</heft>
					</xsl:if>
					
<!--seriesninformation-->	
				<xsl:if test="seriesntitel!=''">
					<series>
						<xsl:value-of select="seriesntitel"/>
					</series>
				</xsl:if>
				
<!--Ortsangabe-->
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

<!--Verlagsangabe-->
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
<!--
					<xsl:if test="//genderbib/datensatz[Zeitschr_-Titel=$z-titel]/Verlag[1]">
						<publisher>
							<xsl:value-of select="normalize-space(//genderbib/datensatz[Zeitschr_-Titel=$z-titel]/Verlag[1])"/>
						</publisher>
					</xsl:if>-->

<!--Relation herstellen-->

					<xsl:if test="//datensatz[Zeitschr_-Titel=$z-titel]">
						<xsl:element name="relatedItem">
							<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel]/id[1]"/>
						</xsl:element>
					</xsl:if>
					<xsl:if test="//datensatz[Zeitschr_-Titel=$z-titel_collon]">
						<xsl:element name="relatedItem">
							<xsl:value-of select="//datensatz[Zeitschr_-Titel=$z-titel_collon]/id[1]"/>
						</xsl:element>
					</xsl:if>

									<xsl:if test="s__Aufsatz != ''">
					<xsl:for-each select="s__Aufsatz">
						<xsl:element name="artikel">
							<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:if>

</xsl:if>


<!--Zeitschriften/Einzeltitel________________Zeitschriften/Einzeltitel___________________________Zeitschriften/Einzeltitel-->
<!--Zeitschriften/Einzeltitel________________Zeitschriften/Einzeltitel___________________________Zeitschriften/Einzeltitel-->
<!--Zeitschriften/Einzeltitel________________Zeitschriften/Einzeltitel___________________________Zeitschriften/Einzeltitel-->


<xsl:if test="(objektart[text()='Buch/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Zeitschrift/Heftitel')">

<!--Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Einzeltitel[1], ':')">
							<titel>
								<xsl:value-of select="Einzeltitel"/>
							</titel>
							<titel_short>
								<xsl:value-of select="normalize-space(substring-before(Einzeltitel[1], ':'))"/>
							</titel_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Einzeltitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<titel>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel>
							<titel_short>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel_short>
						</xsl:otherwise>
					</xsl:choose>
					
<!--authorneninformation-->
					<xsl:if test="author !=''">
						<xsl:choose>
							<xsl:when test="contains(author[1], ';')">
								<xsl:for-each select="tokenize(author[1], ';')">
									<author>
										<xsl:value-of select="normalize-space(.)"/>
									</author>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="author[1]">
								<author>
									<xsl:value-of select="author"/>
								</author>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					
<!--Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format>
					
<!--ISSN-->
					<xsl:if test="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/ISSN">
						<isbn>
							<xsl:value-of select="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/ISSN"/>
						</isbn>
					</xsl:if>
					
<!--Jahresangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/J_[1]=''">
							<publishDate>
								<xsl:text>o.A.</xsl:text>
							</publishDate>
						</xsl:when>
						<xsl:when test="not(//genderbib/datensatz[id=$s_sachtitel]/J_)">				
							<publishDate>
								<xsl:variable name="z-jahr1" select="substring-after(//genderbib/datensatz[id=$s_sachtitel]/Ausgabe,'(')"></xsl:variable>
								<xsl:value-of select="substring-before($z-jahr1,')')"></xsl:value-of>
							</publishDate>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/J_[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Heftangabe-->
					<xsl:if test="//genderbib/datensatz[id=$s_sachtitel]/H">
						<heft>
							<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/H"></xsl:value-of>
						</heft>
					</xsl:if>
					
<!--Ortsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Ersch_-ort[1]=''">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:when test="contains(//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Ersch_-ort[1], 'o.a.')">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Ersch_-ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Verlag[1]=''">
							<publisher>
								<xsl:text>o.A.</xsl:text>
							</publisher>
						</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="normalize-space(//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Verlag[1])"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Seitenangaben-->
					<xsl:if test="Umfang !=''">
						<physical>
							<xsl:value-of select="Umfang"/>
						</physical>
					</xsl:if>
					
<!--Sprachangaben-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache=''">
							<language>
								<xsl:text>o.A.</xsl:text>
							</language>
						</xsl:when>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache[1]">
							<xsl:choose>
								<xsl:when test="contains(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
									<xsl:for-each select="tokenize(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
										<xsl:element name="language">
											<xsl:value-of select="normalize-space(.)"/>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="language">
										<xsl:value-of select="normalize-space(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1])"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					
<!--Deskriptoren Schlagworte Topics-->
					<xsl:choose>
						<xsl:when test="(contains(Deskriptoren1[1], ';')) and (Deskriptoren1[1]!='')">
							<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
								<topic>
									<xsl:value-of select="normalize-space(.)"/>
								</topic>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="Deskriptoren1[1] and (Deskriptoren1[1]!='')">
							<topic>
								<xsl:value-of select="Deskriptoren1[1]"/>
							</topic>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>

<!--Relation herstellen-->
				<xsl:if test="s__Sachtitel">
						<relatedItem>
							<xsl:value-of select="$s_sachtitel"/>
						</relatedItem>
					</xsl:if>

</xsl:if>


<xsl:if test="(objektart[text()='Zeitschrift/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Zeitschrift/Heftitel')">

<!--Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Einzeltitel[1], ':')">
							<titel>
								<xsl:value-of select="Einzeltitel"/>
							</titel>
							<titel_short>
								<xsl:value-of select="normalize-space(substring-before(Einzeltitel[1], ':'))"/>
							</titel_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Einzeltitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<titel>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel>
							<titel_short>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel_short>
						</xsl:otherwise>
					</xsl:choose>
					
<!--authorneninformation-->
					<xsl:if test="author !=''">
						<xsl:choose>
							<xsl:when test="contains(author[1], ';')">
								<xsl:for-each select="tokenize(author[1], ';')">
									<author>
										<xsl:value-of select="normalize-space(.)"/>
									</author>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="author[1]">
								<author>
									<xsl:value-of select="author"/>
								</author>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					
<!--Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format>
					
<!--ISSN-->
					<xsl:if test="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/ISSN">
						<issn>
							<xsl:value-of select="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/ISSN"/>
						</issn>
					</xsl:if>
					
<!--Jahresangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/J_[1]=''">
							<publishDate>
								<xsl:text>o.A.</xsl:text>
							</publishDate>
						</xsl:when>
						<xsl:when test="not(//genderbib/datensatz[id=$s_sachtitel]/J_)">				
							<publishDate>
								<xsl:variable name="z-jahr1" select="substring-after(//genderbib/datensatz[id=$s_sachtitel]/Ausgabe,'(')"></xsl:variable>
								<xsl:value-of select="substring-before($z-jahr1,')')"></xsl:value-of>
							</publishDate>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/J_[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>

<!--Heftangabe-->
					<xsl:if test="//genderbib/datensatz[id=$s_sachtitel]/H">
						<heft>
							<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/H"></xsl:value-of>
						</heft>
					</xsl:if>
				
<!--Ortsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Ersch_-ort[1]=''">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[s__Ausgabe=$s_sachtitel_pur]/Ersch_-ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[s__Ausgabe=$s_ST]/Verlag[1]=''">
							<publisher>
								<xsl:text>o.A.</xsl:text>
							</publisher>
						</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="normalize-space(//genderbib/datensatz[s__Ausgabe=$s_ST]/Verlag[1])"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Seitenangaben-->
					<xsl:if test="Umfang !=''">
						<physical>
							<xsl:value-of select="Umfang"/>
						</physical>
					</xsl:if>
					
<!--Sprachangaben-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache=''">
							<language>
								<xsl:text>o.A.</xsl:text>
							</language>
						</xsl:when>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache[1]">
							<xsl:choose>
								<xsl:when test="contains(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
									<xsl:for-each select="tokenize(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
										<xsl:element name="language">
											<xsl:value-of select="normalize-space(.)"/>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="language">
										<xsl:value-of select="normalize-space(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1])"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					
<!--Deskriptoren Schlagworte Topics-->

					<xsl:choose>
						<xsl:when test="(contains(Deskriptoren1[1], ';')) and (Deskriptoren1[1]!='')">
							<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
								<topic>
									<xsl:value-of select="normalize-space(.)"/>
								</topic>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="Deskriptoren1[1] and (Deskriptoren1[1]!='')">
							<topic>
								<xsl:value-of select="Deskriptoren1[1]"/>
							</topic>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>

<!--Relation herstellen-->
				<xsl:if test="s__Sachtitel">
						<relatedItem>
							<xsl:value-of select="$s_sachtitel"/>
						</relatedItem>
					</xsl:if>

</xsl:if>


<xsl:if test="(objektart[text()='Zeitschrift/Einzeltitel']) and (//genderbib/datensatz[id=$s_sachtitel]/objektart='Zeitschrift')">
<!--Titelinformationen-->
					<xsl:choose>
						<xsl:when test="contains(Einzeltitel[1], ':')">
							<titel>
								<xsl:value-of select="Einzeltitel"/>
							</titel>
							<titel_short>
								<xsl:value-of select="normalize-space(substring-before(Einzeltitel[1], ':'))"/>
							</titel_short>
							<title_sub>
								<xsl:value-of select="normalize-space(substring-after(Einzeltitel[1], ':'))"/>
							</title_sub>
						</xsl:when>
						<xsl:otherwise>
							<titel>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel>
							<titel_short>
								<xsl:value-of select="Einzeltitel[1]"/>
							</titel_short>
						</xsl:otherwise>
					</xsl:choose>
					
<!--authorneninformation-->
					<xsl:if test="author !=''">
						<xsl:choose>
							<xsl:when test="contains(author[1], ';')">
								<xsl:for-each select="tokenize(author[1], ';')">
									<author>
										<xsl:value-of select="normalize-space(.)"/>
									</author>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="author[1]">
								<author>
									<xsl:value-of select="author"/>
								</author>
							</xsl:when>
						</xsl:choose>
					</xsl:if>
					
<!--Objektartinformationen-->
					<format>
						<xsl:text>Artikel</xsl:text>
					</format>
					
<!--ISSN-->
					<xsl:if test="//genderbib/datensatz[id=$s_sachtitel]/ISSN">
						<issn>
							<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/ISSN"/>
						</issn>
					</xsl:if>
					
<!--Ortsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Ersch_-ort[1]=''">
							<placeOfPublication>
								<xsl:text>o.A.</xsl:text>
							</placeOfPublication>
						</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[id=$s_sachtitel]/Ersch_-ort[1]"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Verlagsangabe-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]//Verlag[1]=''">
							<publisher>
								<xsl:text>o.A.</xsl:text>
							</publisher>
						</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="normalize-space(//genderbib/datensatz[id=$s_sachtitel]/Verlag[1])"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
					
<!--Seitenangaben-->
					<xsl:if test="Umfang !=''">
						<physical>
							<xsl:value-of select="Umfang"/>
						</physical>
					</xsl:if>
					
<!--Sprachangaben-->
					<xsl:choose>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache=''">
							<language>
								<xsl:text>o.A.</xsl:text>
							</language>
						</xsl:when>
						<xsl:when test="//genderbib/datensatz[id=$s_sachtitel]/Sprache[1]">
							<xsl:choose>
								<xsl:when test="contains(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
									<xsl:for-each select="tokenize(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1], ';')">
										<xsl:element name="language">
											<xsl:value-of select="normalize-space(.)"/>
										</xsl:element>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="language">
										<xsl:value-of select="normalize-space(//genderbib/datensatz[id=$s_sachtitel]/Sprache[1])"/>
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					
<!--Deskriptoren Schlagworte Topics-->

					<xsl:choose>
						<xsl:when test="(contains(Deskriptoren1[1], ';')) and (Deskriptoren1[1]!='')">
							<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
								<topic>
									<xsl:value-of select="normalize-space(.)"/>
								</topic>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="Deskriptoren1[1] and (Deskriptoren1[1]!='')">
							<topic>
								<xsl:value-of select="Deskriptoren1[1]"/>
							</topic>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>

<!--Relation herstellen-->
				<xsl:if test="s__Sachtitel">
						<relatedItem>
							<xsl:value-of select="$s_sachtitel"/>
						</relatedItem>
					</xsl:if>

			</xsl:if>


		</xsl:element>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>
