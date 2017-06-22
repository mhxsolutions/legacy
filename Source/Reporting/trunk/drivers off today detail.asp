<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>Drivers off today detail</TITLE>
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
If IsObject(Session("Drivers_off_today_detail_rs")) Then
    Set rs = Session("Drivers_off_today_detail_rs")
Else
    sql = "SELECT tblAbsences.DateOfAbsence, [lastname] & ', ' & [firstname] AS [Drivers Off]  FROM tblDriverList LEFT JOIN tblAbsences ON tblDriverList.EmployeeID = tblAbsences.EmployeeRef  WHERE (((tblAbsences.DateOfAbsence)=Date()) AND ((tblAbsences.TypeOfAbsence)<>3))   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("Drivers_off_today_detail_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Drivers off today detail</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>DateOfAbsence</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Drivers Off</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("DateOfAbsence").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Drivers Off").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>