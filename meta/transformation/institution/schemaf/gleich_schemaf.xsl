<?xml version="1.0" encoding="utf-8"?><!-- New document created with EditiX at Wed Feb 27 13:46:04 CET 2013 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:err="http://www.w3.org/2005/xqt-errors" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xdt err fn" version="2.0">
	<xsl:output indent="yes" method="xml"/>
	<!-- Leere Knoten werden entfernt-->
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>-->
	<!--Nicht dargestellte Zeichen (sog. "Whitespace")  werden im XML Dokument entfernt um Speicherplatz zu sparen-->
	<xsl:strip-space elements="*"/>
	
	
<!--root knoten-->
	<xsl:template match="ROWSET">
		<xsl:element name="catalog">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

<!--Der Objektknoten-->
	<xsl:template match="ROW">
	
		<xsl:variable name="id" select="Mediennummer"/>
			<xsl:element name="record">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/><xsl:text>schemaf</xsl:text>
					</xsl:attribute>
				
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->
<!--Variablen_______________________________________________________Variablen-->

				
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
<!--vufind_______________________________vufind_______________________________vufind-->
		
		
		
<xsl:element name="vufind">
		
	<!--Identifikator-->
				<id>
					<xsl:value-of select="Mediennummer"/>
					<xsl:text>schemaf</xsl:text>
					</id>

	<!--recordCreationDate-->
	
				<recordCreationDate>
					<xsl:value-of select="current-dateTime()"/>
					</recordCreationDate>
			
				<!--<xsl:choose>
					<xsl:when test="erfasst_am- !=''">
						<recordCreationDate>
							<xsl:value-of select="substring(erfasst_am-[1],7,4)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],4,2)"/>
							<xsl:text>-</xsl:text>
							<xsl:value-of select="substring(erfasst_am-[1],1,2)"/>
							<xsl:text>T</xsl:text>
							<xsl:text>00:00:00Z</xsl:text>
							</recordCreationDate>
						</xsl:when>
					<xsl:otherwise>
						<recordCreationDate>
							<xsl:value-of select="current-dateTime()"/>
							</recordCreationDate>
						</xsl:otherwise>
					</xsl:choose>-->
					
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
							<xsl:text>schema f</xsl:text>
							</institutionShortname>
	
<!--institutionFullname-->			<institutionFull>
							<xsl:text>schema f</xsl:text>
							</institutionFull>
							
						<institutionID><xsl:text>schemaf</xsl:text></institutionID>
			
<!--collection-->				<collection><xsl:text>schemaf</xsl:text></collection>
	
<!--isil-->					<isil><xsl:text>o. A.</xsl:text></isil>
	
<!--linkToWebpage-->			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/schweiz/schema-f/</xsl:text></link>
	
<!--geoLocation-->				<geoLocation>
							<latitude>0</latitude>
							<longitude>0</longitude>
							</geoLocation>
			
</xsl:element>



<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->
<!--dataset_______________________________dataset_______________________________dataset-->	
	
	
	
	
	
	
	
	
	
			
<!--Buch__________________________Monographie___________________________Sammelband-->



<xsl:element name="dataset">


<!--FORMAT-->

	<!--typeOfRessource-->
				<typeOfRessource><xsl:text>text</xsl:text></typeOfRessource>
	
	<!--format Objektartinformationen-->
				<format><xsl:text>Buch</xsl:text></format>	

<!--TITLE-->

	<!--title Titelinformationen-->
				<xsl:apply-templates select="Titel"/>
				<xsl:apply-templates select="Untertitel[string-length() != 0]"/>
				<xsl:apply-templates select="Originaltitel[string-length() != 0]"/>
				
<!--RESPONSIBLE-->

	<!--author Autorinneninformation-->
				<xsl:apply-templates select="Autorin1[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin2[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin3[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin4[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin5[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin6[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin7[string-length() != 0]"/>
				<xsl:apply-templates select="Autorin8[string-length() != 0]"/>
				
				
	<!--series Reiheninformation-->
				<xsl:apply-templates select="Reihe[string-length() != 0]"/>

<!--IDENTIFIER-->
	
	<!--ISBN / ISSN-->
				<xsl:apply-templates select="ISBN[string-length() != 0]"/>

