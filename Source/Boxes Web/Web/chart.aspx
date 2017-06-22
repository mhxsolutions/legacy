<%@ Page Language="VB" AutoEventWireup="false" CodeFile="chart.aspx.vb" Inherits="chart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        GP wait time chart</div>
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
        Width="495px" EnableTheming="True">
        <Series>
            <asp:Series BorderWidth="4" ChartType="Line" Legend="Legend1" Name="Load Avg" 
                XValueMember="Date" YValueMembers="Load Avg">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" 
                Name="Wait" XValueMember="Date" YValueMembers="Wait Avg">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" 
                Name="Post Load" XValueMember="Date" YValueMembers="Post Load Avg">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
                <Area3DStyle LightStyle="Realistic" />
            </asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1">
            </asp:Legend>
        </Legends>
        <Titles>
            <asp:Title Font="Microsoft Sans Serif, 8.25pt, style=Bold" Name="GP Time" 
                Text="GP Time">
            </asp:Title>
        </Titles>
    </asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [willcall time analysis for phone]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
