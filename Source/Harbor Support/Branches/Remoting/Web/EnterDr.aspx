<%@ Page Language="C#" MasterPageFile="~/HarborWeb.master" AutoEventWireup="true"
    CodeFile="EnterDr.aspx.cs" Inherits="EnterDr" Title="Harbor Web | Enter DR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

        _MaximumWeight = 60000;
        _PoundsPerKilogram = 2.20462262;
        _PoundsPerMetricTon = 2204.62262;
            
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
            
        function ClientValidateWeight(source, arguments)
        {
            // Assume invalid until proven otherwise.
            
            arguments.IsValid = false;

            if (arguments.Value != "")
            {
                // First, determine the weight in pounds.
            
                var WeightInPounds = arguments.Value;
                var WeightUnitDropdownlist = new GetObj("<%=WeightUnitDropdownlist.ClientID%>");
                
                if (WeightUnitDropdownlist.obj.value == "Kilos")
                    WeightInPounds *= _PoundsPerKilogram;
                else if (WeightUnitDropdownlist.obj.value == "Metric Tons")
                    WeightInPounds *= _PoundsPerMetricTon;
                else
                    WeightInPounds = arguments.Value;

                // If the weight in pounds is within the valid range, we're good to go.
                    
                if (0 < WeightInPounds && WeightInPounds <= _MaximumWeight)
                    arguments.IsValid = true;
            }
        }

        /*
         *  This method utilizes the client-side portion of the Microsoft validation API.
         *  I was originally using the ValidatorHookupControl method, but it turns out the
         *  simplest way to tie the weight unit selection to the custom weight validator
         *  is to pass the custom weight validator to the ValidatorValidate method.
         */
        
        function TriggerWeightValidation()
        {
            var CustomWeightValidator = new GetObj("<%=WeightCustomValidator.ClientID%>");
            ValidatorValidate(CustomWeightValidator.obj);
        }
            
    </script>

    <h2>Enter DR</h2>
    <table cellpadding="1">
        <tr>
            <td valign="top">
                BL:</td>
            <td valign="top">
                <asp:TextBox ID="BlTextbox" runat="server" /><br />
                <asp:RequiredFieldValidator EnableClientScript="true" ID="BlRequiredValidator" runat="server"
                    ControlToValidate="BlTextbox" Display="Dynamic" ValidationGroup="AlwaysRequired"
                    ErrorMessage="BL number is required"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="BlRangeValidator" runat="server" ControlToValidate="BlTextbox"
                    Display="Dynamic" ErrorMessage="BL must be a number > 0" MaximumValue="2147483647"
                    MinimumValue="1" Type="Integer" ValidationGroup="AlwaysRequired"></asp:RangeValidator>
                <asp:CustomValidator ID="BlCustomValidator" runat="server" ControlToValidate="BlTextbox"
                    Display="Dynamic" OnServerValidate="ServerValidateBlId" ErrorMessage="BL doesn't exist or harbor project isn't active"
                    ValidationGroup="AlwaysRequired"></asp:CustomValidator></td>
        </tr>
        <tr>
            <td valign="top">
                DR:</td>
            <td valign="top">
                <asp:TextBox ID="DrTextbox" runat="server" /><br />
                <asp:RequiredFieldValidator EnableClientScript="true" ID="DrRequiredValidator" runat="server"
                    ControlToValidate="DrTextbox" Display="Dynamic" ValidationGroup="AlwaysRequired"
                    ErrorMessage="DR number is required"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="DrRangeValidator" runat="server" ControlToValidate="DrTextbox"
                    Display="Dynamic" ErrorMessage="DR must be a number > 0" MaximumValue="2147483647"
                    MinimumValue="1" Type="Integer" ValidationGroup="AlwaysRequired"></asp:RangeValidator>
                <asp:CustomValidator ID="DrCustomValidator" runat="server" ControlToValidate="DrTextbox"
                    Display="Dynamic" OnServerValidate="ServerValidateDrId" ErrorMessage="DR doesn't exist, is already finalized, or doesn't match the BL"
                    ValidationGroup="AlwaysRequired"></asp:CustomValidator></td>
        </tr>
        <tr>
            <td valign="top">
                Count:</td>
            <td valign="top">
                <asp:TextBox ID="CountTextbox" runat="server" /><br />
                <asp:RequiredFieldValidator ID="CountRequiredValidator" runat="server" ControlToValidate="CountTextbox"
                    Display="Dynamic" ValidationGroup="RequiredForLock" ErrorMessage="Count is required"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="CountRangeValidator" runat="server" ControlToValidate="CountTextbox"
                    Display="Dynamic" ErrorMessage="Count must be a number >= 0" MaximumValue="2147483647"
                    MinimumValue="0" Type="Integer" ValidationGroup="RequiredForLock"></asp:RangeValidator></td>
        </tr>
        <tr>
            <td valign="top">
                Weight:</td>
            <td valign="top">
                <asp:TextBox ID="WeightTextbox" runat="server" />
                <asp:DropDownList ID="WeightUnitDropdownlist" runat="server">
                    <asp:ListItem>Kilos</asp:ListItem>
                    <asp:ListItem>Metric Tons</asp:ListItem>
                    <asp:ListItem Selected="True">Pounds</asp:ListItem>
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="WeightRequiredValidator" runat="server" ControlToValidate="WeightTextbox"
                    Display="Dynamic" ErrorMessage="Weight is required" ValidationGroup="RequiredForLock"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="WeightCustomValidator" runat="server" ControlToValidate="WeightTextbox"
                    Display="Dynamic" OnServerValidate="ServerValidateWeight" ClientValidationFunction="ClientValidateWeight"
                    ErrorMessage="Weight must be <= 60k lbs" ValidationGroup="RequiredForLock"></asp:CustomValidator></td>
        </tr>
        <tr>
            <td valign="top">
                Gate Pass:</td>
            <td valign="top">
                <asp:TextBox ID="GatePassTextbox" runat="server" /><br />
                <asp:RequiredFieldValidator ID="GatePassRequiredValidator" runat="server" ControlToValidate="GatePassTextbox"
                    Display="Dynamic" ErrorMessage="Gate pass is required" ValidationGroup="RequiredForLock"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td valign="top">
                PUR/Tractor:</td>
            <td valign="top">
                <asp:TextBox ID="LoadTextbox" runat="server" Width="80" />
                <asp:TextBox ID="TractorTextbox" runat="server" Width="60" /><br />
                <asp:RequiredFieldValidator ID="LoadRequiredValidator" runat="server" ControlToValidate="LoadTextbox"
                    Display="Dynamic" ErrorMessage="PUR is required" ValidationGroup="RequiredForLock"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="LoadCustomValidator" runat="server" ControlToValidate="LoadTextbox"
                    Display="Dynamic" OnServerValidate="ServerValidateLoad" ErrorMessage="Pickup request does not exist in DWS"
                    ValidationGroup="RequiredForLock"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
            </td>
            <td>
                <asp:Button ID="SaveButton" runat="server" Text="Save" OnClick="SaveButton_Click"
                    ValidationGroup="AlwaysRequired" ToolTip="Saves without finalizing DR" />
                <asp:Button ID="FinalizeButton" runat="server" Text="Finalize" ValidationGroup="RequiredForLock"
                    OnClick="FinalizeButton_Click" ToolTip="Saves and finalzes the DR, preventing further editing" />
            </td>
        </tr>
    </table>
</asp:Content>
