<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardStakeholders" Title="BOPS | RFS Wizard | Stakeholders" Codebehind="RfsWizardStakeholders.aspx.cs" %>

<%@ Register Assembly="FarPoint.Web.Spread" Namespace="FarPoint.Web.Spread" TagPrefix="FarPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>

            <!-- Show the create tab only if the user has advanced permissions -->
            
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
            <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a>
                <a class="selected" href="RfsWizardStakeholders.aspx">Stakeholders</a>
                <a href="RfsWizardServices.aspx">Services</a>
            <% } %>
            
            <!-- Show the tools tab only if the user has selected/created an RFS and has advanced permissions -->
            
            <% if ((Session["CONTEXT_RFSID"] != null) && (User.IsInRole("Power Users") || User.IsInRole("Administrators"))) { %>
            <a href="RfsWizardTools.aspx">Tools</a>
            <% } %>
            
            <a href="RfsWizardHelp.aspx">Help Me!</a>
        </div>
    </div>

    <div style="z-index: 102; left: 0px; width: 1000px;">
        <div id="topbar">
            <div style="left: 0px; top: 5px; position: relative">
                <asp:Label ID="SelectedRfsLabel" runat="server" Text=""></asp:Label>            
            </div>
        </div>
    </div>

    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px;">

        <h2>Defining Stakeholders and Their Roles</h2>
        <p>
            Use this page to define the shipper and other stakeholders for this RFS.
            <a href="RfsWizardHelp.aspx#Stakeholder_Help">Click here for more information
            about stakeholders and their roles.</a>
        </p>
        
        <h3>Shipper Stakeholder</h3>
        <p>
            The shipper stakeholder is specified on the main page of data for the RFS. <a href="RfsWizardMain.aspx">Click here
            to visit that page</a> or simply click the tab above.
        </p>
        
        <h3>
            Other Stakeholders
        </h3>
        
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <p>
                    The following displays the stakeholders for the RFS. 
                </p>
            </LoggedInTemplate>
            <RoleGroups>
                <asp:RoleGroup Roles="Power Users,Administrators">
                <ContentTemplate>
                <p>
                    The following displays the stakeholders for the RFS. The delete and edit links may be
                    used to remove or change stakeholders.
                </p>
                </ContentTemplate>
            </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
        
        <asp:GridView ID="StakeholdersGridview" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataSourceID="RfsStakeholdersDatasource" DataKeyNames="StakeholderId" ForeColor="#333333" GridLines="None" AllowSorting="True">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:TemplateField HeaderText="Client" SortExpression="Client">
                    <EditItemTemplate>
                        <asp:DropDownList ID="StakeholderDropdown" runat="server" DataSourceID="StakeholderList"
                            DataTextField="Destination" DataValueField="Destination id" 
                            SelectedValue='<%# Bind("ClientRef") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="StakeholderLabel" runat="server" Text='<%# Bind("Client") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:TemplateField>
            
                <asp:TemplateField HeaderText="Role" SortExpression="Role">
                    <EditItemTemplate>
                        <asp:DropDownList ID="RoleDropdown" runat="server" DataSourceID="StakeholderRoleList"
                            DataTextField="Role" DataValueField="Role Id" SelectedValue='<%# Bind("RoleRef") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="RoleLabel" runat="server" Text='<%# Bind("Role") %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                
                <asp:HyperLinkField Text="References" DataNavigateUrlFormatString="RfsWizardStakeholderReferences.aspx?StakeholderId={0}" 
                    DataNavigateUrlFields="StakeholderId" />
                <asp:HyperLinkField Text="Instructions" DataNavigateUrlFormatString="RfsWizardStakeholderInstructions.aspx?StakeholderId={0}" 
                    DataNavigateUrlFields="StakeholderId" />

                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick='return confirm("Are you sure you want to delete the row?");' Text="Delete" 
                            ForeColor="controltext" />
                    </ItemTemplate>
                </asp:TemplateField>
                    
                <asp:CommandField ShowEditButton="True" >
                    <HeaderStyle HorizontalAlign="Left" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:CommandField>
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#C0FFFF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="RfsStakeholdersDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Stakeholders].[RFS ref] AS RfsRef, [RFS Stakeholders].[Stakeholder ID] AS StakeholderId, [RFS Stakeholders].[Client ref] AS ClientRef, [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') AS Client, [RFS Stakeholders].[Role ref] AS RoleRef, [RFS Stakeholder Roles].Role FROM [RFS Main] INNER JOIN [RFS Stakeholders] ON [RFS Main].[RFS ID] = [RFS Stakeholders].[RFS ref] INNER JOIN [RFS Stakeholder Roles] ON [RFS Stakeholders].[Role ref] = [RFS Stakeholder Roles].[Role Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[RFS ref] = @RfsId) AND ([RFS Stakeholders].[Role ref] <> 1)"
            UpdateCommand="UPDATE [RFS Stakeholders] SET [Client ref] = @ClientRef, [Role ref] = @RoleRef WHERE [Stakeholder ID] = @StakeholderId"
            DeleteCommand="DELETE FROM [RFS Stakeholders] WHERE [Stakeholder ID] = @StakeholderId"
            InsertCommand="INSERT INTO [RFS Stakeholders] ([RFS ref], [Role ref], [Client ref]) VALUES (@RfsId, @RoleRef, @ClientRef)">
            <SelectParameters>
                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ClientRef" />
                <asp:Parameter Name="RoleRef" />
                <asp:Parameter Name="StakeholderId" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="StakeholderId" />
            </DeleteParameters>
            <InsertParameters>
                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
                <asp:Parameter Name="RoleRef" />
                <asp:Parameter Name="ClientRef" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="StakeholderRoleList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Role Id], Role FROM [RFS Stakeholder Roles] WHERE ([Role Id] > 1) ORDER BY Role">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="StakeholderList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
            SelectCommand="SELECT [Destination id], Destination + ': ' + City + ', ' + ISNULL(State, '') AS Destination FROM tbldestinationList WHERE ([Parent Ref] = [Destination id])">
        </asp:SqlDataSource>
    </div>
    <asp:Panel ID="AddNewStakeholderPanel" runat="server">
        <h3>
            Add A New Stakeholder</h3>
        To add a new stakeholder, select the client and role and click the button.<br />
        <br />
        <table>
            <tr>
                <td style="width: 100px">
                    Client:</td>
                <td style="width: 100px">
                    Role:</td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <asp:DropDownList ID="NewClientDropdown" runat="server" DataSourceID="StakeholderList"
                        DataTextField="Destination" DataValueField="Destination id" ValidationGroup="NewValueValidation">
                    </asp:DropDownList>
                </td>
                <td style="width: 100px">
                    <asp:DropDownList ID="NewRoleDropdown" runat="server" DataSourceID="StakeholderRoleList"
                        DataTextField="Role" DataValueField="Role Id" ValidationGroup="NewValueValidation">
                    </asp:DropDownList>
                </td>
                <td style="width: 100px">
                    <asp:Button ID="SaveButton" runat="server" Text="Add New Stakeholder" ValidationGroup="NewValueValidation"
                        OnClick="SaveButton_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
