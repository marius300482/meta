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
			<!--<xsl:apply-templates select="Datensatz[1]/id" />-->
			</xsl:element>
		</xsl:template>
	
	
	<xsl:template match="Thesaurus">
		<xsl:element name="catalog">
			<xsl:apply-templates select="//concept" />
			<!--<xsl:apply-templates select="Datensatz[1]/id" />-->
			</xsl:element>
		</xsl:template>
	




<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->
<!--KLassifikation______________________Klassifikation-->


	<xsl:template match="concept">
		
		<xsl:element name="record">
			
			
			<xsl:variable name="top">
						<xsl:choose>
							<xsl:when test="not(broader)">
								<xsl:value-of select="notation" />
								</xsl:when>
							<xsl:when test="not(contains(broader,'.'))">
								<xsl:value-of select="broader" />
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="substring-before(broader,'.')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
					
					<xsl:variable name="broader" select="broader" />
			
			
		<vufind>
				<id>			
					<xsl:choose>
					
					<!--wenn kein Punkt in der Notation-->
						<xsl:when test="not(contains(notation,'.'))">
							<xsl:if test="useFor">
								<xsl:value-of select="normalize-space(substring-before(useFor[1],' '))"/>
								</xsl:if>
							<xsl:if test="not(useFor)">
								<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
								</xsl:if>
							
							
							<!--<xsl:choose>
								<xsl:when test="contains(prefTerm,'NL')">
									<xsl:text>NL</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'NL')" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SP')">
									<xsl:text>SP</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'SP')" />
									</xsl:when>
								<xsl:when test="contains(prefTerm,'ST')">
									<xsl:text>ST</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'ST')" />
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SK')">
									<xsl:text>SK</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'SK')" />
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
									</xsl:otherwise>
								</xsl:choose>-->
							</xsl:when>
					<!--andernfalls-->
						<xsl:otherwise>
							<xsl:value-of select="substring-before(//concept[notation=$top]/useFor[1],' ')" />
							<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
							<!--<xsl:choose>
								<xsl:when test="contains(prefTerm,'NL')">
									<xsl:text>NL</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'NL'))" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SP')">
									<xsl:text>SP</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'SP'))" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'ST')">
									<xsl:text>ST</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'ST'))" />
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SK')">
									<xsl:text>SK</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'SK'))" />
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
									</xsl:otherwise>
								</xsl:choose>-->
							
							</xsl:otherwise>
						</xsl:choose>
					<!--<xsl:text>_</xsl:text>-->
					<xsl:text>addf</xsl:text>
					</id>
				
				<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
				<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
				
				
				<recordType>
					<xsl:choose>
						<xsl:when test="not(contains(notation,'.'))">
							<xsl:text>archive</xsl:text>
							</xsl:when>
						<xsl:otherwise>
							<xsl:text>systematics</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</recordType>	
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
				
				<xsl:choose>
						<xsl:when test="not(contains(notation,'.'))">
							<xsl:choose>
								<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Themen')">
									<format>
										<xsl:text>Bestandsübersicht</xsl:text>
										</format>
									</xsl:when>
								<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Personen')">
									<format>
										<xsl:text>Bestandsübersicht</xsl:text>
										</format>
									</xsl:when>
								<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Körperschaften')">
									<format>
										<xsl:text>Bestandsübersicht</xsl:text>
										</format>
									</xsl:when>
								<xsl:otherwise>
									<format>
										<xsl:text>Nachlass / Vorlass</xsl:text>
										</format>
									</xsl:otherwise>
								</xsl:choose>
							
							
							</xsl:when>
						<xsl:otherwise>
							
							</xsl:otherwise>
						</xsl:choose>
				
				<xsl:apply-templates select="prefTerm" />
					
				</dataset>
			
		<functions>
				<hierarchyFields>
					
					<top><xsl:value-of select="$top"></xsl:value-of></top>
					
					<broader><xsl:value-of select="$broader"></xsl:value-of></broader>
			
			<!--hierarchy_top-->
					
					<hierarchy_top_id>
						
						<xsl:choose>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Personen')">
								<xsl:text>SammlungenPersonen</xsl:text>
								</xsl:when>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Themen')">
								<xsl:text>SammlungenThemen</xsl:text>
								</xsl:when>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Körperschaften')">
								<xsl:text>SammlungenKrperschaften</xsl:text>
								</xsl:when>
							<xsl:when test="not(broader)">
								<xsl:value-of select="normalize-space(substring-before(useFor[1],' '))"/>
								</xsl:when>
							<xsl:when test="broader">
								<xsl:value-of select="substring-before(//concept[notation=$top]/useFor[1],' ')" />
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
								</xsl:otherwise>
							</xsl:choose>
						
							<xsl:text>addf</xsl:text>
						
						</hierarchy_top_id>
					
					<hierarchy_top_title>
						
						<xsl:choose>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Personen')">
								<xsl:text>Sammlungen Personen</xsl:text>
								</xsl:when>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen Themen')">
								<xsl:text>Sammlungen Themen</xsl:text>
								</xsl:when>
							<xsl:when test="contains(//concept[1]/prefTerm,'Sammlungen c')">
								<xsl:text>Sammlungen Körperschaften</xsl:text>
								</xsl:when>
							<xsl:when test="not(broader)">
								<xsl:value-of select="prefTerm"></xsl:value-of>
								</xsl:when>
							<xsl:when test="broader">
								<xsl:value-of select="//concept[notation=$top]/prefTerm" />
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="prefTerm"></xsl:value-of>
								</xsl:otherwise>
							</xsl:choose>
						
					
						</hierarchy_top_title>
						
			<!--hierarchy_parent-->
					
					<xsl:if test="contains(notation,'.')">
					
						<hierarchy_parent_id>
							
							<xsl:choose>
								<xsl:when test="//concept[notation=$broader]/prefTerm='Sammlungen Körperschaften'">
									<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
									</xsl:when>
								<xsl:when test="//concept[notation=$broader]/prefTerm='Sammlungen Personen'">
									<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
									</xsl:when>
								<xsl:when test="//concept[notation=$broader]/prefTerm='Sammlungen Themen'">
									<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring-before(//concept[notation=$top]/useFor[1],' ')" />
									</xsl:otherwise>
								</xsl:choose>
							
							<xsl:if test="contains($broader,'.')">
								<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
								</xsl:if>
								
							<!--<xsl:choose>
								
								<xsl:when test="contains(//concept[notation=$broader]/prefTerm,'NL')">
									<xsl:text>NL</xsl:text>
									<xsl:value-of select="substring-after(//concept[notation=$top]/prefTerm,'NL')" />	
									
									</xsl:when>
								<xsl:when test="contains(//concept[notation=$broader]/prefTerm,'SP')">
									<xsl:text>SP</xsl:text>
									<xsl:value-of select="substring-after(//concept[notation=$broader]/prefTerm,'SP')" />	
									
									</xsl:when>
								<xsl:when test="contains(//concept[notation=$broader]/prefTerm,'ST')">
									<xsl:text>ST</xsl:text>
									<xsl:value-of select="substring-after(//concept[notation=$broader]/prefTerm,'ST')" />	
									
									</xsl:when>
								<xsl:when test="contains(//concept[notation=$broader]/prefTerm,'SK')">
									<xsl:text>SK</xsl:text>
									<xsl:value-of select="substring-after(//concept[notation=$broader]/prefTerm,'SK')" />	
									</xsl:when>
								
								<xsl:otherwise>
									<xsl:value-of select="translate(//concept[notation=$broader]/prefTerm, '. /äüö,', '')" />
									
									</xsl:otherwise>
								</xsl:choose>-->
								
								<xsl:text>addf</xsl:text>
							
							</hierarchy_parent_id>
					
						<hierarchy_parent_title>
							
							<xsl:value-of select="//concept[notation=$broader]/prefTerm" />
							
							</hierarchy_parent_title>
						
						</xsl:if>
			
			<!--is_hierarchy-->
					
					<is_hierarchy_id>
					
						<xsl:choose>
							<xsl:when test="not(contains(notation,'.'))">
								<xsl:if test="useFor">
									<xsl:value-of select="normalize-space(substring-before(useFor[1],' '))"/>
									</xsl:if>
								<xsl:if test="not(useFor)">
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
									</xsl:if>
							
							<!--<xsl:choose>
								<xsl:when test="contains(prefTerm,'NL')">
									<xsl:text>NL</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'NL')" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SP')">
									<xsl:text>SP</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'SP')" />
									</xsl:when>
								<xsl:when test="contains(prefTerm,'ST')">
									<xsl:text>ST</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'ST')" />
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SK')">
									<xsl:text>SK</xsl:text>
									<xsl:value-of select="substring-after(prefTerm,'ST')" />
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
									</xsl:otherwise>
								</xsl:choose>-->		
							</xsl:when>
						
						<xsl:otherwise>
							
							<xsl:value-of select="substring-before(//concept[notation=$top]/useFor[1],' ')" />
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
							
							<!--<xsl:choose>
								<xsl:when test="contains(prefTerm,'NL')">
									<xsl:text>NL</xsl:text>
									<xsl:value-of select="substring-after(//concept[notation=$top]/prefTerm,'NL')" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SP')">
									<xsl:text>SP</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'SP'))" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'ST')">
									<xsl:text>ST</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'ST'))" />	
									</xsl:when>
								<xsl:when test="contains(prefTerm,'SK')">
									<xsl:text>SK</xsl:text>
									<xsl:value-of select="normalize-space(substring-after(translate(prefTerm, '. /äüö,', ''),'SK'))" />	
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="substring-before(//concept[notation=$top]/useFor[1],' ')" />
									<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"></xsl:value-of>
									</xsl:otherwise>
								</xsl:choose>-->
							
							</xsl:otherwise>
						</xsl:choose>
						
						<xsl:text>addf</xsl:text>
					
						</is_hierarchy_id>
					
					<is_hierarchy_title>
						<xsl:value-of select="normalize-space(prefTerm)" />
						</is_hierarchy_title>
					
					
					<hierarchy_sequence>
						<xsl:value-of select="translate(prefTerm, translate(.,'0123456789', ''), '')"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="translate(prefTerm, '. /äüö,', '')"/>
						</hierarchy_sequence>
						
					</hierarchyFields>
				
				
				</functions>
			
			</xsl:element>
		
		</xsl:template>
	
	
	
	
	
	
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
<!--Datensatz__________________________Datensatz-->
	
	
	

	<xsl:template match="Datensatz">
		
		<xsl:if test="id">
		
		<xsl:element name="record">
		
		<vufind>
				<id><xsl:value-of select="id" /><xsl:text>addf</xsl:text></id>
				<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
				<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
				
				<xsl:choose>
					<xsl:when test="Objektart[text()='Periodika']">
						<recordType><xsl:text>library</xsl:text></recordType>	
						</xsl:when>
					<xsl:when test="Objektart[text()='Monografien/Aufsätze']">
						<recordType><xsl:text>library</xsl:text></recordType>	
						</xsl:when>
					<xsl:otherwise>
						<recordType><xsl:text>archive</xsl:text></recordType>	
						</xsl:otherwise>
					</xsl:choose>
				
						
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

