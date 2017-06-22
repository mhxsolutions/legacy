<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>Drivers Assigned Loads Today Detail</TITLE>
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
If IsObject(Session("Drivers_Assigned_Loads_Today_Detail_rs")) Then
    Set rs = Session("Drivers_Assigned_Loads_Today_Detail_rs")
Else
    sql = "SELECT [lastname] & ', ' & [firstname] AS Name  FROM [Drivers Assigned Loads Today P1] INNER JOIN tblDriverList ON [Drivers Assigned Loads Today P1].[Drivers Assigned] = tblDriverList.EmployeeID  ORDER BY [lastname] & ', ' & [firstname]   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("Drivers_Assigned_Loads_Today_Detail_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Drivers Assigned Loads Today</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Name</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Name").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>