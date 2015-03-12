<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	
	
<!-- Leere Knoten werden entfernt-->
	<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	
<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>	

<!--Der Hauptknoten-->	
	<xsl:template match="collection">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>



<!--Der Objektknoten-->
	<xsl:template match="document">	
		
		<xsl:if test="datafield[6]">
		
		<!--<xsl:if test="not(datafield[@tag='078'])">-->
		<!--<xsl:if test="datafield[@tag='078'][1][text()='Bildtonträger']">-->
		<!--<xsl:if test="(datafield[@tag='078'][text()='Monographie']) or (datafield[@tag='078'][text()='Reihe']) or (datafield[@tag='078'][text()='Anthologie']) or (datafield[@tag='078'][text()='Reihenband']) or (datafield[@tag='078'][text()='Mehrbändiges Werk']) or (datafield[@tag='078'][text()='Zeitschrift']) or (datafield[@tag='078'][text()='Artikel'])">-->
		<!--<xsl:if test="datafield[@tag='078'][text()='Artikel']">-->
		<!--<xsl:if test="(datafield[@tag='078'][text()='Monographie']) 
		or (datafield[@tag='078'][text()='Anthologie']) 
		or (datafield[@tag='078'][text()='Reihenband'])
		or (datafield[@tag='078'][text()='Mehrbändiges Werk'])">-->
			
			<xsl:variable name="id" select="controlfield[@tag='001']" />	
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
			
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
			
					
			<xsl:variable name="rel" select="datafield[@tag='QUE']/subfield[@code='L']" />
			<xsl:variable name="mbd" select="datafield[@tag='GTO']/subfield[@code='L']" />

<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->

<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="$id" />
					<xsl:text>frso</xsl:text>
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
							<xsl:text>Frauensolidarität</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Frauensolidarität - Bibliothek und Dokumentationsstelle Frauen und "Dritte Welt"</xsl:text>
							</institutionFull>
			
<!--collection-->				<collection><xsl:text>FRSO</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>AT-FRSO</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/oesterreich/frauensolidaritaet/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>48.219999</latitude>
							<longitude>16.353449</longitude>
							</geoLocation>
			
</xsl:element>


	


<!--Monographie________________Monographie___________________________Monographie-->
<!--Monographie________________Monographie___________________________Monographie-->
<!--Monographie________________Monographie___________________________Monographie-->

<xsl:if test="(datafield[@tag='078'][1][text()='Monographie']) 
		or (datafield[@tag='078'][1][text()='MOnographie']) 
		or (datafield[@tag='078'][1][text()='Aufsatzsammlung']) 
		or (datafield[@tag='078'][1][text()='Anthologie']) 
		or (datafield[@tag='078'][1][text()='Reihe'])
		or (datafield[@tag='078'][1][text()='Mehrbändiges Werk'])
		or (not(datafield[@tag='078']))">
		
	<xsl:element name="dataset">

		<xsl:variable name="GT1" select="datafield[@tag='GT1']/subfield[@code='L']" />
		
