<%@ Page Title="Consigned" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="InventoryConsigned.aspx.cs" Inherits="Web.Clients.All.InventoryConsigned" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory Consigned to you</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Office2003Olive">
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn Caption="Inventory" FieldName="Client" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" GroupIndex="0">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="16">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="1" SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 1" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 1" SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 2" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 2" SortIndex="4" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 3" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 3" SortIndex="5" SortOrder="Ascending" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt UOM" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Wt" FieldName="Gross Wt" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Total Ct" FieldName="Count In Unit" VisibleIndex="13">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="20">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Units" FieldName="Items" VisibleIndex="18">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="LNFT" FieldName="Linear Ft" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Extended Description" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver ID" ReadOnly="True" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Consigned Inventory" GridViewID="ASPxGridView1" BottomMargin="50" LeftMargin="50" Landscape="True" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory Available - web - consigned] WHERE ([Auth_Client_ref] = @Auth_Client_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Auth_Client_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
