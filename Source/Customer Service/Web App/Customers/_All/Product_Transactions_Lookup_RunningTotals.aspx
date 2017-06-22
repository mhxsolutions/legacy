<%@ Page  Title="Product Transactions" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers__All_Product_Transactions_Lookup_RunningTotals" 
    CodeBehind="Product_Transactions_Lookup_RunningTotals.aspx.cs" CodeFile="Product_Transactions_Lookup_RunningTotals.aspx.cs"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    &nbsp;<br />
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="16in" 
        Width="30in">
        <LocalReport ReportPath="Report_Definitions\product_transactions_lookup_runningtotals.rdlc" 
            EnableHyperlinks="True">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="DWS_No_Rep_DataDataSetTableAdapters.COPS_Transactions_Log_by_carrier_for_webTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" Type="Int32" />
            <asp:QueryStringParameter Name="PG1" QueryStringField="Product_Group_1" 
                DefaultValue="" Type="String" />
            <asp:QueryStringParameter Name="Profile" QueryStringField="profile" 
                DefaultValue="" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </asp:Content>

