<?xml version="1.0" encoding="utf-8"?>
<!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>

	

	
<!--root knoten-->
	<xsl:template match="ASH">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="datensatz">
	
		<!--<xsl:if test="objektart[text()='Fotos/Dias']">-->
		<xsl:if test="(objektart[text()='Akten']) or
				(objektart[text()='Publikationen_Aufsatz/Artikel']) or
				(objektart[text()='Publikationen_Buch'])  or
				(objektart[text()='Publikationen_Diplomarbeiten'])  or
				(objektart[text()='Publikationen_Graue'])  or
				(objektart[text()='Publikationen_Zeitschriften_Heft']) ">
		
		
	
		<xsl:variable name="id" select="id"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/>
					</xsl:attribute>
				
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->


		<xsl:variable name="ref_grau" select="translate(Graue_REF[1], translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="ref_akte" select="translate(Akte_REF[1], translate(.,'0123456789', ''), '')"/>		
		<xsl:variable name="ref_zs-heft" select="translate(ZS_Heft_REF[1], translate(.,'0123456789', ''), '')"/>	
		<xsl:variable name="ref_zs-ref" select="translate(ZS_REF[1], translate(.,'0123456789', ''), '')"/>	
		<xsl:variable name="ref_buch" select="translate(Buchtitel_REF[1], translate(.,'0123456789', ''), '')"/>
		<xsl:variable name="ref_artikel" select="translate(Aufsatz-Artikel_REF[1], translate(.,'0123456789', ''), '')"/>
				
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="id"/>
					<xsl:text>ash</xsl:text>
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
							<xsl:text>Alice Salomon Archiv</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>Alice Salomon Archiv der ASH Berlin</xsl:text>
							</institutionFull>
			
						<institutionID>
							<xsl:text>ash</xsl:text>
							</institutionID>
			
<!--collection-->				<collection><xsl:text>ash</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>DE-B1591</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/alice-salomon-archiv/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>49.6115690</latitude>
							<longitude>6.1274660</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Publikationen_Buch__________________________Publikationen_Buch___________________________Publikationen_Buch-->

<xsl:if test="objektart[text()='Publikationen_Buch']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Buch" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="ISBN" />	
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="Erschienen" />
		
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
		
<xsl:if test="Aufsatz-Artikel_REF">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Titel_Buch" /></hierarchy_top_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Buch" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Buch,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
		</xsl:if>		


		</xsl:if>








			
<!--Publikationen_Diplomarbeiten__________________________Publikationen_Diplomarbeiten___________________________Publikationen_Diplomarbeiten-->

<xsl:if test="objektart[text()='Publikationen_Diplomarbeiten']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Hochschulschrift</xsl:text></format>	
	
	<!--documentType-->
				<documentTyp><xsl:text>Diplomarbeit</xsl:text></documentTyp>

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Diplomarbeit" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--revwiewer Gutachterin-->
			<xsl:apply-templates select="GutachterInnen" />
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="Provenienz" />
		
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="Umfang" />

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
		</xsl:if>




	
<!--Publikationen_Graue__________________________Publikationen_Graue___________________________Publikationen_Graue-->

<xsl:if test="objektart[text()='Publikationen_Graue']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Akte</xsl:text></format>	
	<!--documentType-->
				<documentTyp><xsl:text>Graue Materialien</xsl:text></documentTyp>

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Graue" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
		
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
			<xsl:if test="Umfang">
				<physical>
					<xsl:value-of select="Umfang"/>		
					</physical>
				</xsl:if>

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />
	<!--description-->
			<!--<description>
				<xsl:value-of select="Umfang"/>		
				</description>-->
			
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="vSIGN" />
		
		</xsl:element>	
		
	<xsl:if test="Akte_REF">
		<functions>
			<hierarchyFields>
				
				
				<hierarchy_top_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Graue" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Graue,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>
		
		
		
		</xsl:if>






	
			
