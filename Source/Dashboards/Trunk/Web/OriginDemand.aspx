<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OriginDemand.aspx.cs" Inherits="OriginDemand" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Origin Summary Demand</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Origin Demand Summary</h3>
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="Plan_Date" DataValueField="Plan_Date">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Demand Load Count Origin Summary] ORDER BY [Plan Date] DESC">
        </asp:SqlDataSource>
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Demand Load Count Origin Summary] WHERE ([Plan Date] = @Plan_Date) ORDER BY [Origin]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Plan_Date" PropertyName="SelectedValue"
                    Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
