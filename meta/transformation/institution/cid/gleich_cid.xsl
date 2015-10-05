<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	xmlns:marc="http://www.loc.gov/MARC21/slim" 
	exclude-result-prefixes="xs xdt err fn marc">

	<xsl:output method="xml" indent="yes"/>


<!--root knoten-->
	<xsl:template match="/" >
		<xsl:element name="catalog">
			<xsl:apply-templates select="//marc:record" />
			<xsl:apply-templates select="//datensatz" />
			</xsl:element>
	</xsl:template>
	
	  <xsl:template match="responseDate" mode="non-editor-note"/>
	







<!--Nachlässe_______________________________Nachlässe_______________________________Nachlässe-->
	
	<xsl:template match="datensatz">
		
		<xsl:element name="record">
		
		<vufind>
			<id>
				<xsl:value-of select="translate(Titel_des_Nachlasses, '. /äüö,=', '') "></xsl:value-of>
				<xsl:text>cid</xsl:text>
				</id>
			
			<recordCreationDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordCreationDate>
			
			<recordChangeDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordChangeDate>
	
			<recordType>
				<xsl:text>library</xsl:text>
				</recordType>			
			
			</vufind>
		
		<institution>
			
			<institutionShortname><xsl:text>Cid Fraen an Gender</xsl:text></institutionShortname>
			<institutionFull><xsl:text>Frauen- und Genderbibliothek Cid</xsl:text></institutionFull>
			<institutionID><xsl:text>cid</xsl:text></institutionID>
			<collection><xsl:text>CID</xsl:text></collection>
			<isil><xsl:text>ZDB-LU-100</xsl:text></isil>
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/luxemburg/cid-fraen-an-gender/</xsl:text></link>
			<geoLocation>
				<latitude>49.6115690</latitude>
				<longitude>6.1274660</longitude>
				</geoLocation>
			
			</institution>
		
		<dataset>

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>

	<!--format Objektartinformationen-->
				<format>
					<xsl:value-of select="format" />
					</format>
	<!--documentType-->
				<xsl:if test="Um_was_handelt_es_sich[string-length() != 0]">
					<documentType><xsl:value-of select="Um_was_handelt_es_sich" /></documentType>
					</xsl:if>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel_des_Nachlasses" />			

<!--CONTENTRELATED INFORMATION-->

	<!--description-->
				<xsl:apply-templates select="Bestandsbeschreibung" />	
		</dataset>
		
		</xsl:element>
		
		</xsl:template>
	




