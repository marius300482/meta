<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="litarchiv">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
<!--root knoten-->
	<xsl:template match="konser">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--root knoten-->
	<xsl:template match="archnoten">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="LIDOS-Dokument">
		
						
		<!--<xsl:variable name="id" select="MEDNR[1]"/>-->
		
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="Dok-Nummer"/><xsl:text>fraumusik</xsl:text>
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
					<xsl:value-of select="Dok-Nummer"/>
					<xsl:variable name="root" select="../name()" />
					<xsl:choose>
					<xsl:when test="$root='konser'">
						<xsl:text>tonfraumusik</xsl:text>
						</xsl:when>
					<xsl:when test="$root='litarchiv'">
						<xsl:text>buchfraumusik</xsl:text>
						</xsl:when>
					<xsl:when test="$root='archnoten'">
						<xsl:text>notefraumusik</xsl:text>
						</xsl:when>
					</xsl:choose>
					<!--<xsl:text>fraumusik</xsl:text>-->
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
				<xsl:variable name="root" select="../name()" />
				<xsl:choose>
					<xsl:when test="$root='konser'">
						<recordType><xsl:text>library</xsl:text></recordType>
						</xsl:when>
					<xsl:when test="$root='litarchiv'">
						<recordType><xsl:text>library</xsl:text></recordType>
						</xsl:when>
					<xsl:when test="$root='archnoten'">
						<recordType><xsl:text>archive</xsl:text></recordType>
						</xsl:when>
					</xsl:choose>
						
	
</xsl:element>



<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


	
<xsl:element name="institution">
	
<!--institutionShortname-->			<institutionShortname>
							<xsl:text>Archiv Frau und Musik</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Archiv Frau und Musik</xsl:text>
							</institutionFull>

<!--institutionID-->			<institutionID>
							<xsl:text>fraumusik</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>fraumusik</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-Ks15</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/archiv-frau-und-musik/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>50.0923690</latitude>
							<longitude>8.6505250</longitude>
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
				<xsl:variable name="root" select="../name()" />
				<xsl:choose>
					<xsl:when test="$root='konser'">
						<format><xsl:text>Tonträger</xsl:text></format>	
						</xsl:when>
					<xsl:when test="$root='litarchiv'">
						<format><xsl:text>Buch</xsl:text></format>	
						</xsl:when>
					<xsl:when test="$root='archnoten'">
						<format><xsl:text>Noten</xsl:text></format>	
						</xsl:when>
					</xsl:choose>
				
				
						
	
	<!--documentType-->		
				

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel[string-length() != 0]"/>	
				<xsl:apply-templates select="Zusatz_zum_Titel[string-length() != 0]"/>	
				<xsl:apply-templates select="Originaltitel[string-length() != 0]"/>	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Verfasser[string-length() != 0]"/>	

	<!--editor-->
				<xsl:apply-templates select="Herausgeber[string-length() != 0]"/>
				
	<!--entity-->
				<xsl:apply-templates select="Körperschaft[string-length() != 0]"/>
	
	<!--series-->
				<xsl:apply-templates select="GT1[1][string-length() != 0]"/>

<!--IDENTIFIER-->
	
	<!--isbn-->
				<xsl:apply-templates select="ISBN[1][string-length() != 0]"/>
				
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
				<xsl:apply-templates select="Ort[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="Umfang_-_Format[string-length() != 0]"/>
	
<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
				<xsl:apply-templates select="Deskriptoren[string-length() != 0]"/>
				
				
	<!--description-->	
				<xsl:apply-templates select="Inhalt[string-length() != 0]"/>
	<!--issue-->
	
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Standort[1][string-length() != 0]"/>
				<xsl:apply-templates select="Signatur[1][string-length() != 0]"/>
			
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->

	<xsl:template match="Umfang_-_Format">
		<physical>
			<xsl:value-of select="normalize-space(.)" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Deskriptoren">
		<subjectTopic>
			<xsl:value-of select="normalize-space(.)" />
			</subjectTopic>
		</xsl:template>
	
	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="normalize-space(.)" />
			</originalTitle>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>
		</xsl:template>
	
	<xsl:template match="Zusatz_zum_Titel">
		<title_sub>
			<xsl:value-of select="normalize-space(.)" />
			</title_sub>	
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>	
		</xsl:template>	
	
	<xsl:template match="Inhalt">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>	
		</xsl:template>	

	<xsl:template match="Jahr">
		<xsl:choose>
			<xsl:when test=".!=''">
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				
				<xsl:choose>
					<xsl:when test="contains(.,'-')">
						<xsl:for-each select="tokenize(.,'-')">
							<publishDate>
								<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
								</publishDate>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
								</publishDate>
							</xsl:otherwise>
					</xsl:choose>
				
				<!--<publishDate>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
					</publishDate>-->
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:text>o.A.</xsl:text>
					</displayPublishDate>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Standort">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
		
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Verfasser">
		
		<xsl:for-each select="tokenize(.,';')">
		
		<xsl:choose>

		<xsl:when test="contains(.,'(Hrsg.)')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'(Hrsg.)'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'HG.')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'HG.'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'(Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'(Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'[Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'[Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'(hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'(hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(.,'Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(.,'Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:otherwise>

			<author>

				<xsl:value-of select="normalize-space(.)" />

				</author>

			</xsl:otherwise>

		</xsl:choose>
			
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Herausgeber">
		
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
			
		</xsl:template>
	
	<xsl:template match="Körperschaft">
			<entity>
				<xsl:value-of select="normalize-space(.)" />
				</entity>
		</xsl:template>
	
	
	

</xsl:stylesheet>
