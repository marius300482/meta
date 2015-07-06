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
	<xsl:template match="belladonna">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>



<xsl:template match="datensatz">	
	
	<!--<xsl:if test="Objektart[text()='Plakate']">-->
	<!--<xsl:if test="Objektart[text()='Zeitschriften-Artikel']">-->
	<!--<xsl:if test="Objektart[text()='Zeitschriften']">-->
	<!--<xsl:if test="Objektart[text()='Filme']">-->
	<!--<xsl:if test="Objektart[text()='Einzelfilm']">-->
	<!--<xsl:if test="Objektart[text()='Tonträger']">-->
	<!--<xsl:if test="Objektart[text()='CD']">-->
	<!--<xsl:if test="Objektart[text()='Graue Materialien']">-->
	<!--<xsl:if test="Objektart[text()='Einzelbeitrag']">-->
	<!--<xsl:if test="Objektart[text()='Diplom- und Examensarbeiten']">-->
	<!--<xsl:if test="Objektart[text()='Buch-Aufsatz']">-->
	<!--<xsl:if test="Objektart[text()='Sachliteratur']">-->
	<!--<xsl:if test="Objektart[text()='Belletristik']">-->

		<xsl:variable name="id" select="id" />
		<xsl:element name="record">
			<xsl:attribute name="id"><xsl:value-of select="$id"></xsl:value-of></xsl:attribute>	
		
	
	
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
		
		<xsl:variable name="s_sachtitel" select="translate(s_Sachtitel[1], translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="s_zeitschriftenreihe" select="translate(s__Zeitschriften-Reihe[1], translate(.,'0123456789', ''), '')"/>
		
<xsl:variable name="connect">

	<xsl:choose>
		<xsl:when test="s_Sachtitel!=''">
			
			<xsl:for-each select="//datensatz[id=$s_sachtitel]">
			
			<xsl:text>editor:</xsl:text>
				<xsl:value-of select="HerausgeberIn"></xsl:value-of>
				<xsl:text>:editor</xsl:text>
			
			<xsl:text>hrsg:</xsl:text>
				<xsl:value-of select="Hrsg__Körperschaft"></xsl:value-of>
				<xsl:text>:hrsg</xsl:text>
			
			<xsl:text>contributor:</xsl:text>
				<xsl:value-of select="ÜbersetzerIn"></xsl:value-of>
				<xsl:text>:contributor</xsl:text>
			
			<xsl:text>entity:</xsl:text>
				<xsl:value-of select="Körperschaft"></xsl:value-of>
				<xsl:text>:entity</xsl:text>
			
			<xsl:text>series:</xsl:text>
				<xsl:value-of select="Reihe"></xsl:value-of>
				<xsl:text>:series</xsl:text>
				
			<xsl:text>edition:</xsl:text>
				<xsl:value-of select="Ausgabe"></xsl:value-of>
				<xsl:text>:edition</xsl:text>
			
			<xsl:text>volume:</xsl:text>
				<xsl:value-of select="Band-Nr_"></xsl:value-of>
				<xsl:text>:volume</xsl:text>
			
			<xsl:text>isbn:</xsl:text>
				<xsl:value-of select="ISBN"></xsl:value-of>
				<xsl:text>:isbn</xsl:text>
			
			<xsl:text>publishDate:</xsl:text>
				<xsl:value-of select="Jahr"></xsl:value-of>
				<xsl:text>:publishDate</xsl:text>
			
			<xsl:text>placeOfPublication:</xsl:text>
				<xsl:value-of select="Ort"></xsl:value-of>
				<xsl:text>:placeOfPublication</xsl:text>
			
			<xsl:text>publisher:</xsl:text>
				<xsl:value-of select="Verlag"></xsl:value-of>
				<xsl:value-of select="Druckerei-Verlag"></xsl:value-of>
				<xsl:text>:publisher</xsl:text>
			
			<xsl:text>sourceInfo:</xsl:text>
				<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"></xsl:value-of>
				<xsl:text>:sourceInfo</xsl:text>
				
			<xsl:text>title_sub:</xsl:text>
				<xsl:value-of select="Zus__Sachtitel"></xsl:value-of>
				<xsl:text>:title_sub</xsl:text>
				
			<xsl:text>subtitle:</xsl:text>
				<xsl:value-of select="Untertitel"></xsl:value-of>
				<xsl:text>:subtitle</xsl:text>
			
			<xsl:text>shelfMark:</xsl:text>
				<xsl:value-of select="Signatur"></xsl:value-of>
				<xsl:text>:shelfMark</xsl:text>
			</xsl:for-each>	
		</xsl:when>
			
		<xsl:when test="s__Zeitschriften-Reihe!=''">
			
			<xsl:for-each select="//datensatz[id=$s_zeitschriftenreihe]">
			
			<xsl:text> editor:</xsl:text>
				<xsl:value-of select="HerausgeberIn"></xsl:value-of>
				<xsl:text>:editor</xsl:text>
			
			<xsl:text> hrsg:</xsl:text>
				<xsl:value-of select="Hrsg__Körperschaft"></xsl:value-of>
				<xsl:text>:hrsg</xsl:text>
			
			<xsl:text> entity:</xsl:text>
				<xsl:value-of select="Körperschaft"></xsl:value-of>
				<xsl:text>:entity</xsl:text>
			
			<xsl:text> series:</xsl:text>
				<xsl:value-of select="Reihe"></xsl:value-of>
				<xsl:text>:series</xsl:text>
			
			<xsl:text> volume:</xsl:text>
				<xsl:value-of select="Band-Nr_"></xsl:value-of>
				<xsl:text>:volume</xsl:text>
			
			<xsl:text> issn:</xsl:text>
				<xsl:value-of select="ISSN"></xsl:value-of>
				<xsl:text>:issn</xsl:text>
			
			<xsl:text> zdbid:</xsl:text>
				<xsl:value-of select="ZDB-ID"></xsl:value-of>
				<xsl:text>:zdbid</xsl:text>
			
			<xsl:text> publishDate:</xsl:text>
				<xsl:value-of select="Jahr"></xsl:value-of>
				<xsl:text>:publishDate</xsl:text>
			
			<xsl:text> placeOfPublication:</xsl:text>
				<xsl:value-of select="Ort"></xsl:value-of>
				<xsl:text>:placeOfPublication</xsl:text>
			
			<xsl:text> publisher:</xsl:text>
				<xsl:value-of select="Verlag"></xsl:value-of>
				<xsl:text>:publisher</xsl:text>
				
			<xsl:text> title_sub:</xsl:text>
				<xsl:value-of select="Zus__Sachtitel"></xsl:value-of>
				<xsl:text>:title_sub</xsl:text>
			
			<xsl:text> zeittitel:</xsl:text>
				<xsl:value-of select="Z-Titel_"></xsl:value-of>
				<xsl:text>:zeittitel</xsl:text>
				
			<xsl:text> subtitle:</xsl:text>
				<xsl:value-of select="Untertitel"></xsl:value-of>
				<xsl:text>:subtitle</xsl:text>
			
			<xsl:text> shelfMark:</xsl:text>
				<xsl:value-of select="Signatur"></xsl:value-of>
				<xsl:text>:shelfMark</xsl:text>
			</xsl:for-each>
			
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
		
		
<!--vufind_______________________________vufind_______________________________vufind-->	


