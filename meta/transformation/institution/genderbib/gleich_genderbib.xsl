<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="genderbib">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="datensatz">
	<xsl:variable name="s_sachtitel" select="translate(s__Sachtitel[1], translate(.,'0123456789', ''), '')"/>
			
			
			<xsl:if test="(objektart[text()='Zeitschrift']) or (objektart[text()='Zeitschrift/Heftitel'])">
			<!--
			
			<xsl:if test="objektart[text()!='NutzerIn']">
			<xsl:if test="(objektart[text()='Zeitschrift']) or (objektart[text()='Zeitschrift/Heftitel'])">
			<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">
			
			
			-->
			<!--<xsl:if test="objektart[text()!='NutzerIn']">-->
			<!--<xsl:if test="(objektart[text()='Zeitschrift']) or (objektart[text()='Zeitschrift/Heftitel'])">-->
			<!--<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">-->
			<!--<xsl:if test="contains(objektart,'Einzeltitel')">-->
			
			
			<!--<xsl:if test="(objektart[text()!='NutzerIn']) and (objektart[text()='Buch'])">
			<xsl:if test="objektart[text()='Buch']">-->
			<!--<xsl:if test="objektart[text()='Zeitschrift']">-->
			<!--<xsl:if test="objektart[text()='Zeitschrift']">-->
			
			<!--<xsl:if test="(objektart[text()!='NutzerIn']) and (objektart[text()='Zeitschrift/Heftitel'])">-->
			<!--<xsl:if test="contains(objektart,'Einzeltitel')">-->
			<!---->
			<!--<xsl:if test="(objektart[text()='Zeitschrift']) or (objektart[text()='Zeitschrift/Heftitel'])">-->
			<!--xsl:if test="objektart[text()='Online-Artikel']">-->
			<!--<xsl:if test="objektart[text()='Artikel']">-->
			
		<!--<xsl:if test="(objektart[text()='Magistra/Magister Gender Studies']) or (objektart[text()='Abschlussarbeit'])
		or (objektart[text()='Buch']) or (objektart[text()='Zeitschrift'])
		or (contains(objektart,'Einzeltitel')) or objektart[text()='Zeitschrift/Heftitel']">--><!--Datensätze dieser Objektart werden nicht umgewandelt-->

		<!--<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">-->

		<xsl:variable name="id" select="id"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>genderbib</xsl:text>
					</xsl:attribute>
				
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->

		<xsl:variable name="s_sachtitel" select="translate(s__Sachtitel[1], translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="z-ausgabe" select="Ausgabe"/>
		<xsl:variable name="currentDate" select="current-date()"/>
		
	<xsl:variable name="connect">
	
		<xsl:choose>
			<xsl:when test="s__Sachtitel">
				
			<xsl:for-each select="//datensatz[id=$s_sachtitel]">
			
			<xsl:text> editor:</xsl:text>
				<xsl:value-of select="Hrsg_"></xsl:value-of>
				<xsl:text>:editor</xsl:text>
			
			<xsl:text> hrsg:</xsl:text>
				<xsl:value-of select="Hrsg__Körperschaft"></xsl:value-of>
				<xsl:text>:hrsg</xsl:text>
			
			<xsl:text> contributor:</xsl:text>
				<xsl:value-of select="ÜbersetzerIn"></xsl:value-of>
				<xsl:text>:contributor</xsl:text>
			
			<xsl:text> entity:</xsl:text>
				<xsl:value-of select="Körperschaft"></xsl:value-of>
				<xsl:text>:entity</xsl:text>
			
			<xsl:text> series:</xsl:text>
				<xsl:value-of select="Reihentitel"></xsl:value-of>
				<xsl:text>:series</xsl:text>
				
			<!--<xsl:text> edition:</xsl:text>
				<xsl:value-of select="Ausgabe"></xsl:value-of>
				<xsl:text>:edition</xsl:text>-->
			
			<xsl:text> volume:</xsl:text>
				<xsl:value-of select="Jg-"></xsl:value-of>
				<xsl:text>:volume</xsl:text>
			
			<xsl:text> issue:</xsl:text>
				<xsl:value-of select="H"></xsl:value-of>
				<xsl:text>:issue</xsl:text>
			
			<xsl:text> isbn:</xsl:text>
				<xsl:value-of select="ISBN"></xsl:value-of>
				<xsl:text>:isbn</xsl:text>
			
			<xsl:text> issn:</xsl:text>
				<xsl:value-of select="ISSN"></xsl:value-of>
				<xsl:text>:issn</xsl:text>
			
			<xsl:text> zdbid:</xsl:text>
				<xsl:value-of select="ZDB-ID"></xsl:value-of>
				<xsl:text>:zdbid</xsl:text>
			
			<xsl:text> displayPublishDate:</xsl:text>
				<xsl:value-of select="J_"></xsl:value-of>
				<xsl:value-of select="Jahr"></xsl:value-of>
				<xsl:text>:displayPublishDate</xsl:text>
			
			<xsl:text> publishDate:</xsl:text>
				<xsl:value-of select="J_"></xsl:value-of>
				<!--<xsl:value-of select="Jahr"></xsl:value-of>-->
				
				<xsl:variable name="year" select="Jahr"/>
					<!--<xsl:value-of select="$year"/>-->
						<xsl:choose>
							<xsl:when test="(string-length($year) &gt; 7) and (not(contains($year, ';')))">
								<xsl:value-of select="normalize-space(substring-before($year, '/'))"/>
								<xsl:text>;</xsl:text>
								<xsl:value-of select="normalize-space(substring-after($year, '/'))"/>
								</xsl:when>
							<xsl:when test="(matches($year,'/'))">
								<xsl:value-of select="normalize-space(substring-before($year, '/'))"/>
								<xsl:text>;</xsl:text>
								<xsl:value-of select="normalize-space(substring($year, 1,2))"/>
								<xsl:value-of select="normalize-space(substring-after($year, '/'))"/>
								</xsl:when>
							<xsl:when test="(contains($year, '[')) or (contains($year, '(')) or (contains($year, 'ca'))">
								<xsl:value-of select="normalize-space(translate($year, translate(.,'0123456789', ''), ''))"/>
								</xsl:when>
							<xsl:when test="matches($year,'[a-z]')">
								<xsl:text>0000</xsl:text>
								</xsl:when>
							<xsl:when test="$year=''">
								<xsl:text>0000</xsl:text>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space($year)"/>		
								</xsl:otherwise>
							</xsl:choose>		
					<xsl:text>:publishDate</xsl:text>
			
			<xsl:text> ausgabe:</xsl:text>
				<xsl:value-of select="Ausgabe"></xsl:value-of>
				<xsl:text>:ausgabe</xsl:text>
			
			<xsl:text> placeOfPublication:</xsl:text>
				<xsl:value-of select="Ort"></xsl:value-of>
				<xsl:value-of select="Ersch_-ort"></xsl:value-of>
				<xsl:text>:placeOfPublication</xsl:text>
			
			<xsl:text> publisher:</xsl:text>
				<xsl:value-of select="Verlag"></xsl:value-of>
				<xsl:value-of select="Druckerei-Verlag"></xsl:value-of>
				<xsl:text>:publisher</xsl:text>
			
			<xsl:text> sourceInfo:</xsl:text>
				<xsl:choose>
					<xsl:when test="Inhalt-Thema[string-length() != 0]">
						<xsl:value-of select="replace(Inhalt-Thema[1],'_','')"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"/>
						</xsl:otherwise>
					</xsl:choose>
				<!--<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"></xsl:value-of>-->
				<xsl:value-of select="Zeitschr_-Titel"></xsl:value-of>
				<xsl:text>:sourceInfo</xsl:text>
			
			<xsl:text> topic:</xsl:text>
				<xsl:value-of select="Inhalt-Thema"></xsl:value-of>
				<xsl:text>:topic</xsl:text>
			
			<xsl:text> shelfMark:</xsl:text>
				<xsl:value-of select="Sign_"></xsl:value-of>
				<xsl:text>:shelfMark</xsl:text>
			</xsl:for-each>	
			
				</xsl:when>
			
			</xsl:choose>
	
		</xsl:variable>
		
	
				
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id"/>
					<xsl:text>genderbib</xsl:text>
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
							<xsl:text>Genderbibliothek</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Genderbibliothek am Zentrum für transdisziplinäre Geschlechterstudien</xsl:text>
							</institutionFull>
							
						<institutionID>
							<xsl:text>genderbib</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>GReTA</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-B1542</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.520326</latitude>
							<longitude>13.394218799999976</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Buch__________________________Monographie___________________________Sammelband-->


