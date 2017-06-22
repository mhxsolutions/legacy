<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Marathon.aspx.vb" Inherits="Marathon" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Marathon Analysis</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Dakota 3/Marathon Analysis - <a href="default.aspx">home</a></h3>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Width="130px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons In" SummaryType="Sum" 
                    ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="LNFT In" SummaryType="Sum" 
                    ValueDisplayFormat="n1" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Year" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Abbreviation" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons In" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT In" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowTitlePanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <SettingsText Title="Receiving" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [ETI receiving for web monthly summary] WHERE ([Profile] LIKE '%' + @Profile + '%')">
            <SelectParameters>
                <asp:Parameter DefaultValue="marathon" Name="Profile" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Marathon Inbound Summary" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <br />
        <br />
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Export to Excel" 
            Width="130px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" EnableTheming="True" Theme="MetropolisBlue">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons Out" SummaryType="Sum" 
                    ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="LNFT Out" SummaryType="Sum" 
                    ValueDisplayFormat="n1" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Year" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Abbreviation" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Carrier" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Out" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT Out" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowTitlePanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <SettingsText Title="Shipping" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [ETI shipping for web monthly summary] WHERE ([Profile] LIKE '%' + @Profile + '%')">
            <SelectParameters>
                <asp:Parameter DefaultValue="Marathon" Name="Profile" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter2" runat="server" 
            FileName="marathon outbound summary" GridViewID="ASPxGridView2" 
            Landscape="True">
        </dx:ASPxGridViewExporter>
        <br />
        No Transfers, Inspection or Correction tonnage included.</div>
    </form>
</body>
</html>