<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id"/>
					<xsl:text>belladonna</xsl:text>
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
					<xsl:when test="Objektart[text()='Plakate']">
						<recordType>
							<xsl:text>archive</xsl:text>
							</recordType>
						</xsl:when>
					<xsl:otherwise>
						<recordType>
							<xsl:text>library</xsl:text>
							</recordType>
						</xsl:otherwise>
					</xsl:choose>		
					<!--<xsl:text>library</xsl:text>-->
			</xsl:element>




<!--institution_______________________________institution_______________________________institution-->

		<xsl:element name="institution">
	
	<!--institutionShortname-->
				<institutionShortname>
					<xsl:text>belladonna</xsl:text>
					</institutionShortname>
	<!--institutionFullname-->
				<institutionFull>
					<xsl:text>belladonna, Kultur, Bildung und Wirtschaft für Frauen e.V.</xsl:text>
					</institutionFull>
	
				<institutionID>
					<xsl:text>belladonna</xsl:text>
					</institutionID>
	
	<!--collection-->
				<collection>
					<xsl:text>belladonna</xsl:text>
					</collection>
	<!--isil-->
				<isil>
					<xsl:text>DE-Bre13</xsl:text>
					</isil>
	<!--linkToWebpage-->
				<link>
					<xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/belladonna/</xsl:text>
					</link>
	<!--geoLocation-->
				<geoLocation>
					<latitude>53.077493</latitude>
					<longitude>8.822647</longitude>
					</geoLocation>
			</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->











<!--Belletristik_________________Belletristik________________Belletristik-->


	<xsl:if test="Objektart[text()='Belletristik']">
		<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<!--<format><xsl:text>Buch</xsl:text></format>		-->
				<format><xsl:text>Buch</xsl:text></format>
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Belletristik</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
				<!--<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Dokumentenart!=''">
					<documentType><xsl:value-of select="Dokumentenart" /></documentType>
					</xsl:if>-->
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Sachtitel" />
				<xsl:apply-templates select="Originaltitel" />
			
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />				

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Ort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
				
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Kollationsvermerk" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache"/>		
				
	<!--subjects-->
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>
	
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>			

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
						
				
				
			</xsl:element>
		</xsl:if>












<!--Sachliteratur______________Sachliteratur____________Sachliteratur-->

	<xsl:if test="Objektart[text()='Sachliteratur']">
		<xsl:element name="dataset">

<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>		
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Sachliteratur</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Sachtitel" />
				<xsl:apply-templates select="Originaltitel" />
			
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />				

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Ort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
				
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Kollationsvermerk" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>
				
<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache"/>		
				
	<!--subjects-->
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>
	
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>			

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
			
			</xsl:element>	

<xsl:if test="s_Buch-Aufsatz!=''">
<xsl:element name="functions">
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="id"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"/>
	           	<xsl:if test="Zus__Sachtitel">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Zus__Sachtitel" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"/>
	           	<xsl:if test="Zus__Sachtitel">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Zus__Sachtitel" />
						</xsl:if>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Sachtitel,1,3))"/>
			</hierarchy_sequence>
	

	
	</xsl:element>
	</xsl:element>
	</xsl:if>	

