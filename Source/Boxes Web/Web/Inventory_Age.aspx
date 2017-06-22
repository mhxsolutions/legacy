<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory_Age.aspx.vb" Inherits="Inventory_Age" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Age</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Steelscape Inventory Age<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="1" SortOrder="Descending" VisibleIndex="3">
                    <Settings AutoFilterCondition="GreaterOrEqual" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Material#" FieldName="Product Group 1" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Delivery#" FieldName="Product Group 2" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Order#" FieldName="Product Group 3" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Customer" FieldName="Product Group 4" SortIndex="2" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Weight" VisibleIndex="13">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="14">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Days in Storage" ReadOnly="True" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="Average={0:n1}" FieldName="Days in Storage" SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Total Days={0:n0}" FieldName="Days in Storage" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Pounds={0:n0}" FieldName="Weight" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Company ID ref" ShowInColumn="Client" SummaryType="Count" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Average={0:n1}" FieldName="Days in Storage" ShowInGroupFooterColumn="Days in Storage" SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Company ID ref" ShowInGroupFooterColumn="Client" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Pounds={0:n0}" FieldName="Weight" ShowInGroupFooterColumn="Weight" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Inventory Detail Days in Storage] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Receiving Client Ref] = @Receiving_Client_Ref))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter DefaultValue="2" Name="Receiving_Client_Ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory Age" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
