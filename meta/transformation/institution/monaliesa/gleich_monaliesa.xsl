<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="monaliesa">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="object">
		
						
		<xsl:variable name="id" select="MEDNR[1]"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>monaliesa</xsl:text>
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
					<xsl:text>monaliesa</xsl:text>
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
							<xsl:text>MONAliesA</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Frauenbibliothek/Genderbibliothek MONAliesA</xsl:text>
							</institutionFull>

<!--institutionID-->			<institutionID>
							<xsl:text>monaliesa</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>monaliesa</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>L 334</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/monaliesa/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>51.3110400</latitude>
							<longitude>12.3763070</longitude>
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
				<xsl:apply-templates select="HST[1][string-length() != 0]"/>	
				<!--<xsl:apply-templates select="Untertitel[string-length() != 0]"/>	-->
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="VERF1[string-length() != 0]"/>
				<!--<xsl:apply-templates select="Name_zweiter_Verfasserin[string-length() != 0]"/>
				<xsl:apply-templates select="Name_weiterer_Verfasserin[string-length() != 0]"/>-->

	<!--series-->
				<xsl:apply-templates select="GT1[1][string-length() != 0]"/>

<!--IDENTIFIER-->
	
	<!--isbn-->
				<xsl:apply-templates select="ISBN[1][string-length() != 0]"/>
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="JAHR[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="VERL[string-length() != 0]"/>
				<xsl:apply-templates select="VORT[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="UMF[string-length() != 0]"/>
	
<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
				<xsl:apply-templates select="SW0[string-length() != 0]"/>
				
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="SYST[1][string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="SW0">
		<xsl:if test="not(contains(.,'u. a.'))">
		<xsl:choose>
			<xsl:when test="contains(.,'g||')">
				<subjectGeographic>
					<xsl:value-of select="normalize-space(substring-after(.,'g||'))" />
					</subjectGeographic>
				</xsl:when>
			<xsl:when test="contains(.,'p||')">
				<subjectPerson>
					<xsl:value-of select="normalize-space(substring-after(.,'p||'))" />
					</subjectPerson>
				</xsl:when>
			<xsl:otherwise>
				<subjectTopic>
					<xsl:value-of select="normalize-space(.)" />
					</subjectTopic>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:if>
		</xsl:template>
		
	<xsl:template match="UMF">
		<xsl:choose>
			<xsl:when test="contains(.,';')">
				<physical>
					<xsl:value-of select="normalize-space(translate(substring-before(.,';'), translate(.,'0123456789', ''), ''))" />
					</physical>
				</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
					</physical>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="HST[1]">
		<title>
			<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
			</title_short>	
		<xsl:if test="contains(../HST[2],'U ')">
			<xsl:if test="(not(contains(../HST[2],'Roman')))">
			<title_sub>
				<xsl:value-of select="substring-after(../HST[2],'U ')"/>
				</title_sub>	
				</xsl:if>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="GT1">
		<series>
			<xsl:value-of select="."/>
			</series>	
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="."/>
			</isbn>	
		</xsl:template>	

	<xsl:template match="JAHR">
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
	
	<xsl:template match="VORT">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="VERL">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>
	
	<xsl:template match="SYST">
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
	
	<xsl:template match="VERF1">
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
