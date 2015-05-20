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
	
	<xsl:template match="@*[.='']"/><!-- Leere Knoten werden entfernt-->
	
	<xsl:strip-space elements="*"/><!--Whitespace entfernen-->

	<xsl:template match="saar">
		<xsl:element name="catalog">
			<xsl:for-each select="object">

			
		<xsl:if test="objektart[text()='Buch']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>	
	
	
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="objektnummer" />
					<xsl:text>saar</xsl:text>
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
					<xsl:when test="(contains(Dokumentart,'film')) or
								(contains(Dokumentart,'DVD')) or
								(contains(Dokumentart,'Video'))">
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
							<xsl:text>FrauenGenderBibliothek Saar</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>FrauenGenderBibliothek Saar</xsl:text>
							</institutionFull>
						
						<institutionID>
							<xsl:text>saar</xsl:text>
							</institutionID>
						
<!--collection-->				<collection><xsl:text>Saar</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>ISIL DE-Sa24</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/frauengenderbibliothek-saar/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>49.2307100</latitude>
							<longitude>7.0074400</longitude>
							</geoLocation>
			
</xsl:element>


	
	
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
						
						
			
					
			<!--<xsl:apply-templates select="Erf.-stelle" />-->
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<xsl:choose>
						<!--<xsl:when test="Dokumentart[text()=' Sammelwerk, Zeitschrift']">-->
						<xsl:when test="(contains(Dokumentart,'Zeitschrift')) or
									(contains(Dokumentart,'Zeitung')) ">
							<format><xsl:text>Zeitschrift</xsl:text></format>
							</xsl:when>
						<xsl:when test="(contains(Dokumentart,'Aufsatz')) or
									(contains(Dokumentart,'Interview')) or
									(contains(Dokumentart,'Artikel'))">
							<format><xsl:text>Artikel</xsl:text></format>
							</xsl:when>
						<xsl:when test="(contains(Dokumentart,'Diplomarbeit')) or
									(contains(Dokumentart,'Diss')) or 
									(contains(Dokumentart,'Examensarbeit')) or 
									(contains(Dokumentart,'Habilitationsschrift'))or 
									(contains(Dokumentart,'Magisterarbeit'))or 
									(contains(Dokumentart,'Magistra'))">
							<format><xsl:text>Hochschulschrift</xsl:text></format>
							</xsl:when>
						<xsl:when test="(contains(Dokumentart,'film')) or
									(contains(Dokumentart,'DVD')) or
									(contains(Dokumentart,'Video'))">
							<format><xsl:text>Film</xsl:text></format>
							</xsl:when>
						<xsl:when test="(contains(Dokumentart,'CD')) or
									(contains(Dokumentart,'DVD')) or
									(contains(Dokumentart,'Hör')) or
									(contains(Dokumentart,'MC')) or
									(contains(Dokumentart,'Musik-Cassette'))">
							<format><xsl:text>Tonträger</xsl:text></format>
							</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="contains(Seitenangabe_der_Zeitschrift,'-')">
									<format><xsl:text>Artikel</xsl:text></format>
									</xsl:when>
								<xsl:otherwise>
									<format><xsl:text>Buch</xsl:text></format>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					
			<!--documentType-->
					<xsl:apply-templates select="Dokumentart[string-length() != 0]" />

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Titel[string-length() != 0]">
							<xsl:apply-templates select="Titel[string-length() != 0]" />
							</xsl:when>
						<xsl:when test="Titel_des_Sammelwerkes[string-length() != 0]">
							<title>
								<xsl:value-of select="normalize-space(Titel_des_Sammelwerkes)" />
								</title>
							<title_short>
								<xsl:value-of select="normalize-space(Titel_des_Sammelwerkes)" />
								</title_short>
							</xsl:when>
						<xsl:when test="Zeitschriftentitel[string-length() != 0]">
							<title>
								<xsl:value-of select="normalize-space(Zeitschriftentitel)" />
								</title>
							<title_short>
								<xsl:value-of select="normalize-space(Zeitschriftentitel)" />
								</title_short>
							</xsl:when>
						</xsl:choose>
					
					<xsl:apply-templates select="Originaltitel[string-length() != 0]" />


<!--RESPONSIBLE-->
					
			<!--author-->
					<xsl:apply-templates select="AutorIn[string-length() != 0]" />
					<xsl:apply-templates select="Co-AutorIn[string-length() != 0]" />
			
			<!--editor-->
					<xsl:apply-templates select="HerausgeberIn_der_Zeitschrift[string-length() != 0]" />
			
			<!--entity-->
					<xsl:apply-templates select="Körperschaftsname[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />


<!--IDENTIFIER-->

			<!--isbn issn-->
					<xsl:apply-templates select="ISBN[string-length() != 0]" />
					<xsl:apply-templates select="ISSN[string-length() != 0]" />
			
		
