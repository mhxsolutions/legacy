<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_ContainerMoveEntry" 
    Title="BOPS | Planning | Container Move Entry" Codebehind="ContainerMoveEntry.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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

        function SetDropdownSelectionByValue(s, v)
        {
            for (var i = 0; i < s.obj.options.length; i++)
            {
                if (s.obj.options[i].value == v)
                {
                    s.obj.options[i].selected = true;
                    return;
                }
            }
        }

        function SetOdPair()
        {
            // NB:  The IDs must be provided through ASP.NET to avoid confusion over the prefixes
            //      Microsoft's master pages add to every control ID.
            
            var Orig = new GetObj("<%=_OriginDropdownlist.ClientID%>");
            var Dest = new GetObj("<%=_DestinationDropdownlist.ClientID%>");

            var DeliverRadioButton = new GetObj("<%=_MoveTypeRadiobuttonlist.ClientID%>_0");
            var ReturnRadioButton = new GetObj("<%=_MoveTypeRadiobuttonlist.ClientID%>_1");

            if (DeliverRadioButton.obj.checked)
            {
                SetDropdownSelectionByValue(Orig, origRef);
                SetDropdownSelectionByValue(Dest, destRef);
            } 
            else if (ReturnRadioButton.obj.checked)
            {
                SetDropdownSelectionByValue(Orig, destRef);
                SetDropdownSelectionByValue(Dest, origRef);
            }
        }        

        function ClientValidateContainerId(source, arguments)
        {
            var Rx = /[A-Z]{4}[0-9]{7}$/;
            var Ctl = new GetObj("<%=_ContainerIdTextbox.ClientID%>");
            arguments.IsValid = Rx.test(Ctl.obj.value);
        }
        
    </script>


    <%-- Necessary for the AJAX control toolkit --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Container Move Entry</h2>
    <p>To enter data for a container move, select the project, enter the required data,
        and click the "Enter Move" button. Note well: changing the move type will select
        the origin/destination based on the values entered in the project. You may choose
        a custom O/D pair, but these will be reported elsewhere as a custom move and will
        not be included in pickup/return counts.</p>
    
        <table>
        <tr>
            <td valign="top">Container Project:</td>
            <td>
                <asp:DropDownList ID="_ProjectDropdownlist" runat="server" DataSourceID="_ProjectDatasource" DataTextField="Project" 
                    DataValueField="Project Id" Width="600" OnSelectedIndexChanged="_ProjectDropdownlist_SelectedIndexChanged" AutoPostBack="True"/>
                <asp:SqlDataSource
                    ID="_ProjectDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT [CPS Projects].[Project Id], 'ID ' + RIGHT ('000000' + RTRIM(CAST([CPS Projects].[Project Id] AS VARCHAR(5))), 5) + ' - Booking ' + [CPS Projects].[Booking Id] + ' - ' + [CPS Projects].[Shipping Line] + ' at Berth ' + [CPS Projects].Berth + ' for ' + [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Project FROM [CPS Projects] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([CPS Projects].Complete = 0) ORDER BY [CPS Projects].[Project Id]">
                </asp:SqlDataSource>
            </td>
        </tr>
        
        <tr>
            <td valign="top">Pickup Request ID:</td>
            <td>
                <asp:TextBox ID="_PickupRequestIdTextbox" runat="server" Width="100" MaxLength="50" />&nbsp;
                <asp:RequiredFieldValidator ID="_PickupRequestIdRequiredValidator" runat="server" ControlToValidate="_PickupRequestIdTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
                <asp:CustomValidator ID="_PickupRequestCustomValidator" runat="server" ControlToValidate="_PickupRequestIdTextbox"
                    OnServerValidate="ServerValidatePickupRequestId" Display="Dynamic" ErrorMessage="Invalid pickup request ID" />
            </td>
        </tr>

        <tr>
            <td valign="top">Container ID:</td>
            <td>
                <asp:TextBox ID="_ContainerIdTextbox" runat="server" Width="100" MaxLength="15" Style="text-transform:uppercase;"/>
                <asp:RequiredFieldValidator ID="_ContainerIdRequiredValidator" runat="server" ControlToValidate="_ContainerIdTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
                <asp:CustomValidator ID="_ContainerIdCustomValidator" runat="server" Display="Dynamic" ErrorMessage="Must be four letters and seven numbers"
                    ControlToValidate="_ContainerIdTextbox" ClientValidationFunction="ClientValidateContainerId" 
                    OnServerValidate="ServerValidateContainerId"/>
            </td>
        </tr>

        <tr>
            <td valign="top">Move Type:</td>
            <td>
                <asp:RadioButtonList ID="_MoveTypeRadiobuttonlist" runat="server">
                    <asp:ListItem>Pickup and Deliver (starts the demurrage clock)</asp:ListItem>
                    <asp:ListItem>Container Return (stops the demurrage clock)</asp:ListItem>
                    <asp:ListItem>Other Movement</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        
        <tr>
            <td valign="top">Origin:</td>
            <td><asp:DropDownList ID="_OriginDropdownlist" runat="server" DataSourceID="_OriginDatasource" DataTextField="Destination" 
                DataValueField="Destination id" Width="400"/>
                <asp:SqlDataSource ID="_OriginDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        
        <tr>
            <td valign="top">Departed Date/Time:</td>
            <td>
                <asp:TextBox ID="_DepartedDateTextbox" runat="server" Width="100" MaxLength="10" />
                <cc1:CalendarExtender ID="_DepartedCalendarExtender" runat="server" TargetControlID="_DepartedDateTextbox"
                    PopupButtonID="_DepartedCalendarImage">
                </cc1:CalendarExtender>
                <asp:Image ID="_DepartedCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" ImageAlign="Middle" />
                <asp:TextBox ID="_DepartedTimeTextbox" runat="server" Width="100" MaxLength="8" />
                <asp:CustomValidator ID="_DepartDateCustomValidator" runat="server" Display="Dynamic" ErrorMessage="Departed date is invalid" 
                    ControlToValidate="_DepartedDateTextbox" OnServerValidate="ServerValidateDepartedDate" ValidateEmptyText="True"/>
                <asp:CustomValidator ID="_DepartTimeCustomValidator" runat="server" Display="Dynamic" ErrorMessage="Departed time is invalid" 
                    ControlToValidate="_DepartedTimeTextbox" OnServerValidate="ServerValidateDepartedTime" ValidateEmptyText="True"/>
            </td>
        </tr>
        
        <tr>
            <td valign="top">Destination:</td>
            <td><asp:DropDownList ID="_DestinationDropdownlist" runat="server" DataSourceID="_DestinationDatasource" DataTextField="Destination" 
                DataValueField="Destination id" Width="400"/> 
                <asp:SqlDataSource ID="_DestinationDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>

        <tr>
            <td valign="top">Arrived Date/Time:</td>
            <td>
                <asp:TextBox ID="_ArrivedDateTextbox" runat="server" Width="100" MaxLength="10" />
                <cc1:CalendarExtender ID="_ArrivedCalendarExtender" runat="server" TargetControlID="_ArrivedDateTextbox"
                    PopupButtonID="_ArrivedCalendarImage">
                </cc1:CalendarExtender>
                <asp:Image ID="_ArrivedCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" ImageAlign="Middle" />
                <asp:TextBox ID="_ArrivedTimeTextbox" runat="server" Width="100" MaxLength="8" />
                <asp:CustomValidator ID="_ArriveDateCustomValidator" runat="server" Display="Dynamic" ErrorMessage="Arrived date is invalid" 
                    ControlToValidate="_ArrivedDateTextbox" OnServerValidate="ServerValidateArrivedDate" ValidateEmptyText="True"/>
                <asp:CustomValidator ID="_ArriveTimeCustomValidator" runat="server" Display="Dynamic" ErrorMessage="Arrived time is invalid" 
                    ControlToValidate="_ArrivedTimeTextbox" OnServerValidate="ServerValidateArrivedTime" ValidateEmptyText="True"/>
            </td>
        </tr>
        
        <tr>
            <td></td>
            <td><asp:Button ID="_EnterMoveButton" runat="server" Text="Enter Move" OnClick="_EnterMoveButton_Click" /></td>
        </tr>
        
    </table>
    
</asp:Content>
