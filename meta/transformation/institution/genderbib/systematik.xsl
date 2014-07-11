<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Jun 03 10:02:46 CEST 2014 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>
	<!--<xsl:template match="@*[.='']"/>
	<xsl:template match="*[not(node())]"/>
	<xsl:strip-space elements="*"/>-->
	
	
	<!--root knoten-->
	
	<xsl:template match="root">
		<xsl:element name="catalog">
			<xsl:apply-templates select="institution/systemstelle"/>
			<xsl:apply-templates select="systematik/systemstelle"/>
			<xsl:apply-templates select="systematik/systemstelle/unterpunkt" />
			</xsl:element>
		</xsl:template>
	
	
<!--Templates-->

	<xsl:template match="institution/systemstelle">
		
	<xsl:element name="record">
		<xsl:attribute name="id" select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"></xsl:attribute>
		
		<xsl:element name="vufind">
			<id>
				<xsl:value-of select="@id" />
				<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<xsl:text>paulabiblio</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>genderbib</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					</id>
			<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
			<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
			<recordType><xsl:text>systematik</xsl:text></recordType>
			</xsl:element>
		
		<xsl:element name="institution">
	
			<institutionShortname>
					<xsl:text>Genderbibliothek</xsl:text>
				</institutionShortname>
	
			<institutionsFullname>
					<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
				</institutionsFullname>
			
			<xsl:choose>
				<xsl:when test="//root[@id='paula']">
						<collection><xsl:text>Paula | Bibliografie</xsl:text></collection>
					</xsl:when>
				<xsl:otherwise>
						<collection><xsl:text>GReTA | Katalog</xsl:text></collection>
					</xsl:otherwise>
				</xsl:choose>
	
			<isil><xsl:text>DE-B1542</xsl:text></isil>
			
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text></link>
	
			<geoLocation>
				<latitude>52.520326</latitude>
				<longitude>13.394218799999976</longitude>
				</geoLocation>
			</xsl:element>
		
		<xsl:element name="dataset">
			<title><xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="@regex"/></title>
			<format><xsl:text>Systematik</xsl:text></format>
			</xsl:element>
		
		<xsl:element name="functions">
		<xsl:variable name="systematik" select="substring-before(@id, '/')" />
			<xsl:element name="hierarchyFields">
				
				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<hierarchy_top_id>0Bibliografpaulabiblio</hierarchy_top_id>
           		 			<hierarchy_top_title>Bibliographie “Frauen und Geschlechterverhältnisse in der DDR und in den neuen Bundesländern</hierarchy_top_title>
						</xsl:when>
					<xsl:otherwise>
						<hierarchy_top_id>0Genderbiblgenderbib</hierarchy_top_id>
            					<hierarchy_top_title>0 Genderbibliothek Aufstellung</hierarchy_top_title>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
		</xsl:element>
		
		</xsl:element>
	</xsl:template>
		
		
		
	
	
	<xsl:template match="systematik/systemstelle">
		
	<xsl:element name="record">
		<xsl:attribute name="id" select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"></xsl:attribute>
		
		<xsl:element name="vufind">
			<id>
				<xsl:value-of select="@id" />
				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
				
				<!--<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