<xsl:if test="objektart[text()='Buch']">

<!--Die Umwandlung für die Objektart "Buch" beinhaltet Monographien sowie Sammelbände. Sobald ein 
"Buch" die Referenz auf Einzeltitel über das Feld "s_Aufsatz" aufweist ist es ein Sammelband andernfalls
eine Monographie. Monographien und Sammelbäünde können ausgeliehen werden. Die Anzeige des Ausleihstatus wird über
den Datenbestand angezeigt-->

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>	
			
	<!--searchfilter-->
				<!--<xsl:choose>
					<xsl:when test="not(s__Aufsatz)">
						<searchfilter>
							<xsl:text>BU - Monografie</xsl:text>
							</searchfilter>
						</xsl:when>
					<xsl:otherwise>
						<searchfilter>
							<xsl:text>BU - Sammelband</xsl:text>
							</searchfilter>
						</xsl:otherwise>
					</xsl:choose>-->
	
	<!--documentType Objektartinformationen-->
				<xsl:choose>
					<xsl:when test="not(s__Aufsatz)">
						<documentType>
							<xsl:text>Monografie</xsl:text>
							</documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType>
							<xsl:text>Sammelband</xsl:text>
							</documentType>
						</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="Dok-art"/>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Sachtitel[1]"/>
				<!--<xsl:choose>
					<xsl:when test="Sachtitel">
						<xsl:apply-templates select="Sachtitel[1]"/>
						</xsl:when>
					<xsl:when test="Reihentitel">
						<xsl:apply-templates select="Reihentitel[1]"/>
						</xsl:when>
					</xsl:choose>-->
				

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin"/>

	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="Hrsg_"/>

	<!--series Reiheninformation-->
				<xsl:apply-templates select="Reihentitel"/>
				<xsl:apply-templates select="Bd--ReihenNr_"/>

<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
				<xsl:apply-templates select="ISBN"/>

<!--PUBLISHING-->

	<!--displayDate-->
				<xsl:if test="Jahr[1]">
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>
					</xsl:if>

	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>

	<!--placeOfPublication Ortsangabe-->						
				<xsl:apply-templates select="Ort"/>
	
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahlen"/>

<!--CONTENTRELATED INFORMATION-->
				
	<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache"><xsl:apply-templates select="Sprache"/></xsl:when>
					<xsl:otherwise><language>o. A.</language></xsl:otherwise>
					</xsl:choose>
				
	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>
	
<!--OTHER-->
			
	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>
				
<!--projectMark-->	
				<!--<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					</project>-->
</xsl:element>

<xsl:if test="s__Aufsatz">
	<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Sachtitel[1]" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Sachtitel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
		</xsl:element>	
	</xsl:if>				
</xsl:if>










<!--Hochschularbeit_____________________Magistraarbeit_____________________Abschlussarbeit-->

<xsl:if test="(objektart[text()='Magistra/Magister Gender Studies']) or (objektart[text()='Abschlussarbeit'])">

<!--Zu den Hochschularbeiten gehören die Magistraarbeiten des Studiengangs sowie Abschlussarbeiten aus anderen Bereichen.
Die genaue Zuordnung der einzelnen Hochschularbeiten erfolgt über das Feld documentType. Hier wird aus den 
Datensätzen ausgelesen, um welche Art von Hochschularbeit es sich handelt-->

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
				
	<!--format Objektartinformationen-->
				<format><xsl:text>Hochschulschrift</xsl:text></format>
				
	<!--documentType Dokumentinformation-->
				<xsl:if test="objektart[text()='Magistra/Magister Gender Studies']">
					<documentType>
						<xsl:text>Magistra/Magister Gender Studies</xsl:text>
						</documentType>
					</xsl:if>
					<xsl:apply-templates select="Dok-art"/>
				

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel"/>
	
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin"/>

	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="Hrsg"/>
	
	<!--reviewer Gutachterin-->
				<xsl:if test="Gutachter_in">
					<reviewer>
						<xsl:value-of select="Gutachter_in" />
						</reviewer>
					</xsl:if>

<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>

	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr[1]"/>
	
	<!--placeOfPublication Ortsangabe-->						
				<xsl:apply-templates select="Ort"/>
	
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[1]"/>
	
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Umfang"/>
					
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o. A.</language></xsl:otherwise>
					</xsl:choose>

	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1[1]"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>
			
<!--OTHER-->
	
	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

<!--projectMark-->	
				<!--<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
									<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
									<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					</project>-->
				
</xsl:element>


<!--<xsl:element name="functions">-->
	
<!--loan-->			<!--<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
					</xsl:if>-->
	
<!--hierarchyFields--> 	<!--<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
					</xsl:if>-->

<!--</xsl:element>	-->

</xsl:if>










<!--Artikel___________________________Aktenschrank___________________________Artikel-->

<xsl:if test="objektart[text()='Artikel']">

<!--Artikel aus dem Aktenschrank umfassen alle Artikel, die einzeln im Aktenschrank gesammelt werden-->

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>
	
	<!--documentType-->
				<documentType><xsl:text>Artikel (Aktenschrank)</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Einzeltitel">
						<xsl:apply-templates select="Einzeltitel"/>
						</xsl:when>
					<xsl:when test="Sammeltitel">
						<xsl:choose>
							<xsl:when test="contains(Sammeltitel[1], ':')">
								<title>
									<xsl:value-of select="Sammeltitel[1]"/>
									</title>
								<title_short>
									<xsl:value-of select="normalize-space(substring-before(Sammeltitel[1], ':'))"/>
									</title_short>
								<title_sub>
									<xsl:value-of select="normalize-space(substring-after(Sammeltitel[1], ':'))"/>
									</title_sub>
								</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="Sammeltitel[1]"/>
							</title>
						<title_short>
							<xsl:value-of select="Sammeltitel[1]"/>
							</title_short>
						</xsl:otherwise>
					</xsl:choose>
						
						</xsl:when>
					</xsl:choose>
				
	
				<!--<xsl:choose>
					<xsl:when test="Einzeltitel!=''"><xsl:apply-templates select="Einzeltitel[1]"/></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Sammeltitel[1]"/></xsl:otherwise>
					</xsl:choose>-->

<!--RESPONSIBLE-->
				
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin[1]"/>
				
	<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg[1]"/>
			
<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--displayDate-->
				<displayPublishDate><xsl:value-of select="Jahr[1]"/></displayPublishDate>

	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>

	<!--placeOfPublication Ortsangabe-->						
				<xsl:apply-templates select="Ort"/>
				
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>

<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen">
					<physical>
						<xsl:value-of select="translate(Seitenzahlen, translate(.,'0123456789', ''), '')"/>
						</physical>
					</xsl:if>
				<!--<xsl:apply-templates select="Seitenzahlen" />-->

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<!--<xsl:otherwise><language>o. A.</language></xsl:otherwise>-->
					</xsl:choose>
	
	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>
	
<!--DETAILS FOR JOURNAL RELATED CONTENT-->
				
	<!--issue Heft-->
				<xsl:apply-templates select="Heft-Nr_"/>

	<!--volume Jahrgang-->
				<xsl:apply-templates select="Jg_"/>
			
<!--OTHER-->
					
	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

<!--projectMark-->	
				<!--<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					                      </project>-->
</xsl:element>

<!--<xsl:element name="functions">-->
	
<!--loan-->			<!--<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>
	-->
<!--hierarchyFields--> 	<!--<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>-->
<!--
</xsl:element>	-->

</xsl:if>












<!--Online-Artikel_________________________Online-Artikel_______________________Online-Artikel-->

<xsl:if test="objektart[text()='Online-Artikel']">

<!--Onlineartikel sind Datensätze die eine URL zum eigentlichen Artikel im Netz enthalten. Ob diese
URLs noch stimmen kann hier nicht geprüft werden.-->

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>
	
	<!--documentType-->
				<documentType><xsl:text>Online-Artikel</xsl:text></documentType>
				<xsl:apply-templates select="Dok-art"/>

<!--TITLE-->

	<!--Titelinformationen-->			
				<xsl:choose>
					<xsl:when test="Titel">
						<xsl:apply-templates select="Titel[1]"/></xsl:when>
					<xsl:when test="Sammeltitel">
						<title>
							<xsl:value-of select="Sammeltitel" />
							</title>
						<title_short>
							<xsl:value-of select="Sammeltitel" />
							</title_short>
						</xsl:when>
					</xsl:choose>
					
	<!--title Titelinformationen-->
				<!--<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]"/>
					</xsl:if>-->

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin"/>
	
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="Hrsg_[1]"/>
		
	<!--series Reiheninformation-->
				<xsl:apply-templates select="Reihentitel"/>

