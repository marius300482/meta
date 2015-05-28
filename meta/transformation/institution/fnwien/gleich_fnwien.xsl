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
	
		<xsl:variable name="id" select="ID"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>fnwien</xsl:text>
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
					<xsl:value-of select="ID"/>
					<xsl:text>fnwien</xsl:text>
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
							<xsl:text>Frauennachlässe Wien</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Sammlung Frauennachlässe am Institut für Geschichte der Universität Wien</xsl:text>
							</institutionFull>

<!--institutionFullname-->			<institutionID>
							<xsl:text>fnwien</xsl:text>
							</institutionID>
		
<!--collection-->				<collection><xsl:text>fnwien</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/oesterreich/sammlung-frauennachlaesse-wien/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>48.2130160</latitude>
							<longitude>16.3608600</longitude>
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
				<format><xsl:text>Bestandsübersicht</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel"/>
				
				
<!--RESPONSIBLE-->

<!--IDENTIFIER-->
	
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Zeit[string-length() != 0]"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->
				
	<!--description-->
				<xsl:apply-templates select="Enthält[string-length() != 0]"/>	
	
<!--OTHER-->
		
		</xsl:element>	


	<xsl:if test="matches(related,'[0-9]')">
	<xsl:variable name="related" select="related" />
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:text>000fnwien</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Titel" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="related"/><xsl:text>fnwien</xsl:text></hierarchy_parent_id>
				<hierarchy_top_title><xsl:value-of select="//ROW[ID=$related]/Titel" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="ID"/><xsl:text>fnwien</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>

	<xsl:if test="contains(related,'true')">
	<xsl:variable name="related" select="related" />
		<functions>
			<hierarchyFields>
			
				<hierarchy_top_id><xsl:text>000fnwien</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Titel" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:text>000fnwien</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="Titel" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="ID"/><xsl:text>fnwien</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>

	<xsl:if test="contains(related,'top')">
		<functions>
			<hierarchyFields>
			
				<hierarchy_top_id><xsl:text>000fnwien</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Titel" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="ID"/><xsl:text>fnwien</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>



	


</xsl:element>
</xsl:template>








<!--Templates-->

	<xsl:template match="Enthält">
		<description>
			<xsl:value-of select="." />
			</description>
		</xsl:template>

	<xsl:template match="Zeit">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
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
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
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
