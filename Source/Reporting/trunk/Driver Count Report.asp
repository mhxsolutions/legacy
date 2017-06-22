<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>Driver Count Report</TITLE>
<base target="rtop">
<!--mstheme--><link href="_themes/budway/budw1011.css" rel="stylesheet" type="text/css"><meta content="budway 1011" name="Microsoft Theme">
</HEAD>
<BODY>
<%
If IsObject(Session("dhinventory_conn")) Then
    Set conn = Session("dhinventory_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhinventory","dan","love"
    Set Session("dhinventory_conn") = conn
End If
%>
<%
If IsObject(Session("Driver_Count_Report_rs")) Then
    Set rs = Session("Driver_Count_Report_rs")
Else
    sql = "SELECT [Drivers classified as driver].Date, [Drivers classified as driver].CountOfEmployeeID AS [Drivers On Staff], IIf(IsNull([Drivers Off]),0,[drivers off]) AS [Drivers Off Today], [Drivers Assigned Loads Today P2].[CountOfDrivers Assigned] AS [Drivers Assigned Loads]  FROM [Drivers classified as driver] LEFT JOIN ([Drivers Assigned Loads Today P2] LEFT JOIN [Drivers off today] ON [Drivers Assigned Loads Today P2].LogOutDate = [Drivers off today].DateOfAbsence) ON [Drivers classified as driver].Date = [Drivers Assigned Loads Today P2].LogOutDate   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("Driver_Count_Report_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0>
	<FONT FACE="Arial" COLOR=#000000 size="1"><CAPTION><B>Driver Count Report</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT FACE="Arial" COLOR=#000000 size="1">Date</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT FACE="Arial" COLOR=#000000 size="1">
<a target="_self" href="Drivers%20On%20Staff%20Detail.asp">Drivers On Staff</a></FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT FACE="Arial" COLOR=#000000 size="1">
<a target="_self" href="drivers%20off%20today%20detail.asp">Drivers Off Today</a></FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT FACE="Arial" COLOR=#000000 size="1">
<a target="_self" href="Drivers%20Assigned%20Loads%20Today%20Detail.asp">Drivers Assigned Loads</a></FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT FACE="Arial" COLOR=#000000 size="1"><%=Server.HTMLEncode(rs.Fields("Date").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT FACE="Arial" COLOR=#000000 size="1"><%=Server.HTMLEncode(rs.Fields("Drivers On Staff").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT FACE="Arial" COLOR=#000000 size="1"><%=Server.HTMLEncode(rs.Fields("Drivers Off Today").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT FACE="Arial" COLOR=#000000 size="1"><%=Server.HTMLEncode(rs.Fields("Drivers Assigned Loads").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><a href="drivers_not_assigned.asp"><span style="background-color: #FFFFFF">
Drivers Not Assigned</span></a></p>
</BODY>
</HTML>