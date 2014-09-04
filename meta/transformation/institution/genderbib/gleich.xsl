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

		<xsl:if test="objektart[text()!='NutzerIn']"><!--Datensätze dieser Objektart werden nicht umgewandelt-->

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
				<xsl:choose>
					<xsl:when test="erfaßt_am- !=''">
						<recordCreationDate>
							<xsl:value-of select="substring(erfaßt_am-[1],7,4)"/><!--jahr-->
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfaßt_am-[1],4,2)"/><!--monat-->
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfaßt_am-[1],1,2)"/><!--tag-->
							<xsl:text>T</xsl:text>
							<xsl:text>00:00:00Z</xsl:text>
							</recordCreationDate>
						</xsl:when>
					<xsl:otherwise>
						<recordCreationDate>
							<xsl:value-of select="current-dateTime()"/>
							</recordCreationDate>
						</xsl:otherwise>
					</xsl:choose>
					
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
	
<!--institutionFullname-->			<institutionsFullname>
							<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
							</institutionsFullname>
			
<!--collection-->				<collection><xsl:text>GReTA Katalog</xsl:text></collection>
	
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

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Sachtitel[1]">
					<xsl:apply-templates select="Sachtitel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg_[1]">
					<xsl:apply-templates select="Hrsg_[1]"/>
					</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
						 </series>
						</xsl:if>
				<xsl:if test="Bd--ReihenNr_">
					<seriesNr>
						<xsl:value-of select="Bd--ReihenNr_"/>
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
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]"/>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>
					
<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>
				
<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o.A.</language></xsl:otherwise>
					</xsl:choose>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika"/>
						</subjectGeographic>
					</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
						</subjectGeographic>
					</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
					</xsl:if>
			
<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>
				
<!--projectMark-->	
				<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					</project>
</xsl:element>


<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
					</xsl:if>
	
<!--hierarchyFields--> 	<xsl:apply-templates select="Sign_[1]"/>
	
</xsl:element>	
				
</xsl:if>










<!--Hochschularbeit_____________________Magistraarbeit_____________________Abschlussarbeit-->

<xsl:if test="(objektart[text()='Magistra/Magister Gender Studies']) or (objektart[text()='Abschlussarbeit'])">

<!--Zu den Hochschularbeiten gehören die Magistraarbeiten des Studiengangs sowie Abschlussarbeiten aus anderen Bereichen.
Die genaue Zuordnung der einzelnen Hochschularbeiten erfolgt über das Feld documentType. Hier wird aus den 
Datensätzen ausgelesen, um welche Art von Hochschularbeit es sich handelt-->

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]"/>
					</xsl:if>

<!--reviewer Gutachterin-->
				<xsl:if test="Gutachter_in[1]">
					<reviewer>
						<xsl:value-of select="Gutachter_in[1]" />
						</reviewer>
					</xsl:if>

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Hochschularbeit</xsl:text>
					</format>

<!--documentType Dokumentinformation-->
				<xsl:if test="objektart[text()='Magistra/Magister Gender Studies']">
					<documentType>
						<xsl:text>Magistra/Magister Gender Studies</xsl:text>
						</documentType>
					</xsl:if>
				<xsl:if test="Dok-art">
					<documentType>
						<xsl:value-of select="Dok-art[1]"/>
						</documentType>
					</xsl:if>

<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]"/>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o.A.</language></xsl:otherwise>
					</xsl:choose>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika"/>
						</subjectGeographic>
					</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
						</subjectGeographic>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
				</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

<!--projectMark-->	
				<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
									<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
									<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					</project>
				
</xsl:element>


<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
					</xsl:if>
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
					</xsl:if>

</xsl:element>	

</xsl:if>










<!--Artikel___________________________Aktenschrank___________________________Artikel-->

<xsl:if test="objektart[text()='Artikel']">

<!--Artikel aus dem Aktenschrank umfassen alle Artikel, die einzeln im Aktenschrank gesammelt werden-->

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Einzeltitel!=''"><xsl:apply-templates select="Einzeltitel[1]"/></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Sammeltitel[1]"/></xsl:otherwise>
					</xsl:choose>
					
<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]"/>
					</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Artikel (Aktenschrank)</xsl:text>
					</format>

<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]"/>
					</xsl:if>

<!--issue Heft-->
				<xsl:if test="Heft-Nr_">
					<issue>
						<xsl:value-of select="Heft-Nr_"/>
						</issue>
					</xsl:if>

<!--volume Jahrgang-->
				<xsl:if test="Jg_">
					<xsl:for-each select="Jg_">
						<volume>
							<xsl:value-of select="."/>
							</volume>
						</xsl:for-each>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o.A.</language></xsl:otherwise>
					</xsl:choose>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika"/>
						</subjectGeographic>
					</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
						</subjectGeographic>
					</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
					</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

