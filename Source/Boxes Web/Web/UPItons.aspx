<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPItons.aspx.vb" Inherits="UPItons" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UPI tons</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            UPI Tons Delivered<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue" 
            style="margin-right: 0px" Width="298px">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Tons" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons" SummaryType="Sum" />
            </GroupSummary>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Year" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" SortIndex="2" 
                    SortOrder="Descending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1" GroupIndex="0">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="4" Caption="Tons Out">
                    <PropertiesTextEdit DisplayFormatString="{0:n0}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="15">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [UPI tons and times monthly summry]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
