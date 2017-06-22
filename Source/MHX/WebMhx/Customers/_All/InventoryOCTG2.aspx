<%@ Page Title="OCTG Inventory" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="InventoryOCTG2.aspx.cs" Inherits="Clients_All_InventoryOCTG2" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h3>OCTG Inventory at Terminal</h3>
    <p>
        <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="InventoryOCTG2" />
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource1" Theme="Metropolis">

            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="True" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>

            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible"></Settings>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1" SortIndex="0"
                    SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="2" SortIndex="1"
                    SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                    <PropertiesTextEdit>
                        <Style Wrap="False">
                        </Style>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="4" SortIndex="2"
                    SortOrder="Ascending">
                    <PropertiesTextEdit>
                        <Style Wrap="False">
                        </Style>
                    </PropertiesTextEdit>
                    <Settings AllowHeaderFilter="True" />
                    <DataItemTemplate>
                        <a id="clickElement"
                            href="product_transactions_lookup_runningtotalsWithCheck.aspx?product_group_1=<%# Eval("Product").ToString()%>&amp;profile=<%# Eval("Profile").ToString()%>"><%# Eval("Product").ToString()%></a>
                    </DataItemTemplate>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mill" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="8"
                    Caption="LNFT">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client ref" VisibleIndex="10"
                    Visible="False">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <DetailRow Wrap="False">
                </DetailRow>
                <DetailCell Wrap="False">
                </DetailCell>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>

        <br />
        <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1"/>
        <br />

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [COPS OCTG Inventory Summary] WHERE ([Client ref] = @Client_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ref" SessionField="context_clientID"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        

    </p>

</asp:Content>