<!--IDENTIFIER-->

	<!--Digitale_Dokumente-->
				<xsl:apply-templates select="Digitale_Dokumente"/>

<!--PUBLISHING-->
	
	<!--DisplayDate-->
				<xsl:choose>
					<xsl:when test="J_">
						<displayPublishDate>
							<xsl:value-of select="J_[1]"/>
							</displayPublishDate>
						</xsl:when>
					<xsl:otherwise>
						<displayPublishDate>
							<xsl:value-of select="Jahr[1]"/>
							</displayPublishDate>		
						</xsl:otherwise>
					</xsl:choose>
	<!--publishDate Jahresangabe-->
				<xsl:choose>
					<xsl:when test="Jahr[1]">
						<xsl:apply-templates select="Jahr[1]"/>
						</xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>

	<!--placeOfPublication Ortsangabe-->						
					<xsl:apply-templates select="Ort"/>

	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[1]"/>
	
	<!--sourceInfo-->
				<xsl:apply-templates select="Sammeltitel"/>
	
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahlen"/>

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o. A.</language></xsl:otherwise>
					</xsl:choose>

	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->
				<xsl:apply-templates select="H"/>

	<!--volume Jahrgang-->
				<xsl:apply-templates select="Jg-"/>

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>


<!--projectMark-->	
				<!--<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
							</xsl:if>
						</xsl:for-each>
					</project>-->
</xsl:element>
<!--
<xsl:element name="functions">-->
	
<!--loan-->			<!--<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>-->
	
<!--hierarchyFields--> 	<!--<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>-->

<!--</xsl:element>	-->

</xsl:if>









<!--Video/DVD____________________Video/DVD______________________________Video/DVD-->

<xsl:if test="objektart[text()='Video/DVD']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>Video</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
				<format><xsl:text>Film</xsl:text></format>
				
	<!--documentType-->
				<documentType><xsl:text>Video / DVD</xsl:text></documentType>
				<xsl:apply-templates select="Dok-art"/>
				
<!--TITLE-->
		
	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel"/>
				
<!--RESPONSIBLE-->			
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin[1]"/>
				
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="Hrsg_[1]"/>

<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>

	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr[1]"/>

	<!--placeOfPublication Ortsangabe-->	
				<xsl:apply-templates select="Ort"/>

	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[1]"/>

<!--PHYSICAL INFORMATION-->
		
	<!--runTime Laufzeit DVD-->
				<xsl:apply-templates select="Laufzeit"/>
		
<!--CONTENTRELATED INFORMATION-->
				
	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache[1]"/>

	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>

<!--OTHER-->		

	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

</xsl:element>

<!--<xsl:element name="functions">-->
	
<!--loan-->			<!--<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>-->
	
<!--hierarchyFields--> 	<!--<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>
-->
<!--</xsl:element>	-->

</xsl:if>










<!--Online-Zeitschrift_________________________Online-Zeitschrift_______________________Online-Zeitschrift-->

<xsl:if test="objektart[text()='Online-Zeitschrift']">

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
				<format><xsl:text>Zeitschrift</xsl:text></format>
	
	<!--searchfilter-->
				<searchfilter><xsl:text>ZP - Zeitschrift</xsl:text></searchfilter>
	
	<!--documentType Objektartinformationen-->
				<documentType><xsl:text>Online-Zeitschrift</xsl:text></documentType>
				<xsl:apply-templates select="Dok-art"/>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Sachtitel!=''">
						<xsl:apply-templates select="Sachtitel[1]"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="Zeitschr_-Titel[1]"/>
						</xsl:otherwise>
					</xsl:choose>

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin[1]"/>

	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="Hrsg_[1]"/>

	<!--series Reiheninformation-->
				<xsl:apply-templates select="Reihentitel"/>		

<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
				<xsl:apply-templates select="ISSN"/>

	<!--Digitale_Dokumente-->
				<xsl:apply-templates select="Digitale_Dokumente"/>

<!--PUBLISHING-->
	
	<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="J_[1]"/>
					
					<xsl:if test="J_[1]!=J_[last()]">
						<xsl:text> - </xsl:text>
						<xsl:value-of select="J_[last()]"/>
						</xsl:if>
					</displayPublishDate>
				
				<!--<xsl:choose>
					<xsl:when test="J_[2]">
						<displayPublishDate>
							<xsl:value-of select="J_[1]"/>
							<xsl:text> - </xsl:text>
							<xsl:value-of select="J_[last()]"/>
							</displayPublishDate>
						</xsl:when>
					<xsl:otherwise>
						<displayPublishDate>
							<xsl:value-of select="J_[1]"/>
							</displayPublishDate>	
						</xsl:otherwise>
					</xsl:choose>	-->

	<!--timeSpan Laufzeit / Publishdate-->
				
				<xsl:if test="J_">
				<publishDate>
					<xsl:value-of select="J_[last()]"/>
					</publishDate>
					</xsl:if>
				<!--<xsl:choose>
					<xsl:when test="J_[2]">
						<timeSpan>
							<timeSpanStart>
								<xsl:value-of select="J_[1]"/>
								</timeSpanStart>
							<timeSpanEnd>
								<xsl:value-of select="J_[last()]"/>
								</timeSpanEnd>
							</timeSpan>
						</xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>	-->

	<!--placeOfPublication Ortsangabe-->						
				<xsl:apply-templates select="Ort"/>
				<xsl:apply-templates select="Ersch_-ort"/>
				
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>

<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahlen" />

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache[1]"/>

	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<!--<xsl:apply-templates select="Land"/>-->
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->
	
	<!--issue Heft-->
				<xsl:apply-templates select="H"/>

	<!--volume Jahrgang-->
				<xsl:apply-templates select="Jg-"/>

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

</xsl:element>

</xsl:if>











<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->

<xsl:if test="objektart[text()='Zeitschrift']">

<!--Bei den Zeitschriften handelt es sich um Metadatensätze. Hier stehen die Angaben zur
Veröffentlichungsort etc. Mit diesen Angaben werden die Informationen in den 
Zeitschriften/Hefttiteln angereichert. Eine Zeitschrift kann nicht ausgeliehen werden.-->

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
		<format><xsl:text>Zeitschrift</xsl:text></format>

	<!--searchfilter-->
		<searchfilter><xsl:text>ZP - Zeitschrift</xsl:text></searchfilter>

	<!--documentType Objektartinformationen-->
		<documentType><xsl:text>Zeitschriftenreihe</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->
		<xsl:apply-templates select="Zeitschr_-Titel"/>
		<xsl:apply-templates select="Titeländg_" />
					
<!--RESPONSIBLE-->
				

<!--IDENTIFIER-->
				
	<!--ISBN / ISSN-->
		<xsl:apply-templates select="ISSN" />

	<!--ZDB-ID-->
		<xsl:apply-templates select="ZDB-ID" />

<!--PUBLISHING-->

	<!--displayDate / Publishdate-->
		<xsl:choose>
			<xsl:when test="J_[2]">
				<displayPublishDate>
					<xsl:value-of select="J_[1]"/>
					<xsl:text> - </xsl:text>
					<xsl:value-of select="J_[last()]"/>
					</displayPublishDate>
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="J_[1]"/>
					</displayPublishDate>	
				</xsl:otherwise>
			</xsl:choose>	
				
		<xsl:for-each select="J_">
			<publishDate>
				<xsl:value-of select="normalize-space(.)"/>
				</publishDate>
			</xsl:for-each>

	<!--placeOfPublication Ortsangabe-->	
		<!--<xsl:apply-templates select="Ersch_-ort[1]"/>-->

	<!--publisher Verlagsangabe-->
		<!--<xsl:apply-templates select="Verlag[1]"/>-->

<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--specialIssue-->
		<xsl:apply-templates select="Sonderhefte[string-length() != 0]"/>
	
	<!--publicationFrequency-->
		<xsl:apply-templates select="Ersch_-weise[string-length() != 0]"/>
	
	<!--collectionHolding-->
		<xsl:apply-templates select="Bestandsangabe[string-length() != 0]"/>
		
	<!--outOfStocks-->
		<xsl:apply-templates select="Lückenangabe[string-length() != 0]"/>

<!--OTHER-->

	<!--shelfMark Signatur-->
		<!--<xsl:apply-templates select="Standort[1]"/>-->
				
</xsl:element>

