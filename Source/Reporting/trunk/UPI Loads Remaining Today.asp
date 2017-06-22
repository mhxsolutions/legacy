<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>UPI Loads Remaining Today</TITLE>
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
If IsObject(Session("UPI_Loads_Remaining_Today_rs")) Then
    Set rs = Session("UPI_Loads_Remaining_Today_rs")
Else
    sql = "SELECT Count(tblPoscoLoads.Load) AS [UPI Loads Remaining]  FROM tblPoscoLoads  WHERE (((tblPoscoLoads.LoadFamily)=897553022) AND ((tblPoscoLoads.LoadDate)<=Date()) AND ((tblPoscoLoads.LogOut)=False))   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("UPI_Loads_Remaining_Today_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>UPI Loads
    <a href="Todays%20Loads%20not%20Loged%20Out.asp"> Remaining</a> Today</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>UPI Loads Remaining</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("UPI Loads Remaining").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
</BODY>
</HTML>