<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->

<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="bozen">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="object">
		
		<xsl:variable name="id">
			<xsl:value-of select="VE_ID" />
			</xsl:variable>
		
		
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>bozen</xsl:text>
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
					<xsl:text>bozen</xsl:text>
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
					<xsl:text>archive</xsl:text>
					</recordType>
				
				
	
</xsl:element>



<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->
<!--institution_______________________________institution_______________________________institution-->


	
<xsl:element name="institution">
	
<!--institutionShortname-->			<institutionShortname>
							<xsl:text>Frauenarchiv Bozen</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Frauenarchiv Bozen - Archivio storico delle donne</xsl:text>
							</institutionFull>

<!--institutionID-->			<institutionID>
							<xsl:text>bozen</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>bozen</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text></xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/italien/frauenarchiv-bozen/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>46.4976000</latitude>
							<longitude>11.3533600</longitude>
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
				<format><xsl:text>Akte</xsl:text></format>	
	
	<!--documentType-->		

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="VE_Titel[1][string-length() != 0]"/>					
				
<!--RESPONSIBLE-->


<!--IDENTIFIER-->
	
	<!--isbn-->
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Dat.____Findbuch[string-length() != 0]"/>
				
	
	<!--placeOfPublication publisher Verlagsangabe-->
				
	<!--sourceInfo-->
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="Umfang[string-length() != 0]"/>
			
<!--CONTENTRELATED INFORMATION-->
	
	<!--description-->
				<xsl:apply-templates select="Enthält[string-length() != 0]"/>
	
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Syg_Gruppe[1][string-length() != 0]"/>
			
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	
	
	<xsl:template match="Enthält">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="normalize-space(.)" />
			</physical>
		</xsl:template>
	
	<xsl:template match="VE_Titel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			</title>
		
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>
		</xsl:template>
	
	<xsl:template match="Dat.____Findbuch">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)" />
			</displayPublishDate>
		
		<publishDate>
			<xsl:value-of select="normalize-space(.)" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="Syg_Gruppe">
		<shelfMark>
			<xsl:value-of select="normalize-space(.)" />
			</shelfMark>
			</xsl:template>
		
	
	
	
	
	

</xsl:stylesheet>
