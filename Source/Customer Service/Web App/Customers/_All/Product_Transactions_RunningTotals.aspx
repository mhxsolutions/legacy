<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Product_Transactions_RunningTotals" 
    CodeBehind="Product_Transactions_RunningTotals.aspx.cs" CodeFile="Product_Transactions_RunningTotals.aspx.cs"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT DISTINCT Profile, Terminal FROM sysRecvClientPG1List WHERE ([Product Group 1] = @Product_Group_1) AND ([Receiving Client Ref] = @Receiving_Client_Ref) AND (Terminal = @Terminal)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Product_Group_1" PropertyName="SelectedValue"
                Type="String" />
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList3" Name="Terminal" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT DISTINCT [Product Group 1] AS Product_Group_1, Terminal FROM sysRecvClientPG1List WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) AND (Terminal = @Terminal) ORDER BY Product_Group_1">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList3" Name="Terminal" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 189px">
                Filter for Terminal</td>
            <td style="width: 100px">
                <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet"
                        onselectedindexchanged="DropDownList1_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 189px">
                Filter for Product Number</td>
            <td style="width: 100px">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Product_Group_1" DataValueField="Product_Group_1" 
                    onselectedindexchanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 189px">
                Filter for Profile</td>
            <td style="width: 100px">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                    DataTextField="Profile" DataValueField="Profile" 
                    onselectedindexchanged="DropDownList2_SelectedIndexChanged">
                </asp:DropDownList></td>
        </tr>
    </table>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" Height="16in" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="30in">
        <LocalReport EnableHyperlinks="True" 
            ReportPath="Report_Definitions\product_transactions_runningtotals2.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="DWS_No_Rep_DataDataSetTableAdapters.COPS_Transactions_Log_by_carrier_for_web_with_distinct_columnsTableAdapter" >
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="PG1" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Profile" 
                PropertyName="SelectedValue" Type="String"  /> 
            <asp:ControlParameter ControlID="DropDownList3" Name="Terminal" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    </asp:Content>

