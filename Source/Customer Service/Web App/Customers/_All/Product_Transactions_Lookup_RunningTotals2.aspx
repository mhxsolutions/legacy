<%@ Page  Title="Product Transactions" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers__All_Product_Transactions_Lookup_RunningTotals2" 
    CodeBehind="Product_Transactions_Lookup_RunningTotals2.aspx.cs" CodeFile="Product_Transactions_Lookup_RunningTotals2.aspx.cs" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    &nbsp;Summary Data<dx:ASPxGridView ID="ASPxGridView1" runat="server" 
        AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" 
        Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Group_1" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mill" FieldName="Product_Group_2" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="2" Visible="False">
        </SettingsPager>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT DISTINCT [Terminal], [Profile], [Description], [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2 FROM [COPS Transactions Log by carrier for web with distinct columns] WHERE (([Client ref] = @Client_ref) AND ([Product Group 1] = @Product_Group_1) AND ([Profile] = @Profile))">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_ClientID" 
                Type="Int32" />
            <asp:QueryStringParameter Name="Product_Group_1" 
                QueryStringField="product_group_1" Type="String" />
            <asp:QueryStringParameter Name="Profile" QueryStringField="profile" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    Client Confirmation - true/false based on client data entry.
    <br />
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
    <br />
    </asp:Content>

