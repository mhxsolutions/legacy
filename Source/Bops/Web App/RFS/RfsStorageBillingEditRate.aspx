<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="RFS_RfsStorageBillingEditRate" Title="BOPS | RFS Storage Rate" Codebehind="RfsStorageBillingEditRate.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

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

        function OnUpdateBillingType(BillingType)
        {
            var UnitDropdown = new GetObj("<%=_UnitList.ClientID%>");
            
            if (BillingType == 1)
            {
                UnitDropdown.obj.value = 6;
            }
            else
            {
                UnitDropdown.obj.value = 0;
            }
        }
        
        function OnUpdateUnitType(UnitType)
        {
            var BillingTypeDropdown = new GetObj("<%=_BillingTypeList.ClientID%>");
            
            if (UnitType == 0)
            {
                BillingTypeDropdown.obj.value = 2;
            }
            else
            {
                BillingTypeDropdown.obj.value = 1;
            }
        }

    </script>

    <h2>
        RFS Storage Rate</h2>
    <p><a href="RfsStorageBillingRates.aspx">Click here for the list of storage rates.</a></p>
    <table>
        <tr>
            <td>
                Bill-To Client:</td>
            <td>
                <asp:DropDownList ID="_BillToClientList" runat="server" DataSourceID="_ClientsDatasource" DataTextField="Destination" 
                    DataValueField="Destination_id" Width="500">
                </asp:DropDownList><asp:SqlDataSource ID="_ClientsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id] AS Destination_id, Destination + ': ' + City + ', ' + ISNULL(State,'') AS Destination FROM [tbldestinationList] ORDER BY [Destination]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Description:</td>
            <td>
                <asp:TextBox ID="_DescriptionTextbox" runat="server" Width="500"></asp:TextBox>
                <asp:RequiredFieldValidator ID="_DescriptionRequiredValidator" runat="server" ControlToValidate="_DescriptionTextbox" Display="dynamic"
                    ErrorMessage="Description is required" />
            </td>
        </tr>
        <tr>
            <td>
                Billing Type:</td>
            <td>
                <asp:DropDownList ID="_BillingTypeList" runat="server" DataSourceID="_BillingTypesDatasource" DataTextField="Description" 
                    DataValueField="Billing_Type_Id" Width="100">
                </asp:DropDownList><asp:SqlDataSource ID="_BillingTypesDatasource" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Billing Type Id] AS Billing_Type_Id, [Description] FROM [RFS Storage Billing Types]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Cycle Days:</td>
            <td>
                <asp:TextBox ID="_DaysInCycleTextbox" runat="server" Width="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="_DaysRequiredValidator" runat="server" ControlToValidate="_DaysInCycleTextbox" Display="dynamic"
                    ErrorMessage="Cycle days is required" />
                <asp:RangeValidator ID="_DaysRangeValidator" runat="server" ControlToValidate="_DaysInCycleTextbox" Display="dynamic"
                    MinimumValue="1" MaximumValue="120" Type="Integer" ErrorMessage="Cycle days must be from 1 to 120" />
            </td>
        </tr>
        <tr>
            <td>
                Rate / Cycle:</td>
            <td>
                <asp:TextBox ID="_CostPerCycleTextbox" runat="server" Width="100"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RateRequiredValidator" runat="server" ControlToValidate="_CostPerCycleTextbox" Display="dynamic"
                    ErrorMessage="Rate is required" />
            </td>
        </tr>
        <tr>
            <td>
                Units:</td>
            <td>
                <asp:DropDownList ID="_UnitList" runat="server" Width="100">
                    <asp:ListItem Value="0">(none)</asp:ListItem>
                    <asp:ListItem Value="4">Square Feet</asp:ListItem>
                    <asp:ListItem Value="6">Tons</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
    </table>

    <p></p>
    <asp:Button ID="_SaveButton" runat="server" Text="Save" OnClick="_SaveButton_Click"/>

</asp:Content>