<!--FORMAT-->

	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>		

	<!--format Objektartinformationen-->
	<!--documentType-->
	<xsl:choose>
		<xsl:when test="(not(datafield[@tag='078'])) 
		and (//document[@idn=$GT1]/datafield[@tag='078']='Zeitschrift')">
			<format>
				<xsl:text>Zeitschrift</xsl:text>
				</format>
			<documentType>
				<xsl:text>Zeitschriftenheft</xsl:text>
				</documentType>
			</xsl:when>
			<xsl:otherwise>
				<format><xsl:text>Buch</xsl:text></format>
				<xsl:for-each select="datafield[@tag='078']">
					<documentType><xsl:value-of select="." /></documentType>
					</xsl:for-each>
				</xsl:otherwise>
		</xsl:choose>
	
<!--TITLE-->	

	<!--title Titelinformationen-->	
			<xsl:choose>
				<xsl:when test="datafield[@tag='331']">
					<xsl:apply-templates select="datafield[@tag='331']" />
					</xsl:when>
				<xsl:otherwise>
					<title>
						<xsl:text>[Ohne Titelangabe]</xsl:text>
						</title>
					<title_short>
						<xsl:text>[Ohne Titelangabe]</xsl:text>
						</title_short>
					</xsl:otherwise>
				</xsl:choose>
			

	<!--alternativeTitle-->
			<xsl:apply-templates select="datafield[@tag='370']" />
			
	<!--originalTitle-->
			<xsl:apply-templates select="datafield[@tag='341']" />

<!--RESPONSIBLE-->	
		
	<!--author Autorinneninformation-->
			<xsl:apply-templates select="datafield[@tag='100']" />
			<xsl:apply-templates select="datafield[@tag='104']" />
			<xsl:apply-templates select="datafield[@tag='108']" />

	<!--editor Herausgeberinneninformationen-->
			<xsl:if test="(not(datafield[@tag='100'])) and
					(not(datafield[@tag='104'])) and 
					(not(datafield[@tag='108']))">
				<xsl:apply-templates select="datafield[@tag='359']" />
				</xsl:if>
	
	<!--entity Körperschaft-->
			<xsl:apply-templates select="datafield[@tag='200']" />
			
	<!--series-->
			<xsl:choose>
				<xsl:when test="datafield[@tag='GT1']">
					<xsl:apply-templates select="datafield[@tag='GT1']" />
					</xsl:when>
				<xsl:when test="datafield[@tag='GTU']">
					<xsl:apply-templates select="datafield[@tag='GTU']" />
					</xsl:when>
				<xsl:when test="datafield[@tag='GT0']">
					<xsl:apply-templates select="datafield[@tag='GT0']" />
					</xsl:when>
				</xsl:choose>

	<!--edition-->
			<xsl:apply-templates select="datafield[@tag='403']" />

<!--IDENTIFIER-->
		
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="datafield[@tag='540']" />
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="datafield[@tag='542']" />
	
<!--PUBLISHING-->
		
	<!--display / publishDate Jahresangabe-->
			<!--<xsl:apply-templates select="datafield[@tag='425']" />-->
		
		<xsl:choose>
			<xsl:when test="datafield[@tag='425'][@ind1='a']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='b']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='c']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					</publishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</publishDate>	
					
					<!--<timeSpan>
						<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
					</timeSpan>-->
					</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425']"/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
		<!--
		<xsl:if test="datafield[@tag='425'][@ind1='a']">
			<displayPublishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</publishDate>
			</xsl:if>
		
		<xsl:if test="datafield[@tag='425'][@ind1='a']">
			<displayPublishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
				</publishDate>
			</xsl:if>
		
		<xsl:if test="datafield[@tag='425']">
			<xsl:choose>
				<xsl:when test="datafield[@tag='078'][1][text()='Reihe']">
					<timeSpan>
						<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
					</timeSpan>
					</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="datafield[@tag='425'][@ind1='a']" />	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>-->
						
	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="datafield[@tag='594']" />
			<xsl:apply-templates select="datafield[@tag='410']" />
			
	<!--publisher Verlag-->
			<xsl:apply-templates select="datafield[@tag='412']" />

<!--PHYSICAL INFORMATION-->
		
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="datafield[@tag='433']" />
			
	<!--dimensions-->
			<xsl:apply-templates select="datafield[@tag='435']" />
			
	<!--specificMaterialDesignation-->
			<xsl:apply-templates select="datafield[@tag='434']" />
			<xsl:apply-templates select="datafield[@tag='437']" />

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
			<xsl:apply-templates select="datafield[@tag='037']" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="datafield[@tag='THS']" />
			<xsl:apply-templates select="datafield[@tag='710']" />
			<xsl:apply-templates select="datafield[@tag='740']" />
			<xsl:apply-templates select="datafield[@tag='902']" />

	<!--description-->
			<xsl:apply-templates select="datafield[@tag='750']" />

	<!--listOfContents-->
			<xsl:apply-templates select="datafield[@tag='753']" />		
			<xsl:apply-templates select="datafield[@tag='530']" />
	
<!--OTHER-->
				
	<!--shelfMark Signatur-->
			<xsl:apply-templates select="datafield[@tag='544']" />

	</xsl:element>
	<!--END OF DATASETELEMENT-->

<!--HIERARCHY-->

<!--(datafield[@tag='078'][text()='Reihe']) or-->
	<xsl:if test="
			(datafield[@tag='GT1']) or
			(datafield[@tag='GT0']) or 
			(//document/datafield[@tag='QUE']/subfield[@code='L']=$id) or
			(//document/datafield[@tag='GT1']/subfield[@code='L']=$id) or
			(//document/datafield[@tag='GT0']/subfield[@code='L']=$id)">
		
		<xsl:element name="functions">	
			<hierarchyFields>
				
				
				
				<xsl:if test="datafield[@tag='GT0']">
					<hierarchy_top_id><xsl:value-of select="datafield[@tag='GT0']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='GT0']/subfield[@code='a']" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="datafield[@tag='GT0']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="datafield[@tag='GT0']/subfield[@code='a']" /></hierarchy_parent_title>
					</xsl:if>
				
				<xsl:if test="datafield[@tag='GT1']">
					<hierarchy_top_id><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='a']" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='a']" /></hierarchy_parent_title>
					</xsl:if>
				
				<xsl:if test="//document/datafield[@tag='GT0']/subfield[@code='L']=$id">
					<hierarchy_top_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='331']" /></hierarchy_top_title>				
					</xsl:if>
				
				<xsl:if test="//document/datafield[@tag='GT1']/subfield[@code='L']=$id">
					<hierarchy_top_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='331']" /></hierarchy_top_title>					
					</xsl:if>
				
				<xsl:if test="//document/datafield[@tag='QUE']/subfield[@code='L']=$id">
					
					<hierarchy_top_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='331']" /></hierarchy_top_title>
					</xsl:if>
					
				<is_hierarchy_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="contains(datafield[@tag='331'],'¬')">
							<xsl:value-of select="normalize-space(replace(datafield[@tag='331'],'¬',''))"/>
							</xsl:when>
						<xsl:when test="contains(datafield[@tag='331'],'&gt;&gt;')">
							<xsl:variable name="title" select="substring-after(substring-before(datafield[@tag='331'],'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
							<xsl:value-of select="normalize-space(replace(datafield[@tag='331'],'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="normalize-space(datafield[@tag='331'])" />
							</xsl:otherwise>
						</xsl:choose>
					<!--<xsl:value-of select="datafield[@tag='331']" />--></is_hierarchy_title>	
				
				<hierarchy_sequence><xsl:value-of select="substring(datafield[@tag='331'],1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
		</xsl:element>	
		</xsl:if>
