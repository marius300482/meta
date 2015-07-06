<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Mon Feb 10 14:12:20 CET 2014 -->

<xsl:stylesheet version="2.0" exclude-result-prefixes="xs xdt err fn" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:err="http://www.w3.org/2005/xqt-errors">
	
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="ead[@audience='external']">
	
	
	
	<catalog>
		
		<xsl:element name="record">
		<xsl:attribute name="id">
			<xsl:value-of select="translate(archdesc/did/unitid,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
			<xsl:text>hla</xsl:text>
			</xsl:attribute>
			
			<!--<field name="allfields">
				<xsl:value-of select="archdesc/did/unittitle"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="archdesc/did/unitid" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="archdesc/scopecontent/p"/>
				</field>-->
			
		<vufind>
			<id>
				<xsl:value-of select="translate(archdesc/did/unitid,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
				<xsl:text>hla</xsl:text>
				</id>
			
			<recordCreationDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordCreationDate>
			
			<recordChangeDate>
				<xsl:value-of select="current-dateTime()"/>
				</recordChangeDate>
	
			<recordType>
				<xsl:text>archive</xsl:text>
				</recordType>			
			
			</vufind>
		
		<institution>
			
			<institutionShortname><xsl:text>Helene-Lange-Archiv</xsl:text></institutionShortname>
			<institutionFullname><xsl:text>Helene-Lange-Archiv im Landesarchiv Berlin</xsl:text></institutionFullname>
			<institutionID>hla</institutionID>
			<collection><xsl:text>HLA Archiv</xsl:text></collection>
			<isil><xsl:text>DE-B724</xsl:text></isil>
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/helene-lange-archiv/</xsl:text></link>
			<geoLocation>
				<latitude>52.5186360</latitude>
				<longitude>13.3761550</longitude>
				</geoLocation>
			
			</institution>
		
		<dataset>
			
			 <typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
			<format><xsl:text>Nachlass / Vorlass</xsl:text></format>
			
			<title><xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text></title>
			<title_short><xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text></title_short>
			
			<physical><xsl:value-of select="archdesc/bibliography/p" /></physical>
			<language><xsl:value-of select="eadheader/profiledesc/langusage" /></language>
			<description><xsl:value-of select="archdesc/scopecontent/p"/></description>
			
			<shelfMark><xsl:value-of select="archdesc/did/unitid" /></shelfMark>
			
			</dataset>
		
		
		<functions>
			
			<hierarchyFields>
				<hierarchy_top_id><xsl:value-of select="translate(archdesc/did/unitid,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
				<xsl:text>hla</xsl:text></hierarchy_top_id>
				<hierarchy_top_title><xsl:text>Bund Deutscher Frauenvereine (BDF)</xsl:text></hierarchy_top_title>
				</hierarchyFields>
			
			</functions>
			
		</xsl:element>
		
		
