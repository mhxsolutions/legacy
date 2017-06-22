<%--

    This page was created when Dan asked me for a page that he could use to demonstrate our ability
    to enter data on a barcode gun and then display it on the web. It presumably can be deleted
    any time after his demo, as can the [DWS No Rep Data].dbo.[InvDemo] table in the database.
    
    Dan snuck in and added the TypeTextBox code. It seems to work.
 
--%>

<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Demo</title>

    <script runat="Server">
        protected void Page_Load(object Sender, EventArgs E)
        {
            DropDownList1.Focus();
        }

        protected void SaveButton_Click(object Sender, EventArgs E)
        {
            if (!Page.IsValid) return;

            _InvDemoDatasource.InsertParameters["Id"].DefaultValue = _IdTextbox.Text;
            _InvDemoDatasource.InsertParameters["Value"].DefaultValue = _ValueTextbox.Text;
            _InvDemoDatasource.InsertParameters["Type"].DefaultValue = DropDownList1.Text;
            _InvDemoDatasource.Insert();

            _IdTextbox.Text = _ValueTextbox.Text = string.Empty;
            _IdTextbox.Focus();
        }
    </script>

</head>
<body>
    <form id="_Form1" runat="server">
        <div>
            <h2>
                Inventory Demo (dh)</h2>
            <table>
                <tr>
                    <td style="width: 100px">
                        Type:</td>
                    <td style="width: 100px">
                        &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                            DataTextField="Type" DataValueField="Type">
                        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Type] FROM [InvDemoTypes] ORDER BY [Code]"></asp:SqlDataSource>
                    <asp:RequiredFieldValidator ID="_TypeRequiredValidator" runat="server" ControlToValidate="DropDownList1"
                        Display="Dynamic" ErrorMessage="Type is required"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:Label ID="_Label1" runat="server" Text="ID:"></asp:Label></td>
                    <td style="width: 100px">
                        <asp:TextBox ID="_IdTextbox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="_IdRequiredValidator" runat="server" ControlToValidate="_IdTextbox"
                            Display="Dynamic" ErrorMessage="ID is required"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <asp:Label ID="_Label2" runat="server" Text="Value:"></asp:Label></td>
                    <td style="width: 100px">
                        <asp:TextBox ID="_ValueTextbox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="_ValueRequiredValidator" runat="server" ControlToValidate="_ValueTextbox"
                            Display="Dynamic" ErrorMessage="Value is required"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 51px;">
                    </td>
                    <td style="width: 100px; height: 51px;">
                        <asp:Button ID="_SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" Height="53px" Width="108px" /></td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="_InvDemoDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [ID], [Value], [Type] FROM [InvDemo]" InsertCommand="INSERT INTO [InvDemo] ([ID], [Value], [Type]) VALUES (@Id, @Value, @Type)">
            <InsertParameters>
                <asp:Parameter Name="Id" Type="String" />
                <asp:Parameter Name="Value" Type="Double" />
                <asp:Parameter Name="Type" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        Reports<br />
        <a href="InvDemoReport.aspx">Detail Report</a><br />
        <a href="InvDemoReportSummary.aspx">Summary Report</a>
    </form>
</body>
</html>