<!--datasets_______________________________datasets_______________________________datasets-->

	<xsl:template match="marc:record">	

		<xsl:variable name="id" select="substring-before(marc:controlfield[@tag='001'],':')" />
		<xsl:element name="record">
			<!--<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	-->
		
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		
			
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		<vufind>
			<id>
				<xsl:value-of select="$id" /><xsl:text>cid</xsl:text>
				</id>
			
			<recordCreationDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordCreationDate>
			
			<recordChangeDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordChangeDate>
	
			<recordType>
				<xsl:text>library</xsl:text>
				</recordType>			
			
			</vufind>
		
		<institution>
			
			<institutionShortname><xsl:text>Cid Fraen an Gender</xsl:text></institutionShortname>
			<institutionFull><xsl:text>Frauen- und Genderbibliothek Cid</xsl:text></institutionFull>
			<institutionID><xsl:text>cid</xsl:text></institutionID>
			<collection><xsl:text>CID</xsl:text></collection>
			<isil><xsl:text>ZDB-LU-100</xsl:text></isil>
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/luxemburg/cid-fraen-an-gender/</xsl:text></link>
			<geoLocation>
				<latitude>49.6115690</latitude>
				<longitude>6.1274660</longitude>
				</geoLocation>
			
			</institution>
		
		<dataset>
			
	<!--FORMAT-->
			
			 <typeOfRessource>
				 	<xsl:choose>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='BK'">
				 			<xsl:text>text</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='CF'">
				 			<xsl:text>software, multimedia</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MU'">
				 			<xsl:text>audio</xsl:text>
				 			</xsl:when>
			 			<xsl:when test="marc:controlfield[@tag='FMT']='SE'">
				 			<xsl:text>text</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='VM'">
				 			<xsl:text>mixed material</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MX'">
				 			<xsl:text>mixed material</xsl:text>
				 			</xsl:when>
				 		<!--<xsl:otherwise>
				 			<xsl:value-of select="marc:datafield[@tag='949']/marc:subfield[@code='3']" />
				 			</xsl:otherwise>-->
				 		</xsl:choose>
				 	</typeOfRessource>
				 
				 <format>
				 	<xsl:choose>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='BK'">
				 			<xsl:text>Buch</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='CF'">
				 			<xsl:text>Datenträger</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MU'">
				 			<xsl:text>Tonträger</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='SE'">
				 			<xsl:text>Zeitschrift</xsl:text>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='VM'">
				 			<xsl:choose>
				 				<xsl:when test="contains(marc:datafield[@tag='245'],'Film')">	
				 					<xsl:text>Film</xsl:text>
				 					</xsl:when>
				 				<xsl:otherwise>
				 					<xsl:text>Buch</xsl:text>
				 					</xsl:otherwise>
				 				</xsl:choose>
				 			</xsl:when>
				 		<xsl:when test="marc:controlfield[@tag='FMT']='MX'">
				 			<xsl:text>Buch</xsl:text>
				 			</xsl:when>
				 		<!--<xsl:otherwise>
				 			<xsl:value-of select="marc:datafield[@tag='949']/marc:subfield[@code='3']" />
				 			</xsl:otherwise>-->
				 		</xsl:choose>
				 	</format>
					
					<xsl:if test="marc:controlfield[@tag='FMT']='VM'">
					<documentType>
						<xsl:text>Visuelles Material</xsl:text>
						</documentType>
						</xsl:if>
					
					
				<xsl:apply-templates select="marc:controlfield[@tag='008']" />
		
	<!--TITLE-->
			
			<!--title Titelinformationen-->		
				<xsl:apply-templates select="marc:datafield[@tag='245']" />
				<xsl:apply-templates select="marc:datafield[@tag='509']" />
			
	<!--RESPONSIBLE-->	
			
			<!--author Autorinneninformation-->
				<xsl:apply-templates select="marc:datafield[@tag='100']" />
				<xsl:apply-templates select="marc:datafield[@tag='700']" />
				<xsl:apply-templates select="marc:datafield[@tag='511']" />
				
			<!--entity Körperschaft-->
				<xsl:apply-templates select="marc:datafield[@tag='710']" />
				
			<!--series-->
				
				<xsl:apply-templates select="marc:datafield[@tag='490']" />
		
			<!--edition Ausgabe-->
				<xsl:apply-templates select="marc:datafield[@tag='250']" />
	<!--IDENTIFIER-->

		<!--ISBN / ISSN-->
				<xsl:apply-templates select="marc:datafield[@tag='020']" />

	<!--PUBLISHING-->			

		<!--display / publishDate Jahresangabe-->
		<!--placeOfPublication Ortsangabe-->	
		<!--publisher Verlag-->
				<xsl:choose>
					<xsl:when test="marc:datafield[@tag='260']">
						
						</xsl:when>
					</xsl:choose>
				<xsl:apply-templates select="marc:datafield[@tag='260']" />
	
		<!--sourceInfo Quelle-->
				<xsl:apply-templates select="marc:datafield[@tag='773']" />
				
	<!--PHYSICAL INFORMATION-->	
	
		<!--physical Seitenangabe-->		
				<xsl:apply-templates select="marc:datafield[@tag='300']" />
			
				
	<!--CONTENTRELATED INFORMATION-->	
				
				<xsl:for-each select="distinct-values(marc:datafield[@tag='650'][@ind2='6']/marc:subfield[@code='a']/text())">
					<xsl:element name="subjectTopic">
						<xsl:value-of select="."></xsl:value-of>
						</xsl:element>
					</xsl:for-each>
				
				<xsl:apply-templates select="marc:datafield[@tag='690'][@ind1='K'][@ind2='C'][1]" />
				<xsl:apply-templates select="marc:datafield[@tag='651'][@ind2='6']" />
				
				<xsl:if test="marc:datafield[@tag='600'][@ind2='6']">
					<xsl:for-each select="distinct-values(marc:datafield[@tag='600'][@tag='6']/marc:subfield[@code='a']/text())">
						<subjectPerson>
							<xsl:value-of select="." />
							</subjectPerson>		
						</xsl:for-each>
					</xsl:if>
				
		<!--description Beschreibung-->
				<xsl:apply-templates select="marc:datafield[@tag='500'][1]" />
				
	<!--OTHER-->
				
		<!--shelfMark Signatur-->	
				<xsl:apply-templates select="marc:datafield[@tag='691'][1]" />
		
		
			</dataset>
			
			<!--<xsl:if test="(marc:datafield[@tag='PLK']) and (not(marc:datafield[@tag='490']/marc:subfield[@code='w']))">
			<functions>
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="$id" /><xsl:text>cid</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="marc:datafield[@tag='245']" /></hierarchy_top_title>
				
					<is_hierarchy_id><xsl:value-of select="$id" /><xsl:text>cid</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="marc:datafield[@tag='245']" /></is_hierarchy_title>
				
					<hierarchy_sequence><xsl:value-of select="substring(marc:datafield[@tag='245'],1,3)"/></hierarchy_sequence>
				
					</hierarchyFields>
				</functions>
				</xsl:if>
		
			<xsl:if test="marc:datafield[@tag='490']/marc:subfield[@code='w'][1]">
			<functions>
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:text>00</xsl:text><xsl:value-of select="marc:datafield[@tag='490'][1]/marc:subfield[@code='w']" /><xsl:text>cid</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="marc:datafield[@tag='490'][1]/marc:subfield[@code='a']" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:text>00</xsl:text><xsl:value-of select="marc:datafield[@tag='490'][1]/marc:subfield[@code='w']" /><xsl:text>cid</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="marc:datafield[@tag='490'][1]/marc:subfield[@code='a']" /></hierarchy_parent_title>
				
					<is_hierarchy_id><xsl:value-of select="$id" /><xsl:text>cid</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="marc:datafield[@tag='245']" /></is_hierarchy_title>
				
					<hierarchy_sequence><xsl:value-of select="substring(marc:datafield[@tag='245'],1,3)"/></hierarchy_sequence>
				
					</hierarchyFields>
				</functions>
				</xsl:if>-->
	
				
		
				