<!--PUBLISHING-->

			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />
			
			<!--sourceInfo-->
					<xsl:apply-templates select="Zeitschriftentitel[string-length() != 0]" />
					<xsl:apply-templates select="Titel_des_Sammelwerkes[string-length() != 0]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Erscheinungsort[string-length() != 0]" />	
				
			<!--publisher-->
					<xsl:apply-templates select="Verlag[string-length() != 0]" />

			<!--edition-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />
					
<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seitenangabe_der_Zeitschrift[string-length() != 0]" />
					<xsl:apply-templates select="Seitenzahl[string-length() != 0]" />
					
			
<!--CONTENTRELATED INFORMATION-->
			
				
			<!--subjectTopic Deskriptoren-->
					<!--<xsl:apply-templates select="Buch-Desk[string-length() != 0]" />-->
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:choose>
						<xsl:when test="Kurzreferat[string-length() != 0]">
							<xsl:apply-templates select="Kurzreferat[string-length() != 0]" />
							</xsl:when>
						<xsl:when test="Kurzbeschreibung[string-length() != 0]">
							<xsl:apply-templates select="Kurzbeschreibung[string-length() != 0]" />
							</xsl:when>
						<xsl:when test="Buch-Desk[string-length() != 0]">
							<xsl:apply-templates select="Buch-Desk[string-length() != 0]" />
							</xsl:when>
						</xsl:choose>
					<!--<xsl:apply-templates select="Kurzreferat[string-length() != 0]" />-->

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->
				<xsl:apply-templates select="Heft-Nr._der_Zeitschrift[string-length() != 0]" />
	<!--volume Band-->
				<!--<xsl:apply-templates select="Jahrgang__Bandangabe_der_Zeitschrift[string-length() != 0]" />-->
				

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
			
						
				
						</xsl:element>
						<!--closing tag dataset-->
			
<!--hierarchy-->
	
	
			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
		
			
				</xsl:for-each><!--closing tag for-each Schleife datansatz-->

















			
	</xsl:element>
	</xsl:template>










<!--Templates-->	
			
			<!--<xsl:template match="Buch-Desk">
				<xsl:for-each select="tokenize(.,' ')">
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)" />
						</subjectTopic>
					</xsl:for-each>
				</xsl:template>-->
		
			<xsl:template match="Buch-Desk">
				<description>
					<xsl:text>Deskriptoren: </xsl:text>
					<xsl:value-of select="normalize-space(.)" />
					</description>
				</xsl:template>
			
			
			<xsl:template match="Kurzbeschreibung">
				<description>
					<xsl:if test="../Buch-Desk[string-length() != 0]">
						<xsl:text>Deskriptoren: </xsl:text>
						<xsl:value-of select="normalize-space(../Buch-Desk)" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:value-of select="normalize-space(.)" />
					</description>
				</xsl:template>
			
			<xsl:template match="Kurzreferat">
				<description>
					<xsl:if test="../Buch-Desk[string-length() != 0]">
						<xsl:text>Deskriptoren: </xsl:text>
						<xsl:value-of select="normalize-space(../Buch-Desk)" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:if test="../Kurzbeschreibung[string-length() != 0]">
						<xsl:value-of select="normalize-space(../Kurzbeschreibung)" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:value-of select="normalize-space(.)" />
					</description>
				</xsl:template>
			
			<xsl:template match="Signatur">
				<shelfMark>
					<xsl:value-of select="normalize-space(.)" />
					</shelfMark>
				</xsl:template>
			
			<xsl:template match="ISSN">
				<issn>
					<xsl:value-of select="normalize-space(.)" />
					</issn>
				</xsl:template>
			
			<xsl:template match="ISBN">
				<isbn>
					<xsl:value-of select="normalize-space(.)" />
					</isbn>
				</xsl:template>
			
			<xsl:template match="Reihentitel">
				<series>
					<xsl:value-of select="normalize-space(.)" />
					</series>
				</xsl:template>
			
			<xsl:template match="Auflage">
				<edition>
					<xsl:value-of select="normalize-space(.)" />
					</edition>
				</xsl:template>
			
			<xsl:template match="Verlag">
				<publisher>
					<xsl:value-of select="normalize-space(.)" />
					</publisher>
				</xsl:template>
		
			<xsl:template match="Erscheinungsort">
				<placeOfPublication>
					<xsl:value-of select="normalize-space(.)" />
					</placeOfPublication>
				</xsl:template>
			
			<xsl:template match="Körperschaftsname">
				<entity>
					<xsl:value-of select="normalize-space(.)" />
					</entity>
				</xsl:template>
			
			<xsl:template match="Dokumentart">
				<documentType>
					<xsl:value-of select="normalize-space(.)" />
					</documentType>
				</xsl:template>
			
			<xsl:template match="Seitenzahl">
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:template>
			
			<xsl:template match="Seitenangabe_der_Zeitschrift">
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:template>
			
			<xsl:template match="Titel_des_Sammelwerkes">
				<sourceInfo>
					<xsl:value-of select="normalize-space(.)" />
					</sourceInfo>
				</xsl:template>
			
			<xsl:template match="Zeitschriftentitel">
				<sourceInfo>
					<xsl:value-of select="normalize-space(.)" />
					</sourceInfo>
				</xsl:template>
			
			<xsl:template match="Jahrgang__Bandangabe_der_Zeitschrift">
				<volume>
					<xsl:value-of select="normalize-space(.)" />
					</volume>
				</xsl:template>
			
			<xsl:template match="Heft-Nr._der_Zeitschrift">
				<issue>
					<xsl:value-of select="normalize-space(.)" />
					</issue>
				</xsl:template>
			
			<xsl:template match="HerausgeberIn_der_Zeitschrift">
				<xsl:if test="not(contains(../AutorIn,.))">
				<xsl:for-each select="tokenize(.,';')">
				<editor>
					<xsl:choose>
						<xsl:when test="contains(.,'FEMDOK')">
							<xsl:text>Femdok</xsl:text>
							</xsl:when>
						<xsl:when test="contains(.,'femina politica e.V.')">
							<xsl:text>Femina Politica e.V.</xsl:text>
							</xsl:when>
						<xsl:when test="contains(.,'Femina Politica e. V.')">
							<xsl:text>Femina Politica e.V.</xsl:text>
							</xsl:when>
						<xsl:when test="contains(.,'femina politica e. V.')">
							<xsl:text>Femina Politica e.V.</xsl:text>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="normalize-space(.)" />
							</xsl:otherwise>
						</xsl:choose>
					</editor>
					</xsl:for-each>
					</xsl:if>
				</xsl:template>
			
			<xsl:template match="Originaltitel">
				<alternativeTitle>
					<xsl:value-of select="normalize-space(.)" />
					</alternativeTitle>
				</xsl:template>
			
			<xsl:template match="Jahr">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(.)" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="substring(normalize-space(translate(., translate(.,'0123456789', ''), '')),1,4)" />
					</publishDate>	
				</xsl:template>
			
			<xsl:template match="Co-AutorIn">
				<xsl:for-each select="tokenize(.,';')">
					<xsl:choose>
						<xsl:when test="contains(.,'(Hrsg.)')">
							<editor>
								<xsl:value-of select="normalize-space(substring-before(replace(.,'u\.a\.',''),'(Hrsg.)'))" />
								</editor>
							</xsl:when>
						<xsl:when test="contains(.,'(Red.)')">
							<contributor>
								<xsl:value-of select="normalize-space(substring-before(.,'(Red.)'))" />
								</contributor>
							</xsl:when>
						<xsl:otherwise>
							<author>
								<xsl:choose>
									<xsl:when test="contains(.,'FEMDOK')">
										<xsl:text>Femdok</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'femina politica e.V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'Femina Politica e. V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'femina politica e. V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(.)" />
										</xsl:otherwise>
									</xsl:choose>
								</author>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="AutorIn">
				<xsl:for-each select="tokenize(.,';')">
					<xsl:choose>
						<xsl:when test="contains(.,'(Hrsg.)')">
							<editor>
								<xsl:value-of select="normalize-space(substring-before(replace(.,'u\.a\.',''),'(Hrsg.)'))" />
								</editor>
							</xsl:when>
						<xsl:when test="contains(.,'(Red.)')">
							<contributor>
								<xsl:value-of select="normalize-space(substring-before(.,'(Red.)'))" />
								</contributor>
							</xsl:when>
						<xsl:otherwise>
							<xsl:if test="not(contains(.,'N.N.'))">
							<author>
								<xsl:choose>
									<xsl:when test="contains(.,'FEMDOK')">
										<xsl:text>Femdok</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'femina politica e.V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'Femina Politica e. V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:when test="contains(.,'femina politica e. V.')">
										<xsl:text>Femina Politica e.V.</xsl:text>
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(replace(.,'u.a.',''))" />
										</xsl:otherwise>
									</xsl:choose>
								</author>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Titel">
				<title>
					<xsl:value-of select="normalize-space(.)" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(.)" />
					</title_short>
				<xsl:if test="../Untertitel[string-length() != 0]">
					<title_sub>
						<xsl:value-of select="normalize-space(../Untertitel)" />
						</title_sub>
					</xsl:if>
				</xsl:template>
			
			
			
			


</xsl:stylesheet>
