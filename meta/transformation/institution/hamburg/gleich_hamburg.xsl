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
		
						
		<xsl:variable name="id" select="id"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>hamburg</xsl:text>
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
					<xsl:text>hamburg</xsl:text>
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

<!--institutionShortname-->			
			<institutionShortname>
				<xsl:text>hamburger frauen*bibliothek</xsl:text>
				</institutionShortname>
	
<!--institutionFullname-->
			<institutionFull>
				<xsl:text>hamburger frauen*bibliothek</xsl:text>
				</institutionFull>	

<!--institutionID-->				<institutionID>
							<xsl:text>hamburg</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>hamburg</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/denktraeume/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>53.5659600</latitude>
							<longitude>9.9810000</longitude>
							</geoLocation>
			
<!--location-->
			<xsl:choose>
				<xsl:when test="Standort[text()='LFR']">
					<location>
						<xsl:text>Hamburger Bibliothek für Frauenfragen – Landesfrauenrat Hamburg e.V.</xsl:text>
							</location>	
					</xsl:when>
	
				<xsl:when test="Standort[text()='DENKtRÄUME']">
					<location>
						<xsl:text>DENKtRÄUME</xsl:text>
						</location>	
					</xsl:when>
	
	</xsl:choose>
			
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
				<xsl:apply-templates select="Haupttitel[string-length() != 0]"/>	
				<xsl:apply-templates select="Untertitel[string-length() != 0]"/>	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autoren[string-length() != 0]"/>
				<xsl:apply-templates select="Herausgeber[string-length() != 0]"/>
	
	<!--series-->
				<xsl:apply-templates select="Gesamttitel[string-length() != 0]"/>
	
	<!--edition Ausgabe-->
				<xsl:apply-templates select="Ausgabe[string-length() != 0]"/>
				

<!--IDENTIFIER-->
	
	<!--isbn-->
				<xsl:apply-templates select="ISBN[string-length() != 0]"/>
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Ersch.jahr[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
				
	
	<!--volume-->
				<xsl:apply-templates select="Band[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->

	<!--physical-->
				<xsl:apply-templates select="Umfang[string-length() != 0]"/>

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Titelsignatur[string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="Haupttitel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>	
		</xsl:template>
		
	<xsl:template match="Untertitel">
		<title_sub>
			<xsl:value-of select="normalize-space(.)" />
			</title_sub>	
		</xsl:template>
	

	<xsl:template match="Ersch.jahr">
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
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Band">
		<volume>
			<xsl:value-of select="normalize-space(.)" />
			</volume>
		</xsl:template>
	
	<xsl:template match="Ausgabe">
		<edition>
			<xsl:value-of select="normalize-space(.)" />
			</edition>
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
		
	<xsl:template match="Gesamttitel">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>
	
	<xsl:template match="Titelsignatur">
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
	
	<xsl:template match="Autoren">
		<xsl:for-each select="tokenize(.,';')">
			<xsl:if test="not(contains(.,'u.a.'))">
			<author>
				<xsl:value-of select="normalize-space(.)" />
				</author>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Herausgeber">
		<xsl:for-each select="tokenize(.,';')">
			<xsl:if test="not(contains(.,'u.a.'))">
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>
	
	
	

</xsl:stylesheet>
