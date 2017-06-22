<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="Web.Clients.Inventory" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Inventory</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to Excel" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive" KeyFieldName="Receiver ID">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Control Recd Date" VisibleIndex="15" Caption="Date Recd">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="1" SortIndex="1" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 1" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 1" VisibleIndex="3" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 2" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 2" VisibleIndex="5" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Label 3" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Desc 3" VisibleIndex="7" SortIndex="4" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="8" SortIndex="5" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt UOM" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count In Unit" VisibleIndex="13" Caption="Total Ct">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="21">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Items" VisibleIndex="18" Caption="Units">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="14" Caption="LNFT">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Extended Description" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Weight" FieldName="Wt2" Name="Weight" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True" ShowAllItem="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory available - web] WHERE ([Client ID] = @Client_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>
