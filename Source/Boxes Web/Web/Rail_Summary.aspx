<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rail_Summary.aspx.vb" Inherits="Rail_Summary" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail Summary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Rail Summary<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Status" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Commodity" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" SortIndex="4" 
                SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="50">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
        SelectCommand="SELECT Terminal, Count, Status, Client, Commodity, Carrier FROM [Rail Summary] WHERE (Terminal = N'FONTANA') OR (Terminal = N'Fontana')">
    </asp:SqlDataSource>
    </form>
</body>
</html>