<xsl:if test="s__Ausgabe">
	<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Zeitschr_-Titel[1]" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="Zeitschr_-Titel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
		</xsl:element>	
	</xsl:if>		

</xsl:if>










<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->

<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">

<!--Zeitschriftenhefttitel gehören zu einer Zeitschrift. Ein Zeitschriftenhefttitel hat Einzeltitel. 
Im Gegensatz zur Zeitschrift ist ein Hefttitel ausleihbar.-->

<xsl:variable name="zTitel" select="translate(s__Zeitschriftentitel[1], translate(.,'0123456789', ''), '')"/>
<xsl:variable name="sSachtitel" select="translate(s__ST[1], translate(.,'0123456789', ''), '')"/>

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
				
	<!--format Objektartinformationen-->
				<format><xsl:text>Zeitschrift</xsl:text></format>
	
	<!--searchfilter-->
				<searchfilter><xsl:text>ZP - Zeitschriftenheft</xsl:text></searchfilter>
	
	<!--documentType Objektartinformationen-->
				<documentType><xsl:text>Zeitschriftenheft</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->
				
				<xsl:variable name="title">
					<xsl:choose>
					<xsl:when test="Inhalt-Thema[string-length() != 0]">
						<xsl:value-of select="replace(Inhalt-Thema[1],'_','')"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="Sachtitel"/>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:variable>
				
				<title>
					<xsl:value-of select="$title" />
					</title>
				
				<title_short>
					<xsl:value-of select="$title" />
					</title_short>
				
				<!--<title>
					<xsl:value-of select="Sachtitel[1]"/>
					</title>
				
				<title_short>
					<xsl:value-of select="Sachtitel"/>
					</title_short>
				
				<xsl:if test="Inhalt-Thema">
					<title_sub>
						<xsl:value-of select="replace(Inhalt-Thema[1],'_','')"/>
						</title_sub>
					</xsl:if>-->
				
				<xsl:apply-templates select="Titeländg_" />
				
<!--RESPONSIBLE-->
	
	<!--series Reiheninformation-->
				<xsl:apply-templates select="Reihentitel"/>	
				
	<!--edition-->
				<xsl:apply-templates select="Ausgabe[string-length() != 0]"/>	

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
					<xsl:choose>
						<xsl:when test="ISSN">
							<xsl:apply-templates select="ISSN" />
							</xsl:when>
						<xsl:when test="s__Zeitschriftentitel">
							<issn>
								<xsl:value-of select="//datensatz[id=$zTitel]/ISSN"/>
								</issn>
							</xsl:when>
						<xsl:when test="s__ST">
							<issn>
								<xsl:value-of select="//datensatz[id=$sSachtitel]/ISSN"/>
								</issn>
							</xsl:when>
						<xsl:otherwise>
							<!--<issn>
								<xsl:text>o. A.</xsl:text>
								</issn>-->
							</xsl:otherwise>
						</xsl:choose>

	<!--ZDB-ID-->
					<xsl:choose>
						<xsl:when test="ZDB-ID">
							<xsl:apply-templates select="ZDB-ID" />
							</xsl:when>
						<xsl:when test="s__Zeitschriftentitel">
							<zdbId>
								<xsl:value-of select="//datensatz[id=$zTitel]/ZDB-ID"/>
								</zdbId>
							</xsl:when>
						<xsl:when test="s__ST">
							<zdbId>
								<xsl:value-of select="//datensatz[id=$sSachtitel]/ZDB-ID"/>
								</zdbId>
							</xsl:when>
						<xsl:otherwise>
							<!--<zdbId>
								<xsl:text>o. A.</xsl:text>
								</zdbId>-->
							</xsl:otherwise>
						</xsl:choose>

<!--PUBLISHING-->

	<!--publisher Verlagsangabe-->		
					<xsl:choose>
						<xsl:when test="Verlag">
							<xsl:apply-templates select="Verlag[1]" />
							</xsl:when>
						<xsl:when test="s__Zeitschriftentitel">
							<publisher>
								<xsl:value-of select="//datensatz[id=$zTitel]/Verlag"/>
								</publisher>
							</xsl:when>
						<xsl:when test="s__ST">
							<publisher>
								<xsl:value-of select="//datensatz[id=$sSachtitel]/Verlag"/>
								</publisher>
							</xsl:when>
						<xsl:otherwise>
							<!--<publisher>
								<xsl:text>o. A.</xsl:text>
								</publisher>-->
							</xsl:otherwise>
						</xsl:choose>
					
	<!--placeOfPublication Ortsangabe-->
					<xsl:choose>
						<xsl:when test="Ersch_-ort">
							<xsl:apply-templates select="Ersch_-ort" />
							</xsl:when>
						<xsl:when test="s__Zeitschriftentitel">
							<placeOfPublication>
								<xsl:value-of select="//datensatz[id=$zTitel]/Ersch_-ort"/>
								</placeOfPublication>
							</xsl:when>
						<xsl:when test="s__ST">
							<placeOfPublication>
								<xsl:value-of select="//datensatz[id=$sSachtitel]/Ersch_-ort"/>
								</placeOfPublication>
							</xsl:when>
						<xsl:otherwise>
							<!--<placeOfPublication>
								<xsl:text>o. A.</xsl:text>
								</placeOfPublication>-->
							</xsl:otherwise>
						</xsl:choose>
					
	<!--displayDate-->
					<xsl:choose>
						<xsl:when test="J_">
							<displayPublishDate>
								<xsl:value-of select="J_"/>
							</displayPublishDate>	
							</xsl:when>
						<xsl:when test="not(J_)">				
							<displayPublishDate>
								<xsl:variable name="z-jahr1" select="substring-after($z-ausgabe,'(')"/>
								<xsl:value-of select="substring-before($z-jahr1,')')"/>
								</displayPublishDate>
							</xsl:when>
						</xsl:choose>
						
	<!--publishDate Jahresangabe-->
					<xsl:choose>
						<xsl:when test="J_">
							<publishDate>
								<xsl:value-of select="J_"/>
							</publishDate>	
							</xsl:when>
						<xsl:when test="not(J_)">				
							<publishDate>
								<xsl:variable name="z-jahr1" select="substring-after($z-ausgabe,'(')"/>
								<xsl:value-of select="substring-before($z-jahr1,')')"/>
								</publishDate>
							</xsl:when>
						</xsl:choose>
		
	<!--sourceInfo-->
				<xsl:variable name="zdbid" select="ZDB-ID" />
				
				<sourceInfo>
					<xsl:value-of select="Sachtitel" />
					</sourceInfo>
	
<!--PHYSICAL INFORMATION-->		

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache[1]"/>

	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="Deskriptoren1"/>
	
	<!--subjectGeographic Ortsangaben-->
				<xsl:apply-templates select="Geografika"/>
				<xsl:apply-templates select="Land"/>
	
	<!--subjectPerson Personenangaben-->
				<xsl:apply-templates select="Personen"/>

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->				
					<xsl:choose>
						<xsl:when test="H">
							<xsl:apply-templates select="H[1]" />
							</xsl:when>
						<xsl:when test="Ausgabe">
							<issue>
								<xsl:value-of select="substring-after(Ausgabe,')')" />
								</issue>
							</xsl:when>
						</xsl:choose>
					<!--<xsl:apply-templates select="H[1]" />-->

	<!--volume Jahrgang-->
					<xsl:apply-templates select="Jg-[1]" />	
					
	<!--contentMatter Inhalt und Thema-->
				<xsl:apply-templates select="Inhalt-Thema"/>

<!--OTHER-->

	<!--shelfMark-->
					<xsl:if test="Sign_">
						<shelfMark>
							<xsl:value-of select="Sign_" />
							</shelfMark>	
						</xsl:if>