<!--Ebene ______1__________________1_________________1_______________1______________ 1-->
<!--Ebene ______1__________________1_________________1_______________1______________ 1-->
<!--Ebene ______1__________________1_________________1_______________1______________ 1-->

		<xsl:for-each select="/ead/archdesc/dsc/c01[@level='class']">
			
			<xsl:element name="record">
			
				<vufind>
					<id>
						<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
						<xsl:text>hla</xsl:text>
					</id>
			
					<recordCreationDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordCreationDate>
			
					<recordChangeDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordChangeDate>
	
					<recordType>
						<xsl:text>systematics</xsl:text>
						</recordType>			
			
					</vufind>
		
				<institution>
			
					<institutionShortname><xsl:text>Helene-Lange-Archiv</xsl:text></institutionShortname>
					<institutionFullname><xsl:text>Helene-Lange-Archiv im Landesarchiv Berlin</xsl:text></institutionFullname>
					<collection><xsl:text>HLA Archiv</xsl:text></collection>
					<isil><xsl:text>DE-B724</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/helene-lange-archiv/</xsl:text></link>
					<geoLocation>
						<latitude>52.5186360</latitude>
						<longitude>13.3761550</longitude>
						</geoLocation>
			
					</institution>
					
				<dataset>
			
					 <typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
					<!--<format><xsl:text>Nachlass / Vorlass</xsl:text></format>-->
			
					<title><xsl:value-of select="did/unittitle" /></title>
					<title_short><xsl:value-of select="did/unittitle"/></title_short>
			
					<!--<physical><xsl:value-of select="archdesc/bibliography/p" /></physical>
					<language><xsl:value-of select="eadheader/profiledesc/langusage" /></language>-->
					<!--<description><xsl:value-of select="archdesc/scopecontent/p"/></description>-->
			
					<!--<shelfMark><xsl:value-of select="archdesc/did/unitid" /></shelfMark>-->
			
					</dataset>
					
				<functions>
			
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:text>BRep23501hla</xsl:text>
							</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text>
							</hierarchy_top_title>
						
						<hierarchy_parent_id>
							<xsl:text>BRep23501hla</xsl:text>
							</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text>
							</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:text>hla</xsl:text>
							</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="did/unittitle" />
							</is_hierarchy_title>
						
						<hierarchy_sequence>
							<xsl:value-of select="substring(did/unittitle,1,5)"/>
							</hierarchy_sequence>
						
						</hierarchyFields>
			
					</functions>
				
				</xsl:element>
		
		</xsl:for-each>
	
	
<!--Ebene ______2__________________2_________________2_______________2______________ 2-->
<!--Ebene ______2__________________2_________________2_______________2______________ 2-->
<!--Ebene ______2__________________2_________________2_______________2______________ 2-->
		
		<xsl:for-each select="/ead/archdesc/dsc/c01[@level='class']/c02[@level='class']">
			
			<xsl:element name="record">
			
				<vufind>
					<id>
						<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
						<xsl:text>hla</xsl:text>
					</id>
			
					<recordCreationDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordCreationDate>
			
					<recordChangeDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordChangeDate>
	
					<recordType>
						<xsl:text>systematics</xsl:text>
						</recordType>			
			
					</vufind>
		
				<institution>
			
					<institutionShortname><xsl:text>Helene-Lange-Archiv</xsl:text></institutionShortname>
					<institutionFullname><xsl:text>Helene-Lange-Archiv im Landesarchiv Berlin</xsl:text></institutionFullname>
					<collection><xsl:text>HLA Archiv</xsl:text></collection>
					<isil><xsl:text>DE-B724</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/helene-lange-archiv/</xsl:text></link>
					<geoLocation>
						<latitude>52.5186360</latitude>
						<longitude>13.3761550</longitude>
						</geoLocation>
			
					</institution>
					
				<dataset>
			
					 <typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
					<!--<format><xsl:text>Nachlass / Vorlass</xsl:text></format>-->
			
					<title><xsl:value-of select="did/unittitle" /></title>
					<title_short><xsl:value-of select="did/unittitle"/></title_short>
			
					<!--<physical><xsl:value-of select="archdesc/bibliography/p" /></physical>
					<language><xsl:value-of select="eadheader/profiledesc/langusage" /></language>-->
					<!--<description><xsl:value-of select="archdesc/scopecontent/p"/></description>-->
			
					<!--<shelfMark><xsl:value-of select="archdesc/did/unitid" /></shelfMark>-->
			
					</dataset>
					
				<functions>
			
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:text>BRep23501hla</xsl:text>
							</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text>
							</hierarchy_top_title>
						
						<hierarchy_parent_id>
							<xsl:value-of select="translate(../did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:text>hla</xsl:text>
							</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:value-of select="../did/unittitle"/>
							</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:text>hla</xsl:text>
							</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="did/unittitle" />
							</is_hierarchy_title>
						
						<hierarchy_sequence>
							<xsl:value-of select="substring(did/unittitle,1,5)"/>
							</hierarchy_sequence>
						
						</hierarchyFields>
			
					</functions>
				
				</xsl:element>

			</xsl:for-each>

		
