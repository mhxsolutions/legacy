<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webAssigned Loads</TITLE>
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
If IsObject(Session("webAssigned_Loads_rs")) Then
    Set rs = Session("webAssigned_Loads_rs")
Else
    sql = "SELECT IIf(IsNull([tbldestinationlist].[Destination]),tbldestinationlist_2.destination,[tbldestinationlist].[Destination]) AS Shipper, tblDestinationList_1.Destination, Count([tblPoscoLoads].[Load]) AS [Count]  FROM ((tblPoscoLoads INNER JOIN tblDestinationList AS tblDestinationList_1 ON [tblPoscoLoads].[DeliveryLocation]=tblDestinationList_1.[Destination id]) LEFT JOIN tblDestinationList ON [tblPoscoLoads].[LoadFamily]=[tblDestinationList].[Destination id]) INNER JOIN tbldestinationList AS tblDestinationList_2 ON [tblPoscoLoads].[LoadDestination]=tblDestinationList_2.[Destination id]  WHERE ((([tblPoscoLoads].[LogOut])=-1) And (([tblPoscoLoads].[LogOutDate])=Date()))  GROUP BY IIf(IsNull([tbldestinationlist].[Destination]),tbldestinationlist_2.destination,[tbldestinationlist].[Destination]), tblDestinationList_1.Destination, [tblPoscoLoads].[Will Call]  HAVING (((tblPoscoLoads.[Will Call])=False))  ORDER BY IIf(IsNull([tbldestinationlist].[Destination]),tbldestinationlist_2.destination,[tbldestinationlist].[Destination]), tblDestinationList_1.Destination   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("webAssigned_Loads_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Today's
    Assigned Loads</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Shipper</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Destination</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Count</FONT></TH>

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
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Count").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><font size="2" face="Arial" color="#000000">no will-call loads</font></p>
</BODY>
</HTML>