<!--Akten__________________________Akten___________________________Akten-->

<xsl:if test="(objektart[text()='Akten']) and (Titel_Akte)">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Akte</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Akte" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="ISBN" />	
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="Laufzeit" />
		
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
			<xsl:if test="Umfang">
				<physical>
					<xsl:value-of select="Umfang"/>
					</physical>
				</xsl:if>

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:if test="Enthält">
				<xsl:choose>
					<xsl:when test="contains(Enthält,';')">
						<xsl:for-each select="tokenize(Enthält,';')">
							<subjectTopic>
								<xsl:value-of select="normalize-space(translate(.,'_','-'))" />
								</subjectTopic>
							</xsl:for-each>
						</xsl:when>
					<xsl:when test="contains(Enthält,',')">
						<xsl:for-each select="tokenize(Enthält,',')">
							<subjectTopic>
								<xsl:value-of select="normalize-space(translate(.,'_','-'))" />
								</subjectTopic>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				
				</xsl:if>
			
	<!--subjectPerson-->	
			<xsl:apply-templates select="AnderePersonen_1" />
		
	<!--description-->
			<xsl:if test="(Bemerkg_) or (Inhalt)">
			<description>
				<!--<xsl:if test="Umfang">
					<xsl:value-of select="Umfang" />
					<xsl:text> - </xsl:text>
					</xsl:if>-->
				<xsl:if test="Bemerkg_">
					<xsl:value-of select="Bemerkg_"/>
					<xsl:text> - </xsl:text>
					</xsl:if>
				<xsl:if test="Inhalt">
					<xsl:value-of select="Inhalt"/>
					</xsl:if>
				</description>
				</xsl:if>
			<xsl:apply-templates select="Personen" />
			
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
	
	<xsl:if test="(Graue_REF) or (Foto_REF) or (Aufsatz-Artikel_REF)">
		<functions>
		
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="Titel_Akte" /></hierarchy_top_title>
					
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Akte" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Akte,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>
		
		
		
		</xsl:if>







			
<!--Publikationen_Aufsatz/Artikel__________________________Publikationen_Aufsatz/Artikel___________________________Publikationen_BuchPublikationen_Aufsatz/Artikel-->

<xsl:if test="objektart[text()='Publikationen_Aufsatz/Artikel']">

