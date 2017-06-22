<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Administration_DestinationSetAssignments" 
    Title="BOPS | Administration | Destination Set Assignments" Codebehind="DestinationSetAssignments.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Destination Set Assignments</h2>
    
    <h3><asp:Label ID="_HeaderLabel" runat="server" /></h3>
    
    <asp:GridView ID="_DestinationsGridView" runat="server" AutoGenerateColumns="False" CellPadding="4" 
        DataSourceID="_AssignmentsDatasource" ForeColor="#333333" GridLines="None" DataKeyNames="Id"
        EmptyDataText="No destinations are assigned to the current set. Use the controls above to add them." OnRowCreated="_DestinationsGridView_RowCreated" OnRowDeleted="_DestinationsGridView_RowDeleted" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" SortExpression="Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="_DeleteLinkbutton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to remove the destination from the set?");' Text="Delete" 
                        ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_AssignmentsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        InsertCommand="INSERT INTO [Destination Set Assignments] ([Set Ref], [Destination Ref]) VALUES (@SetId, @DestinationId)"
        SelectCommand="SELECT [Destination Set Assignments].[Destination Ref] AS Id, [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') AS Destination, [Destination Set Assignments].[Set Ref] FROM [Destination Set Assignments] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Destination Set Assignments].[Destination Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([Destination Set Assignments].[Set Ref] = @SetId) ORDER BY Destination"
        DeleteCommand="DELETE FROM [Destination Set Assignments] WHERE [Set Ref] = @SetId AND [Destination Ref] = @Id"
        >
        <InsertParameters>
            <asp:QueryStringParameter Name="SetId" QueryStringField="SetId" />
            <asp:ControlParameter Name="DestinationId" ControlID="_DestinationsDropdownlist" PropertyName="SelectedValue" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="SetId" QueryStringField="SetId" />
        </SelectParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="SetId" QueryStringField="SetId" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <h3>Create New Assignment</h3>
    <asp:Label ID="_NewDestinationLabel" runat="server" Text="Destination to Add:" />
    <asp:DropDownList ID="_DestinationsDropdownlist" runat="server" DataSourceID="_DestinationsDatasource" 
        DataTextField="Name" DataValueField="Id" Width="400"/>
    <asp:SqlDataSource
        ID="_DestinationsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
        SelectCommand="SELECT [Destination id] AS Id, Destination + N': ' + City + N', ' + ISNULL(State, N'') AS Name FROM tbldestinationList WHERE ([Destination id] NOT IN (SELECT [Destination Ref] FROM [DWS No Rep Data].dbo.[Destination Set Assignments] WHERE ([Set Ref] = @SetId))) ORDER BY Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="SetId" QueryStringField="SetId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="_AddButton" runat="server" Text="Add" OnClick="_AddButton_Click" />

    <p>
        <a href="DestinationSets.aspx">Click here to return to the list of destination sets.</a>
    </p>

</asp:Content>