</xsl:if>









<!--Zeitschrift________________Zeitschrift___________________________Zeitschrift-->
<!--Zeitschrift________________Zeitschrift___________________________Zeitschrift-->
<!--Zeitschrift________________Zeitschrift___________________________Zeitschrift-->

<xsl:if test="(datafield[@tag='078'][1][text()='Zeitschrift']) or
		(datafield[@tag='078'][1][text()='ÖEZA-Zeitschrift'])">

	<xsl:element name="dataset">

 <!--FORMAT-->

	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>		

	<!--format Objektartinformationen-->
		<format><xsl:text>Zeitschrift</xsl:text></format>

	<!--documentType-->
		<xsl:if test="datafield[@tag='078'][text()='ÖEZA-Zeitschrift']">
			<documentType>
				<xsl:text>ÖEZA-Zeitschrift</xsl:text>
				</documentType>
			</xsl:if>
		
<!--		<xsl:choose>
			<xsl:when test="datafield[@tag='078'][text()='Zeitschrift']">
				<documentType>
					<xsl:text>Zeitschrift</xsl:text>
					</documentType>
				</xsl:when>
			<xsl:when test="datafield[@tag='078'][text()='ÖEZA-Zeitschrift']">
				<documentType>
					<xsl:text>ÖEZA-Zeitschrift</xsl:text>
					</documentType>
				</xsl:when>
			</xsl:choose>-->
		
