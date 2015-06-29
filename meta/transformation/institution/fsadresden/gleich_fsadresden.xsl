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
	
		<xsl:variable name="id" select="Registratur"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>fsadresden</xsl:text>
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
					<xsl:value-of select="Registratur"/>
					<xsl:text>fsadresden</xsl:text>
					</id>

	<!--recordCreationDate-->
	
				<recordCreationDate>
					<xsl:value-of select="current-dateTime()"/>
					</recordCreationDate>
			
				<!--<xsl:choose>
					<xsl:when test="erfasst_am- !=''">
						<recordCreationDate>
							<xsl:value-of select="substring(erfasst_am-[1],7,4)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],4,2)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],1,2)"/>
							<xsl:text>T</xsl:text>
							<xsl:text>00:00:00Z</xsl:text>
							</recordCreationDate>
						</xsl:when>
					<xsl:otherwise>
						<recordCreationDate>
							<xsl:value-of select="current-dateTime()"/>
							</recordCreationDate>
						</xsl:otherwise>
					</xsl:choose>-->
					
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
							<xsl:text>FrauenStadtArchiv Dresden</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>FrauenStadtArchiv Dresden</xsl:text>
							</institutionFull>

<!--institutionFullname-->			<institutionID>
							<xsl:text>fsadresden</xsl:text>
							</institutionID>
		
<!--collection-->				<collection><xsl:text>fsadresden</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/frauenstadtarchiv-dresden/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>51.0291950</latitude>
							<longitude>13.7595580</longitude>
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
				<xsl:apply-templates select="Titel"/>
				
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn[string-length() != 0]"/>

<!--IDENTIFIER-->
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Aufl"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->
				
<!--OTHER-->
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->

	<xsl:template match="Aufl">
		<xsl:if test="matches(.,'[0-9]')">
				<xsl:variable name="erschienen" select="translate(., translate(.,'0123456789', ''), '')"/>
				<xsl:for-each select="document('../../anreicherung/year.xml')/root/child/year">
					<xsl:if test="contains($erschienen,.)">
						<displayPublishDate>
							<xsl:value-of select="." />
							</displayPublishDate>
						<publishDate>
							<xsl:value-of select="." />
							</publishDate>	
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
		</xsl:template>

	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Titel2[string-length() != 0]">
				<xsl:text> : </xsl:text>
				<xsl:value-of select="normalize-space(../Titel2)" />
				</xsl:if>
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>
		<xsl:if test="../Titel2[string-length() != 0]">
			<title_sub>
				<xsl:value-of select="normalize-space(../Titel2)" />
				</title_sub>
			</xsl:if>
		</xsl:template>
		
	<xsl:template match="AutorIn">
		<xsl:for-each select="tokenize(.,'/')">
			<xsl:choose>
			<xsl:when test="contains(.,'(Hg.)')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(contains(.,'verschiedene'))">
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)"/>
			</publisher>		
		</xsl:template>
	
	
	
	
	
	

</xsl:stylesheet>
