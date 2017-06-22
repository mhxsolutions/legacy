<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="RFS_RfsWizardMain" Title="BOPS | RFS Wizard | Main" Codebehind="RfsWizardMain.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>

            <!-- Show the create tab only if the user has advanced permissions -->
            
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
            <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a class="selected" href="RfsWizardMain.aspx">Main</a>
                <a href="RfsWizardStakeholders.aspx">Stakeholders</a>
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

    <div style="z-index: 104; left: 0px; width: 1000px; top: 10px;">
        <h2>
            Main Information</h2>
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <p>
                    The following fields display the top-level information for the RFS.
                </p>
            </LoggedInTemplate>
            <RoleGroups>
                <asp:RoleGroup Roles="Administrators,Power Users">
                    <ContentTemplate>
                        <p>
                            Use the fields below to provide the top-level information for the RFS as a whole.
                            Click the button at the bottom to save or one of the tabs at the top to navigate
                            elsewhere.
                        </p>
                    </ContentTemplate>
                </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
        <div style="z-index: 105; left: 20px; position: relative">
            <table cellpadding="4">
                <tr>
                    <td valign="top">
                        <asp:Label ID="LocationLabel" AccessKey="O" AssociatedControlID="LocationList" runat="server" Text="L<u>o</u>cation:" />
                    </td>
                    <td>
                        <asp:DropDownList ID="LocationList" runat="server" Width="400px" DataSourceID="LocationDatasource" DataTextField="Name" DataValueField="Location Code" />
                        <asp:SqlDataSource ID="LocationDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Location Code], [Name] FROM [RFS Locations] ORDER BY [Name]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="StatusLabel" AccessKey="T" AssociatedControlID="StatusList" runat="server" Text="S<u>t</u>atus:" />
                    </td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="StatusList" runat="server" Width="400px" DataSourceID="RfsStatuses" DataTextField="Status" DataValueField="RFS Status ID" />
                        <asp:SqlDataSource
                            ID="RfsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [RFS Status ID], [Status] FROM [RFS Statuses]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="SalespersonLabel" AccessKey="P" AssociatedControlID="SalespersonList"
                            runat="server" Text="Sales<u>p</u>erson:" /></td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="SalespersonList" runat="server" Width="400px" DataSourceID="BudwaySalespersons" DataTextField="Salesperson" DataValueField="EmployeeID" /><asp:SqlDataSource
                            ID="BudwaySalespersons" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT tblDriverList.EmployeeID, tblDriverList.FirstName + ' ' + tblDriverList.LastName AS Salesperson FROM tblDriverList INNER JOIN [Employee Roles] ON tblDriverList.EmployeeID = [Employee Roles].[Employee ref] INNER JOIN [Employee Role Types] ON [Employee Roles].[Employee Role Type ref] = [Employee Role Types].[Employee Role Type Id] WHERE ([Employee Role Types].Role = 'Sales') ORDER BY tblDriverList.LastName, tblDriverList.FirstName">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="ShipperLabel" AccessKey="S" AssociatedControlID="ShipperList" runat="server"
                            Text="<u>S</u>hipper:" /></td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="ShipperList" runat="server" Width="400px" DataSourceID="Shippers" DataTextField="Destination" DataValueField="Destination_id" /><asp:SqlDataSource
                            ID="Shippers" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                            SelectCommand="SELECT [Destination id] AS Destination_id, [Destination id], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [tbldestinationList] ORDER BY [Destination]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="CommodityLabel" AccessKey="C" AssociatedControlID="CommodityList"
                            runat="server" Text="<u>C</u>ommodity:" /></td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="CommodityList" runat="server" Width="400px" DataSourceID="AtsfProducts" DataTextField="Product_Type" DataValueField="ATSF_Product_ID" /><asp:SqlDataSource
                            ID="AtsfProducts" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                            SelectCommand="SELECT [ATSF Product ID] AS ATSF_Product_ID, [Product Type] AS Product_Type FROM [ATSF Product Type] ORDER BY [Product Type]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="WorkTypeLabel" AccessKey="W" AssociatedControlID="WorkTypeList"
                            runat="server" Text="<u>W</u>ork Type:" />
                    </td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="WorkTypeList" runat="server" Width="400px" DataSourceID="RfsWorkTypes" DataTextField="Work_Type" DataValueField="RFS_Work_Type_ID" /><asp:SqlDataSource
                            ID="RfsWorkTypes" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [RFS Work Type ID] AS RFS_Work_Type_ID, [Work Type] AS Work_Type FROM [RFS Work Types] ORDER BY [Work Type]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                
                <tr>
                    <td valign="top">
                        <asp:Label ID="DatesLabel" runat="server" AccessKey="B" AssociatedControlID="BeginDateTextbox" Text="<u>B</u>egin/End Date:"></asp:Label>
                    </td>
                    <td style="width: 400px" valign="top">
                    
                        <asp:TextBox ID="BeginDateTextbox" runat="server" />
                        <cc1:CalendarExtender ID="BeginDateCalendarExtender" runat="server" TargetControlID="BeginDateTextbox" 
                            PopupButtonID="BeginDateCalendarImage" />
                        <asp:Image ID="BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />

                        <asp:TextBox ID="EndDateTextbox" runat="server" />
                        <cc1:CalendarExtender ID="EndDateCalendarExtender" runat="server" TargetControlID="EndDateTextbox" 
                            PopupButtonID="EndDateCalendarImage" />
                        <asp:Image ID="EndDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />

                        <asp:CustomValidator ID="BeginDateCustomValidator" runat="server" ControlToValidate="BeginDateTextbox"
                            OnServerValidate="ServerValidateBeginDate" Display="Dynamic"
                            ErrorMessage="Begin date is required and must be >= 01/01/2007" ValidateEmptyText="True"></asp:CustomValidator></td>
                </tr>
                
                <tr>
                    <td valign="top">
                        <asp:Label ID="RailcarLabel" AccessKey="R" AssociatedControlID="RailcarTextbox"
                            runat="server" Text="<u>R</u>ailcar/Vessel:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="RailcarTextbox" runat="server" Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="FfdLabel" AccessKey="E" AssociatedControlID="FfdTextbox"
                            runat="server" Text="<u>E</u>TA/FFD:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="FfdTextbox" runat="server" Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LfdLabel" AccessKey="L" AssociatedControlID="LfdTextbox"
                            runat="server" Text="<u>L</u>FD:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="LfdTextbox" runat="server" Width="400px"></asp:TextBox>
                    </td>
                </tr>
                <tr valign="top">
                    <td valign="top">
                        <asp:Label ID="StorageFreeDaysLabel" AccessKey="F" AssociatedControlID="StorageFreeDaysTextbox" runat="server" Text="Storage <u>F</u>ree Days:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="StorageFreeDaysTextbox" runat="server" Width="400px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="StorageDaysRequiredValidator" runat="server" ControlToValidate="StorageFreeDaysTextbox"
                            Display="Dynamic" ErrorMessage="Storage free days is required" />
                        <asp:RangeValidator ID="StorageFreeDaysRangeValidator" runat="server" ControlToValidate="StorageFreeDaysTextbox"
                            Display="Dynamic" ErrorMessage="Storage free days (d) must be 0 <= d <= 365" MinimumValue="0" MaximumValue="365"/>
                    </td>
                </tr>
                <tr valign="top">
                    <td valign="top">
                        <asp:Label ID="DescriptionLabel" AccessKey="N" AssociatedControlID="DescriptionTextbox"
                            runat="server" Text="Descriptio<u>n</u>:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="DescriptionTextbox" runat="server" Height="300px" Width="400px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <p>
                <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" OnClick="SaveChangesButton_Click" />
                <asp:Button ID="SaveChangesAndProceedButton" runat="server" Text="Save and go to Stakeholders" 
                OnClick="SaveChangesAndProceedButton_Click" /></p>
        </div>
    </div>
    
</asp:Content>