<!--TITLE-->

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="datafield[@tag='331']" />

	<!--alternativeTitle-->
			<xsl:apply-templates select="datafield[@tag='370']" />
	
<!--RESPONSIBLE-->
			
	<!--editor Herausgeberinneninformationen-->
			<xsl:apply-templates select="datafield[@tag='359']" />
			
	<!--editor Herausgeberinneninformationen-->
			<!--<xsl:apply-templates select="datafield[@tag='200']" />-->

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
			<xsl:apply-templates select="datafield[@tag='542']" />
	
<!--PUBLISHING-->

	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="datafield[@tag='594']" />
			<xsl:apply-templates select="datafield[@tag='410']" />

	<!--publishDate-->
			<xsl:choose>
				<xsl:when test="datafield[@tag='425'][@ind1='b']">
					<timeSpan>
						<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
						</timeSpan>
					</xsl:when>
				<xsl:when test="datafield[@tag='425'][@ind1='a']">
					<displayPublishDate>
						<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="datafield[@tag='425'][@ind1='a']"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="datafield[@tag='425'][@ind1=' ']">
					<displayPublishDate>
						<xsl:value-of select="datafield[@tag='425'][@ind1=' ']"/>
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="datafield[@tag='425'][@ind1=' ']"/>
						</publishDate>
					</xsl:when>
				</xsl:choose>
			
			<!--<xsl:if test="datafield[@tag='425'][1]">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="datafield[@tag='425'][@ind1='b']" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="datafield[@tag='425'][@ind1='c']" /></timeSpanEnd>
				</timeSpan>	
				</xsl:if>-->
			<!--<xsl:apply-templates select="datafield[@tag='425'][1]" />	-->	
		
	<!--publisher Verlag-->
			<xsl:apply-templates select="datafield[@tag='412']" />

<!--PHYSICAL INFORMATION-->

	<!--dimensions-->
			<xsl:apply-templates select="datafield[@tag='435']" />

	<!--dimensions-->
			<xsl:apply-templates select="datafield[@tag='437']" />

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
			<xsl:apply-templates select="datafield[@tag='037']" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="datafield[@tag='THS']" />
			<xsl:apply-templates select="datafield[@tag='710']" />
			<xsl:apply-templates select="datafield[@tag='740']" />
			<xsl:apply-templates select="datafield[@tag='902']" />
			
	</xsl:element>
	<!--END OF DATASETELEMENT-->

<!--HIERARCHY-->
	<xsl:if test="//document/datafield[@tag='QUE']/subfield[@code='L']=$id">
		<xsl:element name="functions">	
			<hierarchyFields>
				
					<!--<hierarchy_top_id><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='GT1']/subfield[@code='a']" /></hierarchy_top_title>-->
					
					<hierarchy_top_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='331']" /></hierarchy_top_title>
					
					<!--<hierarchy_parent_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="datafield[@tag='331']" /></hierarchy_parent_title>-->
					
					<is_hierarchy_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="datafield[@tag='331']" /></is_hierarchy_title>
					
					<hierarchy_sequence><xsl:value-of select="substring(datafield[@tag='331'],1,3)"/></hierarchy_sequence>
					
				</hierarchyFields>
		</xsl:element>	
	</xsl:if>
	
</xsl:if>

<!--Artikel________________Artikel___________________________Artikel-->
<!--Artikel________________Artikel___________________________Artikel-->
<!--Artikel________________Artikel___________________________Artikel-->

