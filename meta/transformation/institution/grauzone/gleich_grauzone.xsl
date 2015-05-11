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

	<xsl:template match="grauzone">
		<xsl:element name="catalog">
			<xsl:for-each select="object">

				<xsl:if test="(objektart[text()='A(1) - Akten']) or
				(objektart[text()='BA - Bücher/Artikel']) or
				(objektart[text()='BS - Bücher/Sammeltitel']) or
				(objektart[text()='F - Fotos/DIAS']) or
				(objektart[text()='P - Plakate']) or
				(objektart[text()='V - Videos']) or
				(objektart[text()='WA- wiss. Arbeiten/Studien']) or
				(objektart[text()='Z - Zeitschriften (Heft)']) or
				(objektart[text()='Z - Zeitschriften (Artikel)']) or
				(objektart[text()='ZA- Artikel']) ">
	
	
	
	<!--Akten-->		
	<!--Akten-->	
	<!--Akten-->	
	<!--Akten-->	
	<!--Akten-->	
	<!--Akten-->	
	
						
			<xsl:if test="objektart[text()='A(1) - Akten']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Akte</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Titel" />


<!--RESPONSIBLE-->
					
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />

<!--PUBLISHING-->

			<!--display / publishDate Jahresangabe-->
					<xsl:apply-templates select="Laufzeit[string-length() != 0]" />
			
			<!--placeOfPublication Ortsangabe-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />
					
			<!--retentionPeriod-->
					<xsl:apply-templates select="Sperrfrist[string-length() != 0]" />
			
			<!--rightOfPublication-->
					<xsl:apply-templates select="Veröff.-recht[string-length() != 0]" />

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />
			
