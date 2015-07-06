<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<!--<xsl:template match="ROWSET">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>-->
	
<!--root knoten-->
	<!--<xsl:template match="ExportRoot">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>-->

<xsl:template match="*">
		<xsl:element name="catalog">
			<xsl:apply-templates select="Record[1]" />
			<xsl:apply-templates select="ROW" />
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten ARCHIVBESTAND-->
<!--Der Objektknoten ARCHIVBESTAND-->
<!--Der Objektknoten ARCHIVBESTAND-->
	
	<xsl:template match="Record">
	
	<xsl:for-each select="//Record">
	
		<xsl:variable name="id" select="@Id"/>
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
					<xsl:value-of select="@Id"/>
					<xsl:text>fsadresden</xsl:text>
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
				<xsl:choose>
					<xsl:when test="@Level='Bestand'">
						<recordType>
							<xsl:text>systematics</xsl:text>
							</recordType>
						</xsl:when>
					<xsl:when test="@Level='Klassifikationsgruppe'">
						<recordType>
							<xsl:text>systematics</xsl:text>
							</recordType>
						</xsl:when>
					<xsl:when test="@Level='Archivalieneinheit'">
						<recordType>
							<xsl:text>archive</xsl:text>
							</recordType>
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
				<xsl:choose>
					<xsl:when test="@Level='Bestand'">
						<format>
							<xsl:text>Bestandsübersicht</xsl:text>
							</format>
						</xsl:when>
					<xsl:when test="@Level='Klassifikationsgruppe'">
						
						</xsl:when>
					<xsl:when test="@Level='Archivalieneinheit'">
						<format>
							<xsl:text>Akte</xsl:text>
							</format>
						</xsl:when>
					</xsl:choose>
				

<!--TITLE-->

	<!--title Titelinformationen-->
				<title>
					<xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue"></xsl:value-of>
					</title>
				<title_short>
					<xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue"></xsl:value-of>
					</title_short>
				
				<xsl:if test="DetailData/DataElement[@ElementName='Untertitel']">
					<title_sub>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Untertitel']/ElementValue/TextValue" />
						
					<xsl:if test="DetailData/DataElement[@ElementName='Titelzusätze']">
						<xsl:text>; </xsl:text>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Titelzusätze']/ElementValue/TextValue" />
						</xsl:if>
						</title_sub>
					</xsl:if>		
<!--RESPONSIBLE-->

	<!--author-->
				<xsl:if test="not(DetailData/DataElement[@ElementName='Enthält']) and DetailData/DataElement[@ElementName='Autoren u. sonst. beteiligte Personen']">
					<description>
						<xsl:text>Mitwirkende: </xsl:text>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Autoren u. sonst. beteiligte Personen']/ElementValue/TextValue" />
						</description>
					</xsl:if>
				
	<!--series-->
				<xsl:if test="DetailData/DataElement[@ElementName='Reihentitel']">
					<series>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Reihentitel']/ElementValue/TextValue" />
						</series>
					</xsl:if>	
	
				