</xsl:element>
	
	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test="Inhalt-Thema[string-length() != 0]">
				<xsl:value-of select="replace(Inhalt-Thema[1],'_','')"/>
				</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="Sachtitel"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
	<xsl:variable name="reference">
		<xsl:text>Objekt </xsl:text>
		<xsl:value-of select="$id" />
		<xsl:text> / ZiF                 </xsl:text>
		</xsl:variable>
	
	<xsl:variable name="id_parent">
		<xsl:value-of select="//datensatz[s__Ausgabe=$reference]/id" />
		</xsl:variable>
	<!--<variable><xsl:valuect="$reference" /></variable>
	<reference><xsl:value-of select="//datensatz[s__Ausgabe=$reference]/id"></xsl:value-of></reference>-->
	
	<xsl:choose>
		<xsl:when test="((s__Aufsatz_Z) or (s__Aufsatz)) and ($id_parent[string-length() = 0])">
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
					
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
				</hierarchyFields>
			</functions>
			</xsl:when>
		<xsl:otherwise>
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="$id_parent"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Sachtitel" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$id_parent"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="Sachtitel" /></hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:choose>
							<xsl:when test="J_[string-length() != 0]">
								<xsl:value-of select="J_" />
								</xsl:when>
							<xsl:when test="contains(Ausgabe,'(')">
								<xsl:value-of select="substring-after(substring-before(Ausgabe,')'),'(')" />
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$title"/>
								</xsl:otherwise>
							</xsl:choose>
						</hierarchy_sequence>
				</hierarchyFields>
			</functions>
			</xsl:otherwise>
		</xsl:choose>
	
	<!--<xsl:if test="(s__Aufsatz_Z) or (s__Aufsatz)">
		<functions>
			<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:if>
		
	<xsl:if test="$id_parent[string-length() = 0]">
		<functions>
			<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:if>-->
	
	
	<!--<xsl:choosesl:when test="((s__Aufsatz_Z) or (s__Aufsatz)) and ($id_parent[string-length() = 0])">
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
					
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
				</hierarchyFields>
			</functions>
			</xsl:when>
		<xsl:otherwise>
			<functions>
				<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="$id_parent"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="Sachtitel" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$id_parent"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="Sachtitel" /></hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="$title" /></is_hierarchy_title>
				</hierarchyFields>
			</functions>
			</xsl:otherwise>
		</xsl:choose>-->
		
	
	
	<!--<xsl:if test="$id_parent[string-length() != 0]">
		<functions>
			<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="$title" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="$title" />
					</is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:if>-->
	
	
	<!--<xsl:if test="(s__ST) or (s__Aufsatz_Z) or (s__Aufsatz)">
		<xsl:variable name="s_ST" select="translate(s__ST, translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="s_Aufsatz" select="translate(s__Aufsatz_Z, translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="title">
					<xsl:choose>
					<xsl:when test="Inhalt-Thema[string-length() != 0]">
						<xsl:value-of select="replace(Inhalt-Thema[1],'_','')"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="Sachtitel"/>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:variable>
		<functions>
			<hierarchyFields>
				
				
				<xsl:if test="s__Aufsatz">
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="$title" />
					
					</hierarchy_top_title>
					</xsl:if>
					
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="$title" />
					
					</is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:if>-->
	
	<!--<xsl:if test="(s__ST) or (s__Aufsatz_Z)">
		<xsl:variable name="s_ST" select="translate(s__ST, translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="s_Aufsatz" select="translate(s__Aufsatz_Z, translate(.,'0123456789', ''), '')"/>
		<functions>
			<hierarchyFields>
				<xsl:if test="s__ST">
					<hierarchy_top_id><xsl:value-of select="//datensatz[id=$s_ST]/id" /><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title>
						<xsl:value-of select="//datensatz[id=$s_ST]/Zeitschr_-Titel" />
						<xsl:if test="//datensatz[id=$s_ST]/Untertitel">
							<xsl:text> : </xsl:text>
							<xsl:value-of select="//datensatz[id=$s_ST]/Untertitel" />
							</xsl:if>
					</hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$s_ST]/id" /><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:value-of select="//datensatz[id=$s_ST]/Zeitschr_-Titel" />
						<xsl:if test="//datensatz[id=$s_ST]/Untertitel">
							<xsl:text> : </xsl:text>
							<xsl:value-of select="//datensatz[id=$s_ST]/Untertitel" />
							</xsl:if>
					</hierarchy_parent_title>
					</xsl:if>
				
				<xsl:if test="s__Aufsatz_Z">
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Sachtitel" />
					<xsl:if test="Ausgabe">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Ausgabe" />
							</xsl:if></hierarchy_top_title>
					</xsl:if>
					
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Sachtitel" />
					<xsl:if test="Ausgabe">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Ausgabe" />
							</xsl:if></is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:if>-->
</xsl:if>










<!--Einzeltitel______________________Einzeltitel_______________________Einzeltitel-->

<xsl:if test="contains(objektart,'Einzeltitel')">

<xsl:element name="dataset">
	
	<!--<connect>
	<xsl:value-of select="$connect"/>
		</connect>-->
		
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>
	
	<!--documentType Objektartinformationen-->

				<!--<enrichYear><xsl:text>true</xsl:text></enrichYear>-->

<!--TITLE-->
			
	<!--title Titelinformationen-->
				<xsl:apply-templates select="Einzeltitel[1]"/>

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin[1]"/>
						
	<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<xsl:if test="(not(contains(.,'o. A.'))) and not(contains(.,'u.a.'))">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:if>
						</xsl:for-each>
					</xsl:if>
				
				<xsl:apply-templates select="Hrsg_[1]"/>
				
	<!--series Reiheninformation-->					
				<xsl:if test="substring(substring-after($connect,'edition:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'edition:'),':edition'), ';')">
					<edition>
						<xsl:value-of select="normalize-space(.)" />
						</edition>
						</xsl:for-each>
					</xsl:if>
	
	<!--edition Ausgabe-->
				<xsl:if test="substring(substring-after($connect,'ausgabe:'),1,1)!=':'">
					<edition>
						<xsl:value-of select="substring-before(substring-after($connect,'ausgabe:'),':ausgabe')" />
						</edition>
					</xsl:if>
			
<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
				<xsl:if test="substring(substring-after($connect,'isbn:'),1,1)!=':'">
					<isbn>
						<xsl:value-of select="substring-before(substring-after($connect,'isbn:'),':isbn')" />
						</isbn>
					</xsl:if>
					
				<xsl:if test="substring(substring-after($connect,'issn:'),1,1)!=':'">
					<issn>
						<xsl:value-of select="substring-before(substring-after($connect,'issn:'),':issn')" />
						</issn>
					</xsl:if>

	<!--ZDB-ID-->
				<xsl:if test="substring(substring-after($connect,'zdbid:'),1,1)!=':'">
					<zdbId>
						<xsl:value-of select="substring-before(substring-after($connect,'zdbid:'),':zdbid')" />
						</zdbId>
					</xsl:if>
						
<!--PUBLISHING-->

	<!--displayDate-->
				<xsl:if test="substring(substring-after($connect,'displayPublishDate:'),1,1)!=':'">
					<displayPublishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'displayPublishDate:'),':displayPublishDate')" />
						</displayPublishDate>
					
					<xsl:variable name="publishDate" select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						<xsl:for-each select="tokenize($publishDate,';')">
							<publishDate>
								<xsl:value-of select="normalize-space(.)"/>
								</publishDate>
							</xsl:for-each>
					</xsl:if>
				
				
				<!--<xsl:choose>
					<xsl:when test="substring(substring-after($connect,'displayPublishDate:'),1,1)!=':'">
						<displayPublishDate>
							<xsl:value-of select="substring-before(substring-after($connect,'displayPublishDate:'),':displayPublishDate')" />
							</displayPublishDate>
						
						<xsl:variable name="publishDate" select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
							<xsl:for-each select="tokenize($publishDate,';')">
								<publishDate>
									<xsl:value-of select="."/>
									</publishDate>
								</xsl:for-each>
						</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="ausgabe" select="substring-before(substring-after($connect,'ausgabe:'),':ausgabe')" />
						<displayPublishDate>							
							<xsl:value-of select="substring-after(substring-before($ausgabe,')'),'(')"></xsl:value-of>
							</displayPublishDate>
						<publishDate>
							<xsl:value-of select="substring-after(substring-before($ausgabe,')'),'(')"></xsl:value-of>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>-->
				
	<!--placeOfPublication angabe-->
				<xsl:if test="substring(substring-after($connect,'placeOfPublication:'),1,1)!=':'">
					<placeOfPublication>
						<xsl:value-of select="substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication')" />
						</placeOfPublication>
					</xsl:if>

	<!--publisher Verlagsangabe-->
				<xsl:if test="substring(substring-after($connect,'publisher:'),1,1)!=':'">
					<publisher>
						<xsl:value-of select="substring-before(substring-after($connect,'publisher:'),':publisher')" />
						</publisher>
					</xsl:if>
					
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
					</sourceInfo>
				
