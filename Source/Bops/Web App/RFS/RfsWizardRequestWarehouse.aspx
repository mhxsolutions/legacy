<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardRequestWarehouse" Title="BOPS | RFS Wizard | Warehouse" Codebehind="RfsWizardRequestWarehouse.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script language="javascript" type="text/javascript">
        function GetObj(name)
        {
            // DHTML Micro API
            // Source: http://www.quirksmode.org/js/dhtmloptions.html
            
            if (document.getElementById) // test if browser supports document.getElementById
            {
                this.obj = document.getElementById(name);
                this.style = document.getElementById(name).style;
            }
            else if (document.all) // test if browser supports document.all
            {
                this.obj = document.all[name];
                this.style = document.all[name].style;
            }
            else if (document.layers) // test if browser supports document.layers
            {
                this.obj = document.layers[name];
                this.style = document.layers[name].style;
            }
        }

        function UpdatePrivateCostControls(Method)
        {
            var CostTextbox = new GetObj("<%=CostTextbox.ClientID%>");
            var PerLabel = new GetObj("<%=PerLabel.ClientID%>");
            var UnitDropdown = new GetObj("<%=CostUnitList.ClientID%>");
            var MatricesDropdown = new GetObj("<%=CostMatrixList.ClientID%>");
            var SpecialUnitTextbox = new GetObj("<%=SpecialUnitTextbox.ClientID%>");
            
            if (Method == 1)        // Flat Fee
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 2)   // Per Unit
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "";
                UnitDropdown.obj.style.display = "";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 3)   // Matrix
            {
                CostTextbox.obj.style.display = "none";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 4)   // Per Special Unit
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "";
            }
            else if (Method == 5)        // Per Item
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
        }
        
        function UpdatePublicCostControls(Method)
        {
            var CostTextbox = new GetObj("<%=PublicCostTextbox.ClientID%>");
            var PerLabel = new GetObj("<%=PublicPerLabel.ClientID%>");
            var UnitDropdown = new GetObj("<%=PublicCostUnitList.ClientID%>");
            var MatricesDropdown = new GetObj("<%=PublicCostMatrixList.ClientID%>");
            var SpecialUnitTextbox = new GetObj("<%=PublicSpecialUnitTextbox.ClientID%>");
            
            if (Method == 1)        // Flat Fee
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 2)   // Per Unit
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "";
                UnitDropdown.obj.style.display = "";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 3)   // Matrix
            {
                CostTextbox.obj.style.display = "none";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "";
                SpecialUnitTextbox.obj.style.display = "none";
            }
            else if (Method == 4)   // Per Special Unit
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "";
            }
            else if (Method == 5)        // Per Item
            {
                CostTextbox.obj.style.display = "";
                PerLabel.obj.style.display = "none";
                UnitDropdown.obj.style.display = "none";
                MatricesDropdown.obj.style.display = "none";
                SpecialUnitTextbox.obj.style.display = "none";
            }
        }

        function CopyObjectValue(SourceObjectId, DestinationObjectId)
        {
            var SourceObject = new GetObj(SourceObjectId);
            var DestinationObject = new GetObj(DestinationObjectId);
            DestinationObject.obj.value = SourceObject.obj.value;
        }
        
        function CopyPrivateRateToPublicRate(source, arguments)
        {
            var PrivateCostMethodList = new GetObj("<%=CostMethodList.ClientID%>");
            CopyObjectValue("<%=CostMethodList.ClientID%>", "<%=PublicCostMethodList.ClientID%>");
            UpdatePublicCostControls(PrivateCostMethodList.obj.value);
            
            CopyObjectValue("<%=CostTextbox.ClientID%>", "<%=PublicCostTextbox.ClientID%>");
            CopyObjectValue("<%=CostUnitList.ClientID%>", "<%=PublicCostUnitList.ClientID%>");
            CopyObjectValue("<%=CostMatrixList.ClientID%>", "<%=PublicCostMatrixList.ClientID%>");
            CopyObjectValue("<%=PrivateWhenChargedList.ClientID%>", "<%=PublicWhenChargedList.ClientID%>");
            CopyObjectValue("<%=SpecialUnitTextbox.ClientID%>", "<%=PublicSpecialUnitTextbox.ClientID%>");
        }
        
        function CopyPublicRateToPrivateRate(source, arguments)
        {
            var PublicCostMethodList = new GetObj("<%=PublicCostMethodList.ClientID%>");
            CopyObjectValue("<%=PublicCostMethodList.ClientID%>", "<%=CostMethodList.ClientID%>");
            UpdatePrivateCostControls(PublicCostMethodList.obj.value);
            
            CopyObjectValue("<%=PublicCostTextbox.ClientID%>", "<%=CostTextbox.ClientID%>");
            CopyObjectValue("<%=PublicCostUnitList.ClientID%>", "<%=CostUnitList.ClientID%>");
            CopyObjectValue("<%=PublicCostMatrixList.ClientID%>", "<%=CostMatrixList.ClientID%>");
            CopyObjectValue("<%=PublicWhenChargedList.ClientID%>", "<%=PrivateWhenChargedList.ClientID%>");
            CopyObjectValue("<%=PublicSpecialUnitTextbox.ClientID%>", "<%=SpecialUnitTextbox.ClientID%>");
        }

        function ValidateStakeholderSelection(dropdownlistid)
        {
            var Dropdown = new GetObj(dropdownlistid);
            return Dropdown.obj.value != "";
        }

        function ClientValidateBillTo(source, arguments)
        {
            arguments.IsValid = ValidateStakeholderSelection("<%=BillToStakeholderList.ClientID%>");
        }

        function ClientValidateReceiver(source, arguments)
        {
            arguments.IsValid = ValidateStakeholderSelection("<%=ReceiverStakeholderList.ClientID%>");
        }
        
    </script>

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

    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px;">
    
        <h2><% Response.Write(Request.QueryString["mode"]); %> Warehouse Service <% Response.Write(Request.QueryString["ServiceId"]); %></h2>
        <p>
            Use the fields below to configure the service as desired and click the button at the bottom to save.
            To return to the services page, click the tab at the top.
        </p>

        <div style="z-index: 105; left: 20px; position: relative">
            <table cellpadding="4">
                <tr class="header"><td colspan="2" valign="top">Warehouse Details</td></tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="GroupLabel" AccessKey="G" AssociatedControlID="" runat="server" Text="<u>G</u>roup:" />
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="GroupDropdown" runat="server">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>6</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>8</asp:ListItem>
                            <asp:ListItem>9</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>

                <asp:Panel ID="ScopePanel" runat="Server">
                <tr>
                    <td>
                        <asp:Label ID="ScopeLabel" AccessKey="S" AssociatedControlID="ScopeDropdown" runat="server" Text="<u>S</u>cope:" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ScopeDropdown" runat="server">
                            <asp:ListItem>Both</asp:ListItem>
                            <asp:ListItem>Public</asp:ListItem>
                            <asp:ListItem>Private</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                </asp:Panel>
                
                <tr>
                    <td valign="top">
                        <asp:Label ID="ServiceLabel" AccessKey="S" AssociatedControlID="ServicesList"
                            runat="server" Text="<u>S</u>ervice:" /></td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="ServicesList" runat="server" DataSourceID="ServiceList" DataTextField="Name"
                            DataValueField="Service_Offered_Id" Width="400px">
                        </asp:DropDownList><asp:SqlDataSource ID="ServiceList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Service Offered Id] AS Service_Offered_Id, [Name] FROM [RFS Services Offered] WHERE ([Service Category Ref] = @Service_Category_Ref)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="2" Name="Service_Category_Ref" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="BillToLabel" AccessKey="B" AssociatedControlID="BillToStakeholderList"
                            runat="server" Text="<u>B</u>ill-to:" /></td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="BillToStakeholderList" runat="server" DataSourceID="BillToStakeholders"
                            DataTextField="Destination" DataValueField="Stakeholder ID" AppendDataBoundItems="True" Width="400px">
                            <asp:ListItem Value="">You must select a stakeholder</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="BillToStakeholderCustomValidator" runat="server" 
                            ClientValidationFunction="ClientValidateBillTo" OnServerValidate="ServerValidateBillTo"
                            ValidateEmptyText="True" ControlToValidate="BillToStakeholderList" 
                            ErrorMessage="You must specify a bill-to stakeholder."></asp:CustomValidator>
                        <asp:SqlDataSource ID="BillToStakeholders" runat="server"
                            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [RFS Stakeholders] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[RFS ref] = @RfsId) AND ([RFS Stakeholders].[Role ref] = 5) ORDER BY [DWS Rep Data].dbo.tbldestinationList.Destination">
                            <SelectParameters>
                                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="ShipperLabel" AccessKey="S" runat="server" Text="Shipper:" />
                    </td>
                    <td style="width: 400px" valign="top">
                        <asp:Label ID="ShipperStakeholderLabel" runat="server" Width="400px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="ReceiverLabel" AccessKey="R" AssociatedControlID="ReceiverStakeholderList"
                            runat="server" Text="<u>R</u>eceiver:" />
                    </td>
                    <td style="width: 400px" valign="top">
                        <asp:DropDownList ID="ReceiverStakeholderList" runat="server" DataSourceID="ReceiverStakeholders" DataTextField="Destination" 
                            DataValueField="Stakeholder ID" AppendDataBoundItems="True" Width="400px">
                            <asp:ListItem Value="">You must select a stakeholder</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="ReceiverStakeholderCustomValidator" runat="server" 
                            ClientValidationFunction="ClientValidateReceiver" OnServerValidate="ServerValidateReceiver"
                            ValidateEmptyText="True" ControlToValidate="ReceiverStakeholderList" 
                            ErrorMessage="You must specify a receiver stakeholder."></asp:CustomValidator>
                        <asp:SqlDataSource ID="ReceiverStakeholders" runat="server"
                            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [RFS Stakeholders] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[RFS ref] = @RfsId) AND ([RFS Stakeholders].[Role ref] = 2) ORDER BY [DWS Rep Data].dbo.tbldestinationList.Destination">
                            <SelectParameters>
                                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr valign="top">
                    <td valign="top">
                        <asp:Label ID="SpecialNeedsLabel" AccessKey="N" AssociatedControlID="SpecialNeedsTextbox"
                            runat="server" Text="Special <u>N</u>eeds:" />
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="SpecialNeedsTextbox" runat="server" Height="100px" Width="400px"></asp:TextBox>
                    </td>
                </tr>
                
                <!-- Public Rate Information -->
                
                <tr class="header">
                    <td colspan="3" valign="top">
                        <table style="width: 100%;"> 
                            <tr>
                                <td>
                                    Public Rate Information
                                </td>
                                <td style="text-align: right;">
                                    <% if (User.IsInRole("Administrators")) { %>
                                        <input type="button" onclick="CopyPrivateRateToPublicRate();" value="Copy From Private"/>
                                    <% } %>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicCostMethodLabel" runat="server" Text="Cost <u>M</u>ethod:" AccessKey="M" AssociatedControlID="PublicCostMethodList"/>
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="PublicCostMethodList" runat="server" DataSourceID="CostMethods" DataTextField="Cost_Method" DataValueField="Cost_Method_ID"/>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicCostLabel" runat="server" Text="Cost:"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="PublicCostTextbox" runat="server" Width="75"/>
                        <asp:Label ID="PublicPerLabel" runat="server" Text=" per "/>
                        <asp:DropDownList ID="PublicCostUnitList" runat="server" DataSourceID="CostUnitTypes" DataTextField="Unit" DataValueField="Unit_ID"/>
                        <asp:DropDownList ID="PublicCostMatrixList" runat="server" DataSourceID="CostMatrices" DataTextField="Name" DataValueField="Matrix_Id"/>
                        <asp:TextBox ID="PublicSpecialUnitTextbox" runat="server" Width="75"/>
                    </td>
                    
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicWhenChargedLabel" runat="server" Text="Charged:" />
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="PublicWhenChargedList" runat="server">
                            <asp:ListItem Selected="True">Received</asp:ListItem>
                            <asp:ListItem>Shipped</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                
                <!-- Private Rate Information -->
                
                <asp:Panel ID="PrivateRatePanel" runat="server">
                
                <tr class="header">
                    <td colspan="3" valign="middle">
                        <table style="width: 100%;"> 
                            <tr>
                                <td>
                                    Private Rate Information
                                </td>
                                <td style="text-align: right;">
                                    <% if (User.IsInRole("Administrators")) { %>
                                        <input type="button" onclick="CopyPublicRateToPrivateRate();" value="Copy From Public"/>
                                    <% } %>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td valign="top">
                        <asp:Label ID="CostMethodLabel" runat="server" Text="Cost <u>M</u>ethod:" AccessKey="M" AssociatedControlID="CostMethodList"/>
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="CostMethodList" runat="server" DataSourceID="CostMethods" DataTextField="Cost_Method" DataValueField="Cost_Method_ID"/>
                        <asp:SqlDataSource ID="CostMethods" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Cost Method ID] AS Cost_Method_ID, [Cost Method] AS Cost_Method FROM [RFS Cost Methods] ORDER BY [Cost Method]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="CostLabel" runat="server" Text="Cost:"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="CostTextbox" runat="server" Width="75"></asp:TextBox>
                        <asp:Label ID="PerLabel" runat="server" Text=" per "></asp:Label>
                        <asp:DropDownList ID="CostUnitList" runat="server" DataSourceID="CostUnitTypes" DataTextField="Unit" DataValueField="Unit_ID">
                        </asp:DropDownList><asp:SqlDataSource ID="CostUnitTypes" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Unit ID] AS Unit_ID, [Unit] FROM [sys Units of Measure] ORDER BY [Unit]">
                        </asp:SqlDataSource>
                        <asp:DropDownList ID="CostMatrixList" runat="server" DataSourceID="CostMatrices" DataTextField="Name" DataValueField="Matrix_Id"/>
                        <asp:SqlDataSource ID="CostMatrices" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [Matrix Id] AS Matrix_Id, [Name] FROM [RFS Cost Matrices] ORDER BY [Name]">
                        </asp:SqlDataSource>
                        <asp:TextBox ID="SpecialUnitTextbox" runat="server" Width="75"/>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PrivateWhenChargedLabel" runat="server" Text="Charged:" />
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="PrivateWhenChargedList" runat="server">
                            <asp:ListItem Selected="True">Received</asp:ListItem>
                            <asp:ListItem>Shipped</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="UnlinkPrivateRateLabel" runat="server" Text="Private Rate Is Unlinked:"/>
                    </td>
                    <td valign="top">
                        <asp:CheckBox ID="UnlinkPrivateRateCheckbox" runat="server" Tooltip="By default, private rate data is updated when public rate data is updated by normal users; checking this box unlinks it."/>
                    </td>
                </tr>
                
                </asp:Panel>
            
            </table>
        </div>

        <p>
            <asp:Button ID="SaveButton" runat="server" Text="Add Service" OnClick="SaveButton_Click" />
        </p>
        
    </div>

</asp:Content>
