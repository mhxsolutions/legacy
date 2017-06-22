<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=windows-1252">
<TITLE>chartOnTimeDeliveryPerformanceXP</TITLE>
</HEAD>
<BODY>
<%
If IsObject(Session("dhDispatch_conn")) Then
    Set conn = Session("dhDispatch_conn")
Else
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.open "dhDispatch","dan","love"
    Set Session("??dhDispatch_conn") = conn
End If
%>

</BODY>
</HTML>