<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webTodays Unassigned Load Detail</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhDispatch_conn")) Then
    Set conn = Session("dhDispatch_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatchMSDE","IUSR_FON-DATA","sa" 
    Set Session("dhDispatch_conn") = conn
End If
%>
<%
If IsObject(Session("webTodays_Unassigned_Load_Detail_rs")) Then
    Set rs = Session("webTodays_Unassigned_Load_Detail_rs")
Else
    sql = "SELECT   IsNull([DWS rep data].dbo.[tbldestinationlist].[Destination], [tbldestinationlist_2].[destination]) AS Shipper, "
    sql = sql &     "tblDestinationList_1.Destination, dbo.ChkIIFCond(dbo.Check4Null([tbldestinationlist_1].[state]), [tbldestinationlist_1].[city], [tbldestinationlist_1].[city] + ', ' + [tbldestinationlist_1].[state]) AS [City/St], "
    sql = sql &     "dbo.tblPoscoLoads.[Load], dbo.tblPoscoLoads.LoadDate, dbo.tblPoscoLoads.LoadNotes  " 
    sql = sql & "FROM ((dbo.tblPoscoLoads INNER JOIN [DWS rep data].dbo.tblDestinationList AS tblDestinationList_1 ON " 
    sql = sql & "dbo.tblPoscoLoads.DeliveryLocation = tblDestinationList_1.[Destination id]) LEFT JOIN [DWS rep data].dbo.tblDestinationList ON " 
    sql = sql & "dbo.tblPoscoLoads.LoadFamily = [DWS rep data].dbo.tblDestinationList.[Destination id]) INNER JOIN [DWS rep data].dbo.tbldestinationList AS tblDestinationList_2 ON  " 
    sql = sql & "dbo.tblPoscoLoads.LoadDestination = tblDestinationList_2.[Destination id]  "
    sql = sql & "WHERE (((dbo.tblPoscoLoads.LoadDate)<=CONVERT(datetime, CONVERT(char(10), GETDATE(), 101), 101)) AND " 
    sql = sql & "((dbo.tblPoscoLoads.LogOut)=0) AND ((dbo.tblPoscoLoads.[Will Call])=0) AND ((dbo.tblPoscoLoads.LogOutDate)=CONVERT(datetime, CONVERT(char(10), GETDATE(), 101), 101)) Or " 
    sql = sql & "((dbo.tblPoscoLoads.LogOutDate) Is Null))  "
    sql = sql & "ORDER BY IsNull([DWS rep data].dbo.[tbldestinationlist].[Destination], [tbldestinationlist_2].[destination]), tblPoscoLoads.[Load]   "
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