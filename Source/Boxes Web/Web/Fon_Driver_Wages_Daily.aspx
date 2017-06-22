<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Fon_Driver_Wages_Daily.aspx.vb" Inherits="Fon_Driver_Wages_Daily" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fon Driver Wages</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver and Sub Hauler Daily Revenue &amp; Pay - Fontana - <a href="fon.aspx">home</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Throughput" ReadOnly="True" 
                    VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver Pay" ReadOnly="True" 
                    VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FSC" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Driver Revenue and Pay by day 45 days ltd] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Driver and Sub Hauler pay from weekly payroll calculation.</p>
    <p>
        55 days data where Driver Pay has been processed by Operations</p>
    <p>
        Throughput based on Planned Transit + Dwell</p>
</body>
</html>
