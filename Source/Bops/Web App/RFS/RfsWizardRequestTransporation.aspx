<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardRequestTransporation" Title="BOPS | RFS Wizard | Transportation" Codebehind="RfsWizardRequestTransporation.aspx.cs" %>

<%@ MasterType VirtualPath="~/BopsWeb.master" %>

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

        function IndeterminateStatusChanged()
        {
            // NB:  The IDs must be provided through ASP.NET to avoid confusion over the prefixes
            //      Microsoft's master pages add to every control ID.
            
            var Checkbox = new GetObj("<%=IndeterminateDestinationCheckbox.ClientID%>");
            var Dropdown = new GetObj("<%=DestinationStakeholderList.ClientID%>");

            if (Checkbox.obj.checked == true)
            {
                Dropdown.obj.disabled = true;
                Dropdown.obj.style.display = "none";
            }
            else
            {
                Dropdown.obj.disabled = false;
                Dropdown.obj.style.display = "";
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

        function UpdatePrivateFscControls(Method)
        {
            var FscListLabel = new GetObj("<%=FscListLabel.ClientID%>");
            var FscList = new GetObj("<%=FscList.ClientID%>");
            var FixedRateLabel = new GetObj("<%=FixedRateLabel.ClientID%>");
            var FixedRateTextbox = new GetObj("<%=FixedRateTextbox.ClientID%>");
            var MileageLabel = new GetObj("<%=MileageLabel.ClientID%>");
            var OdMileageTextbox = new GetObj("<%=OdMileageTextbox.ClientID%>");
            
            if (Method == 1)
            {
                FscListLabel.obj.style.display = "none";
                FscList.obj.style.display = "none";
                FixedRateLabel.obj.style.display = "none";
                FixedRateTextbox.obj.style.display = "none";
                MileageLabel.obj.style.display = "none";
                OdMileageTextbox.obj.style.display = "none";
            }
            else if (Method == 2)
            {
                FscListLabel.obj.style.display = "none";
                FscList.obj.style.display = "none";
                FixedRateLabel.obj.style.display = "";
                FixedRateTextbox.obj.style.display = "";
                MileageLabel.obj.style.display = "none";
                OdMileageTextbox.obj.style.display = "none";
            }
            else if (Method == 3)
            {
                FscListLabel.obj.style.display = "";
                FscList.obj.style.display = "";
                FixedRateLabel.obj.style.display = "none";
                FixedRateTextbox.obj.style.display = "none";
                MileageLabel.obj.style.display = "";
                OdMileageTextbox.obj.style.display = "";
            }
        }

        function UpdatePublicFscControls(Method)
        {
            var FscListLabel = new GetObj("<%=PublicFscListLabel.ClientID%>");
            var FscList = new GetObj("<%=PublicFscList.ClientID%>");
            var FixedRateLabel = new GetObj("<%=PublicFixedRateLabel.ClientID%>");
            var FixedRateTextbox = new GetObj("<%=PublicFixedRateTextbox.ClientID%>");
            var MileageLabel = new GetObj("<%=PublicMileageLabel.ClientID%>");
            var OdMileageTextbox = new GetObj("<%=PublicOdMileageTextbox.ClientID%>");
            
            if (Method == 1)
            {
                FscListLabel.obj.style.display = "none";
                FscList.obj.style.display = "none";
                FixedRateLabel.obj.style.display = "none";
                FixedRateTextbox.obj.style.display = "none";
                MileageLabel.obj.style.display = "none";
                OdMileageTextbox.obj.style.display = "none";
            }
            else if (Method == 2)
            {
                FscListLabel.obj.style.display = "none";
                FscList.obj.style.display = "none";
                FixedRateLabel.obj.style.display = "";
                FixedRateTextbox.obj.style.display = "";
                MileageLabel.obj.style.display = "none";
                OdMileageTextbox.obj.style.display = "none";
            }
            else if (Method == 3)
            {
                FscListLabel.obj.style.display = "";
                FscList.obj.style.display = "";
                FixedRateLabel.obj.style.display = "none";
                FixedRateTextbox.obj.style.display = "none";
                MileageLabel.obj.style.display = "";
                OdMileageTextbox.obj.style.display = "";
            }
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

        function ClientValidateOrigin(source, arguments)
        {
            arguments.IsValid = ValidateStakeholderSelection("<%=OriginStakeholderList.ClientID%>");
        }
        
        function ClientValidateDestination(source, arguments)
        {
            var Checkbox = new GetObj("<%=IndeterminateDestinationCheckbox.ClientID%>");
            arguments.IsValid = (Checkbox.obj.checked == true) || ValidateStakeholderSelection("<%=DestinationStakeholderList.ClientID%>");
        }
        
        function ClientValidateFixedFscRate(source, arguments)
        {
            // The RadioButtonList control is really just a table in the document, so it's necessary to
            // go directly to the input radio buttons, which bear the same names as the control plus an 
            // index. In this particular case, we need the second button for the fixed rate, at index one.
        
            var FixedRateCheckbox = new GetObj("<%=FscRadioButtonList.ClientID%>_1");
            
            if (FixedRateCheckbox.obj.checked == true)
            {
                if (arguments.Value != "" && -0.05 <= arguments.Value && arguments.Value <= 0.50)
                    arguments.IsValid = true;
                else
                    arguments.IsValid = false;
            }
            else
            {
                arguments.IsValid = true;
            }
        }
        
        function PublicClientValidateFixedFscRate(source, arguments)
        {
            // The RadioButtonList control is really just a table in the document, so it's necessary to
            // go directly to the input radio buttons, which bear the same names as the control plus an 
            // index. In this particular case, we need the second button for the fixed rate, at index one.
        
            var FixedRateCheckbox = new GetObj("<%=PublicFscRadioButtonList.ClientID%>_1");
            
            if (FixedRateCheckbox.obj.checked == true)
            {
                if (arguments.Value != "" && -0.05 <= arguments.Value && arguments.Value <= 0.50)
                    arguments.IsValid = true;
                else
                    arguments.IsValid = false;
            }
            else
            {
                arguments.IsValid = true;
            }
        }
        
        function CopyObjectValue(SourceObjectId, DestinationObjectId)
        {
            var SourceObject = new GetObj(SourceObjectId);
            var DestinationObject = new GetObj(DestinationObjectId);
            DestinationObject.obj.value = SourceObject.obj.value;
        }
        
        function CopyRadiobuttonChecked(SourceObjectId, DestinationObjectId)
        {
            var SourceObject = new GetObj(SourceObjectId);
            var DestinationObject = new GetObj(DestinationObjectId);
            DestinationObject.obj.checked = SourceObject.obj.checked;
        }

        function GetRadiobuttonlistSelectedIndex(ControlId, NumItems)
        {
            var i;
            for (i = 0; i < NumItems; i++)
            {
                var RadioButtonId = ControlId + "_" + i;
                var RadioButton = new GetObj(RadioButtonId);
                if (RadioButton.obj.checked)
                {
                    return i + 1;
                }
            }
            
            return 0;
        }
        
        function CopyPrivateRateToPublicRate(source, arguments)
        {
            var PrivateCostMethodList = new GetObj("<%=CostMethodList.ClientID%>");
            CopyObjectValue("<%=CostMethodList.ClientID%>", "<%=PublicCostMethodList.ClientID%>");
            UpdatePublicCostControls(PrivateCostMethodList.obj.value);
            
            CopyObjectValue("<%=CostTextbox.ClientID%>", "<%=PublicCostTextbox.ClientID%>");
            CopyObjectValue("<%=CostUnitList.ClientID%>", "<%=PublicCostUnitList.ClientID%>");
            CopyObjectValue("<%=CostMatrixList.ClientID%>", "<%=PublicCostMatrixList.ClientID%>");
            
            CopyRadiobuttonChecked("<%=FscRadioButtonList.ClientID%>_0", "<%=PublicFscRadioButtonList.ClientID%>_0");
            CopyRadiobuttonChecked("<%=FscRadioButtonList.ClientID%>_1", "<%=PublicFscRadioButtonList.ClientID%>_1");
            CopyRadiobuttonChecked("<%=FscRadioButtonList.ClientID%>_2", "<%=PublicFscRadioButtonList.ClientID%>_2");
            var SelectedIndex = GetRadiobuttonlistSelectedIndex("<%=PublicFscRadioButtonList.ClientID%>", 3);
            UpdatePublicFscControls(SelectedIndex);
            
            CopyObjectValue("<%=FixedRateTextbox.ClientID%>", "<%=PublicFixedRateTextbox.ClientID%>");
            CopyObjectValue("<%=FscList.ClientID%>", "<%=PublicFscList.ClientID%>");
            CopyObjectValue("<%=OdMileageTextbox.ClientID%>", "<%=PublicOdMileageTextbox.ClientID%>");
            CopyObjectValue("<%=MinimumChargedWeightTextbox.ClientID%>", "<%=PublicMinimumChargedWeightTextbox.ClientID%>");
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
            
            CopyRadiobuttonChecked("<%=PublicFscRadioButtonList.ClientID%>_0", "<%=FscRadioButtonList.ClientID%>_0");
            CopyRadiobuttonChecked("<%=PublicFscRadioButtonList.ClientID%>_1", "<%=FscRadioButtonList.ClientID%>_1");
            CopyRadiobuttonChecked("<%=PublicFscRadioButtonList.ClientID%>_2", "<%=FscRadioButtonList.ClientID%>_2");
            var SelectedIndex = GetRadiobuttonlistSelectedIndex("<%=FscRadioButtonList.ClientID%>", 3);
            UpdatePrivateFscControls(SelectedIndex);
            
            CopyObjectValue("<%=PublicFixedRateTextbox.ClientID%>", "<%=FixedRateTextbox.ClientID%>");
            CopyObjectValue("<%=PublicFscList.ClientID%>", "<%=FscList.ClientID%>");
            CopyObjectValue("<%=PublicOdMileageTextbox.ClientID%>", "<%=OdMileageTextbox.ClientID%>");
            CopyObjectValue("<%=PublicMinimumChargedWeightTextbox.ClientID%>", "<%=MinimumChargedWeightTextbox.ClientID%>");
            CopyObjectValue("<%=PublicSpecialUnitTextbox.ClientID%>", "<%=SpecialUnitTextbox.ClientID%>");
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

    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px; ">
    
        <h2><% Response.Write(Request.QueryString["mode"]); %> Transporation Service <% Response.Write(Request.QueryString["ServiceId"]); %></h2>
        <p>
            Use the fields below to configure the service as desired and click the button at the bottom to save.
            To return to the services page, click the tab at the top.
        </p>

        <div style="z-index: 105; left: 20px; position: relative">
            <table cellpadding="4">
                <tr class="header"><td colspan="2" valign="middle">Transportation Details</td></tr>
                <tr>
                    <td>
                        <asp:Label ID="GroupLabel" AccessKey="G" AssociatedControlID="GroupDropdown" runat="server" Text="<u>G</u>roup:" />
                    </td>
                    <td>
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
                                <asp:Parameter DefaultValue="1" Name="Service_Category_Ref" Type="Int32" />
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
                <tr>
                    <td valign="top">
                        <asp:Label ID="OriginLabel" AccessKey="O" AssociatedControlID="OriginStakeholderList"
                            runat="server" Text="<u>O</u>rigin:" />
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="OriginStakeholderList" runat="server" 
                            Width="400px" DataSourceID="OriginStakeholders" DataTextField="Destination" DataValueField="Stakeholder ID" 
                            AppendDataBoundItems="True">
                            <asp:ListItem Value="">You must select a stakeholder</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="OriginStakeholderCustomValidator" runat="server" 
                            ClientValidationFunction="ClientValidateOrigin" OnServerValidate="ServerValidateOrigin"
                            ValidateEmptyText="True" ControlToValidate="OriginStakeholderList" 
                            ErrorMessage="You must specify an origin stakeholder."></asp:CustomValidator>
                        <asp:SqlDataSource ID="OriginStakeholders" runat="server"
                            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [RFS Stakeholders] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[RFS ref] = @RfsId) AND ([RFS Stakeholders].[Role ref] = 3) ORDER BY [DWS Rep Data].dbo.tbldestinationList.Destination">
                            <SelectParameters>
                                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr valign="top">
                    <td valign="top">
                        <asp:Label ID="DestinationLabel" AccessKey="T" AssociatedControlID="DestinationStakeholderList"
                            runat="server" Text="Des<u>t</u>ination:" />
                    </td>
                    <td valign="top">
                        <asp:CheckBox ID="IndeterminateDestinationCheckbox" runat="server" />
                        <asp:Label ID="IndeterminateTextLabel" runat="server" Text="Destination Is <u>I</u>ndeterminate"
                        AccessKey="I" AssociatedControlID="IndeterminateDestinationCheckbox"></asp:Label><br />
                    
                        <asp:DropDownList ID="DestinationStakeholderList" runat="server" Width="400px" DataSourceID="DestinationStakeholders" DataTextField="Destination" 
                            DataValueField="Stakeholder ID" AppendDataBoundItems="True">
                            <asp:ListItem Value="">You must select a stakeholder</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CustomValidator ID="DestinationStakeholderCustomValidator" runat="server" 
                            ClientValidationFunction="ClientValidateDestination" OnServerValidate="ServerValidateDestination"
                            ValidateEmptyText="True" ControlToValidate="DestinationStakeholderList" 
                            ErrorMessage="You must specify a destination stakeholder."></asp:CustomValidator>
                        <asp:SqlDataSource ID="DestinationStakeholders" runat="server"
                            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [RFS Stakeholders] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[RFS ref] = @RfsId) AND ([RFS Stakeholders].[Role ref] = 4) ORDER BY [DWS Rep Data].dbo.tbldestinationList.Destination">
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
                    <td colspan="3" valign="middle">
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
                        <asp:Label ID="PublicFuelSurchargeLabel" runat="server" Text="Fuel Surcharge:"/>
                    </td>
                    <td valign="top">
                        <asp:RadioButtonList ID="PublicFscRadioButtonList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PublicFscRadioButtonList_SelectedIndexChanged">
                            <asp:ListItem>None</asp:ListItem>
                            <asp:ListItem>Fixed Rate</asp:ListItem>
                            <asp:ListItem>Matrix</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicFixedRateLabel" runat="server">Fixed FSC Rate:</asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="PublicFixedRateTextbox" runat="server"></asp:TextBox>
                        <asp:CustomValidator ID="PublicFixedFscRateCustomValidator" runat="server" 
                            ClientValidationFunction="PublicClientValidateFixedFscRate" OnServerValidate="PublicServerValidateFixedFscRate"
                            ValidateEmptyText="True" ControlToValidate="PublicFixedRateTextbox" 
                            ErrorMessage="Fixed rate must be between -0.50 and 0.50."></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicFscListLabel" runat="server">FSC Matrix:</asp:Label>
                    </td>
                    <td valign="top">
                        <asp:DropDownList ID="PublicFscList" runat="server" DataSourceID="FscMatrices" DataTextField="Name" DataValueField="FSC ID"/>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="height: 49px">
                        <asp:Label ID="PublicMileageLabel" runat="server">Mileage:</asp:Label>
                    </td>
                    <td valign="top" style="height: 49px">
                        <asp:TextBox ID="PublicOdMileageTextbox" runat="server"/>
                        <asp:CustomValidator ID="PublicMileageCustomValidator" runat="server"
                            OnServerValidate="PublicServerValidateMileage" ValidateEmptyText="true"
                            ControlToValidate="PublicOdMileageTextbox" ErrorMessage="A non-negative mileage must be provided for the selected FSC matrix.">
                        </asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="PublicMinimumChargedWeightLabel" runat="server" Text="Minimum Charged <u>W</u>eight:" 
                        AccessKey="W" AssociatedControlID="PublicMinimumChargedWeightTextbox"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="PublicMinimumChargedWeightTextbox" runat="server">0</asp:TextBox>
                        <asp:RequiredFieldValidator ID="PublicValidateMinimumChargedWeightExists" runat="server"
                            ControlToValidate="PublicMinimumChargedWeightTextbox" ErrorMessage="You must provide a minimum charged weight." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="PublicValidateMinimumChargedWeightRange" runat="server" ControlToValidate="PublicMinimumChargedWeightTextbox"
                            ErrorMessage="Minimum charged weight must be from zero to 80,000 lbs." MaximumValue="80000"
                            MinimumValue="0" Type="Integer"></asp:RangeValidator>
                    </td>
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
                        <asp:Label ID="FuelSurchargeLabel" runat="server" Text="Fuel Surcharge:"/>
                    </td>
                    <td valign="top">
                        <asp:RadioButtonList ID="FscRadioButtonList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FscRadioButtonList_SelectedIndexChanged">
                            <asp:ListItem>None</asp:ListItem>
                            <asp:ListItem>Fixed Rate</asp:ListItem>
                            <asp:ListItem>Matrix</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="FixedRateLabel" runat="server">Fixed FSC Rate:</asp:Label></td>
                    <td valign="top">
                        <asp:TextBox ID="FixedRateTextbox" runat="server"></asp:TextBox>
                        <asp:CustomValidator ID="FixedFscRateCustomValidator" runat="server" 
                            ClientValidationFunction="ClientValidateFixedFscRate" OnServerValidate="ServerValidateFixedFscRate"
                            ValidateEmptyText="True" ControlToValidate="FixedRateTextbox" 
                            ErrorMessage="Fixed rate must be between -0.50 and 0.50."></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="FscListLabel" runat="server">FSC Matrix:</asp:Label></td>
                    <td valign="top">
                        <asp:DropDownList ID="FscList" runat="server" DataSourceID="FscMatrices" DataTextField="Name" DataValueField="FSC ID"/>
                        <asp:SqlDataSource ID="FscMatrices" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                            SelectCommand="SELECT [FSC Main].[FSC ID], [FSC Main].Name FROM [FSC Main] INNER JOIN [FSC Cost Methods] ON [FSC Main].[Cost Method Ref] = [FSC Cost Methods].[Cost Method ID] WHERE ([FSC Main].[End Date] IS NULL)">
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="height: 49px">
                        <asp:Label ID="MileageLabel" runat="server">Mileage:</asp:Label></td>
                    <td valign="top" style="height: 49px">
                        <asp:TextBox ID="OdMileageTextbox" runat="server"></asp:TextBox>
                        <asp:CustomValidator ID="MileageCustomValidator" runat="server"
                            OnServerValidate="ServerValidateMileage" ValidateEmptyText="true"
                            ControlToValidate="OdMileageTextbox" ErrorMessage="A non-negative mileage must be provided for the selected FSC matrix.">
                        </asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="MinimumChargedWeightLabel" runat="server" Text="Minimum Charged <u>W</u>eight:" 
                        AccessKey="W" AssociatedControlID="MinimumChargedWeightTextbox"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="MinimumChargedWeightTextbox" runat="server">0</asp:TextBox>
                        <asp:RequiredFieldValidator ID="ValidateMinimumChargedWeightExists" runat="server"
                            ControlToValidate="MinimumChargedWeightTextbox" ErrorMessage="You must provide a minimum charged weight." Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="ValidateMinimumChargedWeightRange" runat="server" ControlToValidate="MinimumChargedWeightTextbox"
                            ErrorMessage="Minimum charged weight must be from zero to 80,000 lbs." MaximumValue="80000"
                            MinimumValue="0" Type="Integer"></asp:RangeValidator>
                    </td>
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
            <asp:Button ID="SaveButton" runat="server" Text="Add Service" CausesValidation="true" OnClick="SaveButton_Click" />
        </p>
        
    </div>

</asp:Content>
