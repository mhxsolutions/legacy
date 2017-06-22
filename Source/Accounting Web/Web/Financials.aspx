<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Financials.aspx.cs" Inherits="Financials" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Financials for Rick<br />
        </h3>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Financial ID" DataSourceID="SqlDataSource1"
            ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="Cash" DataFormatString="{0:c}" HeaderText="Cash" HtmlEncode="False"
                    SortExpression="Cash" />
                <asp:BoundField DataField="Money Market" DataFormatString="{0:c}" HeaderText="Money Market"
                    HtmlEncode="False" SortExpression="Money Market" />
                <asp:BoundField DataField="AR" DataFormatString="{0:c}" HeaderText="AR" HtmlEncode="False"
                    SortExpression="AR" />
                <asp:BoundField DataField="AP" DataFormatString="{0:c}" HeaderText="AP" HtmlEncode="False"
                    SortExpression="AP" />
                <asp:BoundField DataField="Created" HeaderText="Created" SortExpression="Created" />
            </Columns>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"
            ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>" DeleteCommand="DELETE FROM [Financial] WHERE [Financial ID] = @original_Financial_ID AND [Cash] = @original_Cash AND [Money Market] = @original_Money_Market AND [AR] = @original_AR AND [AP] = @original_AP AND [Created] = @original_Created"
            InsertCommand="INSERT INTO [Financial] ([Cash], [Money Market], [AR], [AP], [Created]) VALUES (@Cash, @Money_Market, @AR, @AP, @Created)"
            OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Financial] ORDER BY [Financial ID] DESC"
            UpdateCommand="UPDATE [Financial] SET [Cash] = @Cash, [Money Market] = @Money_Market, [AR] = @AR, [AP] = @AP, [Created] = @Created WHERE [Financial ID] = @original_Financial_ID AND [Cash] = @original_Cash AND [Money Market] = @original_Money_Market AND [AR] = @original_AR AND [AP] = @original_AP AND [Created] = @original_Created">
            <DeleteParameters>
                <asp:Parameter Name="original_Financial_ID" Type="Int64" />
                <asp:Parameter Name="original_Cash" Type="Decimal" />
                <asp:Parameter Name="original_Money_Market" Type="Decimal" />
                <asp:Parameter Name="original_AR" Type="Decimal" />
                <asp:Parameter Name="original_AP" Type="Decimal" />
                <asp:Parameter Name="original_Created" Type="DateTime" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Cash" Type="Decimal" />
                <asp:Parameter Name="Money_Market" Type="Decimal" />
                <asp:Parameter Name="AR" Type="Decimal" />
                <asp:Parameter Name="AP" Type="Decimal" />
                <asp:Parameter Name="Created" Type="DateTime" />
                <asp:Parameter Name="original_Financial_ID" Type="Int64" />
                <asp:Parameter Name="original_Cash" Type="Decimal" />
                <asp:Parameter Name="original_Money_Market" Type="Decimal" />
                <asp:Parameter Name="original_AR" Type="Decimal" />
                <asp:Parameter Name="original_AP" Type="Decimal" />
                <asp:Parameter Name="original_Created" Type="DateTime" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="Cash" Type="Decimal" />
                <asp:Parameter Name="Money_Market" Type="Decimal" />
                <asp:Parameter Name="AR" Type="Decimal" />
                <asp:Parameter Name="AP" Type="Decimal" />
                <asp:Parameter Name="Created" Type="DateTime" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        Insert New Financials<p>
            To add a new Financials record, provide at least a date in the fields below and
            click the button.</p>
        <table>
            <tr>
                <td style="width: 75px">
                    Cash</td>
                <td style="width: 75px">
                    Money Market</td>
                <td style="width: 75px">
                    AR</td>
                <td style="width: 75px">
                    AP</td>
                <td style="width: 75px">
                </td>
                <td style="width: 75px">
                    Date:</td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top; width: 75px">
                    <asp:TextBox ID="NewCurrentTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="vertical-align: top; width: 75px">
                    <asp:TextBox ID="NewThirtyTextBox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="vertical-align: top; width: 75px">
                    <asp:TextBox ID="NewFortyfiveTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="vertical-align: top; width: 75px">
                    <asp:TextBox ID="NewSixtyTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="vertical-align: top; width: 75px">
                </td>
                <td style="vertical-align: top; width: 75px">
                    <asp:TextBox ID="NewDateTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="NewDateExistsValidator" runat="server" ControlToValidate="NewDateTextbox"
                        Display="Dynamic" ErrorMessage="Date is required" ValidationGroup="NewValueValidation"></asp:RequiredFieldValidator></td>
                <td style="vertical-align: top">
                    <asp:Button ID="SaveButton" runat="server" OnClick="SaveButton_Click" Text="Add New History"
                        ValidationGroup="NewValueValidation" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