<!--Ebene ______File__________________File_________________File_______________File______________File-->
<!--Ebene ______File__________________File_________________File_______________File______________File-->
<!--Ebene ______File__________________File_________________File_______________File______________File-->
	
		<xsl:for-each select="/ead/archdesc/dsc/c01/c02[@level='file']">
			
			<xsl:element name="record">
			
				<vufind>
					<id>
						<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
						<xsl:text>hla</xsl:text>
					</id>
			
					<recordCreationDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordCreationDate>
			
					<recordChangeDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordChangeDate>
	
					<recordType>
						<xsl:text>systematics</xsl:text>
						</recordType>			
			
					</vufind>
		
				<institution>
			
					<institutionShortname><xsl:text>Helene-Lange-Archiv</xsl:text></institutionShortname>
					<institutionFullname><xsl:text>Helene-Lange-Archiv im Landesarchiv Berlin</xsl:text></institutionFullname>
					<collection><xsl:text>HLA Archiv</xsl:text></collection>
					<isil><xsl:text>DE-B724</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/helene-lange-archiv/</xsl:text></link>
					<geoLocation>
						<latitude>52.5186360</latitude>
						<longitude>13.3761550</longitude>
						</geoLocation>
			
					</institution>
					
				<dataset>
			
					 <typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
					<format><xsl:text>Akte</xsl:text></format>
			
					<title><xsl:value-of select="did/unittitle" /></title>
					<title_short><xsl:value-of select="did/unittitle"/></title_short>
					
					<displayPublishDate>
						<xsl:value-of select="did/unitdate" />
						</displayPublishDate>
					
					<xsl:for-each select="tokenize(did/unitdate, ',')">	
						<xsl:choose>
							<xsl:when test="contains(.,'-')">
								<xsl:for-each select="tokenize(.,'-')">
									<publishDate>
										<xsl:value-of select="normalize-space(.)"/>
										</publishDate>
									</xsl:for-each>
								</xsl:when>
							<xsl:otherwise>
								<publishDate>
									<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))"/>
									</publishDate>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					
					<xsl:if test="did/physdesc/extent!='(...)'">
						<physical><xsl:value-of select="normalize-space(translate(did/physdesc/extent, translate(.,'0123456789', ''), ''))"/></physical>
						</xsl:if>
						
					<xsl:variable name="enthaelt" select="normalize-space(did/abstract[@type='Enthält'])" />
					<xsl:variable name="darin" select="normalize-space(did/abstract[@type='Darin'])" />
					
					<xsl:if test="(not(contains($enthaelt, '(...)'))) or (not(contains($darin, '(...)')))">
						<description>
							<xsl:if test="not(contains($enthaelt, '(...)'))">
								
								<xsl:value-of select="$enthaelt"/>
								</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:if test="not(contains($darin, '(...)'))">
								
								<xsl:value-of select="$darin"/>
								</xsl:if>
							</description>
						</xsl:if>
			
					</dataset>
					
				<functions>
			
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:text>BRep23501hla</xsl:text>
							</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text>
							</hierarchy_top_title>
						
						<hierarchy_parent_id>
							<xsl:value-of select="translate(../did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:text>hla</xsl:text>
							</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:value-of select="../did/unittitle"/>
							</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:value-of select="did/unitid[@type='v.num']"/>
							<xsl:text>hla</xsl:text>
							</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="did/unittitle" />
							</is_hierarchy_title>
						
						<hierarchy_sequence>
							<xsl:value-of select="substring(did/unittitle,1,5)"/>
							</hierarchy_sequence>
						
						</hierarchyFields>
			
					</functions>
				
				</xsl:element>
			
			</xsl:for-each>
	
