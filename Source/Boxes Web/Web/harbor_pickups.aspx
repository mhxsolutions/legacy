<%@ Page Language="VB" AutoEventWireup="false" CodeFile="harbor_pickups.aspx.vb" Inherits="harbor_pickups" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Pickups</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Harbor Pickups</h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load Count" SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" GroupIndex="0" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="0">
                    <Settings GroupInterval="DateMonth" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Classification" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Count" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" 
                ShowGroupedColumns="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Origin Class load count by day with OD pair]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Notes:</p>
    <ul>
        <li>Destination Classification is applied to addresses in DWS</li>
        <li>Based on Log Out Date on Load not Planner</li>
        <li>Not filtered by terminal or fleet</li>
    </ul>
    <p>
        &nbsp;</p>
</body>
</html>