-->				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<xsl:text>paulabiblio</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>genderbib</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
			</id>
			<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
			<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
			<recordType><xsl:text>systematik</xsl:text></recordType>
			</xsl:element>
		
		<xsl:element name="institution">
	
			<institutionShortname>
					<xsl:text>Genderbibliothek</xsl:text>
			</institutionShortname>
	
			<institutionsFullname>
					<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
			</institutionsFullname>
			
			<xsl:choose>
				<xsl:when test="//root[@id='paula']">
						<collection><xsl:text>Paula | Bibliografie</xsl:text></collection>
					</xsl:when>
				<xsl:otherwise>
						<collection><xsl:text>GReTA | Katalog</xsl:text></collection>
					</xsl:otherwise>
				</xsl:choose>
	
			<isil><xsl:text>DE-B1542</xsl:text></isil>
			
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text></link>
	
			<geoLocation>
				<latitude>52.520326</latitude>
				<longitude>13.394218799999976</longitude>
			</geoLocation>
			</xsl:element>
		
		<xsl:element name="dataset">
			<xsl:choose>
				<xsl:when test="//root[@id='paula']">
					<title><xsl:value-of select="@id" /><xsl:text>. </xsl:text><xsl:value-of select="@regex"/></title>
					</xsl:when>
				<xsl:when test="//root[@id='genderbib']">
					<title><xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="@regex"/></title>
					</xsl:when>
				</xsl:choose>
			
			<format><xsl:text>Systematik</xsl:text></format>
			</xsl:element>
		
		<xsl:element name="functions">
		<xsl:variable name="systematik" select="substring-before(@id, '/')" />
			<xsl:element name="hierarchyFields">
				
		<!--Aufstellungssystematik-->
				<xsl:if test="//root[@id!='paula']">
				
				<hierarchy_top_id>0Genderbiblgenderbib</hierarchy_top_id>
            			<hierarchy_top_title>0 Genderbibliothek Aufstellung</hierarchy_top_title>
				
				<hierarchy_parent_id>0Genderbiblgenderbib</hierarchy_parent_id>
            			<hierarchy_parent_title>0 Genderbibliothek Aufstellung</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="@id" />
					<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>
					<xsl:text>genderbib</xsl:text>
					</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="@regex"/>
					</is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="@nr" /></hierarchy_sequence>
				
				</xsl:if>
			
		<!--Bibliografie-->	
				<xsl:if test="//root[@id='paula']">
				
				<hierarchy_top_id>0Bibliografpaulabiblio</hierarchy_top_id>
           		 	<hierarchy_top_title>Bibliografie “Frauen und Geschlechterverhältnisse in der DDR und in den neuen Bundesländern</hierarchy_top_title>
				
				<hierarchy_parent_id>0Bibliografpaulabiblio</hierarchy_parent_id>
           		 	<hierarchy_parent_title>Bibliografie “Frauen und Geschlechterverhältnisse in der DDR und in den neuen Bundesländern</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="@id" />
					<xsl:value-of select="substring(translate(@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
					<xsl:text>paulabiblio</xsl:text>
				</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="@regex"/>
				</is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="@id" /></hierarchy_sequence>
				
				</xsl:if>
				
				
				
				
			</xsl:element>
		</xsl:element>
		
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template match="systematik/systemstelle/unterpunkt">
		
	<xsl:element name="record">
		<xsl:attribute name="id" select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"></xsl:attribute>
		<xsl:element name="vufind">
			<id>
				<xsl:if test="//root[@id='genderbib']">
					<xsl:value-of select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
					</xsl:if>
				
				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
					
				<!--<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>-->
				<xsl:choose>
					<xsl:when test="//root[@id='paula']">
						<xsl:text>paulabiblio</xsl:text>
						</xsl:when>
					<xsl:otherwise>
						<xsl:text>genderbib</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</id>
			<recordCreationDate><xsl:value-of select="current-dateTime()"/></recordCreationDate>
			<recordChangeDate><xsl:value-of select="current-dateTime()"/></recordChangeDate>
			<recordType><xsl:text>systematik</xsl:text></recordType>
		</xsl:element>
		
		<xsl:element name="institution">
	
			<institutionShortname>
					<xsl:text>Genderbibliothek</xsl:text>
			</institutionShortname>
	
			<institutionsFullname>
					<xsl:text>Genderbibliothek/Information/Dokumentation am Zentrum für transdisziplinäre Geschlechterstudien an der Humboldt-Universität zu Berlin</xsl:text>
			</institutionsFullname>
			
			<xsl:choose>
				<xsl:when test="//root[@id='paula']">
						<collection><xsl:text>Paula | Bibliografie</xsl:text></collection>
					</xsl:when>
				<xsl:otherwise>
						<collection><xsl:text>GReTA | Katalog</xsl:text></collection>
					</xsl:otherwise>
				</xsl:choose>
	
			<isil><xsl:text>DE-B1542</xsl:text></isil>
			
			<link><xsl:text>http://www.ida-dachverband.de/einrichtungen/deutschland/genderbibliothek-hub/</xsl:text></link>
	
			<geoLocation>
				<latitude>52.520326</latitude>
				<longitude>13.394218799999976</longitude>
			</geoLocation>
		</xsl:element>
		
		<xsl:element name="dataset">
			<xsl:choose>
				<xsl:when test="//root[@id='paula']">
					<title><xsl:value-of select="."/></title>
					</xsl:when>
				<xsl:when test="//root[@id='genderbib']">
					<title><xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="."/></title>
					</xsl:when>
				</xsl:choose>
			
			<format>
				<xsl:text>Systematik</xsl:text>
				</format>
			</xsl:element>
		
		<xsl:element name="functions">
		<xsl:variable name="systematik" select="substring-before(@id, '/')" />
			<xsl:element name="hierarchyFields">
		
		<!--Aufstellungssystematik-->	
			<xsl:if test="//root[@id!='paula']">
				<hierarchy_top_id>
					<xsl:value-of select="$systematik" />
					<xsl:value-of select="substring(translate(../@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)" />
					<xsl:text>genderbib</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../@id" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="../@regex" />
					</hierarchy_top_title>
					
				<hierarchy_top_id>
					<xsl:value-of select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
					<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>
					<xsl:text>genderbib</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="."/>
					</hierarchy_top_title>
					
					
				<hierarchy_parent_id>
					<xsl:value-of select="$systematik" />
					<xsl:value-of select="substring(translate(../@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)" />
					<xsl:text>genderbib</xsl:text>
					</hierarchy_parent_id>
				
				<hierarchy_parent_title>
					<xsl:value-of select="../@id" />
					<xsl:text> </xsl:text>
					<xsl:value-of select="../@regex" />
					</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="translate(@id,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"/>
					<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>
					<xsl:text>genderbib</xsl:text>
					</is_hierarchy_id>
				
				<is_hierarchy_title>
					<xsl:value-of select="@id" /><xsl:text> </xsl:text><xsl:value-of select="."/>
					</is_hierarchy_title>
				
				<hierarchy_sequence><xsl:value-of select="substring-after(@id, '/')" /></hierarchy_sequence>
				</xsl:if>
				
		<!--Bibliografie-->			
				<xsl:if test="//root[@id='paula']">
				<xsl:variable name="idtitle" select="translate(../@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ')"></xsl:variable>
				
				<hierarchy_top_id>
					<xsl:value-of select="../@id"/>
					<xsl:value-of select="substring($idtitle,1,10)"/>
					<!--<xsl:value-of select="substring(translate(../@regex,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,20)"></xsl:value-of>-->
					<xsl:text>paulabiblio</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="../@regex"/>
					</hierarchy_top_title>
				
				<hierarchy_top_id>
					<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
					<xsl:text>paulabiblio</xsl:text>
					</hierarchy_top_id>
				<hierarchy_top_title>
					<xsl:value-of select="."/>
					</hierarchy_top_title>
				
				<hierarchy_parent_id>
					<xsl:value-of select="../@id"/>
					<xsl:value-of select="substring($idtitle,1,10)"/>
					<!--<xsl:value-of select="substring(../@regex,1,10)"/>-->
					<xsl:text>paulabiblio</xsl:text>
					</hierarchy_parent_id>
				<hierarchy_parent_title>
					<xsl:value-of select="../@regex"/>
					</hierarchy_parent_title>
				
				<is_hierarchy_id>
					<xsl:value-of select="substring(translate(.,'1234567890abcdefghijklmnopqrstuvwxyzäüöABCDEFGHJKLMNOPQRSTUVWYZ -_:.,!?/()', '1234567890abcdefghijklmnopqrstuvwxyzauoABCDEFGHJKLMNOPQRSTUVWYZ'),1,10)"></xsl:value-of>
					<xsl:text>paulabiblio</xsl:text>
					</is_hierarchy_id>
				<is_hierarchy_title>
					<xsl:value-of select="."/>
					</is_hierarchy_title>
				
				<hierarchy_sequence>
					<xsl:value-of select="@id"/>
					</hierarchy_sequence>
				
				</xsl:if>
				
			</xsl:element>
		</xsl:element>
		
	</xsl:element>
	
	</xsl:template>
	
	

</xsl:stylesheet>
