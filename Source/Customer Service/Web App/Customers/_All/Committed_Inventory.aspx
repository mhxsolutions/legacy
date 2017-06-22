<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Committed_Inventory" Title="Committed Inventory" 
    CodeBehind="Committed_Inventory.aspx.cs" CodeFile="Committed_Inventory.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Committed Inventory<br />
        <dx:ASPxGridViewExporter ID="ComInvenExporter1" runat="server">
        </dx:ASPxGridViewExporter>
    </h3>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPS committed inventory] WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) ORDER BY [BOL], [Product Group 1], [Item ID]">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="BOL" SortIndex="0" SortOrder="Ascending" 
                VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Type" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 1" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 2" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 3" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="50">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
</asp:Content>