<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->	
				<xsl:apply-templates select="Umfang[1]"/>

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Deskriptoren1"></xsl:apply-templates>	

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--Heft-->
				<xsl:choose>
					<xsl:when test="substring(substring-after($connect,'issue:'),1,1)!=':'">
						<issue>
							<xsl:value-of select="substring-before(substring-after($connect,'issue:'),':issue')" />
							</issue>
						</xsl:when>
					<xsl:when test="substring(substring-after($connect,'ausgabe:'),1,1)!=':'">
						<!--<xsl:value-of select="substring-before(substring-after($connect,'ausgabe:'),':ausgabe')" />-->
						<xsl:variable name="ausgabe" select="substring-before(substring-after($connect,'ausgabe:'),':ausgabe')" />
						<issue>							
							<xsl:value-of select="substring-after($ausgabe,')')"></xsl:value-of>
							</issue>
						</xsl:when>
					</xsl:choose>

	<!--Volume-->
			<xsl:if test="substring(substring-after($connect,'volume:'),1,1)!=':'">
					<volume>
						<xsl:value-of select="substring-before(substring-after($connect,'volume:'),':volume')" />
						</volume>
					</xsl:if>
<!--OTHER-->
	
	<!--shelfMark-->
				<xsl:if test="substring(substring-after($connect,'shelfMark:'),1,1)!=':'">
					<shelfMark>
						<xsl:value-of select="substring-before(substring-after($connect,'shelfMark:'),':shelfMark')" />
						</shelfMark>
					</xsl:if>

</xsl:element>

<xsl:if test="s__Sachtitel">
<xsl:element name="functions">
	<!--<xsl:variable name="sachtitel" select="//datensatz[id=$s_sachtitel]/Sachtitel[1]" />
	<xsl:variable name="heftthema" select="//datensatz[id=$s_sachtitel]/Inhalt-Thema" />
	<xsl:variable name="heftausgabe" select="//datensatz[id=$s_sachtitel]/Ausgabe[1]" />-->
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>genderbib</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	</hierarchy_top_title>
	            
	           <hierarchy_parent_id>
	           	<xsl:value-of select="$s_sachtitel"/>
	           	<xsl:text>genderbib</xsl:text>
	           	</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	<!--<xsl:value-of select="$sachtitel"/>-->
	           	<!--<xsl:if test="substring(substring-after($connect,'topic:'),1,1)!=':'">
	           	
	           		<xsl:text>: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($connect,'topic:'),':topic')" />
				</xsl:if>
			<xsl:if test="substring(substring-after($connect,'ausgabe:'),1,1)!=':'">
				<xsl:text> </xsl:text>
				<xsl:value-of select="substring-before(substring-after($connect,'ausgabe:'),':ausgabe')" />
				</xsl:if>-->
			</hierarchy_parent_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>genderbib</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="Einzeltitel[1]"/>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring-before(Umfang, '-'))"/>
			</hierarchy_sequence>
	

	</xsl:element>
</xsl:element>
</xsl:if>
</xsl:if>



	
	


</xsl:element>
</xsl:if>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="Ausgabe">
		<edition>
			<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
			</edition>
		</xsl:template>
	
	<xsl:template match="Inhalt-Thema">
		<contentMatter>
			<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
			</contentMatter>
		</xsl:template>
	
	<xsl:template match="Sonderhefte">
		<specialIssue>
			<xsl:value-of select="normalize-space(.)"/>
			</specialIssue>
		</xsl:template>
	
	<xsl:template match="Lückenangabe">
		<outOfStocks>
			<xsl:value-of select="normalize-space(.)"/>
			</outOfStocks>
		</xsl:template>
	
	<xsl:template match="Ersch_-weise">
		<publicationFrequency>
			<xsl:value-of select="normalize-space(.)"/>
			</publicationFrequency>
		</xsl:template>

	<xsl:template match="Standort">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)"/>
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Bestandsangabe">
		<collectionHolding>
			<xsl:value-of select="."/>
			</collectionHolding>
		</xsl:template>

	<xsl:template match="Dok-art">
		<xsl:for-each select=".">
			<documentType>
				<xsl:value-of select="."/>
				</documentType>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="Sammeltitel">
		<xsl:choose>
			
			<xsl:when test="contains(.,'In: ')">
				<sourceInfo>
					<xsl:value-of select="substring-after(.,'In: ')" />
					<!--<xsl:text> (</xsl:text>
					<xsl:value-of select="../Jahr[1]" />
					<xsl:text>)</xsl:text>
					<xsl:choose>
					<xsl:when test="../Heft-Nr_">
						<xsl:value-of select="../Heft-Nr_" />
						</xsl:when>
					<xsl:when test="../H">
						<xsl:value-of select="../H" />
						</xsl:when>
					</xsl:choose>
					<xsl:if test="../Seitenzahlen">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="../Seitenzahlen" />
						</xsl:if>-->
					</sourceInfo>
				</xsl:when>
			
			<xsl:otherwise>
				
			<sourceInfo>
				<xsl:value-of select="." />
				
				<!--<xsl:choose>
					<xsl:when test="../Jahr[1]">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="../Jahr[1]" />
						<xsl:text>)</xsl:text>
						</xsl:when>
					<xsl:when test="../J_[1]">
						<xsl:text> (</xsl:text>
						<xsl:value-of select="../J_[1]" />
						<xsl:text>)</xsl:text>
						</xsl:when>
					</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="../Heft-Nr_">
						<xsl:value-of select="../Heft-Nr_" />
						</xsl:when>
					<xsl:when test="../H">
						<xsl:value-of select="../H" />
						</xsl:when>
					</xsl:choose>
					<xsl:if test="../Seitenzahlen">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="../Seitenzahlen" />
						</xsl:if>-->
			</sourceInfo>
				
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>

	<xsl:template match="Digitale_Dokumente">
		<url>
			<xsl:value-of select="." />
			</url>
		</xsl:template>
	
	<xsl:template match="Bd--ReihenNr_">
		<volume>
			<xsl:value-of select="." />
			</volume>
		</xsl:template>
	
	<xsl:template match="Reihentitel">
		<series>
			<xsl:value-of select="." />
			</series>
		</xsl:template>
	
	<xsl:template match="Seitenzahlen">
		<physical>
			<xsl:value-of select="." />
			</physical>
		</xsl:template>
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="." />
			</physical>
		</xsl:template>
	
	<xsl:template match="Laufzeit">
		<runTime>
			<xsl:value-of select="." />
			</runTime>
		</xsl:template>
	
	<xsl:template match="Jg_">
		<xsl:for-each select=".">
			<volume>
				<xsl:value-of select="." />
				</volume>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Jg-">
		<xsl:for-each select=".">
			<volume>
				<xsl:value-of select="." />
				</volume>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Heft-Nr_">
		<xsl:for-each select=".">
			<issue>
				<xsl:value-of select="."/>
				</issue>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="H">
		<xsl:for-each select=".">
			<issue>
				<xsl:value-of select="."/>
				</issue>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="ZDB-ID">
		<xsl:for-each select=".">
			<zdbId>
				<xsl:value-of select="normalize-space(.)" />
				</zdbId>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="ISSN">
		<xsl:for-each select=".">
			<xsl:if test="not(contains(.,'o.A.'))">
			<issn>
				<xsl:value-of select="normalize-space(.)" />
				</issn>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="ISBN">
		<xsl:for-each select=".">
			<isbn>
				<xsl:value-of select="normalize-space(.)" />
				</isbn>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="s__ST">
		<xsl:variable name="relatedID" select="translate(., translate(.,'0123456789', ''), '')"/>
		<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Sachtitel[1]" />
						<xsl:if test="../Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="../Inhalt-Thema"/>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:value-of select="../Ausgabe"/></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:value-of select="//datensatz[id=$relatedID]/Zeitschr_-Titel[1]" />
						<xsl:if test="//datensatz[id=$relatedID]/Untertitel[1]">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="//datensatz[id=$relatedID]/Untertitel[1]" />
							</xsl:if>
							</hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Sachtitel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
			</xsl:element>	
		</xsl:template>

	<xsl:template match="s__Aufsatz_Z">
		<xsl:variable name="relatedID" select="translate(., translate(.,'0123456789', ''), '')"/>
		<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Sachtitel[1]" />
						<xsl:if test="../Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="../Inhalt-Thema"/>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:value-of select="../Ausgabe"/></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:value-of select="//datensatz[id=$relatedID]/Zeitschr_-Titel[1]" />
						<xsl:if test="//datensatz[id=$relatedID]/Untertitel[1]">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="//datensatz[id=$relatedID]/Untertitel[1]" />
							</xsl:if>
							</hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Sachtitel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
			</xsl:element>	
		</xsl:template>

	<xsl:template match="s__Aufsatz">
		<xsl:variable name="relatedID" select="translate(../s__Zeitschriftentitel, translate(.,'0123456789', ''), '')"/>
		<xsl:element name="functions">	
			<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Sachtitel[1]" />
						<xsl:if test="../Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="../Inhalt-Thema"/>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:value-of select="../Ausgabe"/></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:value-of select="//datensatz[id=$relatedID]/Zeitschr_-Titel[1]" />
						<xsl:if test="//datensatz[id=$relatedID]/Untertitel[1]">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="//datensatz[id=$relatedID]/Untertitel[1]" />
							</xsl:if>
							</hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Sachtitel[1]" /></is_hierarchy_title>
				
				</hierarchyFields>
			</xsl:element>	
		</xsl:template>


	<xsl:template match="s__Ausgabe">
		<functions>
			<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../Zeitschr_-Titel" />
					<xsl:if test="../Untertitel">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="../Untertitel" />
							</xsl:if>
						</hierarchy_top_title>
					
				<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="../Zeitschr_-Titel" />
					<xsl:if test="../Untertitel">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="../Untertitel" />
							</xsl:if></is_hierarchy_title>
				</hierarchyFields>
			</functions>
		</xsl:template>

