<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Administration_DestinationSets" Title="BOPS | Administration | Destination Sets" Codebehind="DestinationSets.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Destination Sets</h2>

    <asp:GridView ID="_SetsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="SetId,AllowDelete" 
        DataSourceID="_SetsDatasource" ForeColor="#333333" GridLines="None" 
        EmptyDataText="No destination sets exist to display; use the controls below to create one." >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:HyperLinkField HeaderText="ID" DataNavigateUrlFields="SetId" 
                DataNavigateUrlFormatString="DestinationSetAssignments.aspx?SetId={0}" DataTextField="SetId" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:HyperLinkField>
        
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>

            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="_DeleteLinkbutton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the destination set?");' Text="Delete" 
                        ForeColor="controltext" Visible='<%#Eval("AllowDelete").ToString().Equals("True")%>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:CommandField>            
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#C0FFFF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_SetsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        InsertCommand="INSERT INTO [Destination Sets] ([Name], [Allow Delete]) VALUES (@Name, 1)"
        SelectCommand="SELECT [Set Id] AS SetId, [Name], [Allow Delete] AS AllowDelete FROM [Destination Sets]"
        UpdateCommand="UPDATE [Destination Sets] SET [Name]=@Name WHERE [Set Id]=@SetId"
        DeleteCommand="DELETE FROM [Destination Sets] WHERE [Set Id] = @SetId AND [Allow Delete] = 1">
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <h3>Create New Destination Set</h3>
    <asp:Label ID="_NewSetNameLabel" runat="server" Text="New Set Name:"></asp:Label>
    <asp:TextBox ID="_NewSetNameTextbox" runat="server" ValidationGroup="CreateValidationGroup"></asp:TextBox>
    <asp:Button ID="_CreateButton" runat="server" OnClick="_CreateButton_Click" Text="Create" ValidationGroup="CreateValidationGroup" />

</asp:Content>
