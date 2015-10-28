<?xml version="1.0" encoding="utf-8"?>
<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>

	

	
<!--root knoten-->
	<xsl:template match="Lisa">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	
<!--root knoten-->
	<xsl:template match="Filsa">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>


<!--Der Objektknoten-->
	<xsl:template match="Datensatz">
	
			<xsl:element name="record">
				
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
					<xsl:choose>
						<xsl:when test="Dok-Nummer">
							<xsl:text>movie</xsl:text>
							<xsl:value-of select="Dok-Nummer"/>
							</xsl:when>
						<xsl:when test="DokumentenNr">
							<xsl:text>book</xsl:text>
							<xsl:value-of select="DokumentenNr"/>
							</xsl:when>
						</xsl:choose>
					<xsl:text>lll</xsl:text>
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
							<xsl:text>Lesbenarchiv Frankfurt</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>LLL e.V. Lesbenarchiv Frankfurt am Main</xsl:text>
							</institutionFull>
			
						<institutionID>
							<xsl:text>lll</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>lll</xsl:text></collection>
	
<!--isil-->					<isil />
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/lesbenarchiv-frankfurt/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>50.1130140</latitude>
							<longitude>8.6893000</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
		

<xsl:element name="dataset">

<!--FORMAT-->

		<format><xsl:text>Buch</xsl:text></format>

<!--TITLE-->	
	
	<!--title-->
		<xsl:apply-templates select="Titel[string-length() != 0]" />
		<xsl:apply-templates select="Untertitel[string-length() != 0]" />
		<xsl:apply-templates select="Zusatz_x032x_zum_x032x_Titel[string-length() != 0]" />
		<xsl:apply-templates select="Originaltitel[string-length() != 0]" />
		

<!--RESPONSIBLE-->	

	<!--author Autorinneninformation-->
		<xsl:apply-templates select="Autorin_x047x_Hrsg_x047x_Veranstalterin_x047x_Regie[string-length() != 0]" />
		<xsl:apply-templates select="Co-Autorin_x047x_Hrsg_x047x_Regie[string-length() != 0]" />
	
	<!--contributor-->
		<xsl:apply-templates select="Uebersetzerin[string-length() != 0]" />
		
	<!--edition Ausgabe-->
		<xsl:apply-templates select="Auflage[string-length() != 0]" />

<!--IDENTIFIER-->
	
	<!--isbn-->
		<xsl:apply-templates select="ISBN_x044x_ISSN[string-length() != 0]" />

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->	
		<xsl:apply-templates select="Erscheinungs_x047x_Veroeffentl_x046x_Jahr[string-length() != 0]" />

	<!--placeOfPublication-->
		<xsl:apply-templates select="Ort[string-length() != 0]" />
	
	<!--publisher-->
		<xsl:apply-templates select="Verlag_x047x_Studio_x047x_Uni_x047x_Veranstaltungsstaette[string-length() != 0]" />
	
<!--CONTENTRELATED INFORMATION-->
	
	<!--subjectTopic-->
		<xsl:apply-templates select="Kategorie_x032x__x040x_Schlagworte_x041x_[string-length() != 0]" />

	<!--annotation-->
		<xsl:apply-templates select="Bemerkungen[string-length() != 0]" />
	
	<!--description-->
		<xsl:apply-templates select="Inhalt_x047x_Einzeltitel[string-length() != 0]" />
	
	</xsl:element>	



</xsl:element>
<!--</xsl:if>-->
</xsl:template>








<!--Templates-->
	
	<xsl:template match="Inhalt_x047x_Einzeltitel">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="ISBN_x044x_ISSN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="Bemerkungen">
		<annotation>
			<xsl:value-of select="normalize-space(.)" />
			</annotation>
		</xsl:template>
	
	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="normalize-space(.)" />
			</originalTitle>
		</xsl:template>
	
	<xsl:template match="Zusatz_x032x_zum_x032x_Titel">
		<title_sub>
			<xsl:value-of select="normalize-space(.)" />
			</title_sub>
		</xsl:template>
	
	<xsl:template match="Untertitel">
		<title_sub>
			<xsl:value-of select="normalize-space(.)" />
			</title_sub>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title>
			<xsl:value-of select="normalize-space(.)" />
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>
		</xsl:template>
	
	<xsl:template match="Verlag_x047x_Studio_x047x_Uni_x047x_Veranstaltungsstaette">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Kategorie_x032x__x040x_Schlagworte_x041x_">
		<subjectTopic>
			<xsl:value-of select="normalize-space(.)" />
			</subjectTopic>
		</xsl:template>
	
	<xsl:template match="Erscheinungs_x047x_Veroeffentl_x046x_Jahr">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)" />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(.)" />
			</publishDate>
		</xsl:template>
	
	<xsl:template match="Uebersetzerin">
		<contributor>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:text> (Übers.)</xsl:text>
			</contributor>
		</xsl:template>
	
	<xsl:template match="Autorin_x047x_Hrsg_x047x_Veranstalterin_x047x_Regie">
		<xsl:choose>
			<xsl:when test="contains(.,'(Hrsg)')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrsg)'))" />
					</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Co-Autorin_x047x_Hrsg_x047x_Regie">
		<xsl:choose>
			<xsl:when test="contains(.,'(Hrsg)')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrsg)'))" />
					</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Auflage">
		<edition>
			<xsl:value-of select="normalize-space(.)" />
			</edition>
		</xsl:template>



</xsl:stylesheet>