<xsl:variable name="titelHeft" select="//datensatz[id=$ref_zs-heft]/Titel_Heft"></xsl:variable>

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Artikel</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Aufsatz-Artikel" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="ISBN" />	
			
			<xsl:if test="(ZS_REF) and (//datensatz[id=$ref_zs-ref]/ZDB_ID)">
				<zdbId>
					<xsl:value-of select="//datensatz[id=$ref_zs-ref]/ZDB_ID"></xsl:value-of>
					</zdbId>
				</xsl:if>
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:choose>
				<xsl:when test="Erschienen_in">
					<xsl:apply-templates select="Erschienen_in" />
					</xsl:when>
				<xsl:when test="//datensatz[id=$ref_zs-heft]/Jahr[last()]">
						<displayPublishDate>
							<xsl:value-of select="//datensatz[id=$ref_zs-heft]/Jahr[last()]"/>
							</displayPublishDate>
						<publishDate>
							<xsl:value-of select="//datensatz[id=$ref_zs-heft]/Jahr[last()]"/>
							</publishDate>
					</xsl:when>
				<xsl:when test="contains($titelHeft,'&lt;')">
					<displayPublishDate>
						<xsl:value-of select="substring-before(substring-after($titelHeft,'&lt;'),'.')"></xsl:value-of>
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="substring-before(substring-after($titelHeft,'&lt;'),'.')"></xsl:value-of>
						</publishDate>
					</xsl:when>
				</xsl:choose>
			<!--<xsl:apply-templates select="Erschienen_in" />-->
	<!--sourceInfo-->
			
			<xsl:if test="(ZS_REF) and (//datensatz[id=$ref_zs-ref]/ZS_Titel)">
				<sourceInfo>
					<xsl:value-of select="//datensatz[id=$ref_zs-ref]/ZS_Titel"></xsl:value-of>
					</sourceInfo>
				</xsl:if>
			
			<xsl:if test="(Buchtitel_REF) and (//datensatz[id=$ref_buch]/Titel_Buch)">
				<sourceInfo>
					<xsl:value-of select="//datensatz[id=$ref_buch]/Titel_Buch"></xsl:value-of>
					</sourceInfo>
				</xsl:if>
				
			<xsl:if test="(Akte_REF) and (//datensatz[id=$ref_akte]/Titel_Akte)">
				<sourceInfo>
					<xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte"></xsl:value-of>
					</sourceInfo>
				</xsl:if>
			
			<xsl:if test="ZS_Heft_REF">
				
				<sourceInfo>
					<xsl:choose>
						<xsl:when test="contains($titelHeft,'&lt;')">
							<xsl:value-of select="normalize-space(substring-before($titelHeft,'&lt;'))"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$titelHeft" />
							</xsl:otherwise>
						</xsl:choose>
					</sourceInfo>
				
				<xsl:if test="contains($titelHeft,'&lt;')">
					<issue>
					
					<xsl:choose>
						<xsl:when test="contains(substring-after(substring-after(substring-before(titelHeft,'&gt;'),'&lt;'),'.'),'H')">
							<xsl:value-of select="substring-after(substring-after(substring-before(titelHeft,'&gt;'),'&lt;'),'.H')"/>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-before(substring-after(substring-after($titelHeft,'&lt;'),'.'),'&gt;')"/>
							<!--<xsl:value-of select="substring-after(substring-after(substring-before(titelHeft,'&gt;'),'&lt;'),'.')"/>-->
							</xsl:otherwise>
						</xsl:choose>
						
						<!--<xsl:value-of select="substring-after(substring-after(substring-before($titelHeft,'&gt;'),'&lt;'),'.H')"></xsl:value-of>-->
						</issue>
					</xsl:if>
				</xsl:if>
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
			<xsl:apply-templates select="Umfang" />

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
		

	<xsl:if test="ZS_Heft_REF">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="//datensatz[id=$ref_zs-heft]/id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//datensatz[id=$ref_zs-heft]/ZS_Titel" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$ref_zs-heft]/id"/><xsl:text>ash</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$ref_zs-heft]/ZS_Titel" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Aufsatz-Artikel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Aufsatz-Artikel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
		</xsl:if>
	
	<xsl:variable name="ref_buch" select="translate(Buchtitel_REF[1], translate(.,'0123456789', ''), '')"/>
	<xsl:if test="Buchtitel_REF">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="//datensatz[id=$ref_buch]/id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//datensatz[id=$ref_buch]/Titel_Buch" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$ref_buch]/id"/><xsl:text>ash</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$ref_buch]/Titel_Buch" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Aufsatz-Artikel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Aufsatz-Artikel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
		</xsl:if>
		
	<xsl:variable name="ref_akte" select="translate(Akte_REF[1], translate(.,'0123456789', ''), '')"/>
	<xsl:if test="Akte_REF">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Aufsatz-Artikel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Aufsatz-Artikel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
		</xsl:if>


</xsl:if>






			
<!--Publikationen_Zeitschriften_Heft__________________________Publikationen_Zeitschriften_Heft___________________________Publikationen_Zeitschriften_Heft-->

<xsl:if test="objektart[text()='Publikationen_Zeitschriften_Heft']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Zeitschrift</xsl:text></format>	
	<!--documentType-->
				<documentType><xsl:text>Zeitschriftenheft</xsl:text></documentType>

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel_Heft" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="ISBN" />	
				
<!--PUBLISHING-->

	<!--displayDate-->
			<xsl:apply-templates select="Jahr" />
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="Erschienen" />
	
	<!--issue Heftangabe-->
			<xsl:apply-templates select="Heft_Nr_" />
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />



<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
		

	<xsl:if test="Artikel_REF">
		<functions>
			<hierarchyFields>
				
				
				<hierarchy_top_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="ZS_Titel" /></hierarchy_top_title>
					
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="ZS_Titel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(ZS_Titel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
			</functions>
		</xsl:if>

</xsl:if>




			
<!--Fotos/Dias__________________________Fotos/Dias___________________________Fotos/Dias-->

<xsl:if test="objektart[text()='Fotos/Dias']">

<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Fotografie</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
			<xsl:apply-templates select="Titel-Gegenstand_Foto" />	
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
			<xsl:apply-templates select="AutorIn-Hrsg_" />	
	<!--contributor Mitwirkende-->
			<xsl:apply-templates select="beteiligte_Personen" />	
			<xsl:apply-templates select="UrheberIn_FotografIn" />	
	<!--entity Körperschaftsangaben-->
			<xsl:apply-templates select="Körperschaft" />	
	<!--series Reiheninformation-->
			<xsl:apply-templates select="Reihentitel" />	
				
<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
			<xsl:apply-templates select="ISBN" />	
				
<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
	<!--placeOfPublication publisher Verlagsangabe-->
			<xsl:apply-templates select="Datierung" />
		
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
	
	<!--dimension Format-->
			<xsl:apply-templates select="Format" />

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
			<xsl:apply-templates select="Schlagworte" />
			<xsl:apply-templates select="Personen" />
	<!--description Beschreibung-->
			<xsl:apply-templates select="Beschreibung" />
<!--OTHER-->
	<!--SHELFMARK-->
			
			<xsl:apply-templates select="Sign_" />
		
		</xsl:element>	
		
	<xsl:if test="Akte_REF">
		<functions>
			<hierarchyFields>
				
				<hierarchy_top_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_top_title>
				
				<hierarchy_parent_id><xsl:value-of select="//datensatz[id=$ref_akte]/id"/><xsl:text>ash</xsl:text></hierarchy_parent_id>
				<hierarchy_parent_title><xsl:value-of select="//datensatz[id=$ref_akte]/Titel_Akte" /></hierarchy_parent_title>
				
				<is_hierarchy_id><xsl:value-of select="id"/><xsl:text>ash</xsl:text></is_hierarchy_id>
				<is_hierarchy_title><xsl:value-of select="Titel_Aufsatz-Artikel" /></is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring(Titel_Aufsatz-Artikel,1,3)"/></hierarchy_sequence>
				
				</hierarchyFields>
	
			</functions>
		</xsl:if>
		
		</xsl:if>





	


</xsl:element>
</xsl:if>
</xsl:template>








