<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webAssigned Loads</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("FonDWSNoRepl_conn")) Then
    Set conn = Session("FonDWSNoRepl_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatchMSDE","IUSR_FON-DATA","sa"
    Set Session("FonDWSNoRepl_conn") = conn
End If
%>
<%
If IsObject(Session("webAssigned_Loads_rs")) Then
    Set rs = Session("webAssigned_Loads_rs")
Else
    sql = "SELECT IsNull([DWS rep data].dbo.[tbldestinationlist].[Destination], tbldestinationlist_2.destination) AS Shipper, tblDestinationList_1.Destination, Count(dbo.[tblPoscoLoads].[Load]) AS [Count] "
    sql = sql &  " FROM ((dbo.tblPoscoLoads INNER JOIN [DWS rep data].dbo.tblDestinationList AS tblDestinationList_1 ON "
    sql = sql &         " dbo.[tblPoscoLoads].[DeliveryLocation]=tblDestinationList_1.[Destination id]) LEFT JOIN [DWS rep data].dbo.tblDestinationList ON  "
    sql = sql &         " dbo.[tblPoscoLoads].[LoadFamily]=[DWS rep data].dbo.[tblDestinationList].[Destination id]) INNER JOIN [DWS rep data].dbo.tbldestinationList AS tblDestinationList_2 ON "
    sql = sql &         " dbo.[tblPoscoLoads].[LoadDestination]=tblDestinationList_2.[Destination id]  "
    sql = sql & " WHERE (((dbo.[tblPoscoLoads].[LogOut])=1) And ((dbo.[tblPoscoLoads].[LogOutDate])= CONVERT(datetime, CONVERT(char(10), GETDATE(), 101), 101)) )  " 
    sql = sql & " GROUP BY IsNull([DWS rep data].dbo.[tbldestinationlist].[Destination], tbldestinationlist_2.destination), tblDestinationList_1.Destination, dbo.[tblPoscoLoads].[Will Call] "
    sql = sql & " HAVING (((dbo.tblPoscoLoads.[Will Call])=0))  "
    sql = sql & " ORDER BY IsNull([DWS rep data].dbo.[tbldestinationlist].[Destination], tbldestinationlist_2.destination), tblDestinationList_1.Destination   " 
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