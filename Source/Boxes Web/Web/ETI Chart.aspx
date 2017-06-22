<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ETI Chart.aspx.vb" Inherits="ETI_Chart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ETI Tons</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <strong>Bismarck ETI Tons 2012</strong></div>
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
        Width="567px">
        <Series>
            <asp:Series Legend="Legend1" Name="In" XValueMember="Month" 
                YValueMembers="Tons In">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Out" 
                XValueMember="Month" YValueMembers="Tons Out">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
            </asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Title="Tons">
            </asp:Legend>
        </Legends>
    </asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [ETI receiving and shipping tons summary] WHERE (([Terminal] = @Terminal) AND ([Year] = @Year)) ORDER BY [Month]">
        <SelectParameters>
            <asp:Parameter DefaultValue="T-Bis" Name="Terminal" Type="String" />
            <asp:Parameter DefaultValue="2012" Name="Year" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
