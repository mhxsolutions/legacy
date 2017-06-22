<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Administration_RfsCalculateEstimatedServiceThroughput" Title="BOPS | Administration | RFS Service Throughput" Codebehind="RfsCalculateEstimatedServiceThroughput.aspx.cs" %>
    
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

        function BeginOperation()
        {
            // NB:  The IDs must be provided through ASP.NET to avoid confusion over the prefixes
            //      Microsoft's master pages add to every control ID.
            
            var CalcBtn = new GetObj("<%=CalculateButton.ClientID%>");
            CalcBtn.obj.disabled = true;
            return false;
        }
    </script>        

    <h2>
        RFS Service Throughput</h2>


    This page allows the administrator to calculate (or re-calculate) the estimated
    throughput values for RFS services. Select the desired operation from the options
    below and click the "Calculate" button to proceed. When the operation is complete,
    which may take a while, the button will be re-enabled.<br />
    <br />
    <asp:RadioButtonList ID="OperationRadioButtonList" runat="server">
        <asp:ListItem Selected="True" Value="CalculateMissing">Calculate only for services that don't already have an estimated throughput.</asp:ListItem>
        <asp:ListItem Value="CalculateAll">Calculate for all services, whether they have an estimated throughput or not.</asp:ListItem>
    </asp:RadioButtonList><br />
    <asp:Button ID="CalculateButton" runat="server" OnClick="CalculateButton_Click" Text="Calculate" UseSubmitBehavior="false"/>
</asp:Content>

