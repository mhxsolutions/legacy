<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>UPI tons this month</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhDispatch_conn")) Then
    Set conn = Session("dhDispatch_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatch","dan","love"
    Set Session("dhDispatch_conn") = conn
End If
%>
<%
If IsObject(Session("UPI_tons_this_month_rs")) Then
    Set rs = Session("UPI_tons_this_month_rs")
Else
    sql = "SELECT [tblDestinationList].[Destination] AS Client, DatePart('yyyy',[LogOutDate]) & '/' & DatePart('m',[LogOutDate]) AS YrMo, Max(DatePart('d',[LogOutDate])) AS [Day], Count([tblPoscoLoads].[Load]) AS [MTD Loads], Sum([ChargedWeight]/2000) AS [MTD Tons]  FROM tblPoscoLoads INNER JOIN tblDestinationList ON [tblPoscoLoads].[LoadFamily]=[tblDestinationList].[Destination id]  WHERE ((([tblPoscoLoads].[LogOutDate]) Between DateValue(Month(Date()) & '/1/' & Year(Date())) And DateValue(Month(DateAdd('m',1,Date())) & '/1/' & Year(Date()))-1))  GROUP BY [tblDestinationList].[Destination], DatePart('yyyy',[LogOutDate]) & '/' & DatePart('m',[LogOutDate]), [tblPoscoLoads].[LoadFamily]  HAVING (((tblPoscoLoads.LoadFamily)=897553022))   "
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