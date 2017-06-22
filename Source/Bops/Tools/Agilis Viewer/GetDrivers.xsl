<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Agilis | Get Drivers</title>
      </head>
      <body>
        <h1>Agilis - Get Drivers</h1>
        <table border="1" cellSpacing="0" cellPadding="4">

          <tr>
            <td>
              <h2>Active</h2>
            </td>
            <td>
              <h2>Phone</h2>
            </td>
            <td>
              <h2>Last Sync Date</h2>
            </td>
            <td>
              <h2>First Name</h2>
            </td>
            <td>
              <h2>Last Name</h2>
            </td>
            <td>
              <h2>Fleet ID</h2>
            </td>
            <td>
              <h2>Business Unit Number</h2>
            </td>

          </tr>
          <xsl:for-each select="//Driver">
            <!-- Each record on a separate row. -->

            <xsl:element name="tr">
              <xsl:element name="td">
                <xsl:value-of select="active" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="phoneNumber" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="lastSyncDate" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="firstName" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="lastName" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="fleetId" />
              </xsl:element>
              <xsl:element name="td">
                <xsl:value-of select="businessUnitNumber" />
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>