<%@ Page Title="Inventory Summary" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Inventory_Summary.aspx.cs" Inherits="Web.Clients.All.Inventory_Summary" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory - Summary</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue" Width="85%">
            <Columns>
                <dx:GridViewDataTextColumn Caption="Project" FieldName="Product Profile Description" VisibleIndex="2" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PSEP" FieldName="Product Group 1" VisibleIndex="4" SortIndex="5" SortOrder="Ascending" Width="1.5in">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" VisibleIndex="21">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 5" VisibleIndex="10" Caption="PO#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs in Unit" VisibleIndex="15" Width="0.5in">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Ct" VisibleIndex="14" Width="0.5in">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="3" Caption="Product" SortIndex="4" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" SortIndex="1" SortOrder="Ascending" VisibleIndex="0" Width="1.5in">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client PO" SortIndex="2" SortOrder="Ascending" VisibleIndex="1" Caption="Client Ref">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Heat Number" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs Total" VisibleIndex="17" Width="0.5in">
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFooter="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:n1}" FieldName="Linear Ft" ShowInColumn="LNFT" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Pcs" ShowInColumn="Pcs" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Unit Ct" ShowInColumn="Item Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Weight" ShowInColumn="Pounds" SummaryType="Sum" Visible="False" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n1}" FieldName="Unit Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="LNFT={0:n1}" FieldName="Linear Ft" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPSInventoryAvailableSummary-Brief] WHERE ([Parent ref] = @Parent_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Stock on Hand Summary" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
<p>
        Weight and LNFT moved to <a href="Invnetory_Sums.aspx">Stock on Hand Net Totals</a></p>
</asp:Content>
