<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="Administration_FscEditFloatIndexedDetails" Title="BOPS | Administration | Edit Float Indexed FSC Matrix" Codebehind="FscEditFloatIndexedDetails.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Edit Float Indexed FSC Matrix</h2>
    <p>
        The grid below may be used to edit the matrix details.</p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="FscDetailId" DataSourceID="FscMatrixDetailsList" ForeColor="#333333"
        GridLines="None">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
        
            <asp:TemplateField HeaderText="Minimum" SortExpression="IndexMinimum" HeaderStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="MinimumTextbox" runat="server" Text='<%# Bind("IndexMinimum", "{0:N2}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="MinimumExistsValidator" runat="server" ControlToValidate="MinimumTextbox"
                    ValidationGroup="GridviewValidationGroup" ErrorMessage="Minimum is required"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="MinimumLabel" runat="server" Text='<%# Bind("IndexMinimum", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Maximum" SortExpression="IndexMaximum" HeaderStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="MaximumTextbox" runat="server" Text='<%# Bind("IndexMaximum", "{0:N2}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="MaximumExistsValidator" runat="server" ControlToValidate="MaximumTextbox"
                     Display="dynamic" ValidationGroup="GridviewValidationGroup" ErrorMessage="Maximum is required"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="MaximumGreaterThanMinimumValidator" runat="server" ControlToValidate="MaximumTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="Dynamic" 
                        ErrorMessage="Maximum must be > minimum" Operator="GreaterThan" Type="double" ControlToCompare="MinimumTextbox">
                    </asp:CompareValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="MaximumLabel" runat="server" Text='<%# Bind("IndexMaximum", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        
            <asp:TemplateField HeaderText="Value" SortExpression="FscValue" HeaderStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="ValueTextbox" runat="server" Text='<%# Bind("FscValue", "{0:N3}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="ValueExistsValidator" runat="server" ErrorMessage="Value is required"
                    ControlToValidate="ValueTextbox" ValidationGroup="GridviewValidationGroup" Display="Dynamic" ></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ValueLabel" runat="server" Text='<%# Bind("FscValue", "{0:N3}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the row?");' Text="Delete" 
                        ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" />
        </Columns>
        
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#C0FFFF" />
        <AlternatingRowStyle BackColor="White" />

    </asp:GridView>
    <asp:SqlDataSource ID="FscMatrixDetailsList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [FSC Detail ID] AS FscDetailId, [FSC Ref] AS FscRef, [Index Minimum] AS IndexMinimum, [Index Maximum] AS IndexMaximum, [FSC Value] AS FscValue FROM [FSC Detail Float Indexed] WHERE ([FSC Ref] = @FscRef) ORDER BY [Index Minimum]"
        DeleteCommand="DELETE FROM [FSC Detail Float Indexed] WHERE [FSC Detail ID] = @FscDetailId"
        InsertCommand="INSERT INTO [FSC Detail Float Indexed] ([FSC Ref], [Index Minimum], [Index Maximum], [FSC Value]) VALUES (@FscRef, @IndexMinimum, @IndexMaximum, @FscValue)"
        UpdateCommand="UPDATE [FSC Detail Float Indexed] SET [Index Minimum] = @IndexMinimum, [Index Maximum] = @IndexMaximum, [FSC Value] = @FscValue WHERE [FSC Detail ID] = @FscDetailId">
        <SelectParameters>
            <asp:QueryStringParameter Name="FscRef" QueryStringField="FSCID" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="FscDetailId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FscRef" Type="Int32" />
            <asp:Parameter Name="IndexMinimum" Type="Double" />
            <asp:Parameter Name="IndexMaximum" Type="Double" />
            <asp:Parameter Name="FscValue" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FscDetailId" Type="Int32" />
            <asp:Parameter Name="IndexMinimum" Type="Double" />
            <asp:Parameter Name="IndexMaximum" Type="Double" />
            <asp:Parameter Name="FscValue" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>
        Add A New Value</h3>
    To add a new value, provide the required values and click the button.<br /><br />
    <div style="text-align: left">
        <table>
            <tr>
                <td style="width: 100px">
                    Minimum:</td>
                <td style="width: 100px">
                    Maximum:</td>
                <td style="width: 100px">
                    Value:</td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:TextBox ID="NewMinimumTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="NewMaximumTextBox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:TextBox ID="NewValueTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
                <td style="width: 100px">
                    <asp:Button ID="SaveButton" runat="server" Text="Add New Value" OnClick="SaveButton_Click" ValidationGroup="NewValueValidation" /></td>
            </tr>
        </table>
    </div>
    <br />
    <asp:RequiredFieldValidator ID="NewMinimumExistsValidator" runat="server" ControlToValidate="NewMinimumTextbox"
        Display="Dynamic" ErrorMessage="Minimum is required." ValidationGroup="NewValueValidation"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="NewMaximumExistsValidator" runat="server" ControlToValidate="NewMaximumTextBox"
        ErrorMessage="Maximum is required." ValidationGroup="NewValueValidation" Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="NewValueExistsValidator" runat="server" ControlToValidate="NewValueTextbox"
        ErrorMessage="Value is required." ValidationGroup="NewValueValidation" Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:CompareValidator ID="NewMaximumGreaterThanMinimumValidator" runat="server" ControlToCompare="NewMinimumTextbox"
        ControlToValidate="NewMaximumTextBox" Display="Dynamic" ErrorMessage="Maximum must be larger than minimum."
        Operator="GreaterThan" ValidationGroup="NewValueValidation"></asp:CompareValidator>
    <asp:CustomValidator ID="NewValueCustomValidator" runat="server" Display="Dynamic" OnServerValidate="ServerValidateNewValue"
        ValidationGroup="NewValueValidation" ErrorMessage="The new range overlaps existing data and cannot be added." ControlToValidate="NewMinimumTextbox"></asp:CustomValidator>
</asp:Content>
