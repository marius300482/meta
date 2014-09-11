<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="bibliographie">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="FAUST-Objekt">
	<xsl:variable name="s_sachtitel" select="translate(s__Sachtitel[1], translate(.,'0123456789', ''), '')"/>

		<xsl:variable name="id" select="ID"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>paulabiblio</xsl:text>
					</xsl:attribute>
				
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->

		<xsl:variable name="s_sachtitel" select="translate(s__Sachtitel[1], translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="z-ausgabe" select="Ausgabe"/>
		<xsl:variable name="currentDate" select="current-date()"/>
				
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="ID"/>
					<xsl:text>paulabiblio</xsl:text>
					</id>

	<!--recordCreationDate-->
				<xsl:choose>
					<xsl:when test="erfasst_am- !=''">
						<recordCreationDate>
							<xsl:value-of select="substring(erfasst_am-[1],7,4)"/><!--jahr-->
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],4,2)"/><!--monat-->
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],1,2)"/><!--tag-->
							<xsl:text>T</xsl:text>
							<xsl:text>00:00:00Z</xsl:text>
							</recordCreationDate>
						</xsl:when>
					<xsl:otherwise>
						<recordCreationDate>
							<!--<xsl:value-of select="format-date($currentDate, '[Y01][M01][D01]')"/>-->
							<xsl:value-of select="current-dateTime()"/>
							<xsl:text>T</xsl:text>
							<xsl:text>00:00:00Z</xsl:text>
							</recordCreationDate>
						</xsl:otherwise>
					</xsl:choose>
					
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
							<xsl:text>Genderbibliothek</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionsFullname>
							<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
							</institutionsFullname>
			
<!--collection-->				<collection><xsl:text>Paula Bibliografie</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-B1542</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>52.520326</latitude>
							<longitude>13.394218799999976</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
<xsl:element name="dataset">

<!--typeOfRessource-->
				<typeOfRessource>
						<xsl:text>text</xsl:text>
					</typeOfRessource>

<!--title Titelinformationen-->
				<xsl:if test="Einzeltitel[1]">
					<xsl:apply-templates select="Einzeltitel[1]"/>
					</xsl:if>

				<xsl:if test="(Sammeltitel[1]) and (not(Einzeltitel))">
					<xsl:apply-templates select="Sammeltitel[1]"/>
					</xsl:if>

<!--author Autorinneninformation-->
				<xsl:if test="UrheberIn[1]">
					<xsl:apply-templates select="UrheberIn[1]"/>
					</xsl:if>
					
<!--author Autorinneninformation-->
				<xsl:if test="HerausgeberIn[1]">
					<xsl:apply-templates select="HerausgeberIn[1]"/>
					</xsl:if>

<!--series Reiheninformation-->
				<xsl:if test="Reihentitel">
					<series>
						<xsl:value-of select="Reihentitel"/>
						 </series>
						</xsl:if>
<!--format-->
				<xsl:choose>
					<xsl:when test="ISSN">
						<format>Zeitschriftenheft</format>
						</xsl:when>
					<xsl:when test="Einzeltitel">
						<format>Artikel</format>
						</xsl:when>
					<xsl:otherwise>
						<format>Monographie</format>
						</xsl:otherwise>
					</xsl:choose>

<!--ISBN / ISSN-->
				<xsl:variable name="isbn" select="normalize-space(substring-after(Verweis[1],'ISBN:'))" />
				<xsl:choose>
					<xsl:when test="ISSN">
						<issn><xsl:value-of select="normalize-space(ISSN)"/></issn>
						</xsl:when>
					<xsl:when test="ISBN">
						<isbn><xsl:value-of select="normalize-space(ISBN)"/></isbn>
						</xsl:when>
					<xsl:when test="(contains(Verweis[1], 'ISBN:')) and (not(contains(Verweis[1],';')))">
						<isbn><xsl:value-of select="normalize-space($isbn)"/></isbn>
						</xsl:when>
					<xsl:when test="(contains(Verweis[1], 'ISBN:')) and (contains(Verweis[1],';'))">
						<isbn><xsl:value-of select="normalize-space(substring-before($isbn,';'))"/></isbn>
						</xsl:when>
					</xsl:choose>
		
<!--displayDate-->
				<displayPublishDate>
					<xsl:value-of select="Jahr[1]"/>
					</displayPublishDate>		

<!--publishDate Jahresangabe-->
				<xsl:if test="Jahr[1]">
					<xsl:apply-templates select="Jahr[1]"/>
					</xsl:if>

<!--placeOfPublication Ortsangabe-->						
				<xsl:if test="Ort[1]">
					<xsl:apply-templates select="Ort"/>
					</xsl:if>

<!--publisher-->
				<xsl:if test="Verlag-Druckerei">
					<publisher>
						<xsl:value-of select="Verlag-Druckerei"/>
						</publisher>
					</xsl:if>

<!--physical Seitenangabe-->
				<xsl:if test="Seitenzahlen !=''">
					<physical>
						<xsl:value-of select="Seitenzahlen"/>
						</physical>
					</xsl:if>

<!--language Sprachangaben-->
				<language>o.A.</language>

<!--subjectTopic Deskriptoren-->
				<xsl:if test="Deskriptoren[1]">
					<xsl:apply-templates select="Deskriptoren[1]"/>
					</xsl:if>

<!--subjectPerson Personenangaben-->
				<xsl:if test="Personenregister">
					<xsl:apply-templates select="Personenregister"/>
					</xsl:if>
					
<!--url Link zum Dokument-->
				<xsl:if test="url">
					<url>
						<xsl:value-of select="url"/>
						</url>
					</xsl:if>

