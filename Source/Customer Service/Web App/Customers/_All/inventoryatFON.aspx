<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_inventoryatFON" 
    Title="BudwayDirect | Inventory" CodeBehind="inventoryatFON.aspx.cs" CodeFile="inventoryatFON.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Inventory at Terminal</h2>
    <p>
        &nbsp;<dx:ASPxButton ID="ASPxButton1" runat="server" 
            onclick="ASPxButton1_Click" Text="Export to Excel" Theme="Office2010Black" 
            Width="132px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" 
            Theme="Metropolis">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile Description" 
                    FieldName="Product Profile Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Label 1" FieldName="Group Label 1" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product 1" FieldName="Product Group 1" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Label 2" FieldName="Group Label 2" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product 2" FieldName="Product Group 2" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Label 3" FieldName="Group Label 3" 
                    VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product 3" FieldName="Product Group 3" 
                    VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Unit" FieldName="Weight Label" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Weight" FieldName="weight" 
                    VisibleIndex="13">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pkg" FieldName="Package Label" 
                    VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pcs" FieldName="Count In Package" 
                    VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Rerceiver" FieldName="Receiver ID" 
                    ReadOnly="True" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="19">
                    <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime">
                    </PropertiesDateEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Packages" FieldName="Items" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NetWeight" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
</p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT Client, [Date Received], Terminal, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], Item_ID, [Weight Label], weight, [Package Label], [Count In Package], [Parent ref], [Receiver ID], [As Of], Items, NetWeight FROM COPSfontanaInventory WHERE ([Parent ref] = @Parent_ref) ORDER BY Terminal, [Product Profile Description], [Date Received]">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
<dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
    FileName="Inventory Detail" GridViewID="ASPxGridView1">
</dx:ASPxGridViewExporter>
</asp:Content>

