<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AlcoaOrdersDelivered.aspx.vb" Inherits="AlcoaOrdersDelivered" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alcoa Orders</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Alcoa Orders Delivered</h3>
        <p>Open Orders<br />
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Order #" Theme="Metropolis" Width="100%">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Order #" ReadOnly="True" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mat#" VisibleIndex="1" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Size" VisibleIndex="2" AllowTextTruncationInAdaptiveMode="True">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Ordered" ReadOnly="True" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order Week" ReadOnly="True" VisibleIndex="15">
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons Delivered" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Ton Balance to Deliver over/(short)" ReadOnly="True" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons Inventory" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons Needed at Whse over/(short)" ReadOnly="True" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons Committed" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons Balance to BOL" ReadOnly="True" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Deliver By Date" VisibleIndex="16">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Tons Ordered" SummaryType="Sum" ShowInColumn="Tons Ordered" />
                <dx:ASPxSummaryItem FieldName="Net Tons Delivered" SummaryType="Sum" ShowInColumn="Net Tons Delivered" />
                <dx:ASPxSummaryItem FieldName="Net Ton Balance to Deliver over/(short)" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Net Tons Balance to BOL" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Net Tons Needed at Whse over/(short)" SummaryType="Sum" />
            </TotalSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [ClientOrders_OpenDeliveredOrdered] WHERE ([ClientID] = @ClientID)">
            <SelectParameters>
                <asp:Parameter DefaultValue="73" Name="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    </body>
</html>