<xsl:if test="datafield[@tag='078'][1][text()='Artikel']">

	<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>		

	<!--format Objektartinformationen-->
		<format><xsl:text>Artikel</xsl:text></format>

<!--TITLE-->	

	<!--title Titelinformationen-->	
			<xsl:apply-templates select="datafield[@tag='331']" />

<!--RESPONSIBLE-->	

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="datafield[@tag='100']" />
			<xsl:apply-templates select="datafield[@tag='104']" />
			<xsl:apply-templates select="datafield[@tag='108']" />

<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:choose>
					<xsl:when test="//document[@idn=$rel]/datafield[@tag='540']/subfield[@code='a']">
						<isbn>
							<xsl:value-of select="//document[@idn=$rel]/datafield[@tag='540']/subfield[@code='a']" />
						</isbn>
					</xsl:when>
					<xsl:when test="//document[@idn=$rel]/datafield[@tag='542']/subfield[@code='a']">
						<issn>
							<xsl:value-of select="//document[@idn=$rel]/datafield[@tag='542']/subfield[@code='a']" />
						</issn>
					</xsl:when>
				</xsl:choose>	

<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="datafield[@tag='425']" />

	<!--placeOfPublication Ortsangabe-->
		<xsl:choose>
				<xsl:when test="datafield[@tag='594']">
					<placeOfPublication>
						<xsl:value-of select="datafield[@tag='594']" />
					</placeOfPublication>
				</xsl:when>
				<xsl:when test="datafield[@tag='410']">
					<placeOfPublication>
						<xsl:value-of select="datafield[@tag='410']" />
					</placeOfPublication>
				</xsl:when>
				<xsl:when test="//document[@idn=$rel]/datafield[@tag='594']">
					<placeOfPublication>
						<xsl:value-of select="//document[@idn=$rel]/datafield[@tag='594']" />
					</placeOfPublication>
				</xsl:when>
				<xsl:otherwise>
					<placeOfPublication>
						<xsl:value-of select="//document[@idn=$rel]/datafield[@tag='410']" />
					</placeOfPublication>
				</xsl:otherwise>
			</xsl:choose>

	<!--publisher Verlag-->
			<xsl:if test="//document[@idn=$rel]/datafield[@tag='412']">
				<publisher>
					<xsl:value-of select="//document[@idn=$rel]/datafield[@tag='412']" />	
				</publisher>
			</xsl:if>

	<!--sourceInfo-->
			<sourceInfo>
				<xsl:value-of select="datafield[@tag='QUE']/subfield[@code='a']" />
				<!--<xsl:text> </xsl:text>
				<xsl:value-of select="datafield[@tag='QUE']/subfield[@code='b']" />-->
				</sourceInfo>

<!--PHYSICAL INFORMATION-->

	<!--physical Seitenangabe-->
			<xsl:apply-templates select="datafield[@tag='QUE']/subfield[@code='b']" />

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
			<xsl:apply-templates select="datafield[@tag='037']" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="datafield[@tag='THS']" />
			<xsl:apply-templates select="datafield[@tag='710']" />
			<xsl:apply-templates select="datafield[@tag='740']" />
			<xsl:apply-templates select="datafield[@tag='902']" />

	<!--description-->
			<xsl:apply-templates select="datafield[@tag='750']" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--volume-->
			<!--Artikel von Zeitschriften bekommen die Volumeangabe-->
			<xsl:variable name="QUEL" select="datafield[@tag='QUE']/subfield[@code='L']" />
			<xsl:if test="//document[@idn=$QUEL]/datafield[@tag='078']='Zeitschrift'">
				<xsl:variable name="vol1" select="substring-after(datafield[@tag='QUE']/subfield[@code='b'], '),')"></xsl:variable>
				<volume>
					<xsl:value-of select="normalize-space(substring-before($vol1,', S.'))"></xsl:value-of>
					</volume>
				</xsl:if>
		
	</xsl:element>
	<!--END OF DATASETELEMENT-->