<!--Format-->

				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
				
				<xsl:choose>
					<xsl:when test="Quellenang_x046x__x032x_Hochschulschriften">
						<format><xsl:text>Hochschulschrift</xsl:text></format>
						</xsl:when>
					<xsl:when test="Quellenang_x046x__x032x_Monographien">
						<format><xsl:text>Buch</xsl:text></format>
						</xsl:when>
					<xsl:when test="Quellenangabe_x032x_Aufsätze">
						<format><xsl:text>Artikel</xsl:text></format>
						</xsl:when>
					<xsl:when test="//id[1]='11630'">
						<format><xsl:text>Buch</xsl:text></format>
						</xsl:when>
					<xsl:when test="Objektart[text()='Periodika']">
						<format><xsl:text>Zeitschrift</xsl:text></format>
						</xsl:when>
					<xsl:otherwise>
						<format><xsl:text>Akte</xsl:text></format>
						</xsl:otherwise>
					</xsl:choose>
				
	<!--documentType-->	
				<xsl:apply-templates select="Thesaurus_x032x_Literaturart[string-length() != 0]" />

<!--TITLE-->
	
	<!--title Titelinformationen-->	
		
				<xsl:apply-templates select="Titel[string-length() != 0]" />
				<xsl:apply-templates select="Hauptsachtitel[string-length() != 0]" />
				<xsl:apply-templates select="Zusatz_x032x_zum_x032x_Hauptsachtitel[string-length() != 0]" />
				<xsl:apply-templates select="Zeitschriftentitel[1][string-length() != 0]" />
				<xsl:apply-templates select="Zeitschriftenuntertitel[string-length() != 0]" />

