<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SteelscapeHarborBalances.aspx.vb" Inherits="SteelscapeHarborBalances" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Steelscape Harbor Balances</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Steelscape Vessel Balances<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="iOS">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Vessel" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mat#" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Shipped" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct Shipped" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Balance" ReadOnly="True" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct Balance" ReadOnly="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Ct Balance" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons Balance" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Ct Balance" SummaryType="Sum" DisplayFormat="Ct Bal={0:n0}" />
                <dx:ASPxSummaryItem FieldName="Tons Balance" SummaryType="Sum" DisplayFormat="Tons Bal={0:n1}" />
            </GroupSummary>
        </dx:ASPxGridView>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Steelscape Vessel shipped and balance by PG1]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
