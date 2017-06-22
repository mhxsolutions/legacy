<%@ Page  Title="Product Transactions" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Product_Transactions_Lookup_RunningTotals2.aspx.cs" Inherits="Customers__All_Product_Transactions_Lookup_RunningTotals2" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
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
        <LocalReport ReportPath="Report_Definitions\product_transactions_lookup_runningtotals2.rdlc" 
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
    </asp:Content>