<!--CONTENTRELATED INFORMATION-->
			
				
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:apply-templates select="Enthält[string-length() != 0]" />

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
			
						
				
						</xsl:element>
						<!--closing tag dataset-->
			

			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
		
			
	<!--BS - Bücher/Sammeltitel-->		
	<!--BS - Bücher/Sammeltitel-->	
	<!--BS - Bücher/Sammeltitel-->	
	<!--BS - Bücher/Sammeltitel-->	
	<!--BS - Bücher/Sammeltitel-->	
	
						
			<xsl:if test="objektart[text()='BS - Bücher/Sammeltitel']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Buch</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Sammeltitel[string-length() != 0]">
							<xsl:apply-templates select="Sammeltitel[string-length() != 0]" />
							</xsl:when>
						<xsl:when test="Einzeltitel[string-length() != 0]">
							<xsl:apply-templates select="Einzeltitel[string-length() != 0]" />
							</xsl:when>
						</xsl:choose>
							
					<!--<xsl:apply-templates select="Einzeltitel[string-length() != 0]" />-->
					<xsl:apply-templates select="Orig.titel[string-length() != 0]" />
						

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg." />		

			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
					
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--verlag-->
					<xsl:apply-templates select="Verlage[string-length() != 0]" />	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seite[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />
			
			<!--listOfContents-->
					<xsl:if test="Einzeltitel[string-length() != 0]">
						<!--<xsl:for-each select="Inhaltsverzeichnis_x058x_[1]">-->
		
							<listOfContents>
								<xsl:value-of select="normalize-space(replace(Einzeltitel,'\\\[W9\]\\','&lt;br&gt;'))"/>
								<!--<xsl:value-of select="normalize-space(Inhaltsverzeichnis_x058x_)"/>-->
								</listOfContents>
						
					</xsl:if>

			
<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		
	<xsl:if test="s._Artikel[string-length() != 0]">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="normalize-space(objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="normalize-space(Sammeltitel)" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="normalize-space(objektnummer)"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="normalize-space(Sammeltitel)" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring(Sammeltitel,1,4))"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
			</xsl:if>

			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
	







	<!--BA - Bücher/Artikel-->		
	<!--BA - Bücher/Artikel-->	
	<!--BA - Bücher/Artikel-->	
	<!--BA - Bücher/Artikel-->	
	<!--BA - Bücher/Artikel-->	
						
			<xsl:if test="objektart[text()='BA - Bücher/Artikel']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
			
			
				<xsl:element name="vufind">
					<id><xsl:value-of select="objektnummer" /><xsl:text>grauzone</xsl:text></id>
					<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
					<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
					<recordType><xsl:text>library</xsl:text></recordType>	
					</xsl:element>
				
				<xsl:element name="institution">
					<institutionShortname><xsl:text>GrauZone</xsl:text></institutionShortname>
					<institutionFull><xsl:text>GrauZone - Archiv der ostdeutschen Frauenbewegung</xsl:text></institutionFull>
					<institutionID>grauzone</institutionID>
					<collection><xsl:text>GrauZone</xsl:text></collection>
					<isil><xsl:text>DE-B1541</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/grauzone/</xsl:text></link>
					<geoLocation>
						<latitude>52.544697</latitude>
						<longitude>13.4211377</longitude>
						</geoLocation>
					</xsl:element>			
			
				<xsl:element name="dataset">
			
			<xsl:variable name="id" select="objektnummer" />
			<xsl:variable name="connect">
			<xsl:for-each select="//s._Artikel">
				
				<xsl:if test="contains(.,$id)">
					
					<xsl:text> editor:</xsl:text>
						<xsl:value-of select="normalize-space(../Hrsg.)"></xsl:value-of>
						<xsl:text>:editor</xsl:text>
			
					<xsl:text> series:</xsl:text>
						<xsl:value-of select="normalize-space(../Reihentitel)"></xsl:value-of>
						<xsl:text>:series</xsl:text>
					
					<xsl:text> volume:</xsl:text>
						<xsl:value-of select="../Bd._Reih.Nr."></xsl:value-of>
						<xsl:text>:volume</xsl:text>
					
					<xsl:text> displayPublishDate:</xsl:text>
						<xsl:value-of select="normalize-space(../Jahr)"></xsl:value-of>
						<xsl:text>:displayPublishDate</xsl:text>
					
					<xsl:text> publishDate:</xsl:text>
						<xsl:variable name="erschienen" select="translate(../Jahr, translate(.,'0123456789', ''), '')"/>
						<xsl:for-each select="document('../../anreicherung/year.xml')/root/child/year">
						<xsl:if test="contains($erschienen,.)">
							<xsl:value-of select="." />
							</xsl:if>
							</xsl:for-each>
						<xsl:text>:publishDate</xsl:text>
					
					<xsl:text> ausgabe:</xsl:text>
						<xsl:value-of select="normalize-space(../Auflage)"></xsl:value-of>
						<xsl:text>:ausgabe</xsl:text>	
					
					<xsl:text> placeOfPublication:</xsl:text>
						<xsl:value-of select="normalize-space(../Orte)"></xsl:value-of>
						<xsl:text>:placeOfPublication</xsl:text>	
					
					<xsl:text> publisher:</xsl:text>
						<xsl:value-of select="normalize-space(../Verlage)"></xsl:value-of>
						<xsl:text>:publisher</xsl:text>
					
					<xsl:text> sourceInfo:</xsl:text>
						<xsl:value-of select="normalize-space(replace(Sammeltitel,'_',''))" />
						<xsl:text>:sourceInfo</xsl:text>
					
					<xsl:text> shelfMark:</xsl:text>
						<xsl:value-of select="../Signatur"></xsl:value-of>
						<xsl:text>:shelfMark</xsl:text>
					
					</xsl:if>
					</xsl:for-each>
				</xsl:variable>
			<!--<test>
				<xsl:value-of select="$connect"></xsl:value-of>
			</test>-->
			
			
			
<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Artikel</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Artikel[string-length() != 0]" />
						

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn" />	
			
			<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<xsl:if test="(not(contains(.,'o. A.'))) and not(contains(.,'u.a.'))">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:if>
						</xsl:for-each>
					</xsl:if>
					
			<!--series Reiheninformation-->					
				<xsl:if test="substring(substring-after($connect,'series:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'series:'),':series'), ';')">
					<series>
						<xsl:value-of select="normalize-space(.)" />
						</series>
						</xsl:for-each>
					</xsl:if>
					
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:if test="substring(substring-after($connect,'displayPublishDate:'),1,1)!=':'">
					<displayPublishDate>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'displayPublishDate:'),':displayPublishDate'))" />
						</displayPublishDate>
						</xsl:if>	
					
					<xsl:if test="substring(substring-after($connect,'publishDate:'),1,1)!=':'">
					<publishDate>
						<xsl:value-of select="substring-before(substring-after($connect,'publishDate:'),':publishDate')" />
						</publishDate>
						</xsl:if>
			
			<!--ort-->
					<xsl:if test="substring(substring-after($connect,'placeOfPublication:'),1,1)!=':'">
					<placeOfPublication>
						<xsl:value-of select="substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication')" />
						</placeOfPublication>
					</xsl:if>	
				
			<!--verlag-->
					<xsl:if test="substring(substring-after($connect,'publisher:'),1,1)!=':'">
					<publisher>
						<xsl:value-of select="substring-before(substring-after($connect,'publisher:'),':publisher')" />
						</publisher>
					</xsl:if>	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		
		<xsl:variable name="objektnummer" select="objektnummer" />	
		<xsl:variable name="title" select="Artikel" />	
	
	<xsl:for-each select="//s._Artikel[contains(.,$objektnummer)]">
		<xsl:variable name="id" select="objektnummer" />
		
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="normalize-space(../Sammeltitel)" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="normalize-space(../Sammeltitel)" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="normalize-space($objektnummer)"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="normalize-space($title)" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring($title,1,4))"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
			</xsl:for-each>
			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->







	<!--F - Fotos/DIAS-->	
	<!--F - Fotos/DIAS-->	
	<!--F - Fotos/DIAS-->	
	<!--F - Fotos/DIAS-->	
	<!--F - Fotos/DIAS-->	
	<!--F - Fotos/DIAS-->	
	
						
			<xsl:if test="objektart[text()='F - Fotos/DIAS']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Fotografie</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Anlass_Ereignis[string-length() != 0]" />		
					
					<xsl:if test="(Anlass_Ereignis[string-length() = 0]) and (Beschreibung[string-length() != 0])">
						<title>
							<xsl:value-of select="normalize-space(Beschreibung)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(Beschreibung)" />							
							</title_short>
						</xsl:if>
					

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg." />		
			
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />	
				
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--verlag-->
					<xsl:apply-templates select="Verlage[string-length() != 0]" />	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />
					
			<!--dimension-->
					<xsl:apply-templates select="Format[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
					
			<!--subjectGeographic-->
					<xsl:apply-templates select="Land[string-length() != 0]" />
				
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		


			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
	





	<!--P - Plakate-->	
	<!--P - Plakate-->	
	<!--P - Plakate-->	
	<!--P - Plakate-->	
	<!--P - Plakate-->	
	<!--P - Plakate-->	
	
						
			<xsl:if test="objektart[text()='P - Plakate']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Fotografie</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:apply-templates select="Titel[string-length() != 0]" />		
					

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn[string-length() != 0]" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg.[string-length() != 0]" />		
			
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />	
				
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--verlag-->
					<xsl:apply-templates select="Verlage[string-length() != 0]" />	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />
					
			<!--dimension-->
					<xsl:apply-templates select="Format[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
					
			<!--subjectGeographic-->
					<xsl:apply-templates select="Land[string-length() != 0]" />
				
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		


			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->
	






	<!--V - Videos-->
	<!--V - Videos-->	
	<!--V - Videos-->	
	<!--V - Videos-->	
	<!--V - Videos-->	
	<!--V - Videos-->	
		
	
						
			<xsl:if test="objektart[text()='V - Videos']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Film</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
				<xsl:choose>
					<xsl:when test="contains(Titel,':')">
						<title>
							<xsl:value-of select="normalize-space(replace(Titel,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(replace(Titel,'\\\[W9\]\\',''),':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(replace(Titel,'\\\[W9\]\\',''),':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(replace(Titel,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(replace(Titel,'\\\[W9\]\\',''))" />
							</title_short>
						<xsl:if test="Anlass_Ereignis[string-length() != 0]">
							<title_sub>
								<xsl:value-of select="normalize-space(Anlass_Ereignis)" />
								</title_sub>
							</xsl:if>
						
						</xsl:otherwise>
					</xsl:choose>
					

					<!--<xsl:apply-templates select="Titel[string-length() != 0]" />	-->	
					

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn[string-length() != 0]" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg.[string-length() != 0]" />		
			
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />	
				
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--verlag-->
					<xsl:apply-templates select="Verlage[string-length() != 0]" />	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />
					
			<!--dimension-->
					<xsl:apply-templates select="Format[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
					
			<!--subjectGeographic-->
					<xsl:apply-templates select="Land[string-length() != 0]" />
				
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		


			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->




	
	<!--WA- wiss. Arbeiten/Studien-->
	<!--WA- wiss. Arbeiten/Studien-->	
	<!--WA- wiss. Arbeiten/Studien-->	
	<!--WA- wiss. Arbeiten/Studien-->	
	<!--WA- wiss. Arbeiten/Studien-->	
	<!--WA- wiss. Arbeiten/Studien-->	
	<!--WA- wiss. Arbeiten/Studien-->	
		
	
						
			<xsl:if test="objektart[text()='WA- wiss. Arbeiten/Studien']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
					
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Hochschulschrift</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Sammeltitel[string-length() != 0]">
							<xsl:apply-templates select="Sammeltitel[string-length() != 0]" />	
							</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="Einzeltitel[string-length() != 0]" />	
							</xsl:otherwise>
						</xsl:choose>
					
					

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn[string-length() != 0]" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg.[string-length() != 0]" />		
			
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />	
				
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:apply-templates select="Orte[string-length() != 0]" />	
				
			<!--verlag-->
					<xsl:apply-templates select="Verlage[string-length() != 0]" />	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />
					
			<!--dimension-->
					<xsl:apply-templates select="Format[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
					
			<!--subjectGeographic-->
					<xsl:apply-templates select="Land[string-length() != 0]" />
				
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		


			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->







	<!--Z - Zeitschriften (Heft)-->
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->	
	<!--Z - Zeitschriften (Heft)-->		
		
	
						
			<xsl:if test="objektart[text()='Z - Zeitschriften (Heft)']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
			
			<xsl:variable name="connect">
				<xsl:variable name="rel" select="normalize-space(translate(s._ST[1], translate(.,'-0123456789', ''), ''))"/>
				
					<xsl:for-each select="//object[objektnummer=$rel]">
			
						<xsl:text> title:</xsl:text>
							<xsl:value-of select="normalize-space(replace(Sachtitel,'\\\[W2\]\\',''))" />
							<xsl:text>:title</xsl:text>
						
						<xsl:text> title_sub:</xsl:text>
							<xsl:value-of select="normalize-space(Untertitel)"></xsl:value-of>
							<xsl:text>:title_sub</xsl:text>
						
						<xsl:text> hrsg:</xsl:text>
							<xsl:value-of select="normalize-space(Hrsg.)"></xsl:value-of>
							<xsl:text>:hrsg</xsl:text>
						
						<xsl:text> placeOfPublication:</xsl:text>
							<xsl:value-of select="Ersch.-ort"></xsl:value-of>
							<xsl:text>:placeOfPublication</xsl:text>
						
						<xsl:text> publisher:</xsl:text>
							<xsl:if test="not(contains(Verlage,'o.A.'))"></xsl:if>
							<xsl:value-of select="Verlage"></xsl:value-of>
							<xsl:text>:publisher</xsl:text>
						
						</xsl:for-each>
			</xsl:variable>
				
			<xsl:apply-templates select="Erf.-stelle" />
			
			<!--vufind und institutionsblock werden hier eingefügt-->			
			
				<xsl:element name="dataset">