<!--PUBLISHING-->

	<!--displayDate-->
	<!--publishDate Jahresangabe-->
				<xsl:apply-templates select="Jahr"/>
	
	<!--placeOfPublication publisher Verlagsangabe-->
				<xsl:apply-templates select="Verlag[string-length() != 0]"/>
	
<!--PHYSICAL INFORMATION-->
					
	<!--physical Seitenangabe-->
				<xsl:apply-templates select="Seiten[string-length() != 0]"/>

<!--CONTENTRELATED INFORMATION-->
				
	<!--subjectTopic Deskriptoren-->
				
	
				<xsl:if test="document('schlagworte.xml')/ROWSET/ROW/mediennummer=$id">
					<xsl:for-each select="document('schlagworte.xml')/ROWSET/ROW[mediennummer=$id]">
						<xsl:for-each select="*[starts-with(name(.), 'schlagwort_')]">
							<xsl:if test=".!=''">
								
								<xsl:if test="not(contains(.,','))">
								<subjectTopic>
									<xsl:value-of select="." />
									</subjectTopic>
									</xsl:if>
								
								<xsl:if test="contains(.,',')">
								<subjectTopic>
									<xsl:choose>
										
										<xsl:when test="(contains(.,'Science Fiction, Fantasy'))
										or (contains(.,'Arbeit'))
										or (contains(.,'Abhängigkeit'))
										or (contains(.,'Erfolg'))
										or (contains(.,'Film'))
										or (contains(.,'Geschichte'))
										or (contains(.,'Gewalt'))
										or (contains(.,'Heilmethoden'))
										or (contains(.,'Heilweisen'))
										or (contains(.,'Krankheit'))
										or (contains(.,'Identität'))
										or (contains(.,'Lesben'))
										or (contains(.,'Lexika'))
										or (contains(.,'Psychologie'))
										or (contains(.,'Psychotherapie'))
										or (contains(.,'Recht'))
										or (contains(.,'Selbsthilfe'))
										or (contains(.,'Steine'))
										or (contains(.,'Spiritualität'))
										or (contains(.,'Test'))
										or (contains(.,'Therapie'))">
											<xsl:value-of select="." />
											</xsl:when>
										
										<xsl:when test="contains(substring-before(.,','),' ')">
											<xsl:variable name="one" select="substring-before(.,' ')" />
											<xsl:variable name="two" select="substring-before(substring-after(.,' '),',')" />
											<xsl:value-of select="substring($one,1,1)" />
											<xsl:value-of select="lower-case(substring($one,2))" />
											<xsl:text> </xsl:text>
											<xsl:value-of select="substring($two,1,1)" />
											<xsl:value-of select="lower-case(substring($two,2))" />
											<xsl:text>, </xsl:text>
											<xsl:value-of select="normalize-space(substring-after(.,','))" />
											</xsl:when>
										
										<xsl:when test="contains(substring-before(.,','),'-')">
											<xsl:variable name="one" select="substring-before(.,'-')" />
											<xsl:variable name="two" select="substring-before(substring-after(.,'-'),',')" />
											<xsl:value-of select="substring($one,1,1)" />
											<xsl:value-of select="lower-case(substring($one,2))" />
											<xsl:text>-</xsl:text>
											<xsl:value-of select="substring($two,1,1)" />
											<xsl:value-of select="lower-case(substring($two,2))" />
											<xsl:text>, </xsl:text>
											<xsl:value-of select="normalize-space(substring-after(.,','))" />
											</xsl:when>
										
										
										
										<xsl:otherwise>
											<xsl:variable name="one" select="substring-before(.,',')" />
											<xsl:value-of select="substring($one,1,1)" />
											<xsl:value-of select="lower-case(substring($one,2))" />
											<xsl:text>, </xsl:text>
											<xsl:value-of select="normalize-space(substring-after(.,','))" />
											</xsl:otherwise>
										
										</xsl:choose>
									</subjectTopic>
									</xsl:if>
								</xsl:if>
							</xsl:for-each>
						</xsl:for-each>
					
					<!--<subjectTopic>
						
						<xsl:value-of select="document('data/schlagworte.xml')/ROWSET/ROW[mediennummer=$id]/schlagwort_01"></xsl:value-of>
						</subjectTopic>-->
					
					<!--<xsl:for-each select="document('data/schlagworte.xml')/ROWSET/ROW/mediennummer=$id">
						<subjectTopic>
						<xsl:value-of select="../schlagwort_1" />
							</subjectTopic>
						</xsl:for-each>-->
					</xsl:if>
				
