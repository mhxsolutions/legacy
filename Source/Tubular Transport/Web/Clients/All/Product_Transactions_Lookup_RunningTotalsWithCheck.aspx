<%@ Page  Title="Product Transactions" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Product_Transactions_Lookup_RunningTotalsWithCheck.aspx.cs" Inherits="Customers__All_Product_Transactions_Lookup_RunningTotalsWithCheck" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content0" ContentPlaceHolderID="ContentPlaceHolderHead" Runat="Server">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>    
    <script type="text/javascript">
        var $receiverID = "";
        $(document).ready(function () {
            $("[id$='dialogreceivercheckoff']").dialog({
                autoOpen: false,
                resizable: false,
                position: 'center',
                height: 230,
                width: 415,
                modal: true,
                buttons: {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Ok": function () {
                        //Set Check Flag and Notes Variable
                        //alert("Setting " + $receiverID + "*" + $('#notes').val());
                        //Call PageMethods to access C# Code
                        PageMethods.setCheckValues($receiverID, $("#radioConfirm").is(":checked"), $('#notes').val(), OnsetCheckValuesCompleted);
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    //Receiver ID~Client Note
                    var params = $(this).data("pParams").toString().split("~");
                    $receiverID = "";
                    if (params.length == 3) {
                        //Set Variables
                        $receiverID = params[0].toString();
                        //val for form fields, html or text for non form fields
                        //Notes
                        $('#notes').val(params[2]);
                        //Radio Button
                        if (params[1] == "1")
                            $('#radioConfirm').prop('checked', true);
                        else
                            $('#radioClear').prop('checked', true);
                        //Set Cursor to go to beginning of line
                        $("#notes").focus();
                        $("#notes")[0].setSelectionRange(0, 0);
                    }
                }
            });
        });
        function respPrompt(pParams) {
            //pParams == Receiver ID~Client Note
            //if NO Receiver ID, do not call dialog
            if (pParams.toString().split("~")[0] != "") {
                $("#dialogreceivercheckoff")
                    .data("pParams", pParams)
                    .dialog("open");
            }
        };
        function OnsetCheckValuesCompleted(result) {
            //Future Use
        };
        function refreshReport() {
            //Refresh Report Grid
            //Actual Client ID Parameter taken on View Source from Browser or ('ReportViewer1.ClientId no work)
            //var v = $find('ctl00_ContentPlaceHolder1_ReportViewer1');
            //v.refreshReport();            
        }
    </script>     
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <br />
<dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="ObjectDataSource1" EnableTheming="True" Theme="Metropolis">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="9">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Group_1" 
            VisibleIndex="10">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Mill" FieldName="Product_Group_2" 
            VisibleIndex="12">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="8">
        </dx:GridViewDataTextColumn>
    </Columns>
    <SettingsPager PageSize="1" Visible="False">
    </SettingsPager>
</dx:ASPxGridView>
    <br />
    &nbsp;<br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="16in" 
        Width="30in">
        <LocalReport ReportPath="Report_Definitions\product_transactions_lookup_runningtotalsWithCheck.rdlc" 
            EnableHyperlinks="True">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="DWS_No_Rep_DataDataSetTableAdapters.COPS_Transactions_Log_by_carrier_for_web_with_distinct_columns1TableAdapter" >
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" Type="Int32" />
            <asp:QueryStringParameter Name="PG1" QueryStringField="Product_Group_1" 
                DefaultValue="" Type="String" />
            <asp:QueryStringParameter Name="Profile" QueryStringField="profile" 
                DefaultValue="" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div id="dialogreceivercheckoff" title="Receiver Check-Off"> 
      <form>
      <fieldset>
        <label for="notes">Notes:</label>
        <input width="80" type="text" name="notes" id="notes" class="text ui-widget-content ui-corner-all" style="width:275px" />
      </fieldset>
      <fieldset>
        <label for="notes">Client Confirmation:</label>
        <input width="80" type="radio" name="radioConfirmClear" id="radioConfirm" value="1" />Confirm
        <input width="80" type="radio" name="radioConfirmClear" id="radioClear" value="0" />Clear
      </fieldset>  
      </form>
    </div>  
 </asp:Content>

