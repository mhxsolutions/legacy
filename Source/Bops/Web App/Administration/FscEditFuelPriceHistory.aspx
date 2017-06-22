<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Administration_FscEditFuelPriceHistory" Title="BOPS | Administration | FSC Fuel Price History" Codebehind="FscEditFuelPriceHistory.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        FSC Fuel Price History</h2>
    The following grid may be used to edit the fuel price history data, given the following conditions:<br />
    <ol>
        <li>The last row and <i>only</i> the last row must have a null (empty) end date value.</li>
        <li>The end date for a row must be the same as the begin date of the next row.</li>
    </ol>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="FuelPriceHistorySqlDataSource" ForeColor="#333333" GridLines="None" AllowSorting="True" DataKeyNames="FuelPriceId">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:TemplateField HeaderText="Begin Date" SortExpression="BeginDate" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="BeginDateTextbox" runat="server" Text='<%# Bind("BeginDate", "{0:MM-dd-yy}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="BeginDateExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="BeginDateTextbox" ErrorMessage="You must provide a begin date" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="BeginDateMinimumValidator" runat="server" ControlToValidate="BeginDateTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="Dynamic" 
                        ErrorMessage="Begin date must be >= 01/01/2007"
                        Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/2007">
                    </asp:CompareValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="BeginDateLabel" runat="server" Text='<%# Eval("BeginDate", "{0:MM-dd-yy}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="End Date" SortExpression="EndDate" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="EndDateTextbox" runat="server" Text='<%# Bind("EndDate", "{0:MM-dd-yy}") %>'></asp:TextBox><br />
                    <asp:CompareValidator ID="EndDateMinimumValidator" runat="server" ControlToValidate="EndDateTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="Dynamic" 
                        ErrorMessage="End date must be > begin date"
                        Operator="GreaterThan" Type="Date" ControlToCompare="BeginDateTextbox">
                    </asp:CompareValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="EndDateLabel" runat="server" Text='<%# Eval("EndDate", "{0:MM-dd-yy}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fuel Price" SortExpression="FuelPrice" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="FuelPriceTextbox" runat="server" Text='<%# Bind("FuelPrice") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="FuelPriceExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="FuelPriceTextbox" ErrorMessage="Fuel price is required" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="FuelPriceRangeValidator" runat="server" ControlToValidate="FuelPriceTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="Dynamic" 
                        ErrorMessage="The fuel price must be from $1.00 to $10.00"
                        MaximumValue="10.00" MinimumValue="1.00" Type="Double">
                    </asp:RangeValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="FuelPriceLabel" runat="server" Text='<%# Eval("Fuelprice", "{0:c3}") %>'></asp:Label>
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
    <asp:SqlDataSource ID="FuelPriceHistorySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [FSC Fuel Price ID] AS FuelPriceId, [Begin Date] AS BeginDate, [End Date] AS EndDate, [Fuel Price] AS FuelPrice FROM [FSC Fuel Price History]"
        UpdateCommand="UPDATE [FSC Fuel Price History] SET [Begin Date] = @BeginDate, [End Date] = @EndDate, [Fuel Price] = @FuelPrice WHERE [FSC Fuel Price ID] = @FuelPriceId">
        <UpdateParameters>
            <asp:Parameter Name="FuelPriceId" />
            <asp:Parameter Name="BeginDate" />
            <asp:Parameter Name="EndDate" />
            <asp:Parameter Name="FuelPrice" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <h3>
    Add A New Fuel Price</h3>
    To add a new fuel price, provide the begin date and price and click the button.
    The end date value in the last row will automatically be set correctly to the begin
    date you specify.<br />
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                Begin Date:</td>
            <td style="width: 100px">
                Fuel Price:</td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="NewBeginDateTextbox" runat="server" ValidationGroup="NewPriceValidationGroup"></asp:TextBox>
            </td>
            <td style="width: 100px">
                <asp:TextBox ID="NewFuelPriceTextbox" runat="server" ValidationGroup="NewPriceValidationGroup"></asp:TextBox>
            </td>
            <td style="width: 100px">
                <asp:Button ID="SaveButton" runat="server" Text="Add New Fuel Price" ValidationGroup="NewPriceValidationGroup" 
                    OnClick="SaveButton_Click" />
            </td>
        </tr>
    </table>
    <br />
    <asp:RequiredFieldValidator ID="NewBeginDateExistsValidator" runat="server" ControlToValidate="NewBeginDateTextbox"
        ValidationGroup="NewPriceValidationGroup" Display="Dynamic" 
        ErrorMessage="You must supply a begin date."></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="NewFuelPriceExistsValidator" runat="server" ControlToValidate="NewFuelPriceTextbox"
        ValidationGroup="NewPriceValidationGroup" Display="Dynamic" 
        ErrorMessage="You must supply a fuel price."></asp:RequiredFieldValidator>
    <asp:CompareValidator ID="NewBeginDateMinimumValidator" runat="server" ControlToValidate="NewBeginDateTextbox"
        ValidationGroup="NewPriceValidationGroup" Display="Dynamic" 
        ErrorMessage="The begin date must be on or after 01/01/2007."
        Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/2007"></asp:CompareValidator>
    <asp:RangeValidator ID="NewFuelPriceRangeValidator" runat="server" ControlToValidate="NewFuelPriceTextbox"
        ValidationGroup="NewPriceValidationGroup" Display="Dynamic" 
        ErrorMessage="The fuel price must be from $1.00 to $10.00."
        MaximumValue="10.00" MinimumValue="1.00" Type="Double"></asp:RangeValidator>
    <asp:CustomValidator ID="OnlyOneNullEndDateCustomValidator" runat="server" Display="Dynamic" 
        ValidationGroup="NewPriceValidationGroup" OnServerValidate="ServerValidateOnlyOneNullEndDate"
        ErrorMessage="Fuel price history has more than one row with a null end date and/or the new date is less than or equal to the last begin date."></asp:CustomValidator>
</asp:Content>