</xsl:if>	












	
<!--Buch-Aufsatz______________Buch-Aufsatz____________Buch-Aufsatz-->
	
<xsl:if test="Objektart[text()='Buch-Aufsatz']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>		
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Buch-Aufsatz</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
				<!--
				<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Dokumentenart!=''">
					<documentType><xsl:value-of select="Dokumentenart" /></documentType>
					</xsl:if>-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Einzeltitel[1]" />

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />

	<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:for-each>
					</xsl:if>
				
	<!--contributor Beteiligte Personen-->
				<xsl:if test="substring(substring-after($connect,'contributor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'contributor:'),':contributor'), ';')">
					<contributor>
						<!--<xsl:value-of select="substring-before(substring-after($connect,'contributor:'),':contributor')" />-->
						<xsl:value-of select="normalize-space(.)" />
						<xsl:text> [Übers.]</xsl:text>
						</contributor>
						</xsl:for-each>
					</xsl:if>

	<!--entity Körperschaftsangaben-->	
				<xsl:if test="substring(substring-after($connect,'entity:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'entity:'),':entity'), ';')">
					<entity>
						<xsl:value-of select="normalize-space(.)" />
						</entity>
						</xsl:for-each>
					</xsl:if>

	<!--series Reiheninformation-->						
				<xsl:if test="substring(substring-after($connect,'series:'),1,1)!=':'">
					<!--<xsl:for-each select="tokenize(substring-before(substring-after($connect,'series:'),':series'), ';')">-->
					<series>
						<xsl:value-of select="substring-before(substring-after($connect,'series:'),':series')" />
						</series>
						<!--</xsl:for-each>-->
					</xsl:if>
				
	<!--volume-->
				<xsl:if test="substring(substring-after($connect,'volume:'),1,1)!=':'">
					<volume>
						<xsl:value-of select="substring-before(substring-after($connect,'volume:'),':volume')" />
						</volume>
					</xsl:if>

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:if test="substring(substring-after($connect,'isbn:'),1,1)!=':'">
					<isbn>
						<xsl:value-of select="substring-before(substring-after($connect,'isbn:'),':isbn')" />
						</isbn>
					</xsl:if>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
				<xsl:if test="substring(substring-after($connect,'publishDate:'),1,1)!=':'">
					<displayPublishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						</publishDate>
					</xsl:if>
						
	<!--placeOfPublication Ortsangabe-->
				<xsl:if test="substring(substring-after($connect,'placeOfPublication:'),1,1)!=':'">
					<placeOfPublication>
						<xsl:value-of select="substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication')" />
						</placeOfPublication>
					</xsl:if>
				
	<!--publisher Verlagsangabe-->
				<xsl:if test="substring(substring-after($connect,'publisher:'),1,1)!=':'">
					<publisher>
						<xsl:value-of select="substring-before(substring-after($connect,'publisher:'),':publisher')" />
						</publisher>
					</xsl:if>
	
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
					</sourceInfo>
			
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahl" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>	
								
<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>		

<!--OTHER-->
	
	<!--shelfMark-->
				<xsl:if test="substring(substring-after($connect,'shelfMark:'),1,1)!=':'">
					<shelfMark>
						<xsl:value-of select="substring-before(substring-after($connect,'shelfMark:'),':shelfMark')" />
						</shelfMark>
					</xsl:if>
		</xsl:element>
	
	
<xsl:element name="functions">
	
		<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	       	   	<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <hierarchy_parent_id>
	           	<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>belladonna</xsl:text>
	           	</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
						</xsl:if>
			</hierarchy_parent_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="replace(Einzeltitel[1],'_','')"/>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Einzeltitel[1],1,3))"/>
			</hierarchy_sequence>
	

	</xsl:element>
	</xsl:element>
</xsl:if>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!--Diplom- und Examensarbeiten___________Diplom- und Examensarbeiten________Diplom- und Examensarbeiten-->
	
	
	<xsl:if test="Objektart[text()='Diplom- und Examensarbeiten']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Hochschulschrift</xsl:text></format>		
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Diplom- und Examensarbeiten</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
				
				<!--<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Dokumentenart!=''">
					<documentType><xsl:value-of select="Dokumentenart" /></documentType>
					</xsl:if>-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Sachtitel" />
	
	
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	
<!--IDENTIFIER-->

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Ort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Kollationsvermerk" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache"/>		
				
	<!--subjects-->
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>
	
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	


		</xsl:element>
		</xsl:if>
	
	
	
	
	
	
