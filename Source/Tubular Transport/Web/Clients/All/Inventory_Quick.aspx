<%@ Page Title="Inventory Compact" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Inventory_Quick.aspx.cs" Inherits="Clients_All_Inventory_Quick" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Inventory at Terminal</h3>
    <p>
        short form - product code<dx:ASPxButton ID="ASPxButton1" runat="server" 
            AutoPostBack="False" onclick="ASPxButton1_Click" Text="Export to Excel" 
            Theme="Office2003Silver" Width="154px">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" AutoFilterCondition="Contains" />
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                    <Settings AutoFilterCondition="Contains" />
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="4">
                    <Settings AutoFilterCondition="Contains" />
                    <DataItemTemplate>
                        <a id="clickElement" 
                           href="product_transactions_lookup_runningtotals2.aspx?product_group_1=<%# Eval("Product").ToString()%>&amp;profile=<%# Eval("Profile").ToString()%>"
                            ><%# Eval("Product").ToString()%></a>
                    </DataItemTemplate>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="LNFT" FieldName="Linear Ft" 
                    VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
            <Styles>
                <Cell Wrap="False">
                </Cell>
                <DetailRow Wrap="False">
                </DetailRow>
                <DetailCell Wrap="False">
                </DetailCell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT Terminal, Profile, Description, Product, Pounds, Count, [Linear Ft], [Client ref] FROM [COPS OCTG Inventory Summary PG1 only] WHERE ([Client ref] = @Client_ref) AND (Count &gt; 0)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" 
            FileName="Inventory - short" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