<!--FORMAT-->
			
			
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Zeitschrift</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Hefttitel[string-length() != 0]">
							<xsl:apply-templates select="Hefttitel" />
							</xsl:when>
						<xsl:when test="($connect[string-length() != 0]) and (substring(substring-after($connect,'title:'),1,1)!=':')">
							<title>
								<xsl:value-of select="substring-before(substring-after($connect,'title:'),':title')" />
								</title>
							<title_short>
								<xsl:value-of select="substring-before(substring-after($connect,'title:'),':title')" />
								</title_short>
							<xsl:if test="substring(substring-after($connect,'title_sub:'),1,1)!=':'">
								<title_sub>
									<xsl:value-of select="substring-before(substring-after($connect,'title_sub:'),':title_sub')" />
									</title_sub>
								</xsl:if>					
							</xsl:when>
						<xsl:otherwise>
								<title>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title>
								<title_short>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title_short>
								<xsl:if test="Beschreibung[string-length() != 0]">
									<title_sub>
										<xsl:value-of select="normalize-space(substring(Beschreibung,1,150))" />
										<xsl:text> [...]</xsl:text>
										</title_sub>
									</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					
					

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn[string-length() != 0]" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg.[string-length() != 0]" />		
			
			<!--entity-->
					<xsl:apply-templates select="Organisationen[string-length() != 0]" />
			
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
			
			<!--edition Ausgabe-->
					<xsl:apply-templates select="Auflage[string-length() != 0]" />	
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />	
				
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="Jahr[string-length() != 0]" />	
			
			<!--ort-->
					<xsl:if test="($connect[string-length() != 0]) and (substring(substring-after($connect,'placeOfPublication:'),1,1)!=':')">
					<placeOfPublication>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'placeOfPublication:'),':placeOfPublication'))" />
						</placeOfPublication>
					</xsl:if>	
				
			<!--verlag-->
					<xsl:if test="($connect[string-length() != 0]) and (substring(substring-after($connect,'publisher:'),1,1)!=':')">
					<publisher>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'publisher:'),':publisher'))" />
						</publisher>
					</xsl:if>	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seitenzahlen[string-length() != 0]" />
					
			<!--dimension-->
					<xsl:apply-templates select="Format[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
					
			<!--subjectGeographic-->
					<xsl:apply-templates select="Land[string-length() != 0]" />
				
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--issue-->
					<xsl:apply-templates select="Heft[string-length() != 0]" />	

			<!--volume-->
					<xsl:apply-templates select="Bd._Reih.Nr.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:apply-templates select="Signatur[string-length() != 0]" />
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		


			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->








	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	<!--Z - Zeitschriften (Artikel)-->
	
		
						
			<xsl:if test="objektart[text()='Z - Zeitschriften (Artikel)']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
			
			
				<xsl:element name="vufind">
					<id><xsl:value-of select="objektnummer" /><xsl:text>grauzone</xsl:text></id>
					<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
					<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
					<recordType><xsl:text>library</xsl:text></recordType>	
					</xsl:element>
				
				<xsl:element name="institution">
					<institutionShortname><xsl:text>GrauZone</xsl:text></institutionShortname>
					<institutionFull><xsl:text>GrauZone - Archiv der ostdeutschen Frauenbewegung</xsl:text></institutionFull>
					<institutionID>grauzone</institutionID>
					<collection><xsl:text>GrauZone</xsl:text></collection>
					<isil><xsl:text>DE-B1541</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/grauzone/</xsl:text></link>
					<geoLocation>
						<latitude>52.544697</latitude>
						<longitude>13.4211377</longitude>
						</geoLocation>
					</xsl:element>			
			
				<xsl:element name="dataset">
			
			<xsl:variable name="id" select="objektnummer" />
			<xsl:variable name="connect">
			<xsl:for-each select="//s._ET">
				
				<xsl:if test="contains(.,$id)">
					
					<xsl:text> shelfMark:</xsl:text>
						<xsl:value-of select="../Signatur"></xsl:value-of>
						<xsl:text>:shelfMark</xsl:text>
					
					<xsl:text> sourceInfo:</xsl:text>
						<xsl:value-of select="../Hefttitel"></xsl:value-of>
						<xsl:text>:sourceInfo</xsl:text>
					
					</xsl:if>
					</xsl:for-each>
				</xsl:variable>
			
