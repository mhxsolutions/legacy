<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fuelprice.aspx.vb" Inherits="fuelprice" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Fuel Price History<br />
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
            Width="1075px">
            <series>
                <asp:Series ChartType="Line" Color="Red" Name="Series1" 
                    XValueMember="Begin_Date" YValueMembers="Fuel_Price">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea BackColor="192, 192, 255" BackGradientStyle="LeftRight" 
                    BackSecondaryColor="128, 128, 255" Name="ChartArea1">
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Font="Microsoft Sans Serif, 18pt, style=Bold" Name="Fuel History" 
                    Text="Fuel History">
                </asp:Title>
                <asp:Title Docking="Left" Font="Microsoft Sans Serif, 12pt" Name="Title1" 
                    Text="Price">
                </asp:Title>
            </Titles>
        </asp:Chart>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Begin Date] AS Begin_Date, [Fuel Price] AS Fuel_Price FROM [FSC Fuel Price History] WHERE ([Begin Date] &gt; @Begin_Date) ORDER BY [Begin Date]">
            <SelectParameters>
                <asp:Parameter DefaultValue="01/01/2010" Name="Begin_Date" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
