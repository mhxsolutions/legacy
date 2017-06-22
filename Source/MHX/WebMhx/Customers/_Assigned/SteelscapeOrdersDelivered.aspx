<%@ Page Title="Orders Delivered" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SteelscapeOrdersDelivered.aspx.cs" Inherits="Customers__Assigned_SteelscapeOrdersDelivered" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Steelscape Orders Delivered</h2>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="SteelScapeOrdersDelivered" />
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Order #" Width="98%" OnCustomUnboundColumnData="ASPxGridView1_CustomUnboundColumnData">
            <SettingsSearchPanel Visible="True">
            </SettingsSearchPanel>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True">
            </Settings>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <SettingsCommandButton>
                <ShowAdaptiveDetailButton ButtonType="Image">
                </ShowAdaptiveDetailButton>
                <HideAdaptiveDetailButton ButtonType="Image">
                </HideAdaptiveDetailButton>
            </SettingsCommandButton>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Order #" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mat#" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Size" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Delivered" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Ordered" ReadOnly="True" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Over/(Short)" ReadOnly="True" VisibleIndex="6" Caption="Balance to Deliver over/(short)">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order Week" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Inventory" VisibleIndex="8" Caption="Stock at Budway">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Balance Needed (over/short)" ReadOnly="True" VisibleIndex="10" Caption="Balance Needed at Budway over/(short)">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Comitted" VisibleIndex="7" Caption="Planned Delivery">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn UnboundType="Decimal" FieldName="InventryRunningBalance" Caption="Running Balance (w/inventory at Budway)" PropertiesTextEdit-DisplayFormatString="f2" VisibleIndex="9" Settings-AllowSort="False">
<PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>

<Settings AllowSort="False"></Settings>
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapeOrdersThisWeekDeliveredOrdered]"></asp:SqlDataSource>
    </p>
</asp:Content>