<!--FORMAT-->
				
			<!--<test>
				<xsl:value-of select="$connect"></xsl:value-of>
				<xsl:value-of select="$id"></xsl:value-of>
				</test>	-->
			
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Artikel</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Einzeltitel[string-length() != 0]">
							<xsl:apply-templates select="Einzeltitel" />
							</xsl:when>
						<xsl:when test="($connect[string-length() != 0]) and (substring(substring-after($connect,'sourceInfo:'),1,1)!=':')">
							<title>
								<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
								</title>
							<title_short>
								<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
								</title_short>			
							</xsl:when>
						<xsl:otherwise>
								<title>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title>
								<title_short>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title_short>
								<xsl:if test="Beschreibung[string-length() != 0]">
									<title_sub>
										<xsl:value-of select="normalize-space(substring(Beschreibung,1,150))" />
										<xsl:text> [...]</xsl:text>
										</title_sub>
										</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn" />	
			
			<!--editor Herausgeberinneninformationen-->
				<xsl:if test="substring(substring-after($connect,'editor:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'editor:'),':editor'), ';')">
					<xsl:if test="(not(contains(.,'o. A.'))) and not(contains(.,'u.a.'))">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
						</xsl:if>
						</xsl:for-each>
					</xsl:if>
					
			<!--series Reiheninformation-->					
				<xsl:if test="substring(substring-after($connect,'series:'),1,1)!=':'">
					<xsl:for-each select="tokenize(substring-before(substring-after($connect,'series:'),':series'), ';')">
					<series>
						<xsl:value-of select="normalize-space(.)" />
						</series>
						</xsl:for-each>
					</xsl:if>
					
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:apply-templates select="J.[string-length() != 0]" />
			
			<!--sourceInfo-->
					<xsl:if test="($connect[string-length() != 0]) and (substring(substring-after($connect,'sourceInfo:'),1,1)!=':')">
					<sourceInfo>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo'))" />
						</sourceInfo>
					</xsl:if>	

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Umfang[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:apply-templates select="Beschreibung[string-length() != 0]" />

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--issue-->
					<xsl:apply-templates select="H.[string-length() != 0]" />	
			<!--volume-->
					<xsl:apply-templates select="Jg.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:if test="($connect[string-length() != 0]) and (substring(substring-after($connect,'shelfMark:'),1,1)!=':')">
					<shelfMark>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'shelfMark:'),':shelfMark'))" />
						</shelfMark>
					</xsl:if>	
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		
		<xsl:variable name="objektnummer" select="objektnummer" />	
		<xsl:variable name="title" select="Artikel" />	
	
	<xsl:for-each select="//s._ET[contains(.,$objektnummer)]">
		<xsl:variable name="id" select="objektnummer" />
		
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="normalize-space(../Hefttitel)" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="normalize-space(../Hefttitel)" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="normalize-space($objektnummer)"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="Einzeltitel[string-length() != 0]">
							<xsl:apply-templates select="Einzeltitel" />
							</xsl:when>
						<xsl:otherwise>
							<xsl:text>Ohne Titelangabe</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring($title,1,4))"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
			</xsl:for-each>
			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->










	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	<!--ZA- Artikel-->
	
		
						
			<xsl:if test="objektart[text()='ZA- Artikel']">
			
			<xsl:element name="record">
				<xsl:attribute name="id"><xsl:value-of select="objektnummer" /></xsl:attribute>
			
			
				<xsl:element name="vufind">
					<id><xsl:value-of select="objektnummer" /><xsl:text>grauzone</xsl:text></id>
					<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
					<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
					<recordType><xsl:text>library</xsl:text></recordType>	
					</xsl:element>
				
				<xsl:element name="institution">
					<institutionShortname><xsl:text>GrauZone</xsl:text></institutionShortname>
					<institutionFull><xsl:text>GrauZone - Archiv der ostdeutschen Frauenbewegung</xsl:text></institutionFull>
					<institutionID>grauzone</institutionID>
					<collection><xsl:text>GrauZone</xsl:text></collection>
					<isil><xsl:text>DE-B1541</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/grauzone/</xsl:text></link>
					<geoLocation>
						<latitude>52.544697</latitude>
						<longitude>13.4211377</longitude>
						</geoLocation>
					</xsl:element>			
			
				<xsl:element name="dataset">
			
			<xsl:variable name="id" select="objektnummer" />
			<xsl:variable name="connect">
			<xsl:for-each select="//s._ET">
				
				<xsl:if test="contains(.,$id)">
					
					<xsl:text> shelfMark:</xsl:text>
						<xsl:value-of select="../Signatur"></xsl:value-of>
						<xsl:text>:shelfMark</xsl:text>
					
					<xsl:text> sourceInfo:</xsl:text>
						<xsl:value-of select="../Hefttitel"></xsl:value-of>
						<xsl:text>:sourceInfo</xsl:text>
					
					</xsl:if>
					</xsl:for-each>
				</xsl:variable>
			