<!--OTHER-->
	<!--SHELFMARK-->
				<xsl:apply-templates select="Signatur[string-length() != 0]"/>
		
		</xsl:element>	


		






	


</xsl:element>
</xsl:template>








<!--Templates-->

	<xsl:template match="Titel">
		<xsl:choose>
			<xsl:when test=".!=''">
				<title>
					<xsl:value-of select="."/>
					<xsl:if test="../Untertitel!=''">
						<xsl:text> : </xsl:text>
						<xsl:value-of select="../Untertitel" />
						</xsl:if>
					</title>
				<title_short>
					<xsl:value-of select="."/>
					</title_short>	
				</xsl:when>
			<xsl:otherwise>
				<title>
					<xsl:value-of select="substring-after(substring-before(../Reihe,')'),'(')"/>
					</title>
				<title_short>
					<xsl:value-of select="substring-after(substring-before(../Reihe,')'),'(')"/>
					</title_short>	
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Untertitel">
		<title_sub>
			<xsl:value-of select="."/>
			</title_sub>
		</xsl:template>

	<xsl:template match="Originaltitel">
		<originalTitle>
			<xsl:value-of select="."/>
			</originalTitle>
		</xsl:template>

	<xsl:template match="Reihe">
		<xsl:choose>
			<xsl:when test="(contains(.,'(')) and contains(.,')')">
				<series>
					<xsl:value-of select="substring-after(substring-before(.,')'),'(')"/>
					</series>
				</xsl:when>
			<xsl:otherwise>
				<series>
					<xsl:value-of select="." />
					</series>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="ISBN">
		<isbn>
			<xsl:value-of select="."/>
			</isbn>
		</xsl:template>

	<xsl:template match="Jahr">
		<xsl:choose>
			<xsl:when test=".!=''">
				<displayPublishDate>
					<xsl:value-of select="."/>
					</displayPublishDate>
				<publishDate>
					<xsl:value-of select="."/>
					</publishDate>
				</xsl:when>
			<xsl:otherwise>
				<displayPublishDate>
					<xsl:text>o.A.</xsl:text>
					</displayPublishDate>
				<publishDate>
					<xsl:text>0000</xsl:text>
					</publishDate>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:template>
	
	<xsl:template match="Verlag">
		<xsl:choose>
			<xsl:when test="contains(.,':')">
				<placeOfPublication>
					<xsl:value-of select="normalize-space(substring-before(.,':'))" />
					</placeOfPublication>
				<xsl:if test="substring-after(.,':')!=''">
				<publisher>
					<xsl:value-of select="normalize-space(substring-after(.,':'))"/>
					</publisher>	
					</xsl:if>	
				</xsl:when>
			<xsl:otherwise>
				<publisher>
					<xsl:value-of select="normalize-space(.)"/>
					</publisher>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Seiten">
		<physical>
			<xsl:value-of select="."/>
			</physical>
		</xsl:template>
	
	<xsl:template match="Signatur">
		<shelfMark>
			<xsl:value-of select="."/>
			</shelfMark>
		</xsl:template>
	
	<xsl:template match="Autorin1">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Autorin2">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Autorin3">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Autorin4">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Autorin5">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Autorin6">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
	<xsl:template match="Autorin7">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="Autorin8">
		<xsl:choose>
			<xsl:when test="contains(.,'Hrsgin')">
				<editor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Hrs'))" />
					</editor>
				</xsl:when>
			<xsl:when test="contains(.,'Redin')">
				<contributor>
					<xsl:value-of select="normalize-space(substring-before(.,'(Redin'))" />
					</contributor>
				</xsl:when>
			<xsl:otherwise>
				<author>
					<xsl:value-of select="normalize-space(.)" />
					</author>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	

</xsl:stylesheet>
