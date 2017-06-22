<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>sys Loads staged 7 day_Crosstab</TITLE>
<base target="rtop">
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
If IsObject(Session("sys_Loads_staged_7_day_Crosstab_rs")) Then
    Set rs = Session("sys_Loads_staged_7_day_Crosstab_rs")
Else
    sql = "TRANSFORM Avg([sys Loads staged 7 day].Count) AS AvgOfCount  SELECT [sys Loads staged 7 day].LoadDate AS [Date], Sum([sys Loads staged 7 day].Count) AS [Total Loads]  FROM [sys Loads staged 7 day]  GROUP BY [sys Loads staged 7 day].LoadDate  ORDER BY [sys Loads staged 7 day].LoadDate DESC   PIVOT [sys Loads staged 7 day].Stage In (Yes,No)   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("sys_Loads_staged_7_day_Crosstab_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><b>Loads
    Staged (7 day)</b></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Date</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Total Loads</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><font style="font-size: 10pt" face="Arial" color="#000000">Staged
  for Loading</font></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><font style="font-size: 10pt" face="Arial" color="#000000">Loaded
  from Floor</font></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Date").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Total Loads").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Yes").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("No").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><font style="font-size: 10pt" face="Arial" color="#000000">*Total Loads
includes all destinations, no will call.</font></p>
</BODY>
</HTML>