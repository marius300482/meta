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
	
	<xsl:template match="@*[.='']"/><!-- Leere Knoten werden entfernt-->
	
	<xsl:strip-space elements="*"/><!--Whitespace entfernen-->

	<xsl:template match="Spinnboden">
		<xsl:element name="catalog">
			<xsl:for-each select="datensatz">

			<!--<xsl:if test="(objektart[text()='D - Diplomarbeiten']) and (Titel_x032x_-D)">-->

	<!--B-Buchtitel-->		
						
			<xsl:if test="objektart[text()='B - Buchtitel']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Buch</xsl:text></format>
			
			<!--documentType-->
					<xsl:choose>
						<xsl:when test="s_x046x__x032x_Einzeltitel_x032x_-B">
							<documentType><xsl:text>Sammelband</xsl:text></documentType>
							</xsl:when>
						<xsl:otherwise>
							<documentType><xsl:text>Monografie</xsl:text></documentType>
							</xsl:otherwise>
						</xsl:choose>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Buchtitel[1]" />
			
			<!--originalTitle-->
					<xsl:apply-templates select="Originaltitel" />

<!--RESPONSIBLE-->
			
			<!--author Autorinneninformation-->
					<xsl:apply-templates select="Autorin" />
			
			<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="HerausgeberIn" />

<!--PUBLISHING-->

			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr[1]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort" />	
				
			<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag" />

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[1]" />
			
			<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Ausstattung[1]" />
			
<!--CONTENTRELATED INFORMATION-->
			
			<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache" />
				
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptoren" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen" />
			
			<!--subjectGeographic Ortsangaben-->
					<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts" />
			
			<!--description-->
					<xsl:apply-templates select="Annotation[1]" />

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur" />
			
			<!--itemLocation Standortangabe-->
					<xsl:apply-templates select="Standort" />
						
				
						</xsl:element><!--closing tag dataset-->
			
			<xsl:apply-templates select="s_x046x__x032x_Einzeltitel_x032x_-B[1]" />
			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
		
			
			
				
	<!--BI - Titel (Aufsätze) in Sammelbänden-->
				
			<xsl:if test="(objektart[text()='BI - Titel (Aufsätze) in Sammelbänden']) and (s_x046x__x032x_Buchtitel)">
			<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben-->
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">
			
			<!--variables-->	
					<xsl:variable name="relatedID" select="translate(s_x046x__x032x_Buchtitel[1], translate(.,'0123456789', ''), '')"/>
					
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Artikel</xsl:text></format>
			
			<!--documentType-->
					<documentType>Artikel aus Sammelband</documentType>
			
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Einzeltitel[1]" />
			
			<!--author Autorinneninformation-->
					<xsl:apply-templates select="Autorin" />
			
			<!--display / publishDate Jahresangabe-->
					<xsl:if test="//datensatz[id=$relatedID]/Jahr[1]">
						<displayPublishDate>
							<xsl:value-of select="//datensatz[id=$relatedID]/Jahr[1]" />
							</displayPublishDate>
						<publishDate>
							<xsl:value-of select="translate(//datensatz[id=$relatedID]/Jahr[1], translate(.,'0123456789', ''), '')" />
							</publishDate>
						</xsl:if>
					
					<xsl:apply-templates select="Jahr[1]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:if test="//datensatz[id=$relatedID]/Ort">
						<placeOfPublication>
							<xsl:value-of select="//datensatz[id=$relatedID]/Ort" />
							</placeOfPublication>
						</xsl:if>
				
			<!--publisher Verlagsangabe-->
					<xsl:if test="//datensatz[id=$relatedID]/Verlag">
						<publisher>
							<xsl:value-of select="//datensatz[id=$relatedID]/Verlag" />
							</publisher>
						</xsl:if>

			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[1]" />
			
			<!--specificMaterialDesignation-->
					<xsl:apply-templates select="Ausstattung[1]" />
			
			<!--description-->
					<xsl:apply-templates select="Annotation" />
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptoren" />
			
						
					</xsl:element><!--closing tag dataset-->
			
				<xsl:element name="functions">
					<xsl:apply-templates select="s_x046x__x032x_Buchtitel" />		
					</xsl:element>
			
			</xsl:element><!--closing tag record-->
				
			</xsl:if>
			

	<!--D - Diplomarbeiten-->
				
			<xsl:if test="(objektart[text()='D - Diplomarbeiten']) and (Titel_x032x_-D)">
			<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben-->
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">
			
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Hochschulschrift</xsl:text></format>
			
			<!--documentType-->
					<xsl:apply-templates select="Art_x032x_der_x032x_Arbeit" />

			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Titel_x032x_-D[1]" />
			
			<!--author Autorinneninformation-->
					<xsl:apply-templates select="Autorin" />
			
			<!--reviewer Begutachterin-->
					<xsl:apply-templates select="Betreuung_x047x_MentorIn_x058x_" />
			
			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr[1]" />

			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort_x047x_Verlag_x058x_" />	
					
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Schlagwortliste_x032x_-B" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen" />
			

						</xsl:element><!--closing tag dataset-->
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
			
			
	<!--Ze - Zeitschriften/Einzeltitel-->
				
			<xsl:if test="(objektart[text()='Ze - Zeitschriften/Einzeltitel']) 
			and (Einzeltitel) and (s_x046x__x032x_ST)">
			<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben-->
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">
			
			
			<!--variables-->	
					<xsl:variable name="relatedID" select="translate(s_x046x__x032x_ST[1], translate(.,'0123456789', ''), '')" />
			
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Artikel</xsl:text></format>
			
			<!--documentType-->
					<documentType>
						<xsl:text>Zeitschriftenartikel</xsl:text>
						</documentType>		
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Einzeltitel[1]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:if test="//datensatz[id=$relatedID]/Ort">
						<placeOfPublication>
							<xsl:value-of select="//datensatz[id=$relatedID]/Ort" />
							</placeOfPublication>
						</xsl:if>
			
			<!--publisher Verlagsangabe-->
					<xsl:if test="//datensatz[id=$relatedID]/Verlag">
						<publisher>
							<xsl:value-of select="//datensatz[id=$relatedID]/Verlag" />
							</publisher>
						</xsl:if>
			
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[1]" />
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptoren" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen" />
			
			<!--subjectGeographic-->
					<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts" />
			
			<!--description-->
					<xsl:apply-templates select="Annotation[1]" />
			
			<!--issue Heft-->	
					<xsl:apply-templates select="Heftnummer_x032x_-Z" />
			
			<!--volume Jahrgang-->
					<xsl:apply-templates select="Jahrgang" />
			
			<!--sourceInfo-->
					<sourceInfo>
						<xsl:value-of select="//datensatz[id=$relatedID]/Sammeltitel_x032x_-Zs" />
						<xsl:text> </xsl:text>
						<xsl:if test="Jahrgang">
							<xsl:text> </xsl:text>
							<xsl:value-of select="Jahrgang" />
							</xsl:if>
						
						<xsl:if test="Jahr">
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr" />
							<xsl:text>)</xsl:text>
							</xsl:if>
						<xsl:if test="Heftnummer_x032x_-Z">
							<xsl:value-of select="Heftnummer_x032x_-Z" />
							</xsl:if>
						</sourceInfo>
					
			
						</xsl:element><!--closing tag dataset-->
				
				<xsl:element name="functions">
					<xsl:apply-templates select="s_x046x__x032x_ST" />		
					</xsl:element>		
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
			
				
	<!--Zs - Zeitschriften/Sammeltitel-->
				
			<xsl:if test="(objektart[text()='Zs - Zeitschriften/Sammeltitel']) 
			and (Sammeltitel_x032x_-Zs)">
			<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben-->
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">
			
			<!--variables-->	
					<!--<xsl:variable name="relatedID" select="translate(s_x046x__x032x_ST[1], translate(.,'0123456789', ''), '')" />-->
			
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Zeitschrift</xsl:text></format>
					
					<!--<xsl:choose>
						<xsl:when test="s_x046x__x032x_ET">
							<format><xsl:text>Zeitschriftenheft</xsl:text></format>
							</xsl:when>
						<xsl:when test="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_">
							<format><xsl:text>Zeitschrift</xsl:text></format>
							</xsl:when>
						<xsl:otherwise>
							<format><xsl:text>Zeitschrift</xsl:text></format>
							</xsl:otherwise>
						</xsl:choose>-->
			
			<!--documentType-->
					<!--<documentType>
						<xsl:text>Zeitschrift</xsl:text>
						</documentType>		-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Sammeltitel_x032x_-Zs[1]" />
			
			<!--editor Herausgeberinneninformationen-->
					<xsl:apply-templates select="Hrsg_x032x_-_x032x_Zs" />
						
			<!--displayPublishDate-->
					<xsl:apply-templates select="Ersch_x046x_-zeitraum" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Ort" />	
				
			<!--publisher Verlagsangabe-->
					<xsl:apply-templates select="Verlag" />
				
						</xsl:element><!--closing tag dataset-->
				
			<!--functions-->
				<xsl:choose>
					<xsl:when test="s_x046x__x032x_ET">
						<xsl:apply-templates select="s_x046x__x032x_ET" />
						</xsl:when>
					<xsl:when test="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_">
						<xsl:apply-templates select="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_" />
						</xsl:when>
				</xsl:choose>
				<xsl:apply-templates select="Erfassungsstelle" />
				
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
				

	<!--Zh - Zeitschriften/Hefttitel-->
				
			<xsl:if test="(objektart[text()='Zh - Zeitschriften/Hefttitel']) 
			and (Hefttitel_x032x_-Zh)">
			<!--Einzeltitel ohne die Angabe zur Referenz werden nicht mit ausgegeben-->
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="id" /></xsl:attribute>
					
			<xsl:apply-templates select="Tagesdatum" /><!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Zeitschrift</xsl:text></format>
			
			<!--documentType-->
					<documentType>
						<xsl:text>Zeitschriftenheft</xsl:text>
						</documentType>		
		
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Hefttitel_x032x_-Zh[1]" />
			
			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="Jahr[1]" />
			
			<!--language Sprachangaben-->
					<xsl:apply-templates select="Sprache" />
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptoren" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen" />
			
			<!--subjectGeographic-->
					<xsl:apply-templates select="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts" />
		
			<!--issue Heft-->	
					<xsl:apply-templates select="Heftnummer_x032x_-Z" />
			
			<!--volume Jahrgang-->
					<xsl:apply-templates select="Jahrgang" />
		
						</xsl:element><!--closing tag dataset-->
						
				
			<!--functions-->
				<xsl:apply-templates select="s_x046x__x032x_Sammeltitel_x032x_-Zs_x040x_h_x041x_" />		
					
						
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
				
				<!--</xsl:if>--><!--closing tag format condition-->
				</xsl:for-each><!--closing tag for-eacht Schleife datansatz-->

			
	</xsl:element>
	</xsl:template>










