<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="baf">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="object">
		
						
		<!--<xsl:variable name="id" select="MEDNR[1]"/>-->
		
		<xsl:variable name="id">
			
			<xsl:value-of select="substring(translate(Titel[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
			<xsl:value-of select="substring(translate(AutorInnen[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ'),1,8)" />
			<xsl:value-of select="translate(ISBN, translate(.,'0123456789', ''), '')" />
			<!--<xsl:value-of select="translate(Titel[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
			<xsl:value-of select="translate(AutorInnen[1],'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
			<xsl:value-of select="translate(ISBN, translate(.,'0123456789', ''), '')" />-->
			</xsl:variable>
		
		
					<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>baf</xsl:text>
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
					<xsl:text>baf</xsl:text>
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
							<xsl:text>BAF e.V.</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>BAF e.V., Bildungszentrum und Archiv zur Frauengeschichte Baden-Württembergs</xsl:text>
							</institutionFull>

<!--institutionID-->			<institutionID>
							<xsl:text>baf</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>baf</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>Tü 133</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/baf/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>48.5232420</latitude>
							<longitude>9.0527320</longitude>
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
				<xsl:apply-templates select="Titel[1][string-length() != 0]"/>	
				<xsl:apply-templates select="Originaltitel[1][string-length() != 0]"/>	
				<!--<xsl:apply-templates select="Untertitel[string-length() != 0]"/>	-->
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorInnen[string-length() != 0]"/>	

	<!--editor-->
				<xsl:apply-templates select="HerausgeberInnen[string-length() != 0]"/>
	
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
				<xsl:apply-templates select="Erscheinungsort[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical-->
				<xsl:apply-templates select="Umf_Ill_Beil[string-length() != 0]"/>
	
<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
				<xsl:apply-templates select="Suchwoerter[string-length() != 0]"/>
				<xsl:apply-templates select="Personenregister[string-length() != 0]"/>
				
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Standort[1][string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="Suchwoerter">
		<xsl:for-each select="tokenize(.,';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Personenregister">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Umf_Ill_Beil">
		<physical>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Titel[1]">
		<title>
			<xsl:choose>
				<xsl:when test="contains(.,'==')">
					<xsl:value-of select="normalize-space(substring-after(.,'=='))" />		
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:for-each select="../Titel[position()>=2]">
				<xsl:if test="not(contains(.,'=='))">
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:if>
				</xsl:for-each>
			</title>
		
		<title_short>
			<xsl:choose>
				<xsl:when test="contains(.,'==')">
					<xsl:value-of select="normalize-space(substring-after(.,'=='))" />		
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			<xsl:text> </xsl:text>
			<xsl:for-each select="../Titel[position()>=2]">
				<xsl:if test="not(contains(.,'=='))">
					<xsl:value-of select="normalize-space(.)"></xsl:value-of>
					</xsl:if>
				</xsl:for-each>
			</title_short>
		
		<xsl:if test="../Untertitel">
			<title_sub>
				<xsl:for-each select="../Untertitel">
					<xsl:value-of select="."></xsl:value-of>
					<xsl:text> </xsl:text>
					</xsl:for-each>
				</title_sub>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="normalize-space(.)" />
			</originalTitle>	
		</xsl:template>	

	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>	
		</xsl:template>	

	<xsl:template match="Jahr">
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
	
	<xsl:template match="Erscheinungsort">
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
	
	<xsl:template match="AutorInnen">
	
		<xsl:for-each select="tokenize(.,'/')">
				<xsl:choose>
			<xsl:when test="contains(.,' u.a.')">
				<xsl:for-each select="tokenize(.,'/')">
				<author>
					<xsl:value-of select="normalize-space(substring-before(.,'u.a.'))" />
					</author>
					</xsl:for-each>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
					</xsl:for-each>
	
		<!--<xsl:choose>
			<xsl:when test="contains(.,' u.a.')">
				<xsl:for-each select="tokenize(.,'/')">
				<author>
					<xsl:value-of select="normalize-space(substring-before(.,'u.a.'))" />
					</author>
					</xsl:for-each>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>-->
		</xsl:template>
	
	<xsl:template match="HerausgeberInnen">
		<xsl:for-each select="tokenize(.,'/')">
			<editor>
				<xsl:value-of select="normalize-space(.)" />
				</editor>
			</xsl:for-each>
		</xsl:template>
	

	
	
	

</xsl:stylesheet>
