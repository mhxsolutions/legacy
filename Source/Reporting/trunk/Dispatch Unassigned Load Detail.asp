<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webTodays Unassigned Load Detail</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhDispatch_conn")) Then
    Set conn = Session("dhDispatchx_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatch","dan","love"
    Set Session("dhDispatchx_conn") = conn
End If
%>
<%
If IsObject(Session("webTodays_Unassigned_Load_Detail_rs")) Then
    Set rs = Session("webTodays_Unassigned_Load_Detail_rs")
Else
    sql = "SELECT IIf(IsNull([tbldestinationlist].[Destination]),[tbldestinationlist_2].[destination],[tbldestinationlist].[Destination]) AS Shipper, tblDestinationList_1.Destination, IIf(IsNull([tbldestinationlist_1].[state]),[tbldestinationlist_1].[city],[tbldestinationlist_1].[city] & ', ' & [tbldestinationlist_1].[state]) AS [City/St], tblPoscoLoads.Load, tblPoscoLoads.LoadDate, tblPoscoLoads.LoadNotes  FROM ((tblPoscoLoads INNER JOIN tblDestinationList AS tblDestinationList_1 ON tblPoscoLoads.DeliveryLocation = tblDestinationList_1.[Destination id]) LEFT JOIN tblDestinationList ON tblPoscoLoads.LoadFamily = tblDestinationList.[Destination id]) INNER JOIN tbldestinationList AS tblDestinationList_2 ON tblPoscoLoads.LoadDestination = tblDestinationList_2.[Destination id]  WHERE (((tblPoscoLoads.LoadDate)<=Date()) AND ((tblPoscoLoads.LogOut)=False) AND ((tblPoscoLoads.[Will Call])=False) AND ((tblPoscoLoads.LogOutDate)=Date() Or (tblPoscoLoads.LogOutDate) Is Null))  ORDER BY IIf(IsNull([tbldestinationlist].[Destination]),[tbldestinationlist_2].[destination],[tbldestinationlist].[Destination]), tblPoscoLoads.Load   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("webTodays_Unassigned_Load_Detail_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Today's Unassigned Loads
    w/Notes</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Shipper</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Destination</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>City/St</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Load</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Load
  Date</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Load
  Notes</FONT></TH>

</TR>
</THEAD>
<TBODY>
<%
On Error Resume Next
rs.MoveFirst
do while Not rs.eof
 %>
<TR VALIGN=TOP>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Shipper").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Destination").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("City/St").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Load").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("LoadDate").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("LoadNotes").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><font size="2" face="Arial" color="#000000">no will-call</font></p>
</BODY>
</HTML>