<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="ROWSET">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="ROW">
		
						
		<xsl:variable name="id" select="ID_Buch"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>basel</xsl:text>
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
					<xsl:text>basel</xsl:text>
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
							<xsl:text>frauen_bibliothek basel</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>frauen_bibliothek basel</xsl:text>
							</institutionFull>

<!--institutionID-->			<institutionID>
							<xsl:text>basel</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>basel</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/schweiz/frauen-bibliothek-basel/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>47.5808950</latitude>
							<longitude>7.5912810</longitude>
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
				<format><xsl:text>Buch</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel[string-length() != 0]"/>	
				<xsl:apply-templates select="Untertitel[string-length() != 0]"/>	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Name_der_Verfasserin[string-length() != 0]"/>
				<xsl:apply-templates select="Name_zweiter_Verfasserin[string-length() != 0]"/>
				<xsl:apply-templates select="Name_weiterer_Verfasserin[string-length() != 0]"/>

<!--IDENTIFIER-->

<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Ausgabejahr[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
				<xsl:apply-templates select="Ort[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
				<xsl:apply-templates select="Schlagworte[string-length() != 0]"/>
				
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Signatur[string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="Schlagworte">
		<xsl:for-each select="tokenize(.,',')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
		
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="."/>
			</title>
		<title_short>
			<xsl:value-of select="."/>
			</title_short>	
		</xsl:template>
		
	<xsl:template match="Untertitel">
		<title_sub>
			<xsl:value-of select="."/>
			</title_sub>	
		</xsl:template>
	

	<xsl:template match="Ausgabejahr">
		<xsl:choose>
			<xsl:when test=".!=''">
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
					</publishDate>
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
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="."/>
			</shelfMark>
		</xsl:template>
	
	<!--<xsl:template match="übersetzt_von">
		<xsl:for-each select="tokenize(.,';')">
		<xsl:if test="(.!='Dublette') and (.!='Doublette') and (.!='o.A.')">
		<contributor>
			<xsl:value-of select="."/>
			</contributor>
			</xsl:if>
			</xsl:for-each>
		</xsl:template>-->
	
	<xsl:template match="Name_der_Verfasserin">
		<author>
			<xsl:value-of select="." />
			</author>
		</xsl:template>
	
	<xsl:template match="Name_zweiter_Verfasserin">
		<author>
			<xsl:value-of select="." />
			</author>
		</xsl:template>
	
	<xsl:template match="Name_weiterer_Verfasserin">
		<author>
			<xsl:value-of select="." />
			</author>
		</xsl:template>
	
	
	

</xsl:stylesheet>
