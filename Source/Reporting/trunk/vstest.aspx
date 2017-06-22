<%@ Page Language="VB" AutoEventWireup="false" CodeFile="vstest.aspx.vb" Inherits="vstest" %>

<%@ Register Assembly="DundasWebChart" Namespace="Dundas.Charting.WebControl" TagPrefix="DCWC" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dcwc:chart id="Chart1" runat="server" palette="Pastel"><Series>
<DCWC:Series BorderWidth="2" ShadowOffset="1" BorderColor="64, 64, 64" Name="Series1" ChartType="Spline"></DCWC:Series>
<DCWC:Series BorderWidth="2" ShadowOffset="1" BorderColor="64, 64, 64" Name="Series2" ChartType="Spline"></DCWC:Series>
</Series>
<Legends>
<DCWC:Legend Name="Default"></DCWC:Legend>
</Legends>
<ChartAreas>
<DCWC:ChartArea Name="Default"></DCWC:ChartArea>
</ChartAreas>
</dcwc:chart>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Throughput 30 day avg]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
