<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UP210_Rail.aspx.vb" Inherits="UP210_Rail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UP210 Inbound</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Inbound Rail Schedule - UP210 and UP211 Cars<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
            </dx:ASPxButton>
            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Expand All" Theme="Metropolis">
            </dx:ASPxButton>
            <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Collapse All" Theme="Metropolis">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="15">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="E T A" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" GroupIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load or Empty" VisibleIndex="4" Caption="L/E status">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Set" SortIndex="1" SortOrder="Ascending" VisibleIndex="2" GroupIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Budway Rail UP210 UP211 inbound]"></asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="UP210 UP211 cars" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
