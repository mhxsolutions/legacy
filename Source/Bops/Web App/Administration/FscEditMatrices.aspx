<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Administration_FscEditMatrices" Title="BOPS | Administration | FSC Matrices" Codebehind="FscEditMatrices.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>FSC Matrices</h2>
    <p>Use the grid to make changes to the FSC properties or click the linked matrix ID to edit the details.</p>
    
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="FscId" DataSourceID="FscMatricesList"
        ForeColor="#333333" GridLines="None">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
        
            <asp:HyperLinkField HeaderText="FSC" DataTextField="FscId" DataNavigateUrlFields="FscId" SortExpression="FscId" 
                DataNavigateUrlFormatString="FscForwardToMatrixDetailsEdit.aspx?FSCID={0}" HeaderStyle-HorizontalAlign="left"
                ItemStyle-VerticalAlign="top" />

            <asp:TemplateField HeaderText="Name" SortExpression="Name" HeaderStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="NameTextbox" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="NameExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="NameTextbox" ErrorMessage="Name is required" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Description" SortExpression="Description" HeaderStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="DescriptionTextbox" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="DescriptionExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="DescriptionTextbox" ErrorMessage="Description is required" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Cost Method" SortExpression="CostMethod" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:Label ID="CostMethodEditLabel" runat="server" Text='<%# Bind("CostMethod") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="CostMethodLabel" runat="server" Text='<%# Bind("CostMethod") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Begin Date" SortExpression="BeginDate" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="top">
                <EditItemTemplate>
                    <asp:TextBox ID="BeginDateTextbox" runat="server" Text='<%# Bind("BeginDate", "{0:MM-dd-yy}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="BeginDateExistsValidator" runat="server" ControlToValidate="BeginDateTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="dynamic" ErrorMessage="Begin date is required">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="BeginDateLabel" runat="server" Text='<%# Eval("BeginDate", "{0:MM-dd-yy}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="End Date" SortExpression="EndDate" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="top">
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
            
            <asp:CommandField ShowEditButton="True" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" />
            
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#C0FFFF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="FscMatricesList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [FSC Main].[FSC ID] as FscId, [FSC Main].Name, [FSC Main].Description, [FSC Cost Methods].Name AS [CostMethod], [FSC Main].[Begin Date] AS [BeginDate], [FSC Main].[End Date] AS [EndDate] FROM [FSC Main] INNER JOIN [FSC Cost Methods] ON [FSC Main].[Cost Method Ref] = [FSC Cost Methods].[Cost Method ID]"
        UpdateCommand="UPDATE [FSC Main] SET [Name] = @Name, [Description] = @Description, [Begin Date] = @BeginDate, [End Date] = @EndDate WHERE [FSC ID] = @FscId"
        InsertCommand="INSERT [FSC Main] ([Name], [Description], [Cost Method Ref], [Begin Date]) VALUES(@Name, @Description, @CostMethod, @BeginDate)">
        <InsertParameters>
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="CostMethod" />
            <asp:Parameter Name="BeginDate" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FscId" />
            <asp:Parameter Name="Name" />
            <asp:Parameter Name="Description" />
            <asp:Parameter Name="BeginDate" />
            <asp:Parameter Name="EndDate" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <h3>
        Add A New FSC Matrix</h3>
    <p>
        To add a new FSC matrix, provide the details and click the button. Note well: once
        a matrix has been created, its cost method <i>cannot</i> be changed.</p>
    <table>
        <tr>
            <td style="width: 100px">
                Cost Method:</td>
            <td style="width: 100px">
                Name:</td>
            <td style="width: 100px">
                Description:</td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:DropDownList ID="NewCostMethodDropdown" runat="server" DataSourceID="FscMatrixCostMethodsDatasource"
                    DataTextField="Name" DataValueField="Cost_Method_ID">
                </asp:DropDownList><asp:SqlDataSource ID="FscMatrixCostMethodsDatasource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Cost Method ID] AS Cost_Method_ID, [Name] FROM [FSC Cost Methods] WHERE [Cost Method ID] IN (1,2) ORDER BY [Cost Method ID]">
                </asp:SqlDataSource>
            </td>
            <td style="width: 100px" valign="top">
                <asp:TextBox ID="NewNameTextbox" runat="server" ValidationGroup="NewValidationGroup" ></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="NewNameExistsValidator" runat="server" ControlToValidate="NewNameTextbox"
                    ValidationGroup="NewValidationGroup" Display="dynamic" ErrorMessage="Name is required" Width="123px"></asp:RequiredFieldValidator></td>
            <td style="width: 100px" valign="top">
                <asp:TextBox ID="NewDescriptionTextbox" runat="server" ValidationGroup="NewValidationGroup" ></asp:TextBox><br />
                <asp:RequiredFieldValidator ID="NewDescriptionExistsValidator" runat="server" ControlToValidate="NewDescriptionTextbox"
                    ValidationGroup="NewValidationGroup" Display="dynamic" ErrorMessage="Description is required" Width="151px"></asp:RequiredFieldValidator></td>
            <td style="width: 100px" valign="top">
                <asp:Button ID="SaveButton" runat="server" Text="Add New Matrix" ValidationGroup="NewValidationGroup" OnClick="SaveButton_Click" /></td>
        </tr>
    </table>
</asp:Content>
