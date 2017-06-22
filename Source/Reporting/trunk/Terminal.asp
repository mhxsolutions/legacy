<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>Detention Query Terminal Daily</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhdispatchx_conn")) Then
    Set conn = Session("dhdispatchx_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhdispatch","dan","love"
    Set Session("dhdispatchx_conn") = conn
End If
%>
<%
If IsObject(Session("Detention_Query_Terminal_Daily_rs")) Then
    Set rs = Session("Detention_Query_Terminal_Daily_rs")
Else
    sql = "SELECT [Detention Query for Terminal].Destination, [Detention Query for Terminal].LegDate, Avg([Detention Query for Terminal].detention) AS [Average Term Time], Count([Detention Query for Terminal].detention) AS Loads  FROM [Detention Query for Terminal]  GROUP BY [Detention Query for Terminal].Destination, [Detention Query for Terminal].LegDate  HAVING ((([Detention Query for Terminal].LegDate) Between Date()-16 And Date()-1))  ORDER BY [Detention Query for Terminal].Destination, [Detention Query for Terminal].LegDate DESC   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("Detention_Query_Terminal_Daily_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Detention Query Terminal Daily</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Destination</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>LegDate</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Average Term Time</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Loads</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Destination").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("LegDate").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=formatnumber(Server.HTMLEncode(rs.Fields("Average Term Time").Value),1)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Loads").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>