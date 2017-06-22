<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Public_Private_Revenue.aspx.vb" Inherits="Public_Private_Revenue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Public Private Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Public/Private Revenue by Driver and Date 
            - </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Truck Default" VisibleIndex="3">
                <EditCellStyle HorizontalAlign="Center">
                </EditCellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Total Hours" ReadOnly="True" 
                VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Drive Time" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Est Transit" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Non Drive" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Est Dwell" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="10">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Private Revenue" ReadOnly="True" 
                VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Public Revenue" ReadOnly="True" 
                VisibleIndex="12">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="50">
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowFilterRowMenuLikeItem="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
        <Styles>
            <Row Wrap="False">
            </Row>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Driver Hours and Revenue by date fleet public private plan actual] WHERE ([Fleet] LIKE @Fleet + '%')">
        <SelectParameters>
            <asp:Parameter DefaultValue="bud" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
    <p>
        Notes:</p>
    <ol>
        <li>Drivers and loads must be on Planner</li>
        <li>Drive/Non Drive Times require phone data. No corrections calculated</li>
        <li>Revenues calculated from RFS billing not invoicing</li>
        <li>Drive/Non Drive, Transit &amp; Dwell in minutes</li>
    </ol>
    <p>
        &nbsp;</p>
</body>
</html>
