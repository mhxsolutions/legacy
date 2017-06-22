<%@ Page Title="Consigned Inventory" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    CodeBehind="InventoryConsignedDetail.aspx.cs" CodeFile="InventoryConsignedDetail.aspx.cs" Inherits="Web_App.Customers._All.InventoryConsignedDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Consigned Inventory (detail)</h3>
    <p>
    <br />
    (held by other Clients for current User)</p>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export Excel" Theme="Office2010Silver">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Silver">
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Inventory" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Ext" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product Group 1" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product Group 2" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product Group 3" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Wt" FieldName="weight" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT Inventory, [Auth ref], Terminal, [Product Profile Description], Ext, [Product Group 1], [Product Group 2], [Product Group 3], weight, Pcs, [Parent ref], [Net Weight], [Linear Ft], Item_ID, [Date Received] FROM COPSauthViewerDetail WHERE ([Auth ref] = @Auth_ref) ORDER BY Inventory, Terminal, Ext">
            <SelectParameters>
                <asp:SessionParameter Name="Auth_ref" SessionField="context_clientID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Consignment Inventory Detail" GridViewID="ASPxGridView2">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>
