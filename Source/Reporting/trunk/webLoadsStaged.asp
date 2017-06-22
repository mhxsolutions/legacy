<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webLoadsStaged</TITLE>
<base target="rtop">
</HEAD>
<BODY>
<font size="1">
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
If IsObject(Session("webLoadsStaged_rs")) Then
    Set rs = Session("webLoadsStaged_rs")
Else
    sql = "SELECT sysLoadCountDelivered.LogOutDate, sysLoadCountDelivered.CountOfLoad AS Delivered, sysLoadsStaged.CtStage AS Staged, [countofload]-[ctstage] AS [Loaded From Floor], [ctstage]/[countofload] AS [Percent Staged]  FROM sysLoadsStaged INNER JOIN sysLoadCountDelivered ON sysLoadsStaged.LogOutDate = sysLoadCountDelivered.LogOutDate  WHERE (((sysLoadCountDelivered.LogOutDate)>=Date()-14))  ORDER BY sysLoadCountDelivered.LogOutDate DESC   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("webLoadsStaged_rs") = rs
End If
%>
</font>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0>
	<FONT FACE="Arial" COLOR=#000000 size="2"><CAPTION><B>Loads
    Staged when Loaded</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT SIZE=1 FACE="Arial" COLOR=#000000>Log
  Out Date</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT SIZE=1 FACE="Arial" COLOR=#000000>Delivered</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT SIZE=1 FACE="Arial" COLOR=#000000>Staged</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<font size="1" face="Arial" color="#000000">Direct</font></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 >
<FONT SIZE=1 FACE="Arial" COLOR=#000000>Percent Staged</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=1 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("LogOutDate").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=1 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Delivered").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=1 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Staged").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=1 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Loaded From Floor").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=1 FACE="Arial" COLOR=#000000><%=formatpercent(Server.HTMLEncode(rs.Fields("Percent Staged").Value),1)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><span style="background-color: #FFFFFF"><font size="1">(report based on logout date)</font></span></p>
<p><span style="background-color: #FFFFFF">Main Menu:
<a target="_top" href="dispatch_reports.htm">Fontana Dispatch Reports</a></span></p>
</BODY>
</HTML>