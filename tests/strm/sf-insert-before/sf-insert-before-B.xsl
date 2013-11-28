<xsl:stylesheet version="3.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="map xs">
    
    <xsl:variable name="RUN" select="true()" static="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="insertion" as="element()*">
      <a>A</a>
      <b>B</b>
    </xsl:variable>
    
    <!-- insert-before() (streaming arg 3): grounded operand -->
    
    <xsl:template name="r-001" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, data(/BOOKLIST/BOOKS/ITEM/PRICE))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): grounded operand -->
    
    <xsl:template name="r-002" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="insert-before($insertion, 2, copy-of(/BOOKLIST/BOOKS/ITEM/PRICE))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): grounded atomic operand -->
    
    <xsl:template name="r-003" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="/BOOKLIST/BOOKS/ITEM/DIMENSIONS ! insert-before($insertion, 2, tokenize(., ' '))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, inspection usage -->
    
    <xsl:template name="r-010" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="count(insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, absorption usage -->
    
    <xsl:template name="r-011" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="sum(insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, transmission usage -->
    
    <xsl:template name="r-012" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE)[position() mod 2 = 0]"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, focus-setting usage -->
    
    <xsl:template name="r-013" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE) ! (.+1)"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, focus-controlled usage -->
    
    <!-- Saxon 26 Nov 2013. Failing. A for-each that returns streamed nodes
         can't currently be handled by a ComposingWatch. Need to generalize
         TransmissionAdjunct -->
    
    <xsl:template name="r-014" use-when="true() or $RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="/BOOKLIST/BOOKS/ITEM[1] ! insert-before($insertion, 2, *)"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, focus-setting usage -->
    
    <xsl:template name="r-015" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:for-each select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE)">
            <xsl:value-of select=".+1 || ' '"/>
          </xsl:for-each>  
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, focus-controlled usage -->
    
    <xsl:template name="r-016" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:for-each select="/BOOKLIST/BOOKS/ITEM[1]">
            <xsl:copy-of select="insert-before($insertion, 2, *)"/>
          </xsl:for-each>  
        </out>
      </xsl:stream>
    </xsl:template>    
    
    <!-- insert-before() (streaming arg 3): striding operand, focus-setting usage for inspection action -->
    
    <xsl:template name="r-017" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]/*) ! contains(name(), 'E')"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): striding operand, apply-templates usage -->
    
    <xsl:template name="r-018" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:apply-templates select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]/*)" mode="r-018-mode"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <xsl:mode name="r-018-mode" streamable="yes" on-no-match="deep-skip"/>
    <xsl:template match="ITEM/*" mode="r-018-mode"><xsl:value-of select="."/></xsl:template>
    
    <!-- insert-before() (streaming arg 3): crawling operand, inspection usage -->
    
    <xsl:template name="r-020" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="count(insert-before($insertion, 2, //PRICE))"/>
        </out>
      </xsl:stream>
    </xsl:template> 
    
    <!-- insert-before() (streaming arg 3): crawling operand, absorption usage -->
    
    <xsl:template name="r-021" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="count(insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]//text()))"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): crawling operand, transmission usage -->
    
    <xsl:template name="r-022" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]//text())[position() lt 4]"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): crawling operand, focus-setting usage -->
    
    <xsl:template name="r-023" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="insert-before($insertion, 2, //PRICE/text()) ! (.+1)"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, inspection usage -->
    
    <xsl:template name="r-030" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]/PRICE/ancestor::*) ! name()"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, inspection usage, removal of duplicates -->
    
    <xsl:template name="r-031" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:copy-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE/ancestor::*) ! name()"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, absorption usage -->
    
    <xsl:template name="r-032" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM[1]/PRICE/ancestor::*/@*)" separator="|"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, absorption usage -->
    
    <xsl:template name="r-033" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/ancestor-or-self::*/@CAT)" separator="|"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, absorption usage, removal of duplicates -->
    
    <xsl:template name="r-034" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, /BOOKLIST/BOOKS/ITEM/PRICE/ancestor-or-self::*/@CAT)" separator="|"/>
        </out>
      </xsl:stream>
    </xsl:template>
    
    <!-- insert-before() (streaming arg 3): climbing operand, absorption usage, removal of duplicates -->
    
    <xsl:template name="r-035" use-when="$RUN">
      <xsl:stream href="../docs/books.xml">
        <out>
          <xsl:value-of select="insert-before($insertion, 2, //PRICE/ancestor-or-self::*/@*)" separator="|"/>
        </out>
      </xsl:stream>
    </xsl:template>               
    
</xsl:stylesheet>