<!--Einzelbeitrag________Einzelbeitrag__________________Einzelbeitrag-->	
	
	<xsl:if test="Objektart[text()='Einzelbeitrag']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>		
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Einzelbeitrag</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
	
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Einzeltitel[1]" />
				
				
	<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:for-each>
					</xsl:if>
				
	<!--contributor Beteiligte Personen-->
				<xsl:if test="substring(substring-after($connect,'contributor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'contributor:'),':contributor'), ';')">
					<contributor>
						<xsl:value-of select="normalize-space(.)" />
						<xsl:text> [Übers.]</xsl:text>
						</contributor>
						</xsl:for-each>
					</xsl:if>
				
	<!--entity Körperschaftsangaben-->	
				<xsl:if test="substring(substring-after($connect,'entity:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'entity:'),':entity'), ';')">
					<entity>
						<xsl:value-of select="normalize-space(.)" />
						</entity>
						</xsl:for-each>
					</xsl:if>

	<!--series Reiheninformation-->						
				<xsl:if test="substring(substring-after($connect,'series:'),1,1)!=':'">
					<series>
						<xsl:value-of select="substring-before(substring-after($connect,'series:'),':series')" />
						</series>
					</xsl:if>
	
	<!--series Reiheninformation-->						
				<xsl:if test="substring(substring-after($connect,'edition:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'edition:'),':edition'), ';')">
					<edition>
						<xsl:value-of select="normalize-space(.)" />
						</edition>
						</xsl:for-each>
					</xsl:if>
						
					
	<!--volume-->
				<xsl:if test="substring(substring-after($connect,'volume:'),1,1)!=':'">
					<volume>
						<xsl:value-of select="substring-before(substring-after($connect,'volume:'),':volume')" />
						</volume>
					</xsl:if>
				
<!--IDENTIFIER-->

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
				<xsl:if test="substring(substring-after($connect,'publishDate:'),1,1)!=':'">
					<displayPublishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						</publishDate>
					</xsl:if>
						
	<!--placeOfPublication Ortsangabe-->
				<xsl:if test="substring(substring-after($connect,'placeOfPublication:'),1,1)!=':'">
					<placeOfPublication>
						<xsl:value-of select="substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication')" />
						</placeOfPublication>
					</xsl:if>
				
	<!--publisher Verlagsangabe-->
				<xsl:if test="substring(substring-after($connect,'publisher:'),1,1)!=':'">
					<publisher>
						<xsl:value-of select="substring-before(substring-after($connect,'publisher:'),':publisher')" />
						</publisher>
					</xsl:if>
				
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
					<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
						</xsl:if>
					</sourceInfo>

<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahl" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>	
								
<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
				
<!--OTHER-->
	
	<!--shelfMark-->
				<xsl:if test="substring(substring-after($connect,'shelfMark:'),1,1)!=':'">
					<shelfMark>
						<xsl:value-of select="substring-before(substring-after($connect,'shelfMark:'),':shelfMark')" />
						</shelfMark>
					</xsl:if>
				
				<!--<xsl:if test="//datensatz[id=$s_sachtitel]/Signatur!=''">
				<xsl:variable name="rel" select="//datensatz[id=$s_sachtitel]/Signatur" />
					<shelfMark>
						<xsl:value-of select="normalize-space($rel)" />
						</shelfMark>
						</xsl:if>-->

		</xsl:element>
		
<xsl:element name="functions">
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <hierarchy_parent_id>
	           	<xsl:value-of select="$s_sachtitel"/>
			<xsl:text>belladonna</xsl:text>
	           	</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
	           	<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
						</xsl:if>
			</hierarchy_parent_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="replace(Einzeltitel[1],'_','')"/>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Einzeltitel[1],1,3))"/>
			</hierarchy_sequence>
	

	</xsl:element>
	</xsl:element>
	
		</xsl:if>
	
	












<!--Graue Materialien__________________Graue Materialien_________________Graue Materialien-->
	
	<xsl:if test="Objektart[text()='Graue Materialien']">
		<xsl:element name="dataset">
		
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>		
	<!--documentType-->
				<xsl:choose>
					<xsl:when test="Dokumentenart!=''">
						<documentType><xsl:value-of select="Dokumentenart" /></documentType>
						</xsl:when>
					<xsl:otherwise>
						<documentType><xsl:text>Graue Materialien</xsl:text></documentType>
						</xsl:otherwise>
					</xsl:choose>
				
				<!--
				<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Dokumentenart!=''">
					<documentType><xsl:value-of select="Dokumentenart" /></documentType>
					</xsl:if>-->
	
<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Sachtitel" />
				
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
				<xsl:apply-templates select="Hrsg__Körperschaft" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />

<!--IDENTIFIER-->

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Ort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
				<xsl:apply-templates select="Druckerei-Verlag"/>

	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />

<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Kollationsvermerk" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>

<!--CONTENTRELATED INFORMATION-->

	<!--language Sprachangaben-->
				<xsl:apply-templates select="Sprache"/>		
				
	<!--subjects-->
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>
	
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	
				
<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	




		</xsl:element>


<xsl:if test="s__Einzelbeitrag!=''">
<xsl:element name="functions">
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="id"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"/>
	           	<xsl:if test="Zus__Sachtitel!=''">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Zus__Sachtitel" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="normalize-space(replace(Sachtitel,'_',''))"/>
	           	<xsl:if test="Zus__Sachtitel!=''">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Zus__Sachtitel" />
						</xsl:if>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Sachtitel,1,3))"/>
			</hierarchy_sequence>
	

	
	</xsl:element>
	</xsl:element>
	</xsl:if>	

		</xsl:if>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