<!--Templates-->
	
	<xsl:template match="AnderePersonen_1">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Format">
		<dimension>
			<xsl:value-of select="."/>
			</dimension>
		</xsl:template>
	
	<xsl:template match="Beschreibung">
		<description>
			<xsl:value-of select="."/>
			</description>
			<xsl:if test="(../objektart[text()='Fotos/Dias']) and not(../Titel-Gegenstand_Foto)">
				<title>
					<xsl:value-of select="substring(.,1,70)" />
					<xsl:text>[...]</xsl:text>
					</title>	
				<title_short>
					<xsl:value-of select="substring(.,1,70)" />
					<xsl:text>[...]</xsl:text>
					</title_short>			
				</xsl:if>
			
		</xsl:template>
	
	<xsl:template match="UrheberIn_FotografIn">
		<contributor><xsl:choose>
				<xsl:when test="contains(.,'Alice-Salomon-Archiv')">
					<xsl:text>Alice Salomon Archiv, Berlin (ASA, Berlin)?</xsl:text>
					</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					</xsl:otherwise>
				</xsl:choose>
		
			<!--<xsl:value-of select="."/>-->
			</contributor>
		<!--<xsl:if test="contains(.,':')">
			<placeOfPublication>
				<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
				</placeOfPublication>
			</xsl:if>-->
		</xsl:template>
	
	<xsl:template match="Datierung">
		<displayPublishDate>
			<xsl:value-of select="."/>
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>	
			</publishDate>
		</xsl:template>
	
	<xsl:template match="Heft_Nr_">
		<!--<xsl:if test="not(contains(../Titel_Heft,'&lt;')) and (contains(../Sign_,'&lt;'))">-->
		<xsl:if test="not(contains(../Titel_Heft,'&lt;')) and (not(contains(../Sign_,'&lt;')))">
		<xsl:for-each select="tokenize(.,',')">
			<xsl:if test="contains(.,'Nr.')">
				<issue>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
					</issue>
				</xsl:if>
			</xsl:for-each>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Jahr">
		<xsl:if test="not(contains(../Titel_Heft,'&lt;'))">
		<displayPublishDate>
			<xsl:value-of select="normalize-space(.)"/>
			</displayPublishDate>
		<publishDate>
			<xsl:value-of select="normalize-space(.)"/>
			</publishDate>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Provenienz">
		<xsl:choose>
			<xsl:when test="contains(.,':')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-after(substring-after(.,':'),','))"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="normalize-space(substring-after(substring-after(.,':'),','))"/>
					</publishDate>
				</xsl:when>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Umfang">
		<physical>
			<xsl:value-of select="translate(., translate(.,'0123456789-', ''), '')"/>
			</physical>
		</xsl:template>
	
	<xsl:template match="Schlagworte">
		<xsl:choose>
			<xsl:when test="contains(.,'/')">
				<xsl:for-each select="tokenize(.,'/')">
					<subjectTopic>
						<xsl:value-of select="normalize-space(translate(.,'_','-'))" />
						</subjectTopic>
					</xsl:for-each>		
				</xsl:when>
			<xsl:when test="contains(.,',')">
				<xsl:for-each select="tokenize(.,',')">
					<subjectTopic>
						<xsl:value-of select="normalize-space(translate(.,'_','-'))" />
						</subjectTopic>
					</xsl:for-each>		
				</xsl:when>
			</xsl:choose>
		
		
		</xsl:template>
	
	<xsl:template match="Reihentitel">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>
	
	<xsl:template match="Personen">
		<xsl:for-each select="tokenize(.,';')">
			<subjectPerson>
				<xsl:value-of select="normalize-space(.)" />
				</subjectPerson>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(.)" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="Körperschaft">
		<xsl:choose>
			<xsl:when test="contains(.,'(Hg.)')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hg.)'))"/>
					</editor>
				</xsl:when>
				<xsl:otherwise>
					<entity>
						<xsl:value-of select="normalize-space(.)" />
						</entity>
						</xsl:otherwise>
				</xsl:choose>
		</xsl:template>
	
	<xsl:template match="beteiligte_Personen">
		<xsl:choose>
			<xsl:when test="contains(.,';')">
				<xsl:for-each select="tokenize(.,';')">
					<contributor>
						<xsl:choose>
							<xsl:when test="contains(.,'Alice-Salomon-Archiv, Berlin (ASA, Berlin)?')">
								<xsl:text>Alice Salomon Archiv, Berlin (ASA, Berlin)?</xsl:text>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(.)" />
								</xsl:otherwise>
							</xsl:choose>
						</contributor>
					</xsl:for-each>
				</xsl:when>
			<xsl:when test="contains(.,'/')">
				<xsl:for-each select="tokenize(.,'/')">
					<contributor>
						<xsl:choose>
							<xsl:when test="contains(.,'Alice-Salomon-Archiv, Berlin (ASA, Berlin)?')">
								<xsl:text>Alice Salomon Archiv, Berlin (ASA, Berlin)?</xsl:text>
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(.)" />
								</xsl:otherwise>
							</xsl:choose>
						</contributor>
					</xsl:for-each>
				</xsl:when>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="Laufzeit">
		<displayPublishDate>
			<xsl:value-of select="."/>
			</displayPublishDate>
		<xsl:for-each select="tokenize(.,'-')">
			<publishDate>
				<xsl:value-of select="normalize-space(.)" />
				</publishDate>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Erschienen_in">
		
		<xsl:for-each select="tokenize(.,',')">
			<xsl:if test="contains(.,'Jg.')">
				<volume>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
					</volume>
				</xsl:if>
			<xsl:if test="contains(.,'Nr.')">
				<issue>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
					</issue>
				</xsl:if>
			</xsl:for-each>
			
			<!--<sourceInfo>
				<xsl:value-of select="."/>
				</sourceInfo>-->
			
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
				
			<!--<xsl:variable name="date" select="tokenize(translate(., translate(.,'0123456789', ''), ''),',')[last()]" />
			<xsl:variable name="string-length-date" select="string-length($date)" />
			<xsl:variable name="string-postion-start" select="$string-length-date - 3"/>
			<displayPublishDate>
				<xsl:value-of select="substring($date,$string-postion-start,$string-length-date)"/>
				</displayPublishDate>
			<publishDate>
				<xsl:value-of select="substring($date,$string-postion-start,$string-length-date)"/>
				</publishDate>-->
						
		</xsl:template>
	
	<xsl:template match="Erschienen">
			
		<xsl:if test="matches(.,'[0-9]')">
		<xsl:variable name="erschienen" select="translate(., translate(.,'0123456789', ''), '')"/>

			<xsl:for-each select="document('../../anreicherung/year.xml')/root/child/year">
				<xsl:if test="contains(.,$erschienen)">
					<displayPublishDate>
						<xsl:value-of select="." />
						</displayPublishDate>
					<publishDate>
						<xsl:value-of select="." />
						</publishDate>	
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
			
			<xsl:if test="contains(.,':')">
				<placeOfPublication>
					<xsl:value-of select="normalize-space(substring-before(.,':'))"></xsl:value-of>
					</placeOfPublication>
					</xsl:if>
	

