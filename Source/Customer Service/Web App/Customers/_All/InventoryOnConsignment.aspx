<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InventoryOnConsignment" 
    Title="Inventory on Consignment" CodeBehind="InventoryOnConsignment.aspx.cs" CodeFile="InventoryOnConsignment.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Consigned
        Inventory (Summary)</h3>
    <br />
    (held by other Clients for current User)<br />
    <p>
        <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
            Text="Export to Excel" />&nbsp;</p>
    <p>
    <br />
    &nbsp;<dx:ASPxGridView ID="ASPxGridView1" runat="server" 
            AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" 
            Theme="Office2003Silver">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Inventory" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Auth ref" Visible="False" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile" 
                    FieldName="Product Profile Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Ext" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product Group 1" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product Group 2" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product Group 3" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Parent ref" Visible="False" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Weight" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="InvenConsigExprot" runat="server">
        </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSfontanaInvSummaryAuthViewer] WHERE ([Auth ref] = @Auth_ref) ORDER BY [Inventory], [Terminal], [Ext]">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