<!--HIERARCHY-->
	<xsl:if test="datafield[@tag='QUE']/subfield[@code='L']">
		<xsl:element name="functions">	
			<hierarchyFields>
					<hierarchy_top_id><xsl:value-of select="datafield[@tag='QUE']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="datafield[@tag='QUE']/subfield[@code='a']" /></hierarchy_top_title>
				
					<hierarchy_parent_id><xsl:value-of select="datafield[@tag='QUE']/subfield[@code='L']"/><xsl:text>frso</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="datafield[@tag='QUE']/subfield[@code='a']" /></hierarchy_parent_title>
				
					<is_hierarchy_id><xsl:value-of select="$id"/><xsl:text>frso</xsl:text></is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:choose>
						<xsl:when test="contains(datafield[@tag='331'],'¬')">
							<xsl:value-of select="normalize-space(replace(datafield[@tag='331'],'¬',''))"/>
							</xsl:when>
						<xsl:when test="contains(datafield[@tag='331'],'&gt;&gt;')">
							<xsl:variable name="title" select="substring-after(substring-before(datafield[@tag='331'],'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
							<xsl:value-of select="normalize-space(replace(datafield[@tag='331'],'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="normalize-space(datafield[@tag='331'])" />
							</xsl:otherwise>
						</xsl:choose>
						<!--<xsl:value-of select="datafield[@tag='331']" />--></is_hierarchy_title>
				
					<hierarchy_sequence><xsl:value-of select="substring(datafield[@tag='331'],1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
		</xsl:element>	
		</xsl:if>


</xsl:if>




<!--Bildtonträger________________Bildtonträger___________________________Bildtonträger-->
<!--Bildtonträger________________Bildtonträger___________________________Bildtonträger-->
<!--Bildtonträger________________Bildtonträger___________________________Bildtonträger-->

<xsl:if test="datafield[@tag='078'][1][text()='Bildtonträger']">

	<xsl:element name="dataset">

<!--FORMAT-->
	
	<!--typeOfRessource-->
		<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>		
		<!--<xsl:choose>
			<xsl:when test="contains(datafield[@tag='100']/subfield[@code='b'],'Regie')">
				<typeOfRessource>
					<xsl:text>moving image</xsl:text>
					</typeOfRessource>		
				</xsl:when>
			</xsl:choose>-->

	<!--format Objektartinformationen-->
		<format><xsl:text>Film</xsl:text></format>

	<!--documentType-->
		<documentType>
			<xsl:value-of select="datafield[@tag='652']/subfield[@code='a']" />
			</documentType>

<!--TITLE-->	
	
	<!--title Titelinformationen-->	
			<xsl:apply-templates select="datafield[@tag='331']" />

	<!--alternativeTitle-->
			<xsl:apply-templates select="datafield[@tag='370']" />

<!--RESPONSIBLE-->	

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="datafield[@tag='100']" />
			<xsl:apply-templates select="datafield[@tag='104']" />
			<xsl:apply-templates select="datafield[@tag='108']" />

<!--IDENTIFIER-->
<!--PUBLISHING-->

	<!--display / publishDate Jahresangabe-->
			<xsl:apply-templates select="datafield[@tag='425'][1]" />

	<!--placeOfPublication Ortsangabe-->
			<xsl:apply-templates select="datafield[@tag='594']" />
			<xsl:apply-templates select="datafield[@tag='410']" />
			
	<!--publisher Verlag-->
			<xsl:apply-templates select="datafield[@tag='412']" />

<!--PHYSICAL INFORMATION-->

	<!--dimensions-->
			<xsl:apply-templates select="datafield[@tag='653']" />

	<!--language Sprachangaben-->
			<xsl:apply-templates select="datafield[@tag='037']" />

