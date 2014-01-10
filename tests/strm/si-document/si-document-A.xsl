<xsl:transform version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="map xs">
    
    <xsl:variable name="RUN" select="true()" static="yes"/>
    <xsl:strip-space elements="*"/>
   
  <!-- within xsl:stream, use xsl:document: atomic values, consuming -->
  
  <xsl:template name="d-001" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/transactions.xml">
        <xsl:for-each select="account/transaction[@value &lt; 0]/@value">
          <xsl:document><xsl:sequence select="data(.)"/></xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: atomic values, consuming and non-consuming -->
  
  <xsl:template name="d-002" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/transactions.xml">
        <xsl:document>
          <xsl:for-each select="data(account/transaction[@value &lt; 0]/@value), 101, 102">
            <xsl:sequence select="data(.)"/>
          </xsl:for-each>  
    	</xsl:document> 
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: climbing posture -->
  
  <xsl:template name="d-003" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/transactions.xml">
        <xsl:variable name="docs" as="document-node()*">
          <xsl:for-each select="account/transaction[@value &lt; 0]/@value">
            <xsl:document><xsl:sequence select="data(.)"/></xsl:document>
          </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="data($docs)"/>  
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: climbing posture -->
  
  <xsl:template name="d-004" use-when="$RUN">
    <xsl:variable name="extra" as="element()*">
      <PRICE value="101"/>
      <PRICE value="102"/>
    </xsl:variable>
    <out>
      <xsl:stream href="../docs/transactions.xml">
        <xsl:variable name="docs" as="document-node()*">
          <xsl:for-each select="account/transaction[@value &lt; 0]/@value, $extra/@value">
            <xsl:document><xsl:sequence select="data(.)"/></xsl:document>
          </xsl:for-each>
        </xsl:variable>
        <xsl:copy-of select="data($docs)"/> 
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: striding posture, element nodes -->
  
  <xsl:template name="d-005" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="/BOOKLIST/BOOKS/ITEM/PRICE">
          <xsl:document>
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: striding posture, text nodes -->
  
  <xsl:template name="d-006" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="/BOOKLIST/BOOKS/ITEM/PRICE/text()">
          <xsl:document>
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: striding posture, text nodes mixed with atomic values -->
  
  <xsl:template name="d-007" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="/BOOKLIST/BOOKS/ITEM/PRICE/text(), 101, 102">
          <xsl:document>
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: striding posture, element nodes mixed with grounded elements -->
  
  <xsl:template name="d-008" use-when="$RUN">
    <xsl:variable name="extra" as="element()*">
      <PRICE>100.00</PRICE>
      <PRICE>101.00</PRICE>
    </xsl:variable>
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="$extra, /BOOKLIST/BOOKS/ITEM/PRICE">
          <xsl:document>
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: descendant text nodes -->
  
  <xsl:template name="d-009" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="outermost(//PRICE)">
          <xsl:document>
            <xsl:sequence select="text()"/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: descendant text nodes mixed with atomic values -->
  
  <xsl:template name="d-010" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <xsl:for-each select="100, 101, /BOOKLIST/BOOKS/ITEM/PRICE/text()">
          <xsl:document>
            <xsl:sequence select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: whole document unchanged -->
  
  <xsl:template name="d-011" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/books.xml">
        <head/>
        <xsl:document>
          <xsl:copy-of select="child::node()"/>
        </xsl:document>
        <tail/>
      </xsl:stream>
    </out>
  </xsl:template>
  

  <!-- within xsl:stream, use xsl:document: validation="strip" (non-schema-aware) -->
  
  <xsl:template name="d-022" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:for-each select="/*/*:description">
          <xsl:document validation="strip">
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: validation="preserve" (non-schema-aware) -->
  
  <xsl:template name="d-023" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:for-each select="/*/*:description">
          <xsl:document validation="preserve">
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!-- within xsl:stream, use xsl:document: validation="lax" (non-schema-aware) -->
  
  <xsl:template name="d-024" use-when="$RUN">
    <out>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:for-each select="/*/*:description">
          <xsl:document validation="lax">
            <xsl:copy-of select="."/>
          </xsl:document>
        </xsl:for-each>
      </xsl:stream>
    </out>
  </xsl:template>
  

  
  <!-- within xsl:stream, use xsl:document/on-empty: empty sequence selected ->
  
  <xsl:template name="d-040" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document select="/*[@dummy='not-there']" on-empty="$a">
          <b/>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty element constructed ->
  
  <xsl:template name="d-041" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document select="/*" on-empty="$a">
          <xsl:if test="current-date() lt xs:date('1900-01-01')"><b/></xsl:if>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty document node constructed ->
  
  <xsl:template name="d-042" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document on-empty="$a">
          <xsl:if test="current-date() lt xs:date('1900-01-01')"><b/></xsl:if>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty document node constructed ->
  
  <xsl:template name="d-043" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document on-empty="$a">
          <xsl:if test="current-date() lt xs:date('1900-01-01')"><b/></xsl:if>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty comment node constructed ->
  
  <xsl:template name="d-044" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/special.xml">
        <xsl:document select="special/comment()[2]" on-empty="$a">
          <xsl:if test="current-date() lt xs:date('1900-01-01')"><b/></xsl:if>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty PI node constructed ->
  
  <xsl:template name="d-045" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/special.xml">
        <xsl:document select="special/processing-instruction()[2]" on-empty="$a">
          <xsl:if test="current-date() lt xs:date('1900-01-01')"><b/></xsl:if>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty attribute node constructed ->
  
  <xsl:template name="d-046" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/special.xml">
        <xsl:document select="special/f/@a" on-empty="$a"/>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty element constructed ->
  
  <xsl:template name="d-047" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document select="/*" on-empty="$a">
          <xsl:copy-of select="a/b/c/d/e/f/g"/>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
  <!- within xsl:stream, use xsl:document/on-empty: empty document constructed ->
  
  <xsl:template name="d-048" use-when="$RUN">
    <out>
      <xsl:variable name="a"><a/></xsl:variable>
      <xsl:stream href="../docs/citygml.xml">
        <xsl:document on-empty="$a">
          <xsl:copy-of select="a/b/c/d/e/f/g"/>
        </xsl:document>
      </xsl:stream>
    </out>
  </xsl:template>
  
   -->
  
</xsl:transform>  