<!--<xsl:choose>
	<xsl:when test="contains(.,':')">
		<xsl:choose>
			<xsl:when test="contains(substring-after(.,':'),',')">
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-after(substring-after(.,':'),','))" />
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(normalize-space(substring-after(substring-after(.,':'),',')), translate(.,'0123456789', ''), '')"/>
					</publishDate>
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="translate(normalize-space(substring-after(.,':')), translate(.,'0123456789', ''), '')"/>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>	
		<xsl:choose>
			<xsl:when test="contains(substring-before(.,':'),',')">
				<publisher>
					<xsl:value-of select="normalize-space(substring-before(substring-after(.,':'),','))"/>
					</publisher>
				<placeOfPublication>
					<xsl:value-of select="normalize-space(substring-before(.,':'))" />
					</placeOfPublication>		
				</xsl:when>
			<xsl:otherwise>
				<placeOfPublication>
					<xsl:value-of select="normalize-space(substring-before(.,':'))" />
					</placeOfPublication>	
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	<xsl:otherwise>
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>	
		</xsl:otherwise>
	</xsl:choose>-->
	
		</xsl:template>
	
	<xsl:template match="GutachterInnen">
		<!--<xsl:for-each se="tokenize(.,';')">-->
			<reviewer>
				<xsl:value-of select="normalize-space(.)" />
				</reviewer>
			<!--</xsl:for-each>-->			</xsl:template>
	
	<xsl:template match="AutorIn-Hrsg_">
		<xsl:choose>
		<xsl:when test="contains(.,';')">
		<xsl:for-each select="tokenize(.,';')">
			<xsl:choose>
				<xsl:when test="contains(.,'(Hg.)')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'(Hg.)'))"/>
						</editor>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not(contains(.,'o. A.'))">
						<author>
							<xsl:value-of select="normalize-space(.)" />
							</author>
							</xsl:if>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			</xsl:when>	
		<xsl:when test="contains(.,'/')">
		<xsl:for-each select="tokenize(.,'/')">
			<xsl:choose>
				<xsl:when test="contains(.,'(Hg.)')">
					<editor>
						<xsl:value-of select="normalize-space(substring-before(.,'(Hg.)'))"/>
						</editor>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not(contains(.,'o. A.'))">
						<author>
							<xsl:value-of select="normalize-space(.)" />
							</author>
							</xsl:if>
						</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test=".!='o. A.'">
				<author>
					<xsl:value-of select="." />
					</author>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="vSIGN">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Sign_">
		<shelfMark>
			<xsl:value-of select="." />
			</shelfMark>
		
		<xsl:if test="(not(../Erschienen)) and (not(matches(../Titel_Heft,'&lt;'))) and (contains(.,'&lt;'))">
			<displayPublishDate>
					<xsl:variable name="lt" select="substring-after(.,'&lt;')" />
					<xsl:value-of select="substring-before($lt,'.')"></xsl:value-of>
					</displayPublishDate>
				<publishDate>
					<xsl:variable name="lt" select="substring-after(.,'&lt;')" />
					<xsl:value-of select="substring-before($lt,'.')"></xsl:value-of>	
					</publishDate>
				<issue>
					<xsl:value-of select="substring-after(substring-after(substring-before(.,'&gt;'),'&lt;'),'.H')"/>
					</issue>
			</xsl:if>
		
		</xsl:template>
	
	<xsl:template match="Titel_Akte">
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Titel_Graue">
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Titel_Diplomarbeit">
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Titel_Buch">
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
	
		<xsl:template match="Titel_Aufsatz-Artikel">
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
		
		<xsl:template match="Titel-Gegenstand_Foto">
		<xsl:choose>
			<xsl:when test="contains(.,'[')">
				<title>
					<xsl:value-of select="normalize-space(substring-before(.,'['))" />
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(.,'['))" />
					</title_short>
				</xsl:when>
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>
		
		<xsl:template match="Titel_Heft">
		<xsl:variable name="lt" select="substring-after(.,'&lt;')" />
		<xsl:choose>
			<xsl:when test="contains(.,'&lt;')">
				<title>
					<xsl:value-of select="normalize-space(substring-before(.,'&lt;'))"/>
					</title>
				<title_short>
					<xsl:value-of select="normalize-space(substring-before(.,'&lt;'))"/>
					</title_short>
				<displayPublishDate>
					<xsl:choose>
						<xsl:when test="contains($lt,'.')">
							<xsl:value-of select="substring-before($lt,'.')"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-before($lt,'&gt;')"/>
							</xsl:otherwise>
						</xsl:choose>
					<!--<xsl:value-of select="substring-before($lt,'.')"></xsl:value-of>-->
					</displayPublishDate>
				<publishDate>
					<xsl:choose>
						<xsl:when test="contains($lt,'.')">
							<xsl:value-of select="substring-before($lt,'.')"></xsl:value-of>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-before($lt,'&gt;')"/>
							</xsl:otherwise>
						</xsl:choose>
					</publishDate>
				<xsl:if test="contains($lt,'.')">
				<issue>
					<xsl:choose>
						<xsl:when test="contains(substring-after(substring-after(substring-before(.,'&gt;'),'&lt;'),'.'),'H')">
							<xsl:value-of select="substring-after(substring-after(substring-before(.,'&gt;'),'&lt;'),'.H')"/>
							</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring-after(substring-after(substring-before(.,'&gt;'),'&lt;'),'.')"/>
							</xsl:otherwise>
						</xsl:choose>
					</issue>
					</xsl:if>
				</xsl:when>
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
					<xsl:value-of select="." />
					</title>
				<title_short>
					<xsl:value-of select="." />
					</title_short>
				</xsl:otherwise>				
			</xsl:choose>
		</xsl:template>



</xsl:stylesheet>
