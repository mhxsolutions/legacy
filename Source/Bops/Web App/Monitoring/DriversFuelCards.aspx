
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Monitoring_DriversFuelCards" Title="BOPS | Monitoring | Drivers Fuel Cards" Codebehind="DriversFuelCards.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Drivers Fuel Cards</h2>
    
    <p>The following shows the defined fuel card assignments. Driver fuel usage summary <a href="DriversFuelUsageSummary.aspx">is available here</a>.</p>
    
    <asp:GridView ID="DriverFuelCardsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CardId" DataSourceID="DriverFuelCardsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:TemplateField HeaderText="Card ID" SortExpression="CardId">
                <EditItemTemplate>
                    <asp:TextBox ID="CardIdTextbox" runat="server" Text='<%# Bind("CardId") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="CardIdExistsValidator" runat="server" ControlToValidate="CardIdTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="dynamic" ErrorMessage="Card ID is required">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="CardIdLabel" runat="server" Text='<%# Bind("CardId") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Driver" SortExpression="Driver">
                <EditItemTemplate>
                    <asp:TextBox ID="DriverTextbox" runat="server" Text='<%# Bind("Driver") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="DriverExistsValidator" runat="server" ControlToValidate="DriverTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="dynamic" ErrorMessage="Driver is required">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="DriverLabel" runat="server" Text='<%# Bind("Driver") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the fuel card assignment?");' Text="Delete" 
                        ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#C0FFFF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    
    <h3>Add A New Assignment</h3>
    <table>
        <tr>
            <td style="width: 100px">Card ID</td>
            <td style="width: 100px">Driver</td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:TextBox ID="CardIdTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox>
            </td>
            <td style="width: 100px">
                <asp:DropDownList ID="DriversDropdownlist" runat="server" DataSourceID="DriversDatasource"
                    DataTextField="Name" DataValueField="EmployeeID" ValidationGroup="NewValueValidation">
                </asp:DropDownList>
            </td>
            <td style="width: 100px">
                <asp:Button ID="AddButton" runat="server" Text="Add Assignment" ValidationGroup="NewValueValidation" OnClick="AddButton_Click"/>
            </td>
        </tr>
    </table>
    
    <asp:CustomValidator ID="NewValueCustomValidator" runat="server" Display="Dynamic" OnServerValidate="ServerValidateNewValue"
        ValidationGroup="NewValueValidation" ErrorMessage="The fuel card is already assigned." ControlToValidate="CardIdTextbox"></asp:CustomValidator>
    
    <asp:SqlDataSource ID="DriverFuelCardsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        InsertCommand="INSERT INTO [Fuel Card Driver Assignments] ([Card Id], [Driver Ref]) VALUES(@CardId, @DriverId)"
        SelectCommand="SELECT [Fuel Card Driver Assignments].[Card Id] AS CardId, tblDriverList.LastName + N', ' + tblDriverList.FirstName AS Driver FROM [Fuel Card Driver Assignments] INNER JOIN tblDriverList ON [Fuel Card Driver Assignments].[Driver Ref] = tblDriverList.EmployeeID ORDER BY [Fuel Card Driver Assignments].[Card Id]"
        DeleteCommand="DELETE FROM [Fuel Card Driver Assignments] WHERE [Card Id] = @CardId">
        <InsertParameters>
            <asp:Parameter Name="CardId" Type="string" />
            <asp:Parameter Name="DriverId" Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="CardId" Type="string" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DriversDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT EmployeeID, LastName + N', ' + FirstName AS Name FROM tblDriverList WHERE (LastName IS NOT NULL) AND (FirstName IS NOT NULL) ORDER BY LastName, FirstName">
    </asp:SqlDataSource>
    
</asp:Content>
