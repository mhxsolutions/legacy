<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Consigned_Loads.aspx.cs" Inherits="Customers__All_Consigned_Loads" Title="Consigned Inventory Deliveries" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Consigned Inventory Loads</h3>
    Loads shipped by 3rd party for current User.<br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load ID] AS Load_ID, [Shipment Date] AS Shipment_Date, [Load Type] AS Load_Type, [Shipper], [Receiver], [PDF File] AS PDF_File, [PDF File Name] AS PDF_File_Name, [Age], [LogOut], [POD] FROM [COPS consigned BOLs] WHERE ([Auth Client ref] = @Auth_Client_ref) ORDER BY [Shipment Date] DESC, [Load ID]">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_Client_ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="ConLoadExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" KeyFieldName="Load_ID" 
        Theme="Metropolis">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Tally Data" FieldName="Load_ID" 
                ReadOnly="True" VisibleIndex="3">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="tally_detail.aspx?load_ref={0}" 
                    Text="Tally">
                </PropertiesHyperLinkEdit>
                <Settings AllowAutoFilter="False" AllowHeaderFilter="False" 
                    ShowFilterRowMenu="False" ShowInFilterControl="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataDateColumn FieldName="Shipment_Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1" Caption="Date">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Load_Type" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="4" Caption="Type">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver" ReadOnly="True" SortIndex="4" 
                SortOrder="Ascending" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Load/PDF" FieldName="PDF_File" 
                ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                <PropertiesHyperLinkEdit EncodeHtml="False">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="PDF_File_Name" VisibleIndex="10" 
                Caption="PDF File" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="8" 
                Caption="POD Signed">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="5" 
                Caption="Shipped">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Age" VisibleIndex="9">
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
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
</asp:Content>

