<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pitt_Driver_Wages.aspx.vb" Inherits="Pitt_Driver_Wages" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Wages</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver and Sub Hauler Wages (45 days) - Pittsburg - <a href="pitt_default.aspx">
            home</a></h3>
        <br />
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Work Days" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Revenue" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Average Revenue" ReadOnly="True" 
                VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Pay" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Average Pay" ReadOnly="True" 
                VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="7">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Driver days worked and revenue 45 days - Pittsburg only]">
    </asp:SqlDataSource>
    </form>
    <p>
        Driver and Sub Hauler pay from weekly payroll calculation.</p>
    <p>
        45 day data is between today less 55 days and today less 10 days in order to 
        avoid days without payroll calculations.</p>
</body>
</html>
