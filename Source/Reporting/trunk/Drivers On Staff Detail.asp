<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>Drivers On Staff Detail</TITLE>
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
If IsObject(Session("Drivers_On_Staff_Detail_rs")) Then
    Set rs = Session("Drivers_On_Staff_Detail_rs")
Else
    sql = "SELECT [lastname] & ', ' & [firstname] AS Driver  FROM tblDriverList  WHERE (((tblDriverList.Title)='driver'))  ORDER BY [lastname] & ', ' & [firstname]   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("Drivers_On_Staff_Detail_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Drivers On Staff </B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Driver</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Driver").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>