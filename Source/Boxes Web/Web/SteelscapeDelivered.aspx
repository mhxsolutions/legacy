<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SteelscapeDelivered.aspx.vb" Inherits="SteelscapeDelivered" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Steelscape Delivered</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Steelscape Orders Delivered</h3>
        <p>Orders for Current Week<br />
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Order #" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

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
                <dx:GridViewDataTextColumn FieldName="Tons Delivered" ReadOnly="True" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Ordered" ReadOnly="True" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Over/(Short)" ReadOnly="True" VisibleIndex="5" Caption="Balance to Deliver (short)">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order Week" ReadOnly="True" VisibleIndex="10">
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Inventory" ReadOnly="True" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Balance Needed (over/short)" ReadOnly="True" VisibleIndex="9" Caption="Balance needed at Whse (short)">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Comitted" VisibleIndex="7" Caption="Tons Committed">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Balance to BOL (short)" FieldName="Balance to BOL" ReadOnly="True" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Tons Ordered" SummaryType="Sum" ShowInColumn="Tons Ordered" />
                <dx:ASPxSummaryItem FieldName="Tons Delivered" SummaryType="Sum" ShowInColumn="Tons Delivered" />
                <dx:ASPxSummaryItem FieldName="Over/(Short)" SummaryType="Sum" ShowInColumn="Over/(Short)" />
                <dx:ASPxSummaryItem FieldName="Tons Inventory" ShowInColumn="Tons Inventory" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Balance Needed (over/short)" SummaryType="Sum" />
            </TotalSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapeOrdersThisWeekDeliveredOrdered]"></asp:SqlDataSource>
        <br />
        Orders for Next Week<br />
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="steelscape_next_week" EnableTheming="True" KeyFieldName="Order#" Theme="Metropolis">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Mat#" FieldName="Product_Ordered" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Size" FieldName="Product_Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Tons Ordered" FieldName="Tons_Ordered" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Order Week" FieldName="wk" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order#" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="steelscape_next_week" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapeOrdersNextWeek]"></asp:SqlDataSource>
        <br />
        <br />
        Orders for All Weeks<br />
        <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SteelscapeAllWeeks" EnableTheming="True" KeyFieldName="Order#" Theme="Metropolis">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Mat#" FieldName="Product_Ordered" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Size" FieldName="Product_Description" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Tons Ordered" FieldName="Tons_Ordered" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Order Week" FieldName="wk" ReadOnly="True" SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order#" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Year" FieldName="year" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Delivered" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SteelscapeAllWeeks" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapeOrdersAllWeeks]"></asp:SqlDataSource>
        <br />
    
    </div>
    </form>
</body>
</html>