<!--projectMark-->	
				<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
								</xsl:if>
						</xsl:for-each>
					                      </project>
</xsl:element>

<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>

</xsl:element>	

</xsl:if>












<!--Online-Artikel_________________________Online-Artikel_______________________Online-Artikel-->

<xsl:if test="objektart[text()='Online-Artikel']">

<!--Onlineartikel sind Datensätze die eine URL zum eigentlichen Artikel im Netz enthalten. Ob diese
URLs noch stimmen kann hier nicht geprüft werden.-->

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Titel!=''"><xsl:apply-templates select="Titel[1]"/></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Sammeltitel[1]"/></xsl:otherwise>
					</xsl:choose>
					
<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>
				
<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
						</series>
					</xsl:if>
			
<!--format Objektartinformationen-->
				<format>
					<xsl:text>Online-Artikel</xsl:text>
					</format>
					
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
					<xsl:when test="Jahr[1]"><xsl:apply-templates select="Jahr[1]"/></xsl:when>
					<xsl:otherwise>
						<publishDate>
							<xsl:value-of select="J_[1]"/>
							</publishDate>
						</xsl:otherwise>
					</xsl:choose>

<!--issue Heft-->
				<xsl:if test="H">
					<issue>
						<xsl:value-of select="H"/>
						</issue>
					</xsl:if>

<!--volume Jahrgang-->
				<xsl:if test="Jg-">
					<volume>
						<xsl:value-of select="Jg-"/>
						</volume>
					</xsl:if>


<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:choose>
					<xsl:when test="Sprache[1]"><xsl:apply-templates select="Sprache[1]"/></xsl:when>
					<xsl:otherwise><language>o.A.</language></xsl:otherwise>
					</xsl:choose>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				
				<xsl:if test="Geografika">
					<xsl:apply-templates select="Geografika[1]"/>
					</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
					</subjectGeographic>
					</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
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
						<xsl:value-of select="Digitale_Dokumente"/>
						</url>
					</xsl:if>

<!--projectMark-->	
				<project>
					<xsl:for-each select="tokenize(Deskriptoren1[1], ';')">
						<xsl:variable name="topic" select="normalize-space(.)"/>
							<xsl:if test="document('keywords.xml')/root/systemstelle/keyword=$topic">
								<xsl:value-of select="document('keywords.xml')/root/systemstelle[keyword=$topic]/@id"/>
								<xsl:text> </xsl:text>			
							</xsl:if>
						</xsl:for-each>
					</project>
</xsl:element>

<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>

</xsl:element>	

</xsl:if>









<!--Video/DVD____________________Video/DVD______________________________Video/DVD-->

<xsl:if test="objektart[text()='Video/DVD']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
					<xsl:text>Video</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Titel[1]">
					<xsl:apply-templates select="Titel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]"/>
					</xsl:if>

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Video / DVD</xsl:text>
					</format>

<!--displayDate-->
				<xsl:if test="Jahr">
					<displayPublishDate>
						<xsl:value-of select="Jahr"/>
						</displayPublishDate>
					</xsl:if>	

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]"/>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>

<!--runTime Laufzeit DVD-->
				<xsl:if test="Laufzeit !=''">
					<runTime>
						<xsl:value-of select="Laufzeit"/>
						</runTime>
					</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]"/>
					</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
					</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika"/>
						</subjectGeographic>
					</xsl:if>
				
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
						</subjectGeographic>
					</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
					</xsl:if>
			

<!--shelfMark Signatur-->
				<xsl:if test="Sign_[1]">
					<shelfMark>
						<xsl:value-of select="Sign_[1]"/>
						</shelfMark>
					</xsl:if>

</xsl:element>

<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>

</xsl:element>	

</xsl:if>










<!--Online-Zeitschrift_________________________Online-Zeitschrift_______________________Online-Zeitschrift-->

<xsl:if test="objektart[text()='Online-Zeitschrift']">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:choose>
					<xsl:when test="Sachtitel!=''"><xsl:apply-templates select="Sachtitel[1]"/></xsl:when>
					<xsl:otherwise><xsl:apply-templates select="Zeitschr_-Titel[1]"/></xsl:otherwise>
					</xsl:choose>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]"/>
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
					<xsl:text>Online-Zeitschrift</xsl:text>
					</format>
<!--ISBN / ISSN-->

				<xsl:if test="ISSN">
					<issn>
						<xsl:value-of select="ISSN"/>
						</issn>
					</xsl:if>

<!--displayDate-->
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

<!--timeSpan Laufzeit / Publishdate-->
				<xsl:choose>
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
					</xsl:choose>	

<!--issue Heft-->
				<xsl:if test="H">
					<issue>
						<xsl:value-of select="H"/>
						</issue>
					</xsl:if>

