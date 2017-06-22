<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>webTodays Delivered Loads</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhdispatch_conn")) Then
    Set conn = Session("dhdispatch_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhdispatch","dan","love"
    Set Session("dhdispatch_conn") = conn
End If
%>
<%
If IsObject(Session("webTodays_Delivered_Loads_rs")) Then
    Set rs = Session("webTodays_Delivered_Loads_rs")
Else
    sql = "SELECT tbldestinationList_1.Destination AS Shipper, tbldestinationList.Destination, tbldestinationList.City, tblPoscoLoads.Load, tblPoscoLoads.LoadNotes  FROM (tblPoscoLoads INNER JOIN tbldestinationList ON tblPoscoLoads.LoadDestination = tbldestinationList.[Destination id]) INNER JOIN tbldestinationList AS tbldestinationList_1 ON tblPoscoLoads.LoadFamily = tbldestinationList_1.[Destination id]  WHERE (((tblPoscoLoads.LogOutDate)=Date()))  ORDER BY tbldestinationList_1.Destination, tbldestinationList.Destination, tbldestinationList.City, tblPoscoLoads.Load   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("webTodays_Delivered_Loads_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><b>Delivered
    Loads</b></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Shipper</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Destination</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>City</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Load</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000>Load
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
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Shipper").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Destination").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("City").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Load").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT style=FONT-SIZE:10pt FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("LoadNotes").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><font style="font-size: 10pt" face="Arial" color="#000000">* Includes Will
Call Loads</font></p>
</BODY>
</HTML>