<!--CD_______________CD_______________CD-->
	
	<xsl:if test="Objektart[text()='CD']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>ton</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Tonträger</xsl:text></format>		
	<!--documentType-->
				<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="ergänz__Angaben!=''">
					<documentType><xsl:value-of select="ergänz__Angaben" /></documentType>
					</xsl:if>	
				
				

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="Sprecherin" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->	
				<xsl:apply-templates select="Ausgabe" />

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />	

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Entstehungsjahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Erscheinungsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
				
<!--PHYSICAL INFORMATION-->
	
	<!--runTime Laufzeit CD-->
				<xsl:apply-templates select="Laufzeit-_Umfang" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
			
		</xsl:element>
		</xsl:if>	
	









<!--Tonträger_______________Tonträger_______________Tonträger-->
	
	<xsl:if test="Objektart[text()='Tonträger']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>ton</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Tonträger</xsl:text></format>		
	<!--documentType-->
				<!--<documentType><xsl:value-of select="Objektart" /></documentType>-->
				<xsl:if test="Anlass-Ereignis-!=''">
					<documentType><xsl:value-of select="Anlass-Ereignis-" /></documentType>
					</xsl:if>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="Sprecherin" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->	
				<xsl:apply-templates select="Ausgabe" />

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />	

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Entstehungsjahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Erscheinungsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
				
<!--PHYSICAL INFORMATION-->
	
	<!--runTime Laufzeit CD-->
				<xsl:apply-templates select="Laufzeit-_Umfang" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
			
		</xsl:element>
		</xsl:if>	










<!--Einzelfilm__________Einzelfilm__________Einzelfilm-->

	<xsl:if test="Objektart[text()='Einzelfilm']">
	<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Film</xsl:text></format>		
	<!--documentType-->
				<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Anlass-Ereignis-!=''">
					<documentType><xsl:value-of select="Anlass-Ereignis-" /></documentType>
					</xsl:if>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="Sprecherin" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="_RegisseurIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->	
				<xsl:apply-templates select="Ausgabe" />

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />	

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Entstehungsjahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Erscheinungsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
				
<!--PHYSICAL INFORMATION-->
	
	<!--runTime Laufzeit CD-->
				<xsl:apply-templates select="Laufzeit-_Umfang" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
			
		</xsl:element>
		</xsl:if>	











<!--Film__________Film_________Film-->

	<xsl:if test="Objektart[text()='Filme']">
	<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Film</xsl:text></format>		
	<!--documentType-->
				<!--<documentType><xsl:value-of select="Objektart" /></documentType>-->
				<xsl:if test="Anlass-Ereignis-!=''">
					<documentType><xsl:value-of select="Anlass-Ereignis-" /></documentType>
					</xsl:if>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />

<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="Sprecherin" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="_RegisseurIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->	
				<xsl:apply-templates select="Ausgabe" />

<!--IDENTIFIER-->

	<!--ISBN-->
				<xsl:apply-templates select="ISBN" />	

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Entstehungsjahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Erscheinungsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
				
<!--PHYSICAL INFORMATION-->
	
	<!--runTime Laufzeit CD-->
				<xsl:apply-templates select="Laufzeit-_Umfang" />

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>	
			
		</xsl:element>
		</xsl:if>	








<!--Zeitschriften__________Zeitschriften_________Zeitschriften-->

	<xsl:if test="Objektart[text()='Zeitschriften']">
	<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Zeitschrift</xsl:text></format>
	<!--documentType Objektartinformationen-->
			<!--	<documentType><xsl:text>Zeitschrift</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Z-Titel_"/>
	
<!--RESPONSIBLE-->
	
	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />
	<!--editor Herausgeberinneninformationen-->
				<xsl:apply-templates select="HerausgeberIn" />
				<xsl:apply-templates select="Hrsg__Körperschaft" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="ÜbersetzerIn" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="Sprecherin" />
	<!--contributor Beteiligte Personen-->
				<xsl:apply-templates select="_RegisseurIn" />
	<!--entity Körperschaftsangaben-->	
				<xsl:apply-templates select="Körperschaft" />
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />
	<!--edition-->	
				<xsl:apply-templates select="Ausgabe" />

<!--IDENTIFIER-->

	<!--ISBN / ISSN-->
				<xsl:apply-templates select="ISSN" />

	<!--ZDB-ID-->
				<xsl:apply-templates select="ZDB-ID" />

<!--PUBLISHING-->
		
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Entstehungsjahr"/>
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Erscheinungsort"/>
	<!--publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag"/>
	<!--series Reiheninformation-->						
				<xsl:apply-templates select="Reihe" />
	<!--volume-->
				<xsl:apply-templates select="Band-Nr_" />

<!--PHYSICAL INFORMATION-->

<!--CONTENTRELATED INFORMATION-->

	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	

<!--OTHER-->

	<!--shelfMark Signatur-->
				<xsl:apply-templates select="Signatur"/>		
				

		</xsl:element>
		



<xsl:if test="//s__Zeitschriften-Reihe[contains(.,$id)]">
	<xsl:element name="functions">
	
		<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="id"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="normalize-space(replace(Z-Titel_,'_',''))"/>
	           	<xsl:if test="Untertitel!=''">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Untertitel" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="normalize-space(replace(Z-Titel_,'_',''))"/>
	           	<xsl:if test="Untertitel!=''">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="Untertitel" />
						</xsl:if>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Z-Titel_,1,3))"/>
			</hierarchy_sequence>
	
	</xsl:element>
	</xsl:element>
		</xsl:if>
	
	

</xsl:if>	









<!--Zeitschriften-Artikel______Zeitschriften-Artikel____________Zeitschriften-Artikel-->


<xsl:if test="Objektart[text()='Zeitschriften-Artikel']">
	<xsl:element name="dataset">
	
	
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>		
	<!--documentType-->
				<documentType><xsl:value-of select="Objektart" /></documentType>
				<xsl:if test="Dokumentenart!=''">
					<documentType><xsl:value-of select="Dokumentenart" /></documentType>
					</xsl:if>

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Z-Artikel-Titel[1]" />

<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="AutorIn" />

	<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:for-each>
					</xsl:if>
	
	<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'hrsg:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'hrsg:'),':hrsg'), ';')">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:for-each>
					</xsl:if>

	<!--entity Körperschaftsangaben-->	
				<xsl:if test="substring(substring-after($connect,'entity:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'entity:'),':entity'), ';')">
					<entity>
						<xsl:value-of select="normalize-space(.)" />
						</entity>
						</xsl:for-each>
					</xsl:if>

	<!--series Reiheninformation-->						
				<xsl:if test="substring(substring-after($connect,'series:'),1,1)!=':'">
					<series>
						<xsl:value-of select="substring-before(substring-after($connect,'series:'),':series')" />
						</series>
					</xsl:if>
	
	<!--volume-->
				<!--<xsl:if test="substring-after($connect,'volume:')!=':'">
					<volume>
						<xsl:value-of select="substring-before(substring-after($connect,'volume:'),':volume')" />
						</volume>
					</xsl:if>-->

<!--IDENTIFIER-->

	<!--ISSN-->
				<xsl:if test="substring(substring-after($connect,'issn:'),1,1)!=':'">
					<issn>
						<xsl:value-of select="substring-before(substring-after($connect,'issn:'),':issn')" />
						</issn>
					</xsl:if>
				
	<!--ZDBID-->
				<xsl:if test="substring(substring-after($connect,'zdbid:'),1,1)!=':'">
					<zdbId>
						<xsl:value-of select="substring-before(substring-after($connect,'zdbid:'),':zdbid')" />
						</zdbId>
					</xsl:if>

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
				
						
	<!--placeOfPublication Ortsangabe-->
				<xsl:if test="substring(substring-after($connect,'placeOfPublication:'),1,1)!=':'">
					<placeOfPublication>
						<xsl:value-of select="substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication')" />
						</placeOfPublication>
					</xsl:if>
				
	<!--publisher Verlagsangabe-->
				<xsl:if test="substring(substring-after($connect,'publisher:'),1,1)!=':'">
					<publisher>
						<xsl:value-of select="substring-before(substring-after($connect,'publisher:'),':publisher')" />
						</publisher>
					</xsl:if>
				
	<!--sourceInfo-->
				<sourceInfo>
					<xsl:value-of select="substring-before(substring-after($connect,'zeittitel:'),':zeittitel')" />
					<xsl:if test="substring(substring-after($connect,'subtitle:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'subtitle:'),':subtitle')" />
						</xsl:if>
					</sourceInfo>
			
<!--PHYSICAL INFORMATION-->
	
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seitenzahl" />
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Ausstattung"/>	
								
<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>	
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
		
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>		

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

	<!--issue Heft-->	
				<xsl:apply-templates select="Heft_Nr_"/>	

	<!--volume Jahrgang-->
				<xsl:apply-templates select="Jahrg_" />

<!--OTHER-->
	
	<!--shelfMark-->
				<xsl:apply-templates select="Heft-Signatur" />
				
			
		</xsl:element>
	
	
<xsl:element name="functions">
	
	<xsl:element name="hierarchyFields">
		
		<hierarchy_top_id>
			<xsl:value-of select="$s_zeitschriftenreihe"/>
			<xsl:text>belladonna</xsl:text>
			</hierarchy_top_id>
	           <hierarchy_top_title>
	           	<xsl:value-of select="substring-before(substring-after($connect,'zeittitel:'),':zeittitel')" />
	           	<xsl:if test="substring(substring-after($connect,'subtitle:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'subtitle:'),':subtitle')" />
						</xsl:if>
	           	</hierarchy_top_title>
	            
	           <hierarchy_parent_id>
	           	<xsl:value-of select="$s_zeitschriftenreihe"/>
			<xsl:text>belladonna</xsl:text>
	           	</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="substring-before(substring-after($connect,'zeittitel:'),':zeittitel')" />
	           	<xsl:if test="substring(substring-after($connect,'subtitle:'),1,1)!=':'">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="substring-before(substring-after($connect,'subtitle:'),':subtitle')" />
						</xsl:if>
			</hierarchy_parent_title>
	            
	           <is_hierarchy_id>
	           	<xsl:value-of select="id"/><xsl:text>belladonna</xsl:text>
	           	</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:value-of select="replace(Einzeltitel[1],'_','')"/>
			</is_hierarchy_title>
			
		<hierarchy_sequence>
			<xsl:value-of select="normalize-space(substring(Einzeltitel[1],1,3))"/>
			</hierarchy_sequence>
	

	</xsl:element>
	</xsl:element>
</xsl:if>	












<!--Plakate______Plakate____________Plakate-->


<xsl:if test="Objektart[text()='Plakate']">
	<xsl:element name="dataset">
	
<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>bild</xsl:text></typeOfRessource>
	<!--format Objektartinformationen-->
				<format><xsl:text>Plakat</xsl:text></format>		
	<!--documentType-->
				<!--<documentType><xsl:text>Plakat</xsl:text></documentType>-->

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel" />		

<!--RESPONSIBLE-->

<!--IDENTIFIER-->

<!--PUBLISHING-->
	
	<!--display publishDate Jahresangabe-->
				<xsl:apply-templates select="Veranstaltungsdatum" />	
				
	<!--placeOfPublication Ortsangabe-->
				<xsl:apply-templates select="Veranstaltungsort" />	

<!--PHYSICAL INFORMATION-->

	<!--dimension Ausmaße-->
				<xsl:apply-templates select="Format" />	
	<!--specificMaterialDesignation-->
				<xsl:apply-templates select="Bildbeschreibung" />	

<!--CONTENTRELATED INFORMATION-->				
	
	<!--Deskriptoren-->		
				<xsl:apply-templates select="Themen_Schlagwort"/>
				<xsl:apply-templates select="Länder_Schlagwort"/>	
				<xsl:apply-templates select="Frauen_Schlagwort"/>	
				<xsl:apply-templates select="Personen"/>	
	
	<!--description-->
				<xsl:apply-templates select="Inhalt"/>	
	
<!--OTHER-->
	
	<!--shelfMark-->
				<xsl:apply-templates select="Signatur" />

	</xsl:element>
	</xsl:if>
	


	
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->
<!--ENDE_____________________________ENDE___________________________________ENDE-->

			
			</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>

<!--Templates-->
	
	
	
	<xsl:template match="Bildbeschreibung">
		<specificMaterialDesignation>
			<xsl:value-of select="normalize-space(.)" />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="Format">
		<dimension>
			<xsl:value-of select="normalize-space(.)" />
			</dimension>
		</xsl:template>
	
	<xsl:template match="Jahrg_">
		<volume>
			<xsl:value-of select="normalize-space(.)" />
			</volume>
		</xsl:template>
	
	<xsl:template match="Heft_Nr_">
		<issue>
			<xsl:value-of select="normalize-space(.)" />
			</issue>
		</xsl:template>
	
	<xsl:template match="Laufzeit-_Umfang">
		<runTime>
			<xsl:value-of select="normalize-space(.)" />
			</runTime>
		</xsl:template>
	
	<xsl:template match="Ausgabe">
		<edition>
			<xsl:value-of select="normalize-space(.)" />
			</edition>
		</xsl:template>
	
	<xsl:template match="Seitenzahl">
		<physical>
			<xsl:value-of select="normalize-space(.)" />
			</physical>
		</xsl:template>
	
	<xsl:template match="Heft-Signatur">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Inhalt">
		<description>
			<xsl:value-of select="." />
			</description>
		</xsl:template>
	
	<xsl:template match="Frauen_Schlagwort">
		<xsl:for-each select="tokenize(., ';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Länder_Schlagwort">
		<xsl:for-each select="tokenize(., ';')">
			<subjectGeographic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectGeographic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Themen_Schlagwort">
		<xsl:for-each select="tokenize(., ';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Sprache">
		<language>
			<xsl:value-of select="." />
			</language>
		</xsl:template>
	
	<xsl:template match="Ausstattung">
		<specificMaterialDesignation>
			<xsl:value-of select="." />
			</specificMaterialDesignation>
		</xsl:template>
	
	<xsl:template match="Kollationsvermerk">
		<physical>
			<xsl:value-of select="normalize-space(substring-before(.,'S'))" />
			</physical>	
		</xsl:template>
	
	<xsl:template match="ZDB-ID">
		<zdbId>
			<xsl:value-of select="normalize-space(.)" />
			</zdbId>
		</xsl:template>
	
	<xsl:template match="ISSN">
		<issn>
			<xsl:value-of select="normalize-space(.)" />
			</issn>
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>

	<xsl:template match="Druckerei-Verlag">
		<publisher>
			<xsl:value-of select="." />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="." />
			</publisher>
		</xsl:template>
	
	<xsl:template match="Veranstaltungsort">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Erscheinungsort">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Ort">
		<placeOfPublication>
			<xsl:value-of select="." />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Entstehungsjahr">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="." />				
			</publishDate>	
		</xsl:template>
	
	<xsl:template match="Veranstaltungsdatum">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="." />				
			</publishDate>	
		</xsl:template>
	
	<xsl:template match="Jahr">
		<displayPublishDate>
			<xsl:value-of select="." />
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="." />				
			</publishDate>	
		</xsl:template>
	
	<xsl:template match="Band-Nr_">
			<volume>
				<xsl:value-of select="normalize-space(.)"/>
				</volume>
		</xsl:template>
	
	<xsl:template match="Reihe">
		<xsl:for-each select=".">
			<series>
				<xsl:value-of select="normalize-space(.)"/>
				</series>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Körperschaft">
		<xsl:for-each select="tokenize(., ';')">
			<entity>
				<xsl:value-of select="normalize-space(.)"/>
				</entity>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Personen">
		<xsl:for-each select="tokenize(., ';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="_RegisseurIn">
		<xsl:for-each select="tokenize(., ';')">
			<contributor>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text> [Regie]</xsl:text>
				</contributor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="SprecherInnen">
		<xsl:for-each select="tokenize(., ';')">
			<contributor>
				<xsl:value-of select="normalize-space(.)"/>
				<xsl:text> [Sprech.]</xsl:text>
				</contributor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="ÜbersetzerIn">
		<xsl:for-each select="tokenize(., ';')">
			<contributor>
				<xsl:value-of select="normalize-space(.)"/>
				</contributor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Hrsg__Körperschaft">
		<xsl:for-each select="tokenize(., ';')">
			<editor>
				<xsl:value-of select="normalize-space(.)"/>
				</editor>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="HerausgeberIn">
		<xsl:for-each select="tokenize(., ';')">
			<editor>
				<xsl:value-of select="normalize-space(.)"/>
				</editor>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="AutorIn">
		<xsl:for-each select="tokenize(., ';')">
			<author>
				<xsl:value-of select="normalize-space(.)"/>
				</author>
			</xsl:for-each>
		</xsl:template>

	<xsl:template match="Originaltitel">
		<xsl:for-each select=".">
			<originalTitle>
				<xsl:value-of select="." />
				</originalTitle>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Z-Artikel-Titel">
			<title>
				<xsl:value-of select="replace(.[1],'_','')"/>
				<xsl:if test="../Z-Art_-Untertitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="../Z-Art_-Untertitel" />
					</xsl:if>
				</title>
		
			<title_short>
				<xsl:value-of select="replace(.[1],'_','')"/>
				</title_short>
			
			<xsl:if test="../Z-Art_-Untertitel!=''">
				<title_sub>
					<xsl:value-of select="../Z-Art_-Untertitel" />
					</title_sub>	
				</xsl:if>
			
		</xsl:template>
	
	<xsl:template match="Z-Titel_">
			<title>
				<xsl:value-of select="replace(.[1],'_','')"/>
				<xsl:if test="../Untertitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="../Untertitel" />
					</xsl:if>
				</title>
		
			<title_short>
				<xsl:value-of select="replace(.[1],'_','')"/>
				</title_short>
			
			<xsl:if test="../Untertitel!=''">
				<title_sub>
					<xsl:value-of select="../Untertitel" />
					</title_sub>	
				</xsl:if>
			
		</xsl:template>
	
	<xsl:template match="Titel">
			<title>
				<xsl:value-of select="normalize-space(replace(.[1],'_',''))"/>
				<xsl:if test="../Zus__Sachtitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="normalize-space(../Zus__Sachtitel)" />
					</xsl:if>
				<xsl:if test="../Untertitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="normalize-space(../Untertitel)" />
					</xsl:if>
				</title>
		
			<title_short>
				<xsl:value-of select="normalize-space(replace(.[1],'_',''))"/>
				</title_short>
			
			<xsl:if test="../Zus__Sachtitel!=''">
				<title_sub>
					<xsl:value-of select="../Zus__Sachtitel" />
					</title_sub>	
				</xsl:if>
			
			<xsl:if test="../Untertitel!=''">
				<title_sub>
					<xsl:value-of select="../Untertitel" />
					</title_sub>	
				</xsl:if>
			
		</xsl:template>
	
	<xsl:template match="Einzeltitel">
			<title>
				<xsl:value-of select="replace(.[1],'_','')"/>
				<xsl:if test="../Untertitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="../Untertitel" />
					</xsl:if>
				</title>
		
			<title_short>
				<xsl:value-of select="replace(.[1],'_','')"/>
				</title_short>
			
			<xsl:if test="../Untertitel!=''">
				<title_sub>
					<xsl:value-of select="../Untertitel" />
					</title_sub>	
				</xsl:if>
			
		</xsl:template>
		
	<xsl:template match="Sachtitel[1]">
	
			<title>
				<xsl:value-of select="normalize-space(replace(.,'_',''))"/>
				<xsl:if test="../Zus__Sachtitel!=''">
					<xsl:text> : </xsl:text>
					<xsl:value-of select="normalize-space(../Zus__Sachtitel)" />
					</xsl:if>
				<xsl:if test="../Untertitel!=''">
					<xsl:text> ; </xsl:text>
					<xsl:value-of select="normalize-space(../Untertitel)" />
					</xsl:if>
				</title>
			
			<title_short>
				<xsl:value-of select="replace(.,'_','')"/>
				</title_short>
			
			
			<xsl:if test="../Zus__Sachtitel!=''">
				<title_sub>
					<xsl:value-of select="normalize-space(../Zus__Sachtitel)" />
					</title_sub>	
				</xsl:if>
				
		
		
		</xsl:template>


		
</xsl:stylesheet>