<!--volume Jahrgang-->
				<xsl:if test="Jg-">
					<xsl:for-each select="Jg-">
						<volume>
							<xsl:value-of select="."/>
							</volume>
						</xsl:for-each>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
				</xsl:if>

<!--language Sprachangaben-->
				<xsl:if test="Sprache[1]">
					<xsl:apply-templates select="Sprache[1]"/>
				</xsl:if>
				
<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren1[1]">
					<xsl:apply-templates select="Deskriptoren1[1]"/>
				</xsl:if>

<!--subjectGeographic Ortsangaben-->
				<xsl:if test="Geografika">
					<subjectGeographic>
						<xsl:value-of select="Geografika"/>
						</subjectGeographic>
					</xsl:if>
			
				<xsl:if test="Land">
					<subjectGeographic>
						<xsl:value-of select="Land"/>
						</subjectGeographic>
					</xsl:if>
			
<!--subjectPerson Personenangaben-->
				<xsl:if test="Personen">
					<xsl:apply-templates select="Personen"/>
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
						<xsl:value-of select="Digitale_Dokumente"/>
						</url>
					</xsl:if>

</xsl:element>

<xsl:if test="Sign_[1]">
	<xsl:element name="functions">
		<xsl:element name="hierarchyFields">
			<hierarchy_top_id>ZZeitschrifgenderbib</hierarchy_top_id>
	           	<hierarchy_top_title>Zeitschriften</hierarchy_top_title>
           		<hierarchy_parent_id>ZZeitschrifgenderbib</hierarchy_parent_id>
			<hierarchy_parent_title>Zeitschriften</hierarchy_parent_title>
			<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>genderbib</xsl:text></is_hierarchy_id>
			<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="Sachtitel!=''"><xsl:value-of select="Sachtitel[1]"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="Zeitschr_-Titel[1]"/></xsl:otherwise>
					</xsl:choose>
			</is_hierarchy_title>
			<hierarchy_sequence>
				<xsl:choose>
					<xsl:when test="Sachtitel!=''"><xsl:value-of select="normalize-space(substring(Sachtitel[1],1,10))"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="normalize-space(substring(Zeitschr_-Titel[1],1,10))"/></xsl:otherwise>
				</xsl:choose>
			</hierarchy_sequence>
		</xsl:element>
	</xsl:element>	
</xsl:if>

</xsl:if>











<!--Zeitschrift_____________________Zeitschrift______________________Zeitschrift-->

<xsl:if test="objektart[text()='Zeitschrift']">

<!--Bei den Zeitschriften handelt es sich um Metadatensätze. Hier stehen die Angaben zur
Veröffentlichungsort etc. Mit diesen Angaben werden die Informationen in den 
Zeitschriften/Hefttiteln angereichert. Eine Zeitschrift kann nicht ausgeliehen werden.-->

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Zeitschr_-Titel">
					<xsl:apply-templates select="Zeitschr_-Titel"/>
					</xsl:if>
					

<!--format Objektartinformationen-->
				<format>
					<xsl:text>Zeitschrift</xsl:text>
					</format>

<!--ISBN / ISSN-->
				<xsl:if test="ISSN">
					<issn>
						<xsl:value-of select="ISSN"/>
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

<!--timeSpan Laufzeit / Publishdate-->
				<xsl:choose>
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
					<xsl:apply-templates select="Ersch_-ort[1]"/>
					</xsl:if>

<!--publisher Verlagsangabe-->
				<xsl:if test="Verlag[1]">
					<xsl:apply-templates select="Verlag[1]"/>
					</xsl:if>
				
</xsl:element>

<xsl:element name="functions">
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>

</xsl:element>	
	
			
</xsl:if>










<!--Zeitschrift/Heftitel_____________________Zeitschrift/Heftitel______________________Zeitschrift/Heftitel-->

<xsl:if test="objektart[text()='Zeitschrift/Heftitel']">

<!--Zeitschriftenhefttitel gehören zu einer Zeitschrift. Ein Zeitschriftenhefttitel hat Einzeltitel. 
Im Gegensatz zur Zeitschrift ist ein Hefttitel ausleihbar.-->

<xsl:variable name="zTitel" select="translate(s__Zeitschriftentitel[1], translate(.,'0123456789', ''), '')"/>

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>


<!--title Titelinformationen-->
					<title>
						<xsl:value-of select="Sachtitel[1]"/>
						<xsl:if test="Inhalt-Thema">
							<xsl:text>: </xsl:text>
							<xsl:value-of select="Inhalt-Thema"/>
							</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:value-of select="$z-ausgabe"/>
						</title>
					
					<title_short>
						<xsl:value-of select="Sachtitel"/>
						</title_short>
					
					<xsl:if test="Inhalt-Thema">
						<title_sub>
							<xsl:value-of select="Inhalt-Thema"/>
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
					<xsl:if test="//datensatz[id=$zTitel]/ISSN">
						<issn>
							<xsl:value-of select="//datensatz[id=$zTitel]/ISSN"/>
							</issn>
						</xsl:if>

