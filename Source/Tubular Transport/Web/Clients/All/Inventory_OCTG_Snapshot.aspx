<%@ Page Title="Inventory Snapshot" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Inventory_OCTG_Snapshot.aspx.cs" Inherits="Clients_All_Inventory_OCTG_Snapshot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Inventory Snapshot</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" onclick="ASPxButton1_Click" 
        Text="Export to Excel" Theme="Office2003Silver" Width="131px">
    </dx:ASPxButton>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="4">
                    <DataItemTemplate>
                        <a id="clickElement" 
                           href="product_transactions_lookup_runningtotalsWithCheck.aspx?product_group_1=<%# Eval("Product").ToString()%>&amp;profile=<%# Eval("Profile").ToString()%>"
                            ><%# Eval("Product").ToString()%></a>
                    </DataItemTemplate>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mill" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="8" 
                    Caption="LNFT">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client ref" Visible="False" 
                    VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Data Reported As Of" FieldName="Run Time" 
                    VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="g">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" ShowFooter="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [Cache OCTG Inventory] WHERE ([Client ref] = @Client_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Inventory snapshot" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
    <p>
        Reporting delayed by 1 hour. For a live inventory please use Inventory 
        (detail) or Inventory (brief).</p>
</asp:Content>

