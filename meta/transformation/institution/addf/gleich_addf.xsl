<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Jun 02 12:03:05 GMT 2015 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
		
	


<!--root knoten-->
	<xsl:template match="AddF-Kassel">
		<xsl:element name="catalog">
			<xsl:apply-templates select="//Datensatz" />
			<xsl:apply-templates select="Datensatz[1]/Datum-Erfassung" />
			</xsl:element>
		</xsl:template>


	<xsl:template match="Datensatz">
		
		<xsl:if test="id">
		
		<xsl:element name="record">
		
		<vufind>
				<id><xsl:value-of select="id" /><xsl:text>addf</xsl:text></id>
				<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
				<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
				<recordType><xsl:text>archive</xsl:text></recordType>			
				</vufind>
			
		<institution>
				<institutionShortname><xsl:text>Archiv der deutschen Frauenbewegung</xsl:text></institutionShortname>
				<institutionFull><xsl:text>Stiftung Archiv der deutschen Frauenbewegung</xsl:text></institutionFull>
				<institutionID><xsl:text>addf</xsl:text></institutionID>
				<collection><xsl:text>ADDF</xsl:text></collection>
				<isil><xsl:text>DE-Ks16</xsl:text></isil>
				<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/archiv-der-deutschen-frauenbewegung/</xsl:text></link>
				<geoLocation>
					<latitude>51.3259450</latitude>
					<longitude>9.5036040</longitude>
					</geoLocation>
				</institution>
		
		<dataset>
			
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
				
				<xsl:choose>
					<xsl:when test="contains(.,'0 Einleitung')">
						<format><xsl:text>Nachlass / Vorlass</xsl:text></format>
						</xsl:when>
					<xsl:otherwise>
						<format><xsl:text>Akte</xsl:text></format>
						</xsl:otherwise>
					</xsl:choose>
			
				<title><xsl:value-of select="Titel" /></title>
				<title_short><xsl:value-of select="Titel" /></title_short>
				
				<xsl:if test="not(contains(.,'0 Einleitung'))">
					<xsl:if test="Thesaurus_Klassifikation">
						<sourceInfo><xsl:value-of select="//Datensatz[Thesaurus_Klassifikation='0 Einleitung']/Titel" /></sourceInfo>	
						</xsl:if>
					<xsl:if test="Thesaurus_Akten">
						<sourceInfo><xsl:value-of select="//Datensatz[Thesaurus_Akten='0 Einleitung']/Titel" /></sourceInfo>	
						</xsl:if>
					</xsl:if>
					
				<physical><xsl:value-of select="Umfang-Format" /></physical>
			
				<displayPublishDate>
				<xsl:for-each select="Jahr-Datierung">
					<xsl:value-of select="." />
					<xsl:if test="not(position()=last())">
						<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					</displayPublishDate>
					
				<!--<displayPublishDate><xsl:value-of select="Jahr-Datierung" /></displayPublishDate>-->
				
				<xsl:for-each select="Jahr-Datierung">
				<xsl:choose>
					<xsl:when test="contains(.,'-')">
						<xsl:for-each select="tokenize(.,'-')">
							<publishDate>
								<xsl:value-of select="normalize-space(.)" />
								</publishDate>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<publishDate>
								<xsl:value-of select="normalize-space(.)" />
								</publishDate>
							</xsl:otherwise>
					</xsl:choose>
					</xsl:for-each>
			
				<xsl:if test="Sperrjahr">
					<blockingYear>
						<xsl:value-of select="Sperrjahr"></xsl:value-of>
						</blockingYear>
					</xsl:if>
				
				<xsl:if test="Bestandsbeschreibung">
					<description><xsl:value-of select="Bestandsbeschreibung" /></description>
					</xsl:if>	
				
				<xsl:if test="Enthält">
					<description><xsl:value-of select="Enthält" /></description>
					</xsl:if>	
				
				<!--<xsl:for-each select="Thesaurus_Körperschaften"><entity><xsl:value-of select="."></xsl:value-of></entity></xsl:for-each>-->			
				<!--<xsl:for-each select="Thesaurus_Schlagworte"><subjectTopic><xsl:value-of select="." /></subjectTopic></xsl:for-each>-->
				<!--<xsl:for-each select="Thesaurus_Personen"><subjectPerson><xsl:value-of select="." /></subjectPerson></xsl:for-each>-->
			
				<shelfMark><xsl:value-of select="Signatur" /></shelfMark>
				
				</dataset>
					
		<functions>
				
				<hierarchyFields>
		
					<hierarchy_top_id>
						<xsl:choose>
							<xsl:when test="Thesaurus_Klassifikation">
								<xsl:value-of select="//Datensatz[Thesaurus_Klassifikation='0 Einleitung']/id" />
								</xsl:when>
							<xsl:when test="Thesaurus_Akten">
								<xsl:value-of select="//Datensatz[Thesaurus_Akten='0 Einleitung']/id" />
								</xsl:when>
							</xsl:choose>
							<xsl:text>addf</xsl:text>
						</hierarchy_top_id>
					<hierarchy_top_title>
						<xsl:choose>
							<xsl:when test="Thesaurus_Klassifikation">
								<xsl:value-of select="//Datensatz[Thesaurus_Klassifikation='0 Einleitung']/Titel" />
								</xsl:when>
							<xsl:when test="Thesaurus_Akten">
								<xsl:value-of select="//Datensatz[Thesaurus_Akten='0 Einleitung']/Titel" />
								</xsl:when>
							</xsl:choose>
						</hierarchy_top_title>
					
					<xsl:if test="not(contains(.,'0 Einleitung'))">
					<hierarchy_parent_id>
						<xsl:choose>
							<xsl:when test="Thesaurus_Klassifikation">
								<xsl:value-of select="translate(Thesaurus_Klassifikation,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
								</xsl:when>
							<xsl:when test="Thesaurus_Akten">
								<xsl:value-of select="translate(Thesaurus_Akten,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
								</xsl:when>
							</xsl:choose>
						<!--<xsl:value-of select="translate(Thesaurus_Klassifikation,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />-->
						<xsl:text>addf</xsl:text>
						</hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:choose>
							<xsl:when test="Thesaurus_Klassifikation">
								<xsl:value-of select="Thesaurus_Klassifikation" /></xsl:when>
							<xsl:when test="Thesaurus_Akten">
								<xsl:value-of select="Thesaurus_Akten" /></xsl:when>
							</xsl:choose>
						<!--<xsl:value-of select="Thesaurus_Klassifikation" />-->
						</hierarchy_parent_title>
						</xsl:if>
		
					<is_hierarchy_id>
						<xsl:value-of select="id" />
						<xsl:text>addf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:value-of select="Titel" />
						</is_hierarchy_title>
		
					<hierarchy_sequence>
						<xsl:choose>
							<xsl:when test="Thesaurus_Klassifikation">
								<xsl:value-of select="Thesaurus_Klassifikation" />
								</xsl:when>
							<xsl:when test="Thesaurus_Akten">
								<xsl:value-of select="Thesaurus_Akten" />
								</xsl:when>
							</xsl:choose>
						</hierarchy_sequence>
					
					</hierarchyFields>
				</functions>
		
			</xsl:element>
			</xsl:if>
		</xsl:template>




	<xsl:template match="Datum-Erfassung">
		
		<xsl:variable name="filename">
			<xsl:choose>
				<xsl:when test="../Thesaurus_Klassifikation">
					<xsl:text>es_klassifikation.xml</xsl:text>
					</xsl:when>
				<xsl:when test="../Thesaurus_Akten">
					<xsl:text>def_klassifikation.xml</xsl:text>
					</xsl:when>
				</xsl:choose>
		</xsl:variable>
		
		<xsl:for-each select="document($filename)/addf//data">
			
			<xsl:element name="record">
			
		<vufind>
				<id>
					<xsl:value-of select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
					<xsl:value-of select="translate(@title,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
					<xsl:text>addf</xsl:text>
					</id>
				<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
				<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
				<recordType><xsl:text>systematics</xsl:text></recordType>	
				</vufind>

		<institution>
				<institutionShortname><xsl:text>Archiv der deutschen Frauenbewegung</xsl:text></institutionShortname>
				<institutionFull><xsl:text>Stiftung Archiv der deutschen Frauenbewegung</xsl:text></institutionFull>
				<institutionID><xsl:text>addf</xsl:text></institutionID>
				<collection><xsl:text>ADDF</xsl:text></collection>
				<isil><xsl:text>DE-Ks16</xsl:text></isil>
				<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/archiv-der-deutschen-frauenbewegung/</xsl:text></link>
				</institution>
			
		<dataset>
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
				<title>
					<xsl:value-of select="@id" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="@title" /></title>
				<title_short>
					<xsl:value-of select="@id" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="@title" />
					</title_short>
				</dataset>
			
		<functions>
				<hierarchyFields>
		
					<hierarchy_top_id>
						<xsl:value-of select="//addf/@id" /><xsl:text>addf</xsl:text>
						</hierarchy_top_id>
					<hierarchy_top_title>
						<xsl:value-of select="//addf/@title" />
						</hierarchy_top_title>
					
					<hierarchy_parent_id>
						<xsl:value-of select="translate(../@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
						<xsl:if test="../@title!=//addf/@title">
							<xsl:value-of select="translate(../@title,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
							</xsl:if>
						<xsl:text>addf</xsl:text>
						</hierarchy_parent_id>
					<hierarchy_parent_title>
						<xsl:if test="../@id!=//addf/@id">
							<xsl:value-of select="../@id"></xsl:value-of>
							<xsl:text> </xsl:text>
							</xsl:if>
						<xsl:value-of select="../@title" />
						</hierarchy_parent_title>
					
					<is_hierarchy_id>
						<xsl:value-of select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
						<xsl:value-of select="translate(@title,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHIJKLMNOPQRSTUVWXYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
						<xsl:text>addf</xsl:text>
						</is_hierarchy_id>
					<is_hierarchy_title>
						<xsl:value-of select="@id" />
						<xsl:text> </xsl:text>
						<xsl:value-of select="@title" />
						</is_hierarchy_title>
					
					
					<hierarchy_sequence>
						<xsl:value-of select="translate(@id,'1234567890.','1234567890')" />
						</hierarchy_sequence>
						
					</hierarchyFields>
				
				
				</functions>
			
			</xsl:element>
			
			</xsl:for-each>
		
		
			
		</xsl:template>


	

	

	</xsl:stylesheet>