<!--FORMAT-->
				
			<!--<test>
				<xsl:value-of select="$connect"></xsl:value-of>
				<xsl:value-of select="$id"></xsl:value-of>
				</test>	-->
			
				
			<!--typeOfRessource-->
					<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			
			<!--format Objektartinformationen-->
					<format><xsl:text>Artikel</xsl:text></format>

<!--TITLE-->
	
			<!--title Titelinformationen-->	
					
			<!--title Titelinformationen-->	
					<xsl:choose>
						<xsl:when test="Einzeltitel[string-length() != 0]">
							<xsl:apply-templates select="Einzeltitel[1]" />
							</xsl:when>
						<xsl:when test="($connect[string-length() != 0]) and (substring(substring-after($connect,'sourceInfo:'),1,1)!=':')">
							<title>
								<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
								</title>
							<title_short>
								<xsl:value-of select="substring-before(substring-after($connect,'sourceInfo:'),':sourceInfo')" />
								</title_short>			
							</xsl:when>
						<xsl:otherwise>
								<title>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title>
								<title_short>
									<xsl:text>Ohne Titelangabe</xsl:text>
									</title_short>
								<xsl:if test="Beschreibung[string-length() != 0]">
									<title_sub>
										<xsl:value-of select="normalize-space(substring(Beschreibung,1,150))" />
										<xsl:text> [...]</xsl:text>
										</title_sub>
										</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						