<!--IDENTIFIER-->
	
	<!--isbn-->
				<xsl:if test="DetailData/DataElement[@ElementName='ISBN']">
					<isbn>
						<xsl:value-of select="DetailData/DataElement[@ElementName='ISBN']/ElementValue/TextValue"></xsl:value-of>
						</isbn>
					</xsl:if>	
	
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<!--<xsl:if test="@Level='Bestand'">	
					<displayPublishDate>
						<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate, translate(.,'0123456789', ''), '')"></xsl:value-of>
						<xsl:text> - </xsl:text>
						<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), '')"></xsl:value-of>
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), '')"></xsl:value-of>
						</publishDate>
					</xsl:if>-->
				
				<xsl:if test="DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate!=''">	
					<displayPublishDate>
						<!--<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate, translate(.,'0123456789', ''), '')"></xsl:value-of>-->
						<xsl:value-of select="substring(translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate, translate(.,'0123456789', ''), ''),1,4)"></xsl:value-of>
						<xsl:if test="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), '')">
						<xsl:text> - </xsl:text>
						<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), '')"></xsl:value-of>
						</xsl:if>
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="substring(translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate, translate(.,'0123456789', ''), ''),1,4)" />
						<!--<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/FromDate, translate(.,'0123456789', ''), '')" />-->
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring(translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), ''),1,4)" />
						
						<!--<xsl:value-of select="translate(DetailData/DataElement[@ElementName='Entstehungszeitraum']/ElementValue/DateRange/ToDate, translate(.,'0123456789', ''), '')"></xsl:value-of>-->
						</publishDate>
					</xsl:if>
				
	<!--publisher-->
				<xsl:if test="DetailData/DataElement[@ElementName='Verlagsort / Verlag']">	
					<xsl:choose>
						<xsl:when test="contains(DetailData/DataElement[@ElementName='Verlagsort / Verlag']/ElementValue/TextValue,',')">
							<publisher>
								<xsl:value-of select="normalize-space(substring-before(DetailData/DataElement[@ElementName='Verlagsort / Verlag']/ElementValue/TextValue,','))"></xsl:value-of>
								</publisher>
							<placeOfPublication>
								<xsl:value-of select="normalize-space(substring-after(DetailData/DataElement[@ElementName='Verlagsort / Verlag']/ElementValue/TextValue,','))"></xsl:value-of>
								</placeOfPublication>
							</xsl:when>
						<xsl:otherwise>
							<publisher>
								<xsl:value-of select="normalize-space(DetailData/DataElement[@ElementName='Verlagsort / Verlag']/ElementValue/TextValue)"></xsl:value-of>
								</publisher>
							</xsl:otherwise>
						</xsl:choose>
					
					
					</xsl:if>
				
	<!--sourceInfo-->
				<xsl:if test="not(@Level='Bestand')">
					<sourceInfo>
						<xsl:value-of select="normalize-space(//Record[@Level='Bestand']/DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue)" />
						</sourceInfo>
					</xsl:if>
	
	
<!--PHYSICAL INFORMATION-->

	<!--physical-->	
				<xsl:if test="DetailData/DataElement[@ElementName='Seitenzahl']">
					<physical>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Seitenzahl']/ElementValue/TextValue"></xsl:value-of>
						</physical>
					</xsl:if>	
	

<!--CONTENTRELATED INFORMATION-->
	
	<!--description-->
				<xsl:if test="DetailData/DataElement[@ElementName='Enthält']">
				<description>
					<xsl:if test="DetailData/DataElement[@ElementName='Autoren u. sonst. beteiligte Personen']">
						<xsl:text>Mitwirkende: </xsl:text>
						<xsl:value-of select="DetailData/DataElement[@ElementName='Autoren u. sonst. beteiligte Personen']/ElementValue/TextValue"></xsl:value-of>
						</xsl:if>
					<xsl:value-of select="DetailData/DataElement[@ElementName='Enthält']/ElementValue/TextValue"></xsl:value-of>
					</description>
					</xsl:if>

<!--OTHER-->
				<shelfMark>
					<xsl:value-of select="@IdName"></xsl:value-of>
					</shelfMark>
				
		
		</xsl:element>	


	<xsl:if test="@Level='Bestand'">
	<xsl:variable name="related" select="related" />
		<functions>
			<hierarchyFields>
			
				<hierarchy_top_id><xsl:value-of select="$id"></xsl:value-of><xsl:text>fsadresden</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="$id"></xsl:value-of><xsl:text>fsadresden</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="$id"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>

	<xsl:if test="@Level='Klassifikationsgruppe'">
		<xsl:variable name="related" select="@ParentId" />
		<functions>
			<hierarchyFields>
			
				<hierarchy_top_id><xsl:value-of select="//Record[@Level='Bestand']/@Id" /><xsl:text>fsadresden</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//Record[@Level='Bestand']/DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></hierarchy_top_title>
			
				<hierarchy_parent_id><xsl:value-of select="@ParentId" /><xsl:text>fsadresden</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//Record[@Id=$related]/DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="$id"></xsl:value-of><xsl:text>fsadresden</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="$id"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>
	
	<xsl:if test="@Level='Archivalieneinheit'">
		<xsl:variable name="related" select="@ParentId" />
		<functions>
			<hierarchyFields>
			
				 <hierarchy_top_id><xsl:value-of select="//Record[@Level='Bestand']/@Id" /><xsl:text>fsadresden</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//Record[@Level='Bestand']/DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="@ParentId" /><xsl:text>fsadresden</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//Record[@Id=$related]/DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="$id"></xsl:value-of><xsl:text>fsadresden</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="DetailData/DataElement[@ElementName='Titel']/ElementValue/TextValue" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="$id"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>

	


</xsl:element>

</xsl:for-each>

</xsl:template>





<!--Der Objektknoten BUCHBESTAND-->
<!--Der Objektknoten BUCHBESTAND-->
<!--Der Objektknoten BUCHBESTAND-->

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
