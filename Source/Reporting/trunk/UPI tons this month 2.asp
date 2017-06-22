<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>UPI tons this month</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhdispatch_conn")) Then
    Set conn = Session("dhdispatch_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhdispatch","dan","love"
    Set Session("dhdispatch_conn") = conn
End If
%>
<%
If IsObject(Session("UPI_tons_this_month_rs")) Then
    Set rs = Session("UPI_tons_this_month_rs")
Else
    sql = "SELECT tblDestinationList.Destination AS Client, DatePart(""yyyy"",[LogOutDate]) & ""/"" & DatePart(""m"",[LogOutDate]) AS [Yr/Mo], Max(DatePart(""d"",[LogOutDate])) AS [Day], Count(tblPoscoLoads.Load) AS [MTD Loads], Sum([ChargedWeight]/2000) AS [MTD Tons]  FROM tblPoscoLoads INNER JOIN tblDestinationList ON tblPoscoLoads.LoadFamily = tblDestinationList.[Destination id]  WHERE (((tblPoscoLoads.LogOutDate)>=DateValue(Month(Date()) & ""/1/"" & Year(Date()))))  GROUP BY tblDestinationList.Destination, DatePart(""yyyy"",[LogOutDate]) & ""/"" & DatePart(""m"",[LogOutDate]), tblPoscoLoads.LoadFamily  HAVING (((tblPoscoLoads.LoadFamily)=897553022))   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("UPI_tons_this_month_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>UPI tons this month</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Client</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Yr/Mo</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Day</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>MTD Loads</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>MTD Tons</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Client").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Yr/Mo").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Day").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("MTD Loads").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("MTD Tons").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>