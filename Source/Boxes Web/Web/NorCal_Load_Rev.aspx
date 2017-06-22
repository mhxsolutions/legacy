<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_Load_Rev.aspx.vb" Inherits="NorCal_Load_Rev" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NorCal Load Rev</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            NorCal Planned Load Revenue</h3>
        <br />
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" 
            Width="2.5in">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rev/Driver" ReadOnly="True" 
                    VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="T/plan min" ReadOnly="True" 
                    VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <strong>Details</strong><br />
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis" 
            Width="2.75in">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rev/Driver" ReadOnly="True" 
                    VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="T/plan min" ReadOnly="True" 
                    VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct Sub - House split] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
