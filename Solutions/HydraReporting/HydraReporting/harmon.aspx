<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="harmon.aspx.vb" Inherits="HydraReporting.harmon" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harmon</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harmon Scrap Inventory (current) [<a href="default.aspx">home</a>]</h3>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Metropolis">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Avg Wt" ShowInColumn="Avg Wt" SummaryType="Average" ValueDisplayFormat="n2" />
                <dx:ASPxSummaryItem FieldName="Ct in Pkg" ShowInColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="WT" ShowInColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="n0" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="n0" FieldName="WT" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="n2" FieldName="Avg Wt" ShowInGroupFooterColumn="Avg Wt" SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="n1" FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="n0" FieldName="Ct in Pkg" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Vendor/Supplier" FieldName="PG 1" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Release#" FieldName="PG 2" SortIndex="3" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Grade" FieldName="PG 3" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="#Bales" FieldName="Ct in Pkg" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Term abr" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Wt Lb" FieldName="WT" VisibleIndex="24">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="26">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Avg Wt" VisibleIndex="25">
                    <PropertiesTextEdit DisplayFormatString="n2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowGroupedColumns="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Client Inventory detail summarized with pending BOL and dt recd for Hydra]"></asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Harmon Inventory" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
