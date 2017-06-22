<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>RM railcars by product this month</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhDispatchx_conn")) Then
    Set conn = Session("dhDispatchx_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatch","dan","love"
    Set Session("dhDispatchx_conn") = conn
End If
%>
<%
If IsObject(Session("RM_railcars_by_product_this_month_rs")) Then
    Set rs = Session("RM_railcars_by_product_this_month_rs")
Else
    sql = "SELECT [ATSF].[Terminal], IIf([S]='L','Inbound','Outbound') AS IO, IIf([product type]>'',[product type],'unassigned') AS Product, Count([ATSF].[Car Number]) AS [CountOfCar Number]  FROM [ATSF Product Type] RIGHT JOIN ATSF ON [ATSF Product Type].[ATSF Product ID]=[ATSF].[Product Type Ref]  WHERE ((([ATSF].[daterel]) Between DateSerial(DatePart('yyyy',Date()),DatePart('m',Date()),1) And Date()))  GROUP BY [ATSF].[Terminal], IIf([S]='L','Inbound','Outbound'), IIf([product type]>'',[product type],'unassigned')  ORDER BY [ATSF].[Terminal], IIf([S]='L','Inbound','Outbound'), IIf([product type]>'',[product type],'unassigned')   "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    If rs.eof Then
        rs.AddNew
    End If
    Set Session("RM_railcars_by_product_this_month_rs") = rs
End If
%>
<TABLE BORDER=1 BGCOLOR=#ffffff CELLSPACING=0><FONT FACE="Arial" COLOR=#000000><CAPTION><B>Railcars by product this month</B></CAPTION></FONT>

<THEAD>
<TR>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Terminal</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>IO</FONT></TH>
<TH BGCOLOR=#c0c0c0 BORDERCOLOR=#000000 ><FONT SIZE=2 FACE="Arial" COLOR=#000000>Product</FONT></TH>
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
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Terminal").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("IO").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0 ><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("Product").Value)%><BR></FONT></TD>
<TD BORDERCOLOR=#c0c0c0  ALIGN=RIGHT><FONT SIZE=2 FACE="Arial" COLOR=#000000><%=Server.HTMLEncode(rs.Fields("CountOfCar Number").Value)%><BR></FONT></TD>

</TR>
<%
rs.MoveNext
loop%>
</TBODY>
<TFOOT></TFOOT>
</TABLE>
<p><font size="2" face="Arial" color="#000000">*only includes released cars</font></p>
</BODY>
</HTML>