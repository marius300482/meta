<?xml version="1.0" encoding="utf-8"?>
<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="FMPXMLRESULT">
		<xsl:element name="catalog">
			<xsl:apply-templates select="ERRORCODE"/>
			<xsl:apply-templates select="ROW"/>
		<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="ROW">
						
		<xsl:variable name="id" select="@RECORDID"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>terredesfemmes</xsl:text>
					</xsl:attribute>
				
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
					<xsl:value-of select="$id"/>
					<xsl:text>terredesfemmes</xsl:text>
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
							<xsl:text>TERRE DES FEMMES</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>TERRE DES FEMMES - Dokumentationsstelle</xsl:text>
							</institutionFull>

<!--institutionID-->				<institutionID>
							<xsl:text>terredesfemmes</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>terredesfemmes</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/frauenbibliothek-lieselle/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.5394800</latitude>
							<longitude>13.3946500</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Buch__________________________Monographie___________________________Sammelband-->



<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<xsl:choose>
					<xsl:when test="contains(COL[1],'Aufsatz aus Quelle')">
						<format><xsl:text>Artikel</xsl:text></format>	
						</xsl:when>
					<xsl:when test="contains(COL[1],'Zeitschrift')">
						<format><xsl:text>Zeitschrift</xsl:text></format>	
						</xsl:when>
					<xsl:otherwise>
						<format><xsl:text>Buch</xsl:text></format>	
						</xsl:otherwise>
					</xsl:choose>
				
				<!--<format><xsl:text>Buch</xsl:text></format>	-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="COL[28][string-length() != 0]"/>
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="COL[4][string-length() != 0]"/>
				<!--<xsl:apply-templates select="übersetzt_von[string-length() != 0]"/>-->
	
	<!--edition-->
				<xsl:apply-templates select="COL[3][string-length() != 0]"/>
	
	<!--serie-->
				<xsl:apply-templates select="COL[24][string-length() != 0]"/>
	
<!--IDENTIFIER-->

	<!--isbn-->
				<xsl:apply-templates select="COL[17][string-length() != 0]"/>
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="COL[10][string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="COL[29][string-length() != 0]"/>
				<xsl:apply-templates select="COL[30][string-length() != 0]"/>
	
	<!--sourceInfo-->
				<xsl:apply-templates select="COL[31][string-length() != 0]"/>
		
<!--PHYSICAL INFORMATION-->
	
	<!--seiten-->
				<xsl:apply-templates select="COL[23][string-length() != 0]"/>
	
<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				<xsl:apply-templates select="COL[21][string-length() != 0]"/>
		
	<!--issue-->
				<xsl:apply-templates select="COL[16][string-length() != 0]"/>
	<!--volume-->
				<xsl:apply-templates select="COL[5][string-length() != 0]"/>
		
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="COL[25][string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>



<!--Templates-->

<xsl:template match="COL[32]">
	<placeOfPublication>
		<xsl:value-of select="normalize-space(.)" />
		</placeOfPublication>
	</xsl:template>

<xsl:template match="COL[31]">
	<sourceInfo>
		<xsl:value-of select="normalize-space(.)" />
		</sourceInfo>
	</xsl:template>

<xsl:template match="COL[30]">
	<placeOfPublication>
		<xsl:value-of select="normalize-space(.)" />
		</placeOfPublication>
	</xsl:template>

<xsl:template match="COL[29]">
	<publisher>
		<xsl:value-of select="normalize-space(.)" />
		</publisher>
	</xsl:template>

<xsl:template match="COL[25]">
	<shelfMark>
		<xsl:value-of select="." />
		</shelfMark>
	</xsl:template>

<xsl:template match="COL[24]">
	<sourceInfo>
		<xsl:value-of select="." />
		</sourceInfo>
	</xsl:template>

<xsl:template match="COL[23]">
	<physical>
		<xsl:value-of select="." />
		</physical>
	</xsl:template>

<xsl:template match="COL[21]">
	<xsl:choose>
		<xsl:when test="contains(DATA[1],'/')">
			<xsl:for-each select="tokenize(DATA[1],'/')">
				<xsl:choose>
					<xsl:when test="contains(.,'FGM')">
						<subjectTopic><xsl:text>Female circumcision</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Female genital cutting (FGC)</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Female genital mutilation</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitalverstümmelung &lt;weibliche&gt;</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitalbeschneidung</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitale Verstümmelung</xsl:text></subjectTopic>
						</xsl:when>
					<xsl:otherwise>
						<subjectTopic>
							<xsl:value-of select="normalize-space(.)" />
							</subjectTopic>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="DATA[string-length() != 0]">
				<xsl:choose>
					<xsl:when test="contains(.,'FGM')">
						<subjectTopic><xsl:text>Female circumcision</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Female genital cutting (FGC)</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Female genital mutilation</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitalverstümmelung &lt;weibliche&gt;</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitalbeschneidung</xsl:text></subjectTopic>
						<subjectTopic><xsl:text>Genitale Verstümmelung</xsl:text></subjectTopic>
						</xsl:when>
					<xsl:otherwise>
						<subjectTopic>
							<xsl:value-of select="normalize-space(.)" />
							</subjectTopic>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template match="COL[17]">
	<xsl:choose>
		<xsl:when test="contains(../COL[1],'Zeitschrift')">
			<issn><xsl:value-of select="." /></issn>	
			</xsl:when>
		<xsl:otherwise>
			<isbn>
				<xsl:value-of select="." />
				</isbn>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template match="COL[16]">
	<issue>
		<xsl:value-of select="." />
		</issue>
	</xsl:template>

<xsl:template match="COL[10]">
	<displayPublishDate>
		<xsl:value-of select="." />
		</displayPublishDate>
	<publishDate>
		<xsl:value-of select="." />
		</publishDate>
	</xsl:template>

<xsl:template match="COL[5]">
	<volume>
		<xsl:value-of select="." />
		</volume>
	</xsl:template>

<xsl:template match="COL[3]">
	<edition>
		<xsl:value-of select="." />
		</edition>
	</xsl:template>

<xsl:template match="COL[28]">
	<xsl:choose>
		<xsl:when test="contains(.,':')">
			<title>
				<xsl:value-of select="." />
				</title>
			<title_short>
				<xsl:value-of select="normalize-space(substring-before(.,':'))" />
				</title_short>
			<title_sub>
				<xsl:value-of select="normalize-space(substring-after(.,':'))" />
				</title_sub>
			</xsl:when>
		<xsl:otherwise>
			<title>
				<xsl:value-of select="." />
				</title>
			<title_short>
				<xsl:value-of select="." />
				</title_short>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
<xsl:template match="COL[4]">
	
	<xsl:choose>
		<xsl:when test="contains(.,';')">
			<xsl:for-each select="tokenize(.,';')">
				<xsl:choose>
					<xsl:when test="contains(.,'ai')">
						<author>
							<xsl:text>AI - Amnesty International</xsl:text>
							</author>
						</xsl:when>
					<xsl:otherwise>
						<author>
							<xsl:value-of select="normalize-space(.)" />
							</author>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
		<xsl:when test="contains(.,'/')">
			<xsl:for-each select="tokenize(.,'/')">
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>

	<!--<xsl:for-each select="tokenize(.,';')">
	<xsl:choose>
		<xsl:when test="contains(.,'ai')">
			<author><xsl:text>AI - Amnesty International</xsl:text></author></xsl:when>
		<xsl:otherwise>
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:for-each>-->
	</xsl:template>

<xsl:template match="ERRORCODE">
	
	</xsl:template>
	

</xsl:stylesheet>
