<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardCreate" Title="BOPS | RFS Wizard | Create RFS" Codebehind="RfsWizardCreate.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>
            <a class="selected" href="RfsWizardCreate.aspx">Create RFS</a>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a>
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

    <div style="z-index: 104; left: 0px; width: 1000px; top: 10px; ">

        <h2>Required Information</h2>
        <p>
            To make a new RFS, use the following fields
            to provide the necessary details and click the button to create it.</p>
        <div style="z-index: 105; left: 20px; position: relative">
            <table cellpadding="4">
                <tr>
                    <td>
                        <asp:Label ID="StatusLabel" AccessKey="T" AssociatedControlID="StatusList" runat="server" Text="S<u>t</u>atus:" />
                    </td>
                    <td style="width: 400px">
                        <asp:DropDownList ID="StatusList" runat="server" Width="400px" DataSourceID="RfsStatuses" DataTextField="Status" DataValueField="RFS Status ID" />
                        <asp:SqlDataSource
                            ID="RfsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [RFS Status ID], [Status] FROM [RFS Statuses]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="SalespersonLabel" AccessKey="P" AssociatedControlID="SalespersonList"
                            runat="server" Text="Sales<u>p</u>erson:" /></td>
                    <td style="width: 400px">
                        <asp:DropDownList ID="SalespersonList" runat="server" Width="400px" DataSourceID="BudwaySalespersons" DataTextField="Salesperson" DataValueField="EmployeeID" /><asp:SqlDataSource
                            ID="BudwaySalespersons" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT tblDriverList.EmployeeID, tblDriverList.FirstName + ' ' + tblDriverList.LastName AS Salesperson FROM tblDriverList INNER JOIN [Employee Roles] ON tblDriverList.EmployeeID = [Employee Roles].[Employee ref] INNER JOIN [Employee Role Types] ON [Employee Roles].[Employee Role Type ref] = [Employee Role Types].[Employee Role Type Id] WHERE ([Employee Role Types].Role = 'Sales') ORDER BY tblDriverList.LastName, tblDriverList.FirstName">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="ShipperLabel" AccessKey="S" AssociatedControlID="ShipperList" runat="server"
                            Text="<u>S</u>hipper:" /></td>
                    <td style="width: 400px">
                        <asp:DropDownList ID="ShipperList" runat="server" Width="400px" DataSourceID="Shippers" DataTextField="Destination" DataValueField="Destination_id" /><asp:SqlDataSource
                            ID="Shippers" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                            SelectCommand="SELECT [Destination id] AS Destination_id, [Destination id], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [tbldestinationList] ORDER BY [Destination]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="CommodityLabel" AccessKey="C" AssociatedControlID="CommodityList"
                            runat="server" Text="<u>C</u>ommodity:" /></td>
                    <td style="width: 400px">
                        <asp:DropDownList ID="CommodityList" runat="server" Width="400px" DataSourceID="AtsfProducts" DataTextField="Product_Type" DataValueField="ATSF_Product_ID" /><asp:SqlDataSource
                            ID="AtsfProducts" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                            SelectCommand="SELECT [ATSF Product ID] AS ATSF_Product_ID, [Product Type] AS Product_Type FROM [ATSF Product Type] ORDER BY [Product Type]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="WorkTypeLabel" AccessKey="W" AssociatedControlID="WorkTypeList"
                            runat="server" Text="<u>W</u>ork Type:" />
                    </td>
                    <td style="width: 400px">
                        <asp:DropDownList ID="WorkTypeList" runat="server" Width="400px" DataSourceID="RfsWorkTypes" DataTextField="Work_Type" DataValueField="RFS_Work_Type_ID" /><asp:SqlDataSource
                            ID="RfsWorkTypes" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [RFS Work Type ID] AS RFS_Work_Type_ID, [Work Type] AS Work_Type FROM [RFS Work Types] ORDER BY [Work Type]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </div>

        <p>
            <asp:Button ID="CreateRfsButton" runat="server" Text="Create RFS" OnClick="CreateRfsButton_Click" />
        </p>
        
    </div>

</asp:Content>
