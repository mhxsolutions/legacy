<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Alcoa_weight_pivot.aspx.vb" Inherits="Alcoa_weight_pivot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alcoa Load Weights</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Alcoa Load Weight - Monthly Average and Count - <a href="fon.aspx">home</a><br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Fields>
                <dx:PivotGridField ID="fieldYear" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Year">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="0" 
                    FieldName="Month">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldLoadWt" Area="DataArea" AreaIndex="0" 
                    CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" 
                    FieldName="Load Wt" GrandTotalCellFormat-FormatString="n0" 
                    GrandTotalCellFormat-FormatType="Numeric" SummaryType="Average">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldLoadID" Area="DataArea" AreaIndex="1" 
                    FieldName="Load ID" SummaryType="Count">
                </dx:PivotGridField>
            </Fields>
            <OptionsPager RowsPerPage="12">
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Alcoa Famosa Load Weight by month and year]">
        </asp:SqlDataSource>
    
        <br />
        <br />
        <h3>
            Monthly Average and Load Detail</h3>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource3" EnableTheming="True" KeyFieldName="Load ID" 
            Theme="Aqua">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load Wt" SummaryType="Average" 
                    ValueDisplayFormat="n0" />
            </GroupSummary>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Year" GroupIndex="0" ReadOnly="True" 
                    SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" GroupIndex="1" ReadOnly="True" 
                    SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Wt" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load ID" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" SortIndex="2" 
                    SortOrder="Descending" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Alcoa Famosa Load Weight by month and year]">
        </asp:SqlDataSource>
        <br />
        <br />
        <h3>
            Daily Average</h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Avg Load Wt" VisibleIndex="2">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Alcoa Famosa Average Load]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