<!--relatedTo-->
				<xsl:if test="Einzeltitel">
					<relatedTo>
						<xsl:choose>
							<xsl:when test="contains(Sammeltitel,'In: ')">
								<xsl:value-of select="substring-after(Sammeltitel, 'In: ')"/>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="Sammeltitel"/>
								</xsl:otherwise>
							</xsl:choose>
						<xsl:choose>
							<xsl:when test="Jahrgang[1]">
								<xsl:text> </xsl:text>
								<xsl:value-of select="Jahrgang[1]"/>
								</xsl:when>
							<xsl:otherwise>
								<xsl:text> </xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						<xsl:if test="Jahr[1]">
							<xsl:text>(</xsl:text>
							<xsl:value-of select="Jahr[1]"/>
							<xsl:text>)</xsl:text>
							</xsl:if>
						<xsl:if test="Heftnummer[1]">
							<xsl:value-of select="Heftnummer[1]"/>
							</xsl:if>
						</relatedTo>
					</xsl:if>
			

</xsl:element>

	<xsl:element name="functions">
		<xsl:element name="hierarchyFields">
		<hierarchy_top_id>
			<xsl:value-of select="substring(translate(Klassifikation,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,11)"/>
			<xsl:text>paulabiblio</xsl:text>
			</hierarchy_top_id>
		<hierarchy_top_title>
			<xsl:value-of select="Klassifikation"/>
			</hierarchy_top_title>
				
		<hierarchy_parent_id>
			<xsl:value-of select="substring(translate(Untergruppe,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"/>
			<xsl:text>paulabiblio</xsl:text>
			</hierarchy_parent_id>
		<hierarchy_parent_title>
			<xsl:value-of select="Untergruppe"/>
			</hierarchy_parent_title>
				
		<is_hierarchy_id>
			<xsl:value-of select="ID"/>
			<xsl:text>paulabiblio</xsl:text>
			</is_hierarchy_id>
		<is_hierarchy_title>
			<xsl:choose>
				<xsl:when test="Einzeltitel">
					<xsl:value-of select="Einzeltitel"/>
					</xsl:when>
				<xsl:when test="(Sammeltitel) and (not(Einzeltitel))">
					<xsl:value-of select="Sammeltitel"/>
					</xsl:when>
				</xsl:choose>
			</is_hierarchy_title>
				
		<hierarchy_sequence>
			<xsl:choose>
				<xsl:when test="Einzeltitel">
					<xsl:value-of select="substring(Einzeltitel,1,3)"/>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(Sammeltitel,1,3)"/>
					</xsl:otherwise>
				</xsl:choose>
			</hierarchy_sequence>
		</xsl:element>
	</xsl:element>	

</xsl:element>
</xsl:template>










<!--Templates-->

<!--Template Titel-->
	<xsl:template match="Einzeltitel[1]">
		<xsl:choose>
			<xsl:when test="contains(.[1], ':')">
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(.[1], ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ':'))"/>
					</title_sub>
			</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="Sammeltitel[1]">
		<xsl:choose>
			<xsl:when test="contains(.[1], ':')">
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(.[1], ':'))"/>
					</title_short>
				<title_sub>
					<xsl:value-of select="normalize-space(substring-after(.[1], ':'))"/>
					</title_sub>
			</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select=".[1]"/>
					</title>
				<title_short>
					<xsl:value-of select=".[1]"/>
					</title_short>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--Template Urheberin-->
	<xsl:template match="UrheberIn[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<author>
				<xsl:value-of select="normalize-space(.)"/>
				</author>
			</xsl:for-each>
		</xsl:template>

<!--Template Herausgeberinnen-->
	<xsl:template match="HerausgeberIn[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<editor>
				<xsl:value-of select="normalize-space(.)"/>
				</editor>
			</xsl:for-each>
		</xsl:template>

<!--Jahr-->
	<!--Template Jahr-->
	<xsl:template match="Jahr[1]">
		<xsl:variable name="jear" select=".[1]"/>
			<xsl:choose>
				<xsl:when test="contains(.,'-')">
					<publishDate>
						<xsl:value-of select="substring-before(.,'-')"/>
						</publishDate>
					<publishDate>
						<xsl:value-of select="substring-after(.,'-')"/>
						</publishDate>
					</xsl:when>
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

<!--Template Ortsangabe-->
	<xsl:template match="Ort[1]">
		<xsl:choose>
			<xsl:when test="(not(.)) or (contains(.[1], 'o.A.'))">
				<placeOfPublication>
					<xsl:text>o.A.</xsl:text>
					</placeOfPublication>
				</xsl:when>
			<xsl:when test=".[1]">
				<xsl:choose>
					<xsl:when test="contains(.[1], ';')">
						<xsl:for-each select="tokenize(.[1], ';')">
							<placeOfPublication>
								<xsl:value-of select="normalize-space(.)"/>
								</placeOfPublication>
							</xsl:for-each>
						</xsl:when>
					<xsl:otherwise>
						<placeOfPublication>
							<xsl:value-of select="normalize-space(.[1])"/>
							</placeOfPublication>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:template>

<!--Template Deskriptoren-->
	<xsl:template match="Deskriptoren[1]">
		<xsl:for-each select="tokenize(.[1], ';')">
			<subjectTopic>
				<xsl:value-of select="normalize-space(.)"/>
				</subjectTopic>
			</xsl:for-each>
		</xsl:template>

<!--Template Personen-->
	<xsl:template match="Personenregister[1]">
			<xsl:for-each select="tokenize(.[1], ';')">
				<subjectPerson>
					<xsl:value-of select="normalize-space(.)"/>
					</subjectPerson>
				</xsl:for-each>
		</xsl:template>

</xsl:stylesheet>
