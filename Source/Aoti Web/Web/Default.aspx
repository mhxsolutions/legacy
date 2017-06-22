<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alcoa One Time Inventory (AOTI)</title>
    
    <script runat="Server">
    protected void Page_Load(object sender, EventArgs e)
    {
        LocationTextbox.Focus();
    }
    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            AotiDatasource.InsertParameters["Location"].DefaultValue = LocationTextbox.Text;
            AotiDatasource.InsertParameters["Coil"].DefaultValue = CoilTextbox.Text;
            AotiDatasource.Insert();
            
            CoilTextbox.Text = string.Empty;
            CoilTextbox.Focus();
        }
    }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                AOTI</h1>
            <p>
                To enter a new record, supply the location and coil information, then click the
                "Save" button.</p>
            <table>
                <tr>
                    <td style="width: 100px">
                        Location:</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="LocationTextbox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="LocationRequiredValidator" runat="server" ControlToValidate="LocationTextbox"
                            Display="Dynamic" ErrorMessage="Location is required"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        Coil:</td>
                    <td style="width: 100px">
                        <asp:TextBox ID="CoilTextbox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CoilRequiredValidator" runat="server" ControlToValidate="CoilTextbox"
                            Display="Dynamic" ErrorMessage="Coil is required"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td style="width: 100px">
                        <asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click" /></td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="AotiDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [ID], [Location], [Coil] FROM [AOTI]" InsertCommand="INSERT INTO [AOTI] ([Location], [Coil]) VALUES (@Location, @Coil)">
            <InsertParameters>
                <asp:Parameter Name="Location" Type="string" />
                <asp:Parameter Name="Coil" Type="string" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