<!--Template Deskriptoren-->
	<xsl:template match="Deskriptoren1[1]">
		
		<!--<xsl:variable name="mapping">
				<xsl:for-each select="document('translation/GIB_VUFGAM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Gender and media ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGAS_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Gender and sports ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGBV_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Genderbased violence ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGCC_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Gender and climate change ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGFW_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Reconciliation between work, family and private life ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGIM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Institutional mechanisms for the advancement of women ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGME_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Men and gender equality ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFGRT_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Gender and research ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFWDM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Women and Decision-Making: political and economic ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				<xsl:for-each select="document('translation/GIB_VUFWEE_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1]/column_2">
					<xsl:text>Women and the Economy with particular focus on entrepreneurship ||</xsl:text>
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text><xsl:value-of select="normalize-space(../column_3)" /><xsl:text>|</xsl:text>
					</xsl:for-each>
				</xsl:variable>-->
		
		
		
		
		
		<xsl:for-each select="tokenize(.[1], ';')">
		
		<xsl:if test=".!=''">
		
		<xsl:variable name="deskriptor" select="normalize-space(.)" />
		
		<xsl:variable name="mapping">
			<xsl:for-each select="document('translation/GIB_VUFGAM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Gender and media ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGAS_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Gender and sports ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGBV_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Genderbased violence ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGCC_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Gender and climate change ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGFW_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Reconciliation between work, family and private life ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGIM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Institutional mechanisms for the advancement of women ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGME_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Men and gender equality  ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFGRT_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Gender and research ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFWDM_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Women and Decision-Making: political and economic ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
			<xsl:for-each select="document('translation/GIB_VUFWEE_keywords_translation.xml')/ooo_calc_export/ooo_sheet/ooo_row[position()>1][column_2=$deskriptor]">
				<xsl:text>Women and the Economy with particular focus on entrepreneurship ::</xsl:text><xsl:value-of select="column_3" /><xsl:text>;;</xsl:text>
				</xsl:for-each>
				</xsl:variable>
			
			
			<xsl:choose>
				<!--<xsl:when test="contains($mapping,$deskriptor)">-->
				<xsl:when test="contains($mapping,';;')">
					
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)"/>
						</subjectTopic>
						
					<xsl:for-each select="tokenize($mapping,';')">
					<xsl:if test=".!=''">
						<translatedTopic>
							<xsl:value-of select="normalize-space($deskriptor)" />
							<xsl:text> - </xsl:text>
							<xsl:value-of select="normalize-space(substring-after(.,'::'))" />
							</translatedTopic>
						<project>
							<xsl:value-of select="normalize-space(substring-before(.,'::'))" />
							</project>
						</xsl:if>
						</xsl:for-each>
					</xsl:when>
				<xsl:otherwise>
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)"/>
						</subjectTopic>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="Geografika">
		<xsl:for-each select="tokenize(., ';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectGeographic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Land">
		<xsl:for-each select="tokenize(., ';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectGeographic>
			</xsl:for-each>
		</xsl:template>
	
<!--Template Personen-->
	<xsl:template match="Personen[1]">
			<xsl:for-each select="tokenize(.[1], ';')">
				<subjectPerson>
					<xsl:value-of select="normalize-space(.)"/>
					</subjectPerson>
				</xsl:for-each>
		</xsl:template>

<!--Template Autorin-->	
	<xsl:template match="Autorin">
		<xsl:for-each select="tokenize(., ';')">
			<xsl:if test="(not(contains(.,'o. A.'))) and not(contains(.,'u.a.'))">
				<author>
					<xsl:value-of select="normalize-space(.)"/>
					</author>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>

<!--Template Herausgeberinnen-->
	<xsl:template match="Hrsg_">
		<xsl:for-each select="tokenize(., ';')">
			<xsl:if test="(not(contains(.,'o. A.'))) and not(contains(.,'u.a.'))">
			<editor>
				<xsl:value-of select="normalize-space(.)"/>
				</editor>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>
	
<!--Template Titel-->
	<xsl:template match="Titel">
		<xsl:choose>
			<xsl:when test="contains(.[1], ':')">
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(replace(.,'_',''), ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ':'))"/>
					</title_sub>
				</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

<!--Template Titeländg_-->

	<xsl:template match="Titeländg_">
		<formerTitle>
			<xsl:value-of select="." />
			</formerTitle>
		</xsl:template>

<!--Template Reihentitel-->
	<!--<xsl:template match="Reihentitel[1]">
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
		</xsl:template>-->

<!--Template Einzeltitel-->
	<xsl:template match="Einzeltitel[1]">
		<xsl:choose>
			<xsl:when test="contains(.[1], ':')">
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(replace(.,'_',''), ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ':'))"/>
					</title_sub>
				</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

<!--Template Zeitschriftentitel-->
	<xsl:template match="Zeitschr_-Titel[1]">
		<title>
			<xsl:value-of select="." />
			<xsl:if test="../Untertitel">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="../Untertitel" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of  select="." />
			</title_short>
		<xsl:if test="../Untertitel">
			<title_sub>
				<xsl:value-of select="../Untertitel" />
				</title_sub>
			</xsl:if>
		<!--<xsl:choose>
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
			<xsl:when test="../Untertitel!=''">
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(../Untertitel[1])"/>
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
			</xsl:choose>-->
		</xsl:template>

<!--Template Sachtitel-->
	<xsl:template match="Sachtitel">
		<xsl:choose>
			<xsl:when test="contains(., ':')">
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(replace(.,'_',''), ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
					</title_sub>
			</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
					</title>
				<title_short>
					<xsl:value-of select="."/>
					</title_short>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--Template Ortsangabe-->
	<xsl:template match="Ort[1]">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(.[1], 'o.A.'))">
				<placeOfPublication>
					<xsl:text>o. A.</xsl:text>
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
					<xsl:text>o. A.</xsl:text>
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
	<xsl:template match="Verlag">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(., 'o.A.'))">
				<publisher>
					<xsl:text>o. A.</xsl:text>
					</publisher>
			</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(., ';')">
						<xsl:for-each select="tokenize(., ';')">
							<publisher>
								<xsl:value-of select="normalize-space(.)"/>
								</publisher>
							</xsl:for-each>
						</xsl:when>
					<xsl:otherwise>
						<publisher>
							<xsl:value-of select="normalize-space(.)"/>
							</publisher>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:template>

<!--Template Jahr-->

<xsl:template match="Jahr">
		<xsl:variable name="year" select="."/>
			<xsl:choose>
				<xsl:when test="contains($year,';')">
					<xsl:for-each select="tokenize($year,';')">
							<publishDate>
								<xsl:value-of select="normalize-space(.)"/>
								</publishDate>
							</xsl:for-each>
					</xsl:when>
				<xsl:when test="string-length($year) &gt; 7">
					<publishDate>
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="normalize-space(substring-after(.[1], '/'))"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="Jahr[1]=''">
					<publishDate>
						<xsl:text>0000</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(contains(.[1], '[')) or (contains(.[1], '(')) or (contains(.[1], 'ca'))">
					<publishDate>
						<xsl:value-of select="normalize-space(translate(.[1], translate(.,'0123456789', ''), ''))"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="matches(.[1],'[a-z]')">
					<publishDate>
						<xsl:text>0000</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(matches(.[1],'/'))">
					<publishDate>
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="normalize-space(substring(.[1], 1,2))"/>
						<xsl:value-of select="normalize-space(substring-after(.[1], '/'))"/>
						</publishDate>
					</xsl:when>
				<xsl:otherwise>
					<publishDate>
						<xsl:value-of select="normalize-space(.[1])"/>
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:template>

	<!--<xsl:template match="Jahr[1]">
		<xsl:variable name="jear" select=".[1]"/>
			<xsl:choose>
				<xsl:when test="string-length($jear) &gt; 7">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring-after(.[1], '/')"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="Jahr[1]=''">
					<publishDate>
						<xsl:text>o. A.</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(contains(.[1], '[')) or (contains(.[1], '(')) or (contains(.[1], 'ca'))">
					<publishDate>
						<xsl:value-of select="normalize-space(translate(.[1], translate(.,'0123456789', ''), ''))"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="matches(.[1],'[a-z]')">
					<publishDate>
						<xsl:text>o. A.</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(matches(.[1],'/'))">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring(.[1], 1,2)"/>
						<xsl:value-of select="substring-after(.[1], '/')"/>
						</publishDate>
					</xsl:when>
				<xsl:otherwise>
					<publishDate>
						<xsl:value-of select=".[1]"/>
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:template>-->

