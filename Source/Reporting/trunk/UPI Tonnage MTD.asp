<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>UPI tons this month</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("FonDWSNoRepl_conn")) Then
    Set conn = Session("FonDWSNoRepl_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatchMSDE","IUSR_FON-DATA","sa"
    Set Session("FonDWSNoRepl_conn") = conn
End If
%>
<%
If IsObject(Session("UPI_tons_this_month_rs")) Then
    Set rs = Session("UPI_tons_this_month_rs")
Else
    sql = "SELECT [DWS Rep Data].dbo.tbldestinationList.Destination AS Client, STR(DATEPART(yyyy, dbo.tblPoscoLoads.LogOutDate)) + '/' + "
    sql = sql & "STR(DATEPART(mm,dbo.tblPoscoLoads.LogOutDate)) AS YrMo, dbo.CntBusDays(GETDATE()) AS [Day], COUNT(dbo.tblPoscoLoads.[Load]) AS [MTD Loads], "
    sql = sql & "SUM(dbo.tblPoscoLoads.ChargedWeight / 2000) AS [MTD Tons] "
    sql = sql & "FROM dbo.tblPoscoLoads INNER JOIN "
    sql = sql & "     [DWS Rep Data].dbo.tbldestinationList ON dbo.tblPoscoLoads.LoadFamily = [DWS Rep Data].dbo.tbldestinationList.[Destination id] "
    sql = sql & "WHERE (dbo.tblPoscoLoads.LogOutDate >= CONVERT(datetime, STR(MONTH(GETDATE())) + '/1/' + STR(YEAR(GETDATE())), 101) "
    sql = sql & "GROUP BY [DWS Rep Data].dbo.tbldestinationList.Destination, STR(DATEPART(yyyy, dbo.tblPoscoLoads.LogOutDate)) + '/' + "
    sql = sql & "        STR(DATEPART(mm,dbo.tblPoscoLoads.LogOutDate)), dbo.tblPoscoLoads.LoadFamily "
    sql = sql & "HAVING (dbo.tblPoscoLoads.LoadFamily = 897553022)"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("UPI_tons_this_month_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>UPI
    Tons This Month</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Client</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>YrMo</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Day</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>MTD Loads</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>MTD Tons</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Client").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("YrMo").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Day").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("MTD Loads").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("MTD Tons").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><a href="UPI%20counts%2030%20days.asp">UPI counts 30 days</a></p>
<p><a href="UPI%20Pace%20Reference.htm">UPI Pace Reference</a></p>
<p><a href="UPI%20Loads%20Delivered%20Today.asp">UPI Loads Delivered Today</a></p>
<p><a href="UPI%20Loads%20Remaining%20Today.asp">UPI Loads Remaining Today</a></p>
</BODY>
</HTML>