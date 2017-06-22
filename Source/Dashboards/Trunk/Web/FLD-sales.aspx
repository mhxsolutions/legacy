<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FLD-sales.aspx.cs" Inherits="FLD_sales" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [FLD Detail INFO] WHERE ([Name] = @Name) ORDER BY [Name], [FLD Category Index], [FLD Activity Index]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Name" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="Name" DataValueField="Name">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Name] FROM [FLD Detail INFO]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