<!--RESPONSIBLE-->

			<!--author Autorinneninformation-->
				<xsl:apply-templates select="VerfasserIn[string-length() != 0]" />
			
			<!--editor-->
				<xsl:apply-templates select="HerausgeberIn[string-length() != 0]" />
			
			<!--contributor-->
				<xsl:apply-templates select="beteiligte_x032x_Personen[string-length() != 0]" />
				
			<!--entity-->
				<xsl:apply-templates select="Text_x032x_Körperschaften[string-length() != 0]" />

			<!--series-->
				<xsl:apply-templates select="Ges_x046x_Titel_x032x_mehrt_x046x_begrenz_x046x_Werk[string-length() != 0]" />
				<xsl:apply-templates select="Ges_x046x_Titel_x032x_fortl_x046x__x032x_Werk_x032x_I[string-length() != 0]" />
	
<!--IDENTIFIER-->
			<!--isbn-->	
				<xsl:apply-templates select="ISBN[string-length() != 0]" />
				
			<!--isbn-->	
				<xsl:apply-templates select="ISSN[string-length() != 0]" />
			
			<!--zdbId-->	
				<xsl:apply-templates select="ZDB-ID[string-length() != 0]" />
		
<!--PUBLISHING-->
			
			<!--jahr-->
				<xsl:apply-templates select="Jahr_x047x_Datierung[1][string-length() != 0]" />			

			<!--ort-->
				<xsl:apply-templates select="Erscheinungsort[string-length() != 0]" />	
			
			<!--verlag-->
				<xsl:apply-templates select="Verlag[string-length() != 0]" />	
			
			<!--ort/verlag-->
				<!--<xsl:apply-templates select="Ersch_Ort_Verlag[string-length() != 0]" />	-->
			
			<!--edition Ausgabe-->
				<xsl:apply-templates select="Ausgabebezeichnung[string-length() != 0]" />	

			<!--Quellenangabe-->
				<!--<xsl:apply-templates select="Quellenang_x046x__x032x_Hochschulschriften[string-length() != 0]" />
				<xsl:apply-templates select="Quellenang_x046x__x032x_Monographien[string-length() != 0]" />
				<xsl:apply-templates select="Quellenangabe_x032x_Aufsätze[string-length() != 0]" />-->
				
