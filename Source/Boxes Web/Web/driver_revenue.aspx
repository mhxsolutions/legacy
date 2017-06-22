<%@ Page Language="VB" AutoEventWireup="false" CodeFile="driver_revenue.aspx.vb" Inherits="driver_revenue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Planned Revenue</title>
    <style type="text/css">
        .style1
        {
            width: 296px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver Planned Revenue<br />
        </h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Theme="Office2010Blue" Width="141px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Revenue = {0:c0}" FieldName="Revenue" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="FSC = {0:c0}" FieldName="FSC" 
                    SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Month" GroupIndex="1" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Year" GroupIndex="0" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="3" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" GroupIndex="4" SortIndex="4" 
                    SortOrder="Descending" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Fleet" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver Pay" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FSC" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" GroupIndex="5" SortIndex="5" 
                    SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataCheckColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Plan Time and Revenue by driver and day]">
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Driver Planned Revenue" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        Driver Pay is taken from posted load pay table, not rate table.<br />
    
    </div>
    </form>
</body>
</html>