<!--Ebene ______File__________________File_________________File_______________File______________File-->
<!--Ebene ______File__________________File_________________File_______________File______________File-->
<!--Ebene ______File__________________File_________________File_______________File______________File-->
	
		<xsl:for-each select="/ead/archdesc/dsc/c01/c02/c03[@level='file']">
			
			<xsl:element name="record">
			
				<vufind>
					<id>
						<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
						<xsl:text>hla</xsl:text>
					</id>
			
					<recordCreationDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordCreationDate>
			
					<recordChangeDate>
						<xsl:value-of select="current-dateTime()"/>
						</recordChangeDate>
	
					<recordType>
						<xsl:text>archive</xsl:text>
						</recordType>			
			
					</vufind>
		
				<institution>
			
					<institutionShortname><xsl:text>Helene-Lange-Archiv</xsl:text></institutionShortname>
					<institutionFullname><xsl:text>Helene-Lange-Archiv im Landesarchiv Berlin</xsl:text></institutionFullname>
					<collection><xsl:text>HLA Archiv</xsl:text></collection>
					<isil><xsl:text>DE-B724</xsl:text></isil>
					<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/helene-lange-archiv/</xsl:text></link>
					<geoLocation>
						<latitude>52.5186360</latitude>
						<longitude>13.3761550</longitude>
						</geoLocation>
			
					</institution>
					
				<dataset>
			
					 <typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
					<format><xsl:text>Akte</xsl:text></format>
			
					<title><xsl:value-of select="did/unittitle" /></title>
					<title_short><xsl:value-of select="did/unittitle"/></title_short>
					
					<displayPublishDate>
						<xsl:value-of select="did/unitdate" />
						</displayPublishDate>
					
					<xsl:for-each select="tokenize(did/unitdate, ',')">	
						<xsl:choose>
							<xsl:when test="contains(.,'-')">
								<xsl:for-each select="tokenize(.,'-')">
									<publishDate>
										<xsl:value-of select="normalize-space(.)"/>
										</publishDate>
									</xsl:for-each>
								</xsl:when>
							<xsl:otherwise>
								<publishDate>
									<xsl:value-of select="normalize-space(translate(., translate(.,'0123456789', ''), ''))"/>
									</publishDate>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					
					<xsl:if test="did/physdesc/extent!='(...)'">
						<physical><xsl:value-of select="normalize-space(translate(did/physdesc/extent, translate(.,'0123456789', ''), ''))"/></physical>
						</xsl:if>
						
					<xsl:variable name="enthaelt" select="normalize-space(did/abstract[@type='Enthält'])" />
					<xsl:variable name="darin" select="normalize-space(did/abstract[@type='Darin'])" />
					
					<xsl:if test="(not(contains($enthaelt, '(...)'))) or (not(contains($darin, '(...)')))">
						<description>
							<xsl:if test="not(contains($enthaelt, '(...)'))">
								
								<xsl:value-of select="$enthaelt"/>
								</xsl:if>
							<xsl:text> </xsl:text>
							<xsl:if test="not(contains($darin, '(...)'))">
								
								<xsl:value-of select="$darin"/>
								</xsl:if>
							</description>
						</xsl:if>
			
					</dataset>
					
				<functions>
			
					<hierarchyFields>
						<hierarchy_top_id>
							<xsl:text>BRep23501hla</xsl:text>
							</hierarchy_top_id>
						<hierarchy_top_title>
							<xsl:text>Bund Deutscher Frauenvereine (BDF) / Nachlass</xsl:text>
							</hierarchy_top_title>
						
						<hierarchy_parent_id>
							<xsl:value-of select="translate(../did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:text>hla</xsl:text>
							</hierarchy_parent_id>
						<hierarchy_parent_title>
							<xsl:value-of select="../did/unittitle"/>
							</hierarchy_parent_title>
						
						<is_hierarchy_id>
							<xsl:value-of select="translate(did/unittitle,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')" />
							<xsl:value-of select="did/unitid[@type='v.num']"/>
							<xsl:text>hla</xsl:text>
							</is_hierarchy_id>
						<is_hierarchy_title>
							<xsl:value-of select="did/unittitle" />
							</is_hierarchy_title>
						
						<hierarchy_sequence>
							<xsl:value-of select="substring(did/unittitle,1,5)"/>
							</hierarchy_sequence>
						
						</hierarchyFields>
			
					</functions>
				
				</xsl:element>
			
			
			</xsl:for-each>
	
	
			<!--<commit/>
			<optimize/>-->
		</catalog>
	</xsl:template>

	
</xsl:stylesheet>