<!--RESPONSIBLE-->

			<!--author-->
					<xsl:apply-templates select="UrheberIn[string-length() != 0]" />	
			
			<!--hrsg-->
					<xsl:apply-templates select="Hrsg.[string-length() != 0]" />	
					
			<!--series-->
					<xsl:apply-templates select="Reihentitel[string-length() != 0]" />	
					
<!--PUBLISHING-->
			<!--jahr-->
					<xsl:choose>
						<xsl:when test="Ersch-dat.[string-length() != 0]">
							<displayPublishDate>
								<xsl:value-of select="normalize-space(Ersch-dat.)" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(translate(Ersch-dat., translate(.,'-0123456789', ''), ''))" />
								</publishDate>
							</xsl:when>
						<xsl:when test="Veranst.-dat.[string-length() != 0]">
							<displayPublishDate>
								<xsl:value-of select="normalize-space(Veranst.-dat.)" />
								</displayPublishDate>
							<publishDate>
								<xsl:value-of select="normalize-space(translate(Veranst.-dat., translate(.,'-0123456789', ''), ''))" />
								</publishDate>
							</xsl:when>
						</xsl:choose>
					
					<xsl:apply-templates select="J.[string-length() != 0]" />
			
			<!--ort-->
					<xsl:choose>
						<xsl:when test="Orte[string-length() != 0]">
							<placeOfPublication>
								<xsl:value-of select="normalize-space(Orte)" />
								</placeOfPublication>
							</xsl:when>
						<xsl:when test="Veranst.-ort[string-length() != 0]">
							<placeOfPublication>
								<xsl:for-each select="Veranst.-ort">
									<xsl:value-of select="normalize-space(.)" />	
									</xsl:for-each>
								</placeOfPublication>
							</xsl:when>
						</xsl:choose>	
				
			
			<!--provinienz-->
					<xsl:apply-templates select="Provenienz[string-length() != 0]" />
			
			<!--sourceInfo-->
					<xsl:if test="Z-titel[string-length() != 0]">	
						<sourceInfo>
							<xsl:value-of select="normalize-space(Z-titel)" />
							</sourceInfo>
						</xsl:if>
					
					

<!--PHYSICAL INFORMATION-->
		
			<!--physical Seitenangabe-->
					<xsl:apply-templates select="Seite[string-length() != 0]" />

<!--CONTENTRELATED INFORMATION-->
			
			<!--subjectTopic Deskriptoren-->
					<xsl:apply-templates select="Deskriptor[string-length() != 0]" />
			
			<!--subjectPerson-->
					<xsl:apply-templates select="Personen[string-length() != 0]" />
			
			<!--description-->
					<xsl:if test="(Anlass_Ereignis[string-length() != 0]) or (Beschreibung[string-length() != 0])">
						<description>
						<xsl:if test="Anlass_Ereignis[string-length() != 0]">
							<xsl:value-of select="normalize-space(Anlass_Ereignis)" />
							<xsl:text> - </xsl:text>
							</xsl:if>
						<xsl:if test="Beschreibung[string-length() != 0]">
							<!--<xsl:value-of select="normalize-space(Beschreibung)" />-->
							<xsl:value-of select="normalize-space(replace(Beschreibung,'\\\[W9\]\\',' '))"/>
							</xsl:if>
						</description>
						</xsl:if>
						
						

<!--DETAILS FOR JOURNAL RELATED CONTENT-->

			<!--issue-->
					<xsl:apply-templates select="H.[string-length() != 0]" />	
			<!--volume-->
					<xsl:apply-templates select="Jg.[string-length() != 0]" />	
					

<!--OTHER-->

			<!--shelfMark Signatur-->
					<xsl:if test="($connect[string-length() != 0]) and (substring(substring-after($connect,'shelfMark:'),1,1)!=':')">
					<shelfMark>
						<xsl:value-of select="normalize-space(substring-before(substring-after($connect,'shelfMark:'),':shelfMark'))" />
						</shelfMark>
					</xsl:if>	
	
	
	
						</xsl:element>
						<!--closing tag dataset-->
		
		<xsl:variable name="objektnummer" select="objektnummer" />	
		<xsl:variable name="title" select="Artikel" />	
	
	<xsl:for-each select="//s._ET[contains(.,$objektnummer)]">
		<xsl:variable name="id" select="objektnummer" />
		
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="normalize-space(../Hefttitel)" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="normalize-space(../objektnummer)"/><xsl:text>grauzone</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="normalize-space(../Hefttitel)" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="normalize-space($objektnummer)"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:choose>
						<xsl:when test="Einzeltitel[string-length() != 0]">
							<xsl:apply-templates select="Einzeltitel" />
							</xsl:when>
						<xsl:otherwise>
							<xsl:text>Ohne Titelangabe</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="normalize-space(substring($title,1,4))"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
			</xsl:for-each>
			
				
					</xsl:element><!--closing tag record-->
				</xsl:if><!--closing tag if in dataset-->





	
	</xsl:if>
			
				</xsl:for-each><!--closing tag for-each Schleife datansatz-->

















			
	</xsl:element>
	</xsl:template>