<!--ZDB-ID-->
					<xsl:if test="//datensatz[id=$zTitel]/ZDB-ID">
						<zdbId>
							<xsl:value-of select="//datensatz[id=$zTitel]/ZDB-ID"/>
							</zdbId>
						</xsl:if>

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
					

<!--issue Heft-->				
					<xsl:if test="H">
						<issue>
							<xsl:value-of select="H"/>
							</issue>
						</xsl:if>

<!--loan-->
			
	
<!--volume Jahrgang-->
				
<!--placeOfPublication Ortsangabe-->	
					<!--<xsl:choose>
						<xsl:when test="Ersch_-ort!=''">
							<placeOfPublication>
								<xsl:value-of select="Ersch_-ort[1]"/>
								</placeOfPublication>
							</xsl:when>
						<xsl:otherwise>
							<placeOfPublication>
								<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Ersch_-ort[1]"/>
								</placeOfPublication>
							</xsl:otherwise>
						</xsl:choose>-->

<!--publisher Verlagsangabe-->
					<!--<xsl:choose>
						<xsl:when test="Verlag">
							<publisher>
								<xsl:value-of select="Verlag[1]"/>
								</publisher>
							</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="//genderbib/datensatz[id=$zTitel]/Verlag[1]"/>
								</publisher>
							</xsl:otherwise>
						</xsl:choose>-->


</xsl:element>

<xsl:element name="functions">
	
<!--loan-->			<xsl:if test="Ausleihe_an[1]">
					<xsl:apply-templates select="Ausleihe_an[1]"/>
				</xsl:if>
	
<!--hierarchyFields--> 	<xsl:if test="Sign_[1]">
					<xsl:apply-templates select="Sign_[1]"/>
				</xsl:if>

</xsl:element>	

</xsl:if>










<!--Einzeltitel______________________Einzeltitel_______________________Einzeltitel-->

<xsl:if test="contains(objektart,'Einzeltitel')">

<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>
				
<!--title Titelinformationen-->
				<xsl:if test="Einzeltitel[1]">
					<xsl:apply-templates select="Einzeltitel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="Autorin[1]">
					<xsl:apply-templates select="Autorin[1]"/>
					</xsl:if>

<!--editor Herausgeberinneninformationen-->
				<xsl:if test="Hrsg[1]">
					<xsl:apply-templates select="Hrsg[1]"/>
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
	<xsl:variable name="sachtitel" select="//datensatz[id=$s_sachtitel]/Sachtitel[1]" />
	<xsl:variable name="heftthema" select="//datensatz[id=$s_sachtitel]/Inhalt-Thema" />
	<xsl:variable name="heftausgabe" select="//datensatz[id=$s_sachtitel]/Ausgabe[1]" />
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>genderbib</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="$sachtitel"/>
	           	<xsl:if test="$heftthema">
	           		<xsl:text>: </xsl:text>
				<xsl:value-of select="$heftthema"/>
				</xsl:if>
			<xsl:if test="$heftausgabe">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$heftausgabe"/>
				</xsl:if>
	           	</hierarchy_top_title>
	            
	           <hierarchy_parent_id>
	           	<xsl:value-of select="$s_sachtitel"/>
	           	<xsl:text>genderbib</xsl:text>
	           	</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="$sachtitel"/>
			<xsl:if test="$heftthema">
	           		<xsl:text>: </xsl:text>
				<xsl:value-of select="$heftthema"/>
				</xsl:if>
			<xsl:if test="$heftausgabe">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$heftausgabe"/>
				</xsl:if>
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



	
	


</xsl:element>
</xsl:if>
</xsl:template>








<!--Templates-->










<!--Template Deskriptoren-->
	<xsl:template match="Deskriptoren1[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectTopic>
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
	<xsl:template match="Autorin[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<author>
				<xsl:value-of select="normalize-space(.)"/>
				</author>
			</xsl:for-each>
		</xsl:template>

<!--Template Herausgeberinnen-->
	<xsl:template match="Hrsg_[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<editor>
				<xsl:value-of select="normalize-space(.)"/>
				</editor>
			</xsl:for-each>
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

<!--Template Zeitschriftentitel-->
	<xsl:template match="Zeitschr_-Titel[1]">
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
		</xsl:template>

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

<!--Template Geografika-->
	<xsl:template match="Geografika">
		<xsl:for-each select="tokenize(.[1], ';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectGeographic>
			</xsl:for-each>
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