<!--Template Ausleihe-->
	<xsl:template match="Ausleihe_an[1]">
		<xsl:if test=".[1]">
			<xsl:variable name="user" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<loan>
					<loanStatus><xsl:text>true</xsl:text></loanStatus>
					<loanReturn><xsl:value-of select="//datensatz[id=$user]/Rückgabe_am[1]"/></loanReturn>
					</loan>
			</xsl:if>
		</xsl:template>
	
<!--Template Sprachangabe-->
	<xsl:template match="Sprache">
		<xsl:choose>
			<xsl:when test="not(.)">
				<language>
					<xsl:text>o. A.</xsl:text>
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
			<xsl:variable name="zTitel" select="replace(replace(../s__Zeitschriftentitel[1], '[^0-9]', ''), '^1', '')"/>
			<xsl:variable name="z-ausgabe" select="../Ausgabe[1]"/>
			<xsl:variable name="s_sachtitel" select="replace(replace(../s__Sachtitel[1], '[^0-9]', ''), '^1', '')"/>
			<xsl:variable name="shelfMark1">
				<xsl:choose>
					<xsl:when test="substring(.[1],1,3)='III'">
						<xsl:text>III</xsl:text>
						</xsl:when>
					<xsl:when test="substring(.[1],1,2)='XX'">
						<xsl:text>XX</xsl:text>
						</xsl:when>
					<xsl:when test="(substring(.[1],1,4)='XVII') and (not(substring(.[1],1,5)='XVIII'))">
						<xsl:text>XVII</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))"/>
						</xsl:otherwise>
					</xsl:choose>
			</xsl:variable> 
			
			<xsl:variable name="shelfMark2">	
				<xsl:choose>
					<xsl:when test="contains(.[1], '/')">
						<xsl:value-of select="normalize-space(substring-before(.[1], '/'))"/>
						<xsl:value-of select="normalize-space(substring(substring-after(.[1], '/'),1,2))"/>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$shelfMark1"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
		
	<xsl:element name="systematikFields">
		<xsl:if test="../objektart[text()!='Zeitschrift/Heftitel']">
			<systematik_parent_id><xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/vufind/id"/></systematik_parent_id>
			<systematik_parent_title><xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/dataset/title"/></systematik_parent_title>
			</xsl:if>
	</xsl:element>
		
		
	<xsl:element name="hierarchyFields">
		
	<!--für Sammelbände-->
		<xsl:if test="../s__Aufsatz">
			<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
            		<hierarchy_top_title>
            			<xsl:value-of select="../Sachtitel[1]"/>
            			<xsl:if test="Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="Inhalt-Thema"/>
					</xsl:if>
				<xsl:if test="$z-ausgabe">
						<xsl:text> </xsl:text>
						<xsl:value-of select="$z-ausgabe"/>
					</xsl:if>
            		</hierarchy_top_title>
           	</xsl:if>
           
           <!--für Zeitschriften-->	
           	<xsl:if test="../objektart[text()='Zeitschrift']">
			<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
            		<hierarchy_top_title>
            			<xsl:value-of select="../Zeitschr_-Titel[1]"/>
            			<xsl:if test="../Untertitel[1]">
            				<xsl:text> : </xsl:text>
            				<xsl:value-of select="../Untertitel[1]"></xsl:value-of>
            			</xsl:if>
            		</hierarchy_top_title>
           	</xsl:if>
	
	<!--für Datensätze mit Signatur-->
		<xsl:if test="$shelfMark2!=''">
			<hierarchy_top_id><xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/vufind/id"/></hierarchy_top_id>
            		<hierarchy_top_title><xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/dataset/title"/></hierarchy_top_title>
            	</xsl:if>
            
            <!--für Zeitschriften/Hefttitel-->
            	<xsl:if test="$zTitel">
            		<hierarchy_top_id><xsl:value-of select="//datensatz[id=$zTitel]/id"/><xsl:text>genderbib</xsl:text></hierarchy_top_id>
			<hierarchy_top_title>
				<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Zeitschr_-Titel[1]"/>
				<xsl:if test="//genderbib/datensatz[id=$zTitel]/Untertitel[1]">
            				<xsl:text> : </xsl:text>
            				<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Untertitel[1]"></xsl:value-of>
            			</xsl:if>
			</hierarchy_top_title>
			
			<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$zTitel]/id"/><xsl:text>genderbib</xsl:text></hierarchy_parent_id>
			<hierarchy_parent_title>
				<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Zeitschr_-Titel[1]"/>
				<xsl:if test="//genderbib/datensatz[id=$zTitel]/Untertitel[1]">
            				<xsl:text> : </xsl:text>
            				<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Untertitel[1]"></xsl:value-of>
            			</xsl:if>
			</hierarchy_parent_title>
            		</xsl:if>
            
            <!--für nicht(Hefttitel)-->
            	<xsl:if test="$zTitel=''">
            		<hierarchy_parent_id>
				<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/vufind/id"/>
			</hierarchy_parent_id>
			<hierarchy_parent_title>
				<xsl:value-of select="document('classification.xml')//record[@id=$shelfMark2]/dataset/title"/>
			</hierarchy_parent_title>
            		</xsl:if>
            		
            <!--der eigene Datensatz-->
            	<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
		<is_hierarchy_title><xsl:choose>
						<xsl:when test="../Sachtitel[1]">
							<xsl:value-of select="../Sachtitel[1]"/>
							<xsl:if test="../Inhalt-Thema">
								<xsl:text>: </xsl:text>
								<xsl:value-of select="../Inhalt-Thema"/>
								</xsl:if>
							<xsl:if test="$z-ausgabe">
								<xsl:text> </xsl:text>
								<xsl:value-of select="$z-ausgabe"/>
							</xsl:if>
							</xsl:when>
						<xsl:when test="../Titel[1]"><xsl:value-of select="../Titel[1]"/></xsl:when>
						<xsl:when test="../Einzeltitel[1]"><xsl:value-of select="../Einzeltitel[1]"/></xsl:when>
						<xsl:when test="../Sammeltitel[1]"><xsl:value-of select="../Sammeltitel[1]"/></xsl:when>
						<xsl:when test="../Zeitschr_-Titel[1]">
							<xsl:value-of select="../Zeitschr_-Titel[1]"/>
							<xsl:if test="../Untertitel[1]">
            							<xsl:text> : </xsl:text>
            							<xsl:value-of select="../Untertitel[1]"></xsl:value-of>
            							</xsl:if>
						</xsl:when>
					</xsl:choose>
		</is_hierarchy_title>
		
		<hierarchy_sequence>
			<xsl:choose>
				<xsl:when test="../Titel[1]"><xsl:value-of select="normalize-space(substring(../Titel[1],1,10))"/></xsl:when>
				<xsl:when test="../Sachtitel[1]"><xsl:value-of select="normalize-space(substring(../Sachtitel[1],1,10))"/></xsl:when>
				<xsl:when test="../Einzeltitel[1]"><xsl:value-of select="normalize-space(substring(../Einzeltitel[1],1,10))"/></xsl:when>
				<xsl:when test="../Sammeltitel[1]"><xsl:value-of select="normalize-space(substring(../Sammeltitel[1],1,10))"/></xsl:when>
				<xsl:when test="../Zeitschr_-Titel[1]"><xsl:value-of select="normalize-space(substring(../Zeitschr_-Titel[1],1,10))"/></xsl:when>
				</xsl:choose>
			</hierarchy_sequence>
	
	</xsl:element>	

</xsl:template>
</xsl:stylesheet>