<!--CONTENTRELATED INFORMATION-->			

	<!--description-->
			<xsl:apply-templates select="datafield[@tag='750']" />

	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="datafield[@tag='THS']" />
			<xsl:apply-templates select="datafield[@tag='710']" />
			<xsl:apply-templates select="datafield[@tag='740']" />
			<xsl:apply-templates select="datafield[@tag='902']" />		
			
		</xsl:element>


	</xsl:if>












<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
			
			
		</xsl:element>
		</xsl:if>
	</xsl:template>

	
	<xsl:template match="datafield[@tag='653']">
		<dimension>
			<xsl:value-of select="subfield[@code='a']" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="subfield[@code='c']" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="subfield[@code='d']" />
			</dimension>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='359']">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsg.')">
				<editor>
					<xsl:value-of select="normalize-space(substring-after(.,'Hrsg.:'))" />
					</editor>
				</xsl:when>
			<xsl:otherwise>
				<editor>
					<xsl:value-of select="normalize-space(.)" />
					</editor>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='QUE']/subfield[@code='b']">
		<xsl:variable name="physical" select="substring-after(.,';')" />
		<xsl:choose>
			<xsl:when test="not(contains(.,';'))">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
					</physical>
				</xsl:when>
			<xsl:when test="not(contains($physical,'S.'))">
				<physical>
					<xsl:value-of select="normalize-space(substring-after(substring-before(.,';'), 'S.'))"></xsl:value-of>
					</physical>
				</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
					</physical>
				</xsl:otherwise>
			</xsl:choose>
		<!--<original>
			<xsl:value-of select="."></xsl:value-of>
		</original>
		<test>
			<xsl:value-of select="$physical"></xsl:value-of>
		</test>
		<physical>
			<xsl:value-of select="normalize-space(substring-after(., 'S.'))" />
			</physical>-->
		</xsl:template>
	
	<xsl:template match="datafield[@tag='200']">
		<entity>
			<xsl:value-of select="subfield[@code='a']" />
			</entity>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='544']">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='GTU']">
		<series>
			<xsl:value-of select="." />
			</series>
		</xsl:template>	

	<xsl:template match="datafield[@tag='GT1']">
		<series>
			<xsl:value-of select="subfield[@code='a']" />
			</series>
		<xsl:if test="subfield[@code='b']">
			<seriesNr>
				<xsl:value-of select="subfield[@code='b']" />
				</seriesNr>
			</xsl:if>
		</xsl:template>		
	
	<xsl:template match="datafield[@tag='GT0']">
		<series>
			<xsl:value-of select="subfield[@code='a']" />
			</series>
		</xsl:template>	
	
	<xsl:template match="datafield[@tag='403']">
		<edition>
			<xsl:value-of select="." />
			</edition>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='542']">
		<issn>
			<xsl:value-of select="." />
			</issn>
		</xsl:template>

	<xsl:template match="datafield[@tag='540']">
		<xsl:for-each select=".">
			<isbn>
				<xsl:value-of select="subfield[@code='a']" />
				</isbn>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='753']">
		<listOfContents>
			<xsl:value-of  select="." />
			</listOfContents>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='530']">
		<listOfContents>
			<xsl:value-of  select="." />
			</listOfContents>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='750']">
		<description>
			<xsl:value-of  select="." />
			</description>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='THS']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='710']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='740']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="." />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='902']">
		<xsl:for-each select=".">
			<subjectTopic>
				<xsl:value-of select="subfield[@code='a']" />
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='037']">
		<xsl:for-each select=".">
			<language_code>
				<xsl:value-of select="." />
				</language_code>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='434']">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='437']">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='435']">
		<dimension>
			<xsl:value-of select="." />
			</dimension>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='433']">
		<physical>
			<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" />
			</physical>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='410']">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='412']">
		<publisher>
			<xsl:value-of select="." />
			</publisher>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='594']">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='425']">
		
		<xsl:choose>
			<xsl:when test=".[@ind1='a']">
				<displayPublishDate>
					<xsl:value-of select=".[@ind1='a']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select=".[@ind1='a']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test=".[@ind1='b']">
				<displayPublishDate>
					<xsl:value-of select=".[@ind1='b']"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select=".[@ind1='b']"/>
					</publishDate>
				</xsl:when>
			<xsl:when test="datafield[@tag='425'][@ind1='c']">
				<displayPublishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					<xsl:text> - </xsl:text>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='b']" />
					</publishDate>
				<publishDate>
					<xsl:value-of select="datafield[@tag='425'][@ind1='c']" />
					</publishDate>	
					
					<!--<timeSpan>
						<timeSpanStart><xsl:value-of select=".[@ind1='b']" /></timeSpanStart>
						<timeSpanEnd><xsl:value-of select=".[@ind1='c']" /></timeSpanEnd>
					</timeSpan>-->
					</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="."/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
	
		<!--<xsl:choose>
			<xsl:when test="../datafield[@tag='078'][1][text()='Reihe']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="@ind1='b'" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select="translate(subfield[@code='c'], translate(.,'0123456789', ''), '')" /></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			<xsl:when test="../datafield[@tag='078'][1][text()='Zeitschrift']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select=".[@ind1='b']" /></timeSpanStart>
					<timeSpanEnd><xsl:value-of select=".[@ind1='c']" /></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			<xsl:when test="../datafield[@tag='078'][1][text()='ÖEZA-Zeitschrift']">
				<timeSpan>
					<timeSpanStart><xsl:value-of select="translate(., translate(.,'0123456789', ''), '')" /></timeSpanStart>
					<timeSpanEnd></timeSpanEnd>
				</timeSpan>	
				</xsl:when>
			</xsl:choose>-->
		
		</xsl:template>
	
	<xsl:template match="datafield[@tag='108']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

	<xsl:template match="datafield[@tag='104']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='100']">
		<xsl:choose>
			<xsl:when test="contains(subfield[@code='b'],'Hrsg.')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'Übers.')">
				<contributor>
					<xsl:value-of select="subfield[@code='a']" />
				</contributor>
				</xsl:when>
			<xsl:when test="contains(subfield[@code='b'],'[Regie]')">
				<editor>
					<xsl:value-of select="subfield[@code='a']" />
				</editor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="subfield[@code='a']" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='341']">
		<originalTitle>
			<!--<xsl:value-of select="." />-->
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
			</originalTitle>
		</xsl:template>
		
	<xsl:template match="datafield[@tag='370']">
		<alternativeTitle>
			<!--<xsl:value-of select="." />-->
			
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
			</alternativeTitle>
		</xsl:template>
	
	<xsl:template match="datafield[@tag='331']">
		
		<title>
			<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
			
				<!--<xsl:value-of select="translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ¬', '1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ')" />-->
				<!--<xsl:value-of select="datafield[@tag='331']" />-->
			
			<xsl:if test="../datafield[@tag='335']">
					<xsl:text>: </xsl:text>
					<xsl:value-of select="../datafield[@tag='335']"></xsl:value-of>
				</xsl:if>
				
			</title>
			
			<title_short>
				<xsl:choose>
				<xsl:when test="contains(.,'¬')">
					<xsl:value-of select="normalize-space(replace(.,'¬',''))"/>
					</xsl:when>
				<xsl:when test="contains(.,'&gt;&gt;')">
					<xsl:variable name="title" select="substring-after(substring-before(.,'&gt;&gt;'),'&lt;&lt;')"></xsl:variable>
					<xsl:value-of select="normalize-space(replace(.,'&lt;&lt;(.*?)&gt;&gt;',$title))"></xsl:value-of>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
				
				
				<!--<xsl:value-of select="translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ¬', '1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ')" />-->
			</title_short>
		
		<xsl:if test="../datafield[@tag='335']">
			<title_sub>
				<xsl:value-of select="../datafield[@tag='335']" />
				</title_sub>
			</xsl:if>

		</xsl:template>


</xsl:stylesheet>