<!--Templates-->	
			<xsl:template match="Ersch_x046x_-zeitraum">
				<displayPublishDate>
					<xsl:value-of select="."></xsl:value-of>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="."></xsl:value-of>
					</publishDate>
				</xsl:template>	
			
			<xsl:template match="Jahrgang">
				<volume>
					<xsl:value-of select="." />
				</volume>
				</xsl:template>
			
			<xsl:template match="Heftnummer_x032x_-Z">
				<issue>
					<xsl:value-of select="." />
					</issue>
				</xsl:template>
			
			<xsl:template match="Schlagwortliste_x032x_-B">
				<xsl:for-each select=".">
					<subjectTopic>
						<xsl:value-of  select="." />
						</subjectTopic>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Ort_x047x_Verlag_x058x_">
				<placeOfPublication>
					<xsl:value-of select="." />
					</placeOfPublication>
				</xsl:template>
			
			<xsl:template match="Betreuung_x047x_MentorIn_x058x_">
				<reviewer>
					<xsl:value-of select="." />
					</reviewer>
				</xsl:template>
			
			<xsl:template match="Art_x032x_der_x032x_Arbeit">
				<documentType>
					<xsl:value-of select="."></xsl:value-of>
					</documentType>
				</xsl:template>
			
		
			
			
			<xsl:template match="s_x046x__x032x_Einzeltitel_x032x_-B[1]">
				<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="relatedTitle" select="//datensatz[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
				<xsl:element name="functions">
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Buchtitel" /></hierarchy_top_title>
					
					<!--<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					-->
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Buchtitel" /></is_hierarchy_title>
					
					<!--<hierarchy_sequence>
						<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
					</hierarchy_sequence>-->
					
					</hierarchyFields>
					</xsl:element>
				</xsl:template>
				
			<xsl:template match="s_x046x__x032x_ET">
				<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="relatedTitle" select="//datensatz[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
				<xsl:element name="functions">
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Sammeltitel_x032x_-Zs" /></hierarchy_top_title>
					
					<!--<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					-->
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Sammeltitel_x032x_-Zs" /></is_hierarchy_title>
					
					<!--<hierarchy_sequence>
						<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
					</hierarchy_sequence>-->
					
					</hierarchyFields>
					</xsl:element>
				</xsl:template>
			
			<xsl:template match="s_x046x__x032x_Hefttitel_x032x_-Zh_x040x_s_x041x_">
				<xsl:element name="functions">
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="../Sammeltitel_x032x_-Zs" /></hierarchy_top_title>
					<!--
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					-->
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Sammeltitel_x032x_-Zs" /></is_hierarchy_title>
					
					<!--<hierarchy_sequence>
						<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
					</hierarchy_sequence>-->
					
					</hierarchyFields>
					</xsl:element>
				</xsl:template>
			
			<xsl:template match="s_x046x__x032x_Sammeltitel_x032x_-Zs_x040x_h_x041x_">
				<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="relatedTitle" select="//datensatz[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
				<xsl:element name="functions">
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="$relatedTitle" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Hefttitel_x032x_-Zh" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
					</hierarchy_sequence>
					
					</hierarchyFields>
					</xsl:element>
				</xsl:template>
			
			<xsl:template match="s_x046x__x032x_ST">
				<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="sequence" select="substring-before(../Umfang,'-')" />
				<xsl:variable name="relatedTitle" select="//datensatz[id=$relatedID]/Sammeltitel_x032x_-Zs"></xsl:variable>
				<xsl:element name="functions">
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="$relatedTitle" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Einzeltitel" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="normalize-space(substring-after($sequence,'S.'))"></xsl:value-of>
					</hierarchy_sequence>
					
					</hierarchyFields>
					</xsl:element>
				</xsl:template>
			
			<xsl:template match="s_x046x__x032x_Buchtitel">
				<xsl:variable name="relatedID" select="translate(.[1], translate(.,'0123456789', ''), '')"/>
				<xsl:variable name="relatedTitle" select="//datensatz[id=$relatedID]/Buchtitel"></xsl:variable>
				<hierarchyFields>
				
					<hierarchy_top_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_top_id>
					<hierarchy_top_title><xsl:value-of select="$relatedTitle" /></hierarchy_top_title>
					
					<hierarchy_parent_id><xsl:value-of select="$relatedID"/><xsl:text>spinnboden</xsl:text></hierarchy_parent_id>
					<hierarchy_parent_title><xsl:value-of select="$relatedTitle" /></hierarchy_parent_title>
					
					<is_hierarchy_id><xsl:value-of select="../id"/><xsl:text>spinnboden</xsl:text></is_hierarchy_id>
					<is_hierarchy_title><xsl:value-of select="../Einzeltitel" /></is_hierarchy_title>
					
					<hierarchy_sequence>
						<xsl:value-of select="substring-after(../Umfang,'S.')"></xsl:value-of>
					</hierarchy_sequence>
					
					</hierarchyFields>
				</xsl:template>
			
			<xsl:template match="Originaltitel">
				<originalTitle>
					<xsl:value-of  select="." />
					</originalTitle>
				</xsl:template>
			
			<xsl:template match="Personen">
				<xsl:for-each select=".">
					<subjectPerson>
						<xsl:value-of  select="." />			
						</subjectPerson>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Standort">
				<itemLocation>
					<xsl:value-of select="." />
					</itemLocation>
				</xsl:template>
			
			<xsl:template match="Ausstattung">
				<specificMaterialDesignation>
					<xsl:value-of select="." />
					</specificMaterialDesignation>
				</xsl:template>
			
			<xsl:template match="Umfang[1]">
				<xsl:choose>
					<xsl:when test="../objektart[text()='B - Buchtitel']">
						<physical>
							<xsl:value-of select="normalize-space(substring-before(.,'S.'))"></xsl:value-of>
							</physical>
						</xsl:when>
					<xsl:when test="../objektart[text()='BI - Titel (Aufsätze) in Sammelbänden']">
						<physical>
							<xsl:value-of select="normalize-space(substring-after(.,'S.'))" />
							</physical>
						</xsl:when>
					<xsl:when test="../objektart[text()='Ze - Zeitschriften/Einzeltitel']">
						<physical>
							<xsl:value-of select="normalize-space(substring-after(.,'S.'))" />
							</physical>
						</xsl:when>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Signatur">
				<shelfMark>
					<xsl:value-of select="." />
					</shelfMark>
				</xsl:template>
			
			<xsl:template match="Ort_x047x_Land_x032x_d_x046x__x032x_Handlung_x047x_Inhalts">
				<xsl:for-each select=".">
					<subjectGeographic>
						<xsl:value-of select="." />
						</subjectGeographic>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Annotation[1]">
				<description>
					<xsl:value-of select="." />
					</description>
				</xsl:template>
			
			<xsl:template match="Deskriptoren">
				<xsl:for-each select=".">
					<subjectTopic>
						<xsl:value-of select="." />
						</subjectTopic>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Sprache">
				<language>
					<xsl:value-of select="."></xsl:value-of>
					</language>
				</xsl:template>
			
			<xsl:template match="Umfang">
				<physical>
					
					</physical>
				</xsl:template>
			
			<xsl:template match="Verlag">
				<publisher>
					<xsl:value-of select="." />
					</publisher>
				</xsl:template>
			
			<xsl:template match="Ort">
				<placeOfPublication>
					<xsl:value-of select="." />
					</placeOfPublication>
				</xsl:template>
			
			<xsl:template match="Jahr[1]">
				<!--<displayPublishDate>
					<xsl:value-of select="." />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(.[1], translate(.,'0123456789', ''), '')" />
					</publishDate>-->
				
				<displayPublishDate>
					<xsl:value-of select="." />
					</displayPublishDate>
				
				<xsl:variable name="jear" select=".[1]"/>
			<xsl:choose>
				<xsl:when test="string-length($jear) &gt; 7">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring-after(.[1], '/')"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="Jahr[1]=''">
					<publishDate>
						<xsl:text>o.A.</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(contains(.[1], '[')) or (contains(.[1], '(')) or (contains(.[1], 'ca'))">
					<publishDate>
						<xsl:value-of select="normalize-space(translate(.[1], translate(.,'0123456789', ''), ''))"/>
						</publishDate>
					</xsl:when>
				<xsl:when test="matches(.[1],'[a-z]')">
					<publishDate>
						<xsl:text>o.A.</xsl:text>
						</publishDate>
					</xsl:when>
				<xsl:when test="(matches(.[1],'/'))">
					<publishDate>
						<xsl:value-of select="substring-before(.[1], '/')"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring(.[1], 1,2)"/>
						<xsl:value-of select="substring-after(.[1], '/')"/>
						</publishDate>
					</xsl:when>
				<xsl:otherwise>
					<publishDate>
						<xsl:value-of select=".[1]"/>
						</publishDate>
					</xsl:otherwise>
				</xsl:choose>
				
				
				</xsl:template>
			
			<xsl:template match="Hrsg_x032x_-_x032x_Zs">
				<xsl:for-each select=".">
					<editor>
						<xsl:value-of select="." />
						</editor>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="HerausgeberIn">
				<xsl:for-each select=".">
					<editor>
						<xsl:value-of select="." />
						</editor>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Autorin">
				<xsl:for-each select=".">
					<author>
						<xsl:value-of select="." />
						</author>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Sammeltitel_x032x_-Zs[1]">
				<xsl:choose>
					
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					
					<xsl:when test="contains(.,'.')">
					<xsl:variable name="subtitle" select="normalize-space(substring-after(., '.'))" />
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="substring-before(.,'.')" />
							</title_short>
						<xsl:if test="$subtitle!=''">
						<title_sub>
							<xsl:choose>
								<xsl:when test="contains($subtitle,'.')">
									<xsl:value-of select="normalize-space(substring-before($subtitle, '.'))"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$subtitle" />
									</xsl:otherwise>
								</xsl:choose>
							</title_sub>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="."/>
								</title>
							<title_short>
								<xsl:value-of select="."/>
								</title_short>
							</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>
			
			<xsl:template match="Buchtitel[1]">
				<xsl:choose>
					
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					
					<xsl:when test="contains(.,'.')">
					<xsl:variable name="subtitle" select="normalize-space(substring-after(., '.'))" />
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="substring-before(.,'.')" />
							</title_short>
						<xsl:if test="$subtitle!=''">
						<title_sub>
							<xsl:choose>
								<xsl:when test="contains($subtitle,'.')">
									<xsl:value-of select="normalize-space(substring-before($subtitle, '.'))"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$subtitle" />
									</xsl:otherwise>
								</xsl:choose>
							</title_sub>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="."/>
								</title>
							<title_short>
								<xsl:value-of select="."/>
								</title_short>
							</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>
			
			<xsl:template match="Einzeltitel[1]">
				<xsl:choose>
					
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					
					<xsl:when test="contains(.,'.')">
					<xsl:variable name="subtitle" select="normalize-space(substring-after(., '.'))" />
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="substring-before(.,'.')" />
							</title_short>
						<xsl:if test="$subtitle!=''">
						<title_sub>
							<xsl:choose>
								<xsl:when test="contains($subtitle,'.')">
									<xsl:value-of select="normalize-space(substring-before($subtitle, '.'))"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$subtitle" />
									</xsl:otherwise>
								</xsl:choose>
							</title_sub>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="."/>
								</title>
							<title_short>
								<xsl:value-of select="."/>
								</title_short>
							</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>

				<xsl:template match="Titel_x032x_-D[1]">
				<xsl:choose>
					
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					
					<xsl:when test="contains(.,'.')">
					<xsl:variable name="subtitle" select="normalize-space(substring-after(., '.'))" />
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="substring-before(.,'.')" />
							</title_short>
						<xsl:if test="$subtitle!=''">
						<title_sub>
							<xsl:choose>
								<xsl:when test="contains($subtitle,'.')">
									<xsl:value-of select="normalize-space(substring-before($subtitle, '.'))"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$subtitle" />
									</xsl:otherwise>
								</xsl:choose>
							</title_sub>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<title>
								<xsl:value-of select="."/>
								</title>
							<title_short>
								<xsl:value-of select="."/>
								</title_short>
							</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>
				
			<xsl:template match="Hefttitel_x032x_-Zh[1]">
				<xsl:choose>	
					<xsl:when test="contains(., ':')">
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(., ':'))"/>
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(., ':'))"/>
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="."/>
							</title>
						<title_short>
							<xsl:value-of select="."/>
							</title_short>
						</xsl:otherwise>
					</xsl:choose>		
				</xsl:template>

			<xsl:template match="Tagesdatum">
				<xsl:variable name="id" select="../id" />
				<xsl:element name="vufind">
					<!--Identifikator-->
						<id>
							<xsl:value-of select="$id" />
							<xsl:text>spinnboden</xsl:text>
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
				
				<xsl:element name="institution">
					<!--institutionShortname-->			
						<institutionShortname>
							<xsl:text>Spinnboden</xsl:text>
							</institutionShortname>
					<!--institutionFullname-->
						<institutionFull>
							<xsl:text>Spinnboden - Lesbenarchiv und Bibliothek</xsl:text>
							</institutionFull>
					<!--collection-->
						<collection><xsl:text>Spinnboden</xsl:text></collection>
					<!--isil-->
						<isil><xsl:text>DE-B1544</xsl:text></isil>
					<!--linkToWebpage-->
						<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/spinnboden/</xsl:text></link>
					<!--geoLocation-->
						<geoLocation>
							<latitude>52.5353200</latitude>
							<longitude>13.3991900</longitude>
							</geoLocation>
						</xsl:element>
				</xsl:template>


</xsl:stylesheet>
