<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Inventory Summary.aspx.cs" Inherits="Clients_All_Inventory_Summary" Title="TTL Inventory Summary" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Terminal], [Product Profile Description] AS Product_Profile_Description, [Ext], [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, [Weight], [Net Weight] AS Net_Weight, [Linear Ft] AS Linear_Ft, [Pcs] FROM [COPSfontanInventorySummary] WHERE ([Parent ref] = @Parent_ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Profile" 
                FieldName="Product_Profile_Description" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ext" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product_Group_1" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product_Group_2" 
                VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product_Group_3" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="9" Caption="Pounds">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Net_Weight" Visible="False" 
                VisibleIndex="10" Caption="Net Wt">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Linear_Ft" VisibleIndex="8" 
                Caption="LNFT">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="7" Caption="Count">
                <PropertiesTextEdit DisplayFormatString="{0:n0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <settings showfilterrow="True" showgrouppanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" ShowFooter="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="InvenSumExport" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>