</xsl:element>	

<!--<commit/>
   <optimize/>-->

	
	</xsl:template>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!--Templates-->
	
	<xsl:template match="Bestandsbeschreibung">
		<description>
			<xsl:value-of select="normalize-space(.)" />
			</description>
		</xsl:template>
	
	<xsl:template match="Titel_des_Nachlasses">	
		<title>
			<xsl:value-of select="normalize-space(.)" />
			</title>
		<title_short>
			<xsl:value-of select="normalize-space(.)" />
			</title_short>
		</xsl:template>
	
	<xsl:template match="marc:controlfield[@tag='008']">
		<displayPublishDate>
			<xsl:value-of select="substring(.,8,4)" />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="substring(.,8,4)" />
			</publishDate>
		<!--<field name="language_code">
			<xsl:value-of select="substring(.,36,3)"></xsl:value-of>
			</field>-->
		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='773']">
		<sourceInfo><xsl:value-of select="marc:subfield[@code='t']" /></sourceInfo>
		<!--<xsl:if test="(not(../marc:datafield[@tag='260'])) and (marc:subfield[@code='1'])">
			<field name="displayPublishDate">
				<xsl:value-of select="marc:subfield[@code='1']"></xsl:value-of>
				</field>
			<field name="publishDateSort">
				<xsl:value-of select="translate(marc:subfield[@code='1'], translate(.,'0123456789', ''), '')" />
				</field>
			</xsl:if>	-->
		<xsl:if test="not(../marc:datafield[@tag='300'])">
			<physical>
				<xsl:value-of select="normalize-space(substring-after(marc:subfield[@code='g'],'p.'))"></xsl:value-of>
				</physical>
			</xsl:if>	
		<xsl:if test="marc:subfield[@code='4']">
			<issue>
				<xsl:value-of select="marc:subfield[@code='4']" />
				</issue>
			</xsl:if>			
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='250']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<edition><xsl:value-of select="." /></edition>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='500']">
		<description>
			<xsl:for-each select="../marc:datafield[@tag='500']/marc:subfield">		
				<xsl:value-of select="." /><xsl:text> </xsl:text>
				</xsl:for-each>
			</description>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='710']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<entity><xsl:value-of select="." /></entity>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='691']">
		<shelfMark><xsl:for-each select="../marc:datafield[@tag='691']/marc:subfield[@code='8']">
			<xsl:value-of select="." /><xsl:text> / </xsl:text>
			</xsl:for-each>		
			</shelfMark>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='490']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<series><xsl:value-of select="." /></series>		
			</xsl:for-each>		
		</xsl:template>
	
	<!--<xsl:template match="marc:datafield[@tag='600']">
		<xsl:for-each select="marc:subfield[@code='a']">
			<subjectPerson><xsl:value-of select="." /></subjectPerson>			
			</xsl:for-each>		
		</xsl:template>-->
	
	<xsl:template match="marc:datafield[@tag='690'][@ind1='K'][@ind2='C']">
			<annotation>
			<xsl:for-each select="../marc:datafield[@tag='690']/marc:subfield[@code='a']">
				<xsl:value-of select="." />
				<xsl:text>; </xsl:text>		
				</xsl:for-each>		
			</annotation>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='651'][@ind2='6']">
		<xsl:for-each select="distinct-values(marc:subfield[@code='a']/text())">
			<subjectGeographic><xsl:value-of select="." /></subjectGeographic>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='650'][@ind2='6']">
		<xsl:for-each select="distinct-values(marc:subfield[@code='a']/text())">
			<subjectTopic><xsl:value-of select="." /></subjectTopic>		
			</xsl:for-each>		
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='300']">
		<xsl:if test="(../marc:controlfield[@tag='FMT']='BK') and (marc:subfield[@code='a'])">
			<physical>
				<xsl:value-of select="normalize-space(substring-before(marc:subfield[@code='a'][1],'p.'))" />
					</physical>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='MU'">
			<physical>
				<xsl:value-of select="normalize-space(marc:subfield[@code='a'])" />
					<xsl:if test="marc:subfield[@code='e']">
						<xsl:text> + </xsl:text>
						<xsl:value-of select="marc:subfield[@code='e']" />
						</xsl:if>
				</physical>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='CF'">
			<physical>
				<xsl:value-of select="normalize-space(marc:subfield[@code='a'])" />
				</physical>
			</xsl:if>
		<xsl:if test="../marc:controlfield[@tag='FMT']='MX'">
			<physical>
				<xsl:for-each select="marc:subfield">
					<xsl:value-of select="normalize-space(.)" /><xsl:text> </xsl:text>
					</xsl:for-each>
				</physical>
			</xsl:if>
		<xsl:if test="marc:subfield[@code='c']">
			<dimension>
				<xsl:value-of select="marc:subfield[@code='c']" />
				</dimension>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='260']">
		<!--<field name="displayPublishDate">
			<xsl:value-of select="marc:subfield[@code='c']" />
			</field>
		<field name="publishDateSort">
			<xsl:value-of select="translate(marc:subfield[@code='c'], translate(.,'0123456789', ''), '')" />
			</field>-->
		<xsl:if test="marc:subfield[@code='a']">
			<placeOfPublication>
				<xsl:value-of select="marc:subfield[@code='a']" />
				</placeOfPublication>
			</xsl:if>
		<xsl:if test="marc:subfield[@code='b']">
			<publisher>
				<xsl:value-of select="marc:subfield[@code='b']" />
				</publisher>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='020']">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='511']">
		<xsl:choose>
			<xsl:when test="../marc:controlfield[@tag='FMT']='MU'">
				 </xsl:when>
			<xsl:otherwise>
				<contributor>
					<xsl:value-of select="marc:subfield[@code='a']" />
					</contributor>
				</xsl:otherwise>
			</xsl:choose>
		
	
		<!--<contributor>
			<xsl:value-of select="marc:subfield[@code='a']" />
			</contributor>-->
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='100']">
		<author>
			<xsl:value-of select="marc:subfield[@code='a']" />
			<xsl:if test="marc:subfield[@code='b']">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="marc:subfield[@code='b']" />
					</xsl:if>
					</author>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='700']">
		<contributor>
			<xsl:value-of select="marc:subfield[@code='a']" />
			<xsl:if test="marc:subfield[@code='b']">
				<xsl:text> - </xsl:text>
				<xsl:value-of select="marc:subfield[@code='b']" />
					</xsl:if>
					</contributor>
		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='245']">
		<title>
					<!--<xsl:value-of select="replace(replace(marc:subfield[@code='a'],'&gt;&gt;',''),'&lt;&lt;','')" /> XSLT 2.0-->
					<xsl:value-of select="translate(marc:subfield[@code='a'][1],'&gt;&gt;&lt;&lt;','')" />
					<xsl:if test="marc:subfield[@code='h']">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="marc:subfield[@code='h']" />
						<xsl:text>]</xsl:text>
						</xsl:if>
					<!--<xsl:value-of select="marc:subfield[@code='a']" />-->
					<xsl:if test="marc:subfield[@code='b']">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="marc:subfield[@code='b']" />
						</xsl:if>
					<xsl:if test="marc:subfield[@code='i']">
						<xsl:text> ; </xsl:text>
						<xsl:value-of select="translate(marc:subfield[@code='i'][1],'&gt;&gt;&lt;&lt;','')" />
						</xsl:if>
					</title>
				<xsl:if test="marc:subfield[@code='b']">
					<title_sub>
						<!--<xsl:value-of select="marc:subfield[@code='b']" />-->
						<xsl:value-of select="translate(marc:subfield[@code='b'][1],'&gt;&gt;&lt;&lt;','')" />
						</title_sub>
					</xsl:if>
				<title_short>
					<xsl:value-of select="translate(marc:subfield[@code='a'][1],'&gt;&gt;&lt;&lt;','')" />
					<xsl:if test="marc:subfield[@code='h']">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="marc:subfield[@code='h']" />
						<xsl:text>]</xsl:text>
						</xsl:if>
					<!--<xsl:value-of select="marc:subfield[@code='a']" />--></title_short>

		</xsl:template>
	
	<xsl:template match="marc:datafield[@tag='509']">
		<alternativeTitle>
			<xsl:value-of select="translate(marc:subfield[@code='t'][1],'&gt;&gt;&lt;&lt;','')" />
			</alternativeTitle>
		</xsl:template>		
		

	
</xsl:stylesheet>