<!--Templates-->	
			
			<!--<xsl:template match="Orte">
				<placeOfPublication>
					<xsl:value-of select="normalize-space(.)" />
					</placeOfPublication>
				</xsl:template>-->
			
			<xsl:template match="Beschreibung">
				<description>
					<xsl:if test="../Veranst.-dat.[string-length() != 0]">
						<xsl:value-of select="normalize-space(../Veranst.-dat.)" />
						<xsl:text> - </xsl:text>
						</xsl:if>
					<xsl:value-of select="normalize-space(replace(replace(.,'\\\[W8\]\\',''),'\\\[W9\]\\',''))" />
					</description>
				</xsl:template>
			
			<xsl:template match="Verlage">
				<publisher>
					<xsl:value-of select="normalize-space(replace(replace(.,'\\\[W8\]\\',''),'\\\[W9\]\\',''))" />
					</publisher>
				</xsl:template>
			
			<xsl:template match="Auflage">
				<edition>
					<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
					</edition>
				</xsl:template>
			
			<xsl:template match="Heft">
				<xsl:choose>
					<xsl:when test="../objektart[text()='Z - Zeitschriften (Heft)']">
						<xsl:if test="contains(.,'(')">
						<xsl:if test="matches(substring(substring-after(.,')'),1,2),'[0-9]')">
						<issue>
							<xsl:value-of select="normalize-space(substring(substring-after(.,')'),1,2))" />
							</issue>
							</xsl:if>
						<displayPublishDate>
							<xsl:value-of select="substring-before(substring-after(.,'('),')')"></xsl:value-of>
							</displayPublishDate>
						<publishDate>
							<xsl:value-of select="substring-before(substring-after(.,'('),')')"></xsl:value-of>
							</publishDate>
						</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="H.">
				<issue>
					<xsl:value-of select="normalize-space(.)" />
					</issue>
				</xsl:template>
			
			<xsl:template match="Jg.">
				<volume>
					<xsl:value-of select="normalize-space(.)" />
					</volume>
				</xsl:template>
			
			<xsl:template match="Bd._Reih.Nr.">
				<volume>
					<xsl:value-of select="normalize-space(.)" />
					</volume>
				</xsl:template>
			
			<xsl:template match="Reihentitel">
				<series>
					<xsl:value-of select="normalize-space(.)" />
					</series>
				</xsl:template>
			
			<xsl:template match="Jahr">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(.)" />
					</displayPublishDate>
				
				<!--<xsl:if test="matches(.,'[0-9]')">-->
				<xsl:variable name="erschienen" select="translate(., translate(.,'0123456789', ''), '')"/>
				<xsl:for-each select="document('../../anreicherung/year.xml')/root/child/year">
					<xsl:if test="contains($erschienen,.)">
						
						<publishDate>
							<xsl:value-of select="." />
							</publishDate>	
					</xsl:if>
				</xsl:for-each>
				<!--</xsl:if>-->
				</xsl:template>
				
			<xsl:template match="J.">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(.)" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(.)" />
						</publishDate>	
				</xsl:template>
			
			<xsl:template match="UrheberIn">
				<xsl:for-each select="tokenize(.,';')">
					<xsl:if test="not(contains(.,'u.a'))">
					<author>
						<xsl:value-of select="normalize-space(.)" />
						</author>
						</xsl:if>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Hrsg.">
				<xsl:for-each select="tokenize(.,';')">
					<editor>
						<xsl:value-of select="normalize-space(.)" />
						</editor>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Land">
				<xsl:for-each select="tokenize(.,';')">
					<subjectGeographic>
						<xsl:value-of select="normalize-space(.)" />
						</subjectGeographic>
					</xsl:for-each>
				</xsl:template>
		
			
			<xsl:template match="Deskriptor">
				<xsl:for-each select="tokenize(.,';')">
					<xsl:for-each select="tokenize(.,',')">
					<subjectTopic>
						<xsl:value-of select="normalize-space(.)" />
						</subjectTopic>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Organisationen">
				<xsl:for-each select="tokenize(.,';')">
					<entity>
						<xsl:value-of select="normalize-space(.)" />
						</entity>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Personen">
				<xsl:for-each select="tokenize(.,';')">
					<subjectPerson>
						<xsl:value-of select="normalize-space(.)" />
						</subjectPerson>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Orte">
				<xsl:for-each select="tokenize(.,';')">
					<placeOfPublication>
						<xsl:value-of select="normalize-space(.)" />
						</placeOfPublication>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Format">
					<dimension>
						<xsl:value-of select="normalize-space(.)" />
						</dimension>
				</xsl:template>
			
			<xsl:template match="Seite">
				<xsl:choose>
					<xsl:when test="../objektart[text()='ZA- Artikel']">
						<physical>
							<xsl:value-of select="normalize-space(.)" />
							</physical>
						</xsl:when>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Seitenzahlen">
				<xsl:choose>
					<xsl:when test="../objektart[text()='Z - Zeitschriften (Heft)']">
						<physical>
							<xsl:value-of select="normalize-space(.)" />
							</physical>
						</xsl:when>
					
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Umfang">
				<xsl:choose>
					<xsl:when test="../objektart[text()='A(1) - Akten']">
						<physical>
							<xsl:value-of select="normalize-space(.)" />
							</physical>
						</xsl:when>
					<xsl:when test="../objektart[text()='V - Videos']">
						<runTime>
							<xsl:value-of select="normalize-space(.)" />
							</runTime>
						</xsl:when>
					<xsl:otherwise>
						<physical>
							<xsl:value-of select="normalize-space(translate(., translate(.,'-0123456789', ''), ''))" />
							</physical>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Veröff.-recht">
				<rightOfPublication>
					<xsl:value-of select="normalize-space(.)" />
					</rightOfPublication>
				</xsl:template>
			
			<xsl:template match="Sperrfrist">
				<retentionPeriod>
					<xsl:value-of select="normalize-space(.)" />
					</retentionPeriod>
				</xsl:template>
			
			<xsl:template match="Laufzeit">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(.)" />
					</displayPublishDate>
				<xsl:for-each select="tokenize(.,';')">
					<xsl:for-each select="tokenize(.,'-')">
						<publishDate>
							<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
							</publishDate>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:template>
			
			<xsl:template match="Enthält">
				<description>
					<xsl:value-of select="normalize-space(replace(replace(.,'\\\[W2\]\\',''),'\\\[W9\]\\',''))" />
					<!--<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />-->
					</description>
				</xsl:template>
				
			<xsl:template match="Orig.titel">
				<alternativeTitle>
					<xsl:value-of select="normalize-space(.)" />
					</alternativeTitle>
				</xsl:template>
				
			<xsl:template match="Anlass_Ereignis">
					<title>
						<xsl:value-of select="normalize-space(.)" />
						</title>
					<title_short>
						<xsl:value-of select="normalize-space(.)" />
						</title_short>
					<!--<xsl:if test="../Beschreibung[string-length() != 0]">
						<title_sub>
							<xsl:value-of select="normalize-space(../Beschreibung)" />
							</title_sub>
						</xsl:if>	-->					
				</xsl:template>
				
			<xsl:template match="Einzeltitel">
				<xsl:choose>
					<xsl:when test="contains(.,':')">
						<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(.,':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(.,':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(.)" />
							</title_short>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Artikel">
				<xsl:choose>
					<xsl:when test="contains(.,':')">
						<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(.,':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(.,':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(.)" />
							</title_short>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Hefttitel">
				<xsl:choose>
					<xsl:when test="contains(.,':')">
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							<!--<xsl:value-of select="normalize-space(replace(.,'$w9',''))" />-->
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title_short>
						<!--<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(.)" />
							</title_short>-->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Sammeltitel">
				<xsl:choose>
					<xsl:when test="contains(.,':')">
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							<!--<xsl:value-of select="normalize-space(replace(.,'$w9',''))" />-->
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title_short>
						<!--<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(.)" />
							</title_short>-->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Titel">
				<xsl:choose>
					<xsl:when test="../objektart[text()='A(1) - Akten']">
						<title>
							<xsl:value-of select="normalize-space(.)" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(.)" />
							</title_short>
						</xsl:when>
					<xsl:when test="contains(.,':')">
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(substring-before(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_short>
						<title_sub>
							<xsl:value-of select="normalize-space(substring-after(replace(.,'\\\[W9\]\\',''),':'))" />
							</title_sub>
						</xsl:when>
					<xsl:otherwise>
						<title>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title>
						<title_short>
							<xsl:value-of select="normalize-space(replace(.,'\\\[W9\]\\',''))" />
							</title_short>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:template>
			
			<xsl:template match="Signatur">
				<shelfMark>
					<xsl:value-of select="normalize-space(.)" />
					</shelfMark>
				</xsl:template>
			
			<xsl:template match="Provenienz">
				<provenance>
					<xsl:value-of select="normalize-space(.)" />
					</provenance>
				</xsl:template>

			<xsl:template match="Erf.-stelle">
				<xsl:variable name="id" select="../objektnummer" />
				<xsl:element name="vufind">
					<!--Identifikator-->
						<id>
							<xsl:value-of select="$id" />
							<xsl:text>grauzone</xsl:text>
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
							<xsl:when test="../objektart[text()='A(1) - Akten']">
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
					</xsl:element>
				
				<xsl:element name="institution">
					<!--institutionShortname-->			
						<institutionShortname>
							<xsl:text>GrauZone</xsl:text>
							</institutionShortname>
					<!--institutionFullname-->
						<institutionFull>
							<xsl:text>GrauZone - Archiv der ostdeutschen Frauenbewegung</xsl:text>
							</institutionFull>
						
						<institutionID>grauzone</institutionID>
					
					<!--collection-->
						<collection><xsl:text>GrauZone</xsl:text></collection>
					<!--isil-->
						<isil><xsl:text>DE-B1541</xsl:text></isil>
					<!--linkToWebpage-->
						<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/grauzone/</xsl:text></link>
					<!--geoLocation-->
						<geoLocation>
							<latitude>52.544697</latitude>
							<longitude>13.4211377</longitude>
							</geoLocation>
						</xsl:element>
				</xsl:template>


</xsl:stylesheet>
