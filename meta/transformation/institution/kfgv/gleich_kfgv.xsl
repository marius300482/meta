<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">

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
					<xsl:value-of select="$id"/><xsl:text>kfgv</xsl:text>
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
					<xsl:value-of select="id"/>
					<xsl:text>kfgv</xsl:text>
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
							<xsl:text>Kölner Frauengeschichtsverein</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Kölner Frauengeschichtsverein e.V.</xsl:text>
							</institutionFull>
			
<!--collection-->				<collection><xsl:text>kfgv</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-Kn189</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/koelner-frauengeschichtsverein/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>50.9338600</latitude>
							<longitude>6.9572540</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Publikationen_Buch__________________________Publikationen_Buch___________________________Publikationen_Buch-->


<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Zeitschrift</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="titel[string-length() != 0]" />	
			<xsl:apply-templates select="titel2[string-length() != 0]" />	
			<xsl:apply-templates select="upcomingTitle[string-length() != 0]" />	
				
<!--RESPONSIBLE-->
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="issn[string-length() != 0]" />
			<xsl:apply-templates select="zdbid[string-length() != 0]" />
				
<!--PUBLISHING-->
	
<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="schlagworte[string-length() != 0]" />
	
	<!--description-->
			<xsl:apply-templates select="bestandsangabe[string-length() != 0]" />
			
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_[string-length() != 0]" />
		
		</xsl:element>	
		













	


</xsl:element>

</xsl:template>








<!--Templates-->
	
	<xsl:template match="bestandsangabe">
		<collectionHolding>
				<xsl:variable name="bracket"><xsl:text>) </xsl:text></xsl:variable>
				<xsl:value-of select="normalize-space(replace(., '\)', $bracket))" />
			</collectionHolding>
		</xsl:template>
	
	<xsl:template match="schlagworte">
		<xsl:if test=".!=''">
		<xsl:for-each select="tokenize(.,';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="zdbid">
		<xsl:choose>
			<xsl:when test="contains(.,'ohne')">
				</xsl:when>
			<xsl:otherwise>
				<xsl:if test=".!=''">
				<zdbId>
					<xsl:value-of select="." />
					</zdbId>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="issn">
		<xsl:if test=".!=''">
		<issn>
			<xsl:value-of select="." />
			</issn>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="upcomingTitle">
		<upcomingTitle>
			<xsl:value-of select="." />
			</upcomingTitle>
			</xsl:template>
	
	<xsl:template match="titel2">
		<alternativeTitle>
			<xsl:value-of select="." />
			</alternativeTitle>
			</xsl:template>
	
	<xsl:template match="titel">
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

</xsl:stylesheet>
