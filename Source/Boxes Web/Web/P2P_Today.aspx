<%@ Page Language="VB" AutoEventWireup="false" CodeFile="P2P_Today.aspx.vb" Inherits="P2P_Today" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Refresh" content="120"/>
<head runat="server">
    <title>Today's P2P</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Performance to Plan - Today</h3>
    
    </div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsPager PageSize="40">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Ahead/Behind (-/+)" FieldName="Delta_to_Schedule" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Delta_to_Schedule" ShowInColumn="Ahead/Behind (-/+)" SummaryType="Sum" />
            </TotalSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT [Fleet], [Driver], [Delta to Schedule] AS Delta_to_Schedule FROM [P2P Driver Net Adjustment to Plan]"></asp:SqlDataSource>
        <br />
        Auto Refresh every 2 minutes<br />
        Negative numbers are minutes ahead of original plan.<br />
        Positive numbers are minutes behind original plan.<br />
        Blanks mean there is no phone data.<br />
        P2P data is from Adjustment to Plan on Planner (auto entered from phone clicks)</form>
</body>
</html>