<!--PHYSICAL INFORMATION-->
			
			<!--physical Seitenangabe-->
				<xsl:apply-templates select="Umfang_x047x_Format[string-length() != 0]" />	
				
				

<!--CONTENTRELATED INFORMATION-->
			
			<!--topics-->
				<xsl:apply-templates select="Thesaurus_x032x_Schlagworte[string-length() != 0]" />	
				<xsl:apply-templates select="Text_x032x_Personen[string-length() != 0]" />	
				<xsl:apply-templates select="Thesaurus_x032x_Region[string-length() != 0]" />	
				
			<!--description-->
					
				<xsl:apply-templates select="Bestandsbeschreibung[string-length() != 0]" />
				<xsl:apply-templates select="Enthält[1][string-length() != 0]" />
				
			<!--weitere Anmerkungen-->
			
				<xsl:apply-templates select="Tagesdatum" />	
				<!--<xsl:apply-templates select="Fu_x225x_noten[string-length() != 0]" />	-->
				<!--<xsl:apply-templates select="Beigefügte_x032x_Werke[string-length() != 0]" />	-->
			
			<!--Bestandsangabe-->
				<xsl:apply-templates select="Bestand[string-length() != 0]" />	
				<xsl:apply-templates select="Bestand_x032x_-_x032x_Hefttitel[string-length() != 0]" />	
				
				
				<xsl:if test="Signatur">
					<shelfMark><xsl:value-of select="Signatur" /></shelfMark>
					</xsl:if>
				
				</dataset>
	
	<xsl:if test="(not(Objektart[text()='Monografien/Aufsätze'])) and (not(Objektart[text()='Periodika']))">
		
			<functions>
				
				<xsl:variable name="topId" select="//id[1]" />
				
				<hierarchyFields>
		
					<hierarchy_top_id>
						
						<xsl:choose>
							<xsl:when test="$topId='11181'">
								<xsl:text>SammlungenPersonen</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='11184'">
								<xsl:text>SammlungenThemen</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='11198'">
								<xsl:text>SammlungenKrperschaften</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='18769'">
								<xsl:choose>
									<xsl:when test="contains(Signatur,';')">
										<xsl:value-of select="normalize-space(substring-before(Signatur,';'))" />
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(Signatur)"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Akten">
								<xsl:value-of select="translate(Thesaurus_x032x_Akten[1], '. /äüö,', '')" />				
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Klassifikation">
								<xsl:value-of select="translate(Thesaurus_x032x_Klassifikation[1], '. /äüö,', '')" />				
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(Signatur)" />
								</xsl:otherwise>
							</xsl:choose>
						
					
						<xsl:text>addf</xsl:text>
						
						</hierarchy_top_id>
				
					<hierarchy_top_title>
						
						<xsl:choose>
							<xsl:when test="$topId='11181'">
								<xsl:text>Sammlungen Personen</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='11184'">
								<xsl:text>Sammlungen Themen</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='11198'">
								<xsl:text>Sammlungen Körperschaften</xsl:text>
								</xsl:when>
							<xsl:when test="$topId='18769'">
								<xsl:value-of select="normalize-space(substring-before(Signatur,';'))" />
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Klassifikation">
								<xsl:value-of select="Thesaurus_x032x_Klassifikation" />				
								</xsl:when>
							<xsl:when test="contains(Signatur,';')">
								<xsl:value-of select="normalize-space(substring-before(Signatur,';'))" />
								</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="normalize-space(Signatur)" />
								</xsl:otherwise>
							</xsl:choose>
						
						
						</hierarchy_top_title>
						
					<hierarchy_parent_id>
						
						<xsl:choose>
							<xsl:when test="Thesaurus_x032x_Akten">
								<xsl:choose>
									<xsl:when test="contains(Signatur,';')">
										<xsl:value-of select="normalize-space(substring-before(Signatur,';'))" />
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(Signatur)"/>
										</xsl:otherwise>
									</xsl:choose>
								<xsl:value-of select="translate(Thesaurus_x032x_Akten[1], '. /äüö,', '')" />			
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Klassifikation">
								<xsl:choose>
									<xsl:when test="contains(Signatur,';')">
										<xsl:value-of select="normalize-space(substring-before(Signatur,';'))" />
										</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(Signatur)"/>
										</xsl:otherwise>
									</xsl:choose>
								<xsl:value-of select="translate(Thesaurus_x032x_Klassifikation, '. /äüö,', '')" />			
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Körperschaften">
								<xsl:value-of select="translate(Thesaurus_x032x_SL_x032x_Körperschaften, '. /äüö,', '')" />	
								<!--<xsl:text>SK</xsl:text>
								<xsl:value-of select="substring-after(Thesaurus_x032x_SL_x032x_Körperschaften,'SK')"/>-->
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Personen">
								<xsl:value-of select="translate(Thesaurus_x032x_SL_x032x_Personen, '. /äüö,', '')" />	
								<!--<xsl:text>SP</xsl:text>
								<xsl:value-of select="substring-after(Thesaurus_x032x_SL_x032x_Personen,'SP')"/>-->
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Themen">
								<xsl:value-of select="translate(Thesaurus_x032x_SL_x032x_Themen, '. /äüö,', '')" />	
								<!--<xsl:text>ST</xsl:text>
								<xsl:value-of select="substring-after(Thesaurus_x032x_SL_x032x_Themen,'ST')"/>-->
								</xsl:when>
							</xsl:choose>
							
							<xsl:text>addf</xsl:text>
							
						</hierarchy_parent_id>
					
					<hierarchy_parent_title>
						
						<xsl:choose>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Körperschaften">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Körperschaften" />			
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Personen">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Personen" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Themen">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Themen" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Akten">
								<xsl:value-of select="Thesaurus_x032x_Akten" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Klassifikation">
								<xsl:value-of select="Thesaurus_x032x_Klassifikation" />		
								</xsl:when>
							</xsl:choose>
							
						</hierarchy_parent_title>
						
					<is_hierarchy_id>
						<xsl:value-of select="id" />
						<xsl:text>addf</xsl:text>
						</is_hierarchy_id>
					
					<is_hierarchy_title>
						<xsl:value-of select="Titel" />
						</is_hierarchy_title>
		
					<hierarchy_sequence>
						<xsl:choose>
							<xsl:when test="Thesaurus_x032x_Akten">
								<xsl:value-of select="Thesaurus_x032x_Akten" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_Klassifikation">
								<xsl:value-of select="Thesaurus_x032x_Klassifikation" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Körperschaften">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Körperschaften" />			
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Personen">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Personen" />		
								</xsl:when>
							<xsl:when test="Thesaurus_x032x_SL_x032x_Themen">
								<xsl:value-of select="Thesaurus_x032x_SL_x032x_Themen" />		
								</xsl:when>
							</xsl:choose>
						</hierarchy_sequence>
					
					</hierarchyFields>
				</functions>
		</xsl:if>		
			</xsl:element>
			</xsl:if>
		</xsl:template>












	
	
	
	<xsl:template match="Ges_x046x_Titel_x032x_fortl_x046x__x032x_Werk_x032x_I">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>

	<xsl:template match="Ges_x046x_Titel_x032x_mehrt_x046x_begrenz_x046x_Werk">
		<series>
			<xsl:value-of select="normalize-space(.)" />
			</series>
		</xsl:template>

	<xsl:template match="Bestand">
		<collectionHolding>
			<xsl:value-of select="normalize-space(.)" />
			</collectionHolding>
		</xsl:template>
	
	<xsl:template match="ZDB-ID">
		<zdbId>
			<xsl:value-of select="normalize-space(.)" />
			</zdbId>
		</xsl:template>
	
	<xsl:template match="ISSN">
		<issn>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</issn>
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))" />
			</isbn>
		</xsl:template>
	
	<xsl:template match="Quellenangabe_x032x_Aufsätze">
		<xsl:choose>
			<xsl:when test="contains(.,'Aus')">
				<sourceInfo>
					<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
					</sourceInfo>
				</xsl:when>
			<xsl:when test="contains(.,'aus')">
				<sourceInfo>
					<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
					</sourceInfo>
				</xsl:when>
			<xsl:otherwise>
				<sourceInfo>
					<xsl:value-of select="normalize-space(.)" />
					</sourceInfo>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Quellenang_x046x__x032x_Monographien">
		<sourceInfo>
			<xsl:value-of select="normalize-space(.)" />
			</sourceInfo>
		</xsl:template>
	
	<xsl:template match="Quellenang_x046x__x032x_Hochschulschriften">
		<sourceInfo>
			<xsl:value-of select="normalize-space(.)" />
			</sourceInfo>
		</xsl:template>
	
	<xsl:template match="Thesaurus_x032x_Literaturart">
		<documentType>
			<xsl:value-of select="normalize-space(.)" />
			</documentType>
		</xsl:template>
	
	<xsl:template match="Text_x032x_Körperschaften">
		<entity>
			<xsl:value-of select="normalize-space(.)" />
			</entity>
		</xsl:template>

	<xsl:template match="Thesaurus_x032x_Region">
		<subjectGeographic>
			<xsl:value-of select="normalize-space(.)" />
			</subjectGeographic>
		</xsl:template>

	<xsl:template match="Text_x032x_Personen">
		<subjectPerson>
			<xsl:value-of select="normalize-space(.)" />
			</subjectPerson>
		</xsl:template>

	<xsl:template match="Thesaurus_x032x_Schlagworte">
		<subjectTopic>
			<xsl:value-of select="normalize-space(replace(.,'_',''))" />
			</subjectTopic>
		</xsl:template>

	<xsl:template match="Ausgabebezeichnung">
		<edition>
			<xsl:value-of select="normalize-space(.)" />
			</edition>
		</xsl:template>

	<xsl:template match="Verlag">
		<publisher>
			<xsl:value-of select="normalize-space(.)" />
			</publisher>
		</xsl:template>

	<xsl:template match="Erscheinungsort">
		<placeOfPublication>
			<xsl:value-of select="normalize-space(.)" />
			</placeOfPublication>
		</xsl:template>
	
	<xsl:template match="Tagesdatum">
		
		<xsl:variable name="annotation">
			<xsl:text>beigefuegt:</xsl:text>
				<xsl:value-of select="../Beigefügte_x032x_Werke" />
				<xsl:text>:beigefuegt</xsl:text>
			<xsl:text>enthalten:</xsl:text>
				<xsl:value-of select="../Enthaltene_x032x_Werke" />
				<xsl:text>:enthalten</xsl:text>
			<xsl:text>vermerke:</xsl:text>
				<xsl:value-of select="../Fu_x225x_noten" />
				<xsl:text>:vermerke</xsl:text>
			<xsl:text>erschienen:</xsl:text>
				<xsl:value-of select="../Ersch_Ort_Verlag" />
				<xsl:text>:erschienen</xsl:text>
			<xsl:text>beigaben:</xsl:text>
				<xsl:value-of select="../Beigaben" />
				<xsl:text>:beigaben</xsl:text>
			<xsl:text>quelle_aufsatz:</xsl:text>
				<xsl:value-of select="../Quellenangabe_x032x_Aufsätze" />
				<xsl:text>:quelle_aufsatz</xsl:text>
			<xsl:text>quelle_mono:</xsl:text>
				<xsl:value-of select="../Quellenang_x046x__x032x_Monographien" />
				<xsl:text>:quelle_mono</xsl:text>
			<xsl:text>quelle_uni:</xsl:text>
				<xsl:value-of select="../Quellenang_x046x__x032x_Hochschulschriften" />
				<xsl:text>:quelle_uni</xsl:text>
			<xsl:text>erscheinungszeitraum:</xsl:text>
				<xsl:value-of select="../Quellenang_x046x__x032x_Hochschulschriften" />
				<xsl:text>:erscheinungszeitraum</xsl:text>
			<xsl:text>bestand_hefttitel:</xsl:text>
				<xsl:value-of select="../Bestand_x032x_-_x032x_Hefttitel" />
				<xsl:text>:bestand_hefttitel</xsl:text>
			
			</xsl:variable>
		
		<xsl:if test="(substring(substring-after($annotation,'beigefuegt:'),1,1)!=':') or 
		(substring(substring-after($annotation,'enthalten:'),1,1)!=':') or 
		(substring(substring-after($annotation,'bestand_hefttitel:'),1,1)!=':')">
		<listOfContents>
			<xsl:if test="substring(substring-after($annotation,'beigefuegt:'),1,1)!=':'">
				<xsl:text>Beigefügte Werke: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'beigefuegt:'),':beigefuegt')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'enthalten:'),1,1)!=':'">
				<xsl:text>Enthaltene Werke: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'enthalten:'),':enthalten')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'bestand_hefttitel:'),1,1)!=':'">
				<xsl:text>Bestand Hefttitel: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'bestand_hefttitel:'),':bestand_hefttitel')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			</listOfContents>
			</xsl:if>
		
		
		<annotation>
			<xsl:if test="substring(substring-after($annotation,'vermerke:'),1,1)!=':'">
				<xsl:text>Vermerke: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'vermerke:'),':vermerke')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'erschienen:'),1,1)!=':'">
				<xsl:text>Erscheinungsvermerk: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'erschienen:'),':erschienen')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'beigaben:'),1,1)!=':'">
				<xsl:text>Beigaben: </xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'beigaben:'),':beigaben')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'quelle_aufsatz:'),1,1)!=':'">
				<xsl:text>Quellenangabe Aufsatz:&lt;br /&gt;</xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'quelle_aufsatz:'),':quelle_aufsatz')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'quelle_mono:'),1,1)!=':'">
				<xsl:text>Quellenangabe Monographie:&lt;br /&gt;</xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'quelle_mono:'),':quelle_mono')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'quelle_uni:'),1,1)!=':'">
				<xsl:text>Quellenangabe Monographie:&lt;br /&gt;</xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'quelle_uni:'),':quelle_uni')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			<xsl:if test="substring(substring-after($annotation,'erscheinungszeitraum:'),1,1)!=':'">
				<xsl:text>Erscheinungszeitraum:&lt;br /&gt;</xsl:text>
				<xsl:value-of select="substring-before(substring-after($annotation,'erscheinungszeitraum:'),':erscheinungszeitraum')" />
				<xsl:text>&lt;p/&gt;</xsl:text>
				</xsl:if>
			</annotation>
		</xsl:template>
	
	<xsl:template match="Fu_x225x_noten">
		<xsl:if test="Ersch_Ort_Verlag[string-length() = 0]">
		<annotation>
			<xsl:value-of select="normalize-space(.)" />
			</annotation>
			</xsl:if>
		</xsl:template>
	
	<xsl:template match="Ersch_Ort_Verlag">
		<annotation>
			<xsl:text>Ort / Verlag: </xsl:text>
			<xsl:value-of select="normalize-space(.)" />
			<xsl:if test="../Fu_x225x_noten[string-length() != 0]">
				<xsl:text> Fußnoten: </xsl:text>
				<xsl:value-of select="../Fu_x225x_noten"/>
				</xsl:if>
			</annotation>
		</xsl:template>
	
	<xsl:template match="beteiligte_x032x_Personen">
		<contributor>
			<xsl:value-of select="normalize-space(.)" />
			</contributor>
		</xsl:template>
	
	<xsl:template match="HerausgeberIn">
		<editor>
			<xsl:value-of select="normalize-space(.)" />
			</editor>
		</xsl:template>
	
	<xsl:template match="VerfasserIn">
		<xsl:for-each select="tokenize(.,';')">
		<author>
			<xsl:value-of select="normalize-space(.)" />
			</author>
			</xsl:for-each>
		</xsl:template>
	
	<xsl:template match="Bestandsbeschreibung">
		<description>
			<xsl:value-of select="." />
			<xsl:if test="../Enthält[string-length() != 0]">
				<xsl:text> Enthält: </xsl:text>
				<xsl:value-of select="../Enthält"/>
				</xsl:if>
			</description>
		</xsl:template>

	<xsl:template match="Enthält">
		<xsl:if test="not(../Bestandsbeschreibung)">
		<description>
			<xsl:for-each select="../Enthält">
				<xsl:value-of select="normalize-space(.)" />
				</xsl:for-each>
			</description>
			</xsl:if>
		</xsl:template>

	<xsl:template match="Umfang_x047x_Format">
		<xsl:choose>
			<xsl:when test="../Objektart[text()='Monografien/Aufsätze']">
				<physical>
					<xsl:value-of select="translate(., translate(.,'0123456789', ''), '')"/>
					</physical>
				</xsl:when>
			<xsl:otherwise>
				<physical>
					<xsl:value-of select="normalize-space(.)" />
					</physical>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>

	<xsl:template match="Jahr_x047x_Datierung">
		<displayPublishDate>
			<xsl:for-each select="../Jahr_x047x_Datierung">
				<xsl:value-of select="normalize-space(.)" />
				<xsl:if test="not(position()=last())">
					<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</displayPublishDate>
					
					
			<xsl:for-each select="../Jahr_x047x_Datierung">
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
		</xsl:template>
	
	<xsl:template match="prefTerm">
		<title><xsl:value-of select="normalize-space(.)" /></title>
		<title_short><xsl:value-of select="normalize-space(.)" /></title_short>
		</xsl:template>
	
	<xsl:template match="Titel">
		<title><xsl:value-of select="normalize-space(.)" /></title>
		<title_short><xsl:value-of select="normalize-space(.)" /></title_short>
		</xsl:template>
	
	<xsl:template match="Hauptsachtitel">
		<title><xsl:value-of select="normalize-space(.)" /></title>
		<title_short><xsl:value-of select="normalize-space(.)" /></title_short>
		</xsl:template>

	<xsl:template match="Zeitschriftentitel">
		<title><xsl:value-of select="normalize-space(replace(.,'_',''))" /></title>
		<title_short><xsl:value-of select="normalize-space(replace(.,'_',''))" /></title_short>
		</xsl:template>

	<xsl:template match="Zusatz_x032x_zum_x032x_Hauptsachtitel">
		<title_sub><xsl:value-of select="normalize-space(.)" /></title_sub>
		</xsl:template>
		
	<xsl:template match="Zeitschriftenuntertitel">
		<title_sub><xsl:value-of select="normalize-space(.)" /></title_sub>
		</xsl:template>
	

	</xsl:stylesheet>
