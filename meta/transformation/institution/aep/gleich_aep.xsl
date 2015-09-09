<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Sep 09 12:26:43 GMT 2015 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
<!--root knoten-->
	<xsl:template match="externdata">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="put-product">
			
			<xsl:variable name="id" select="@id"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/>
					</xsl:attribute>
			
			
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id"/>
					<xsl:text>aep</xsl:text>
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
							<xsl:text>Öffentliche Frauenbibliothek AEP</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Öffentliche Frauenbibliothek AEP</xsl:text>
							</institutionFull>
			
						<institutionID>
							<xsl:text>aep</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>aep</xsl:text></collection>
	
<!--isil-->					<!--<isil><xsl:text>DE-B1591</xsl:text></isil>-->
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/oesterreich/oeffentliche-frauenbibliothek-aep/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>47.2599720</latitude>
							<longitude>11.3910060</longitude>
							</geoLocation>
			
</xsl:element>			

			
			
			


<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	

<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="attributes/string[@name='TITLE']" />	
			<xsl:apply-templates select="attributes/string[@name='SUBTITLE']" />	
			
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="attributes/person[@role='AUTHOR']" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="attributes/string[@name='SERIAL']" />	
	
	
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="attributes/string[@name='ISBN10']" />	
			<xsl:apply-templates select="attributes/string[@name='ISBN13']" />	

<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
			<xsl:apply-templates select="attributes/integer[@name='YEAR']" />	
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="attributes/string[@name='CITY']" />	
			<xsl:apply-templates select="attributes/string[@name='PUBLISHER']" />	

<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="attributes/string[@name='AMOUNT']" />	


	</xsl:element>		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
				
		</xsl:element>
	</xsl:template>


<xsl:template match="attributes/string[@name='AUTHOR_STATEMENT']">

	<xsl:for-each select="tokenize(@value,';')">

		<author>

			<xsl:value-of select="normalize-space(.)" />

			</author>

		</xsl:for-each>

	</xsl:template>




<xsl:template match="attributes/person[@role='AUTHOR']">

	<xsl:choose>

		<xsl:when test="contains(@name,'(Hrsg.)')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'(Hrsg.)'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'HG.')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'HG.'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'(Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'(Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'[Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'[Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'(hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'(hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:when test="contains(@name,'Hg')">

			<editor>

				<xsl:value-of select="normalize-space(substring-before(@name,'Hg'))"></xsl:value-of>

				</editor>

			</xsl:when>

		<xsl:otherwise>

			<author>

				<xsl:value-of select="@name"></xsl:value-of>

				</author>

			</xsl:otherwise>

		</xsl:choose>

	

	</xsl:template>




<xsl:template match="attributes/integer[@name='YEAR']">

	<displayPublishDate>

		<xsl:value-of select="@value"></xsl:value-of>

		</displayPublishDate>

	<publishDate>

		<xsl:value-of select="@value"></xsl:value-of>

		</publishDate>

	</xsl:template>




<xsl:template match="attributes/string[@name='CITY']">

	<placeOfPublication>

		<xsl:value-of select="@value"></xsl:value-of>

		</placeOfPublication>

	</xsl:template>



<xsl:template match="attributes/string[@name='PUBLISHER']">

	<publisher>

		<xsl:value-of select="@value"></xsl:value-of>

		</publisher>

	</xsl:template>



<xsl:template match="attributes/string[@name='AMOUNT']">

	<physical>

		<xsl:value-of select="normalize-space(substring-before(@value,'S.'))" />

		</physical>

	</xsl:template>


<xsl:template match="attributes/string[@name='SERIAL']">

	<series>

		<xsl:value-of select="@value"></xsl:value-of>

		</series>

	</xsl:template>





<xsl:template match="attributes/string[@name='ISBN10']">

	<isbn>

		<xsl:value-of select="@value"></xsl:value-of>

		</isbn>

	</xsl:template>






<xsl:template match="attributes/string[@name='ISBN13']">

	<isbn>

		<xsl:value-of select="@value"></xsl:value-of>

		</isbn>

	</xsl:template>




<xsl:template match="attributes/string[@name='SUBTITLE']">

	<title_sub>

		<xsl:value-of select="@value"></xsl:value-of>

		</title_sub>

	</xsl:template>



<xsl:template match="attributes/string[@name='TITLE']">

	<title>

		<xsl:value-of select="@value"></xsl:value-of>

		</title>

	<title_short>

		<xsl:value-of select="@value" />

		</title_short>

	</xsl:template>


</xsl:stylesheet>
