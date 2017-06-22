<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_Revenue.aspx.vb" Inherits="Web_NorCal_Revenue" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nor Cal Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            NorCal Revenue<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Black">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Year" VisibleIndex="1" SortIndex="2" 
                    SortOrder="Descending">
                    <Settings AllowAutoFilter="False" AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" VisibleIndex="2" SortIndex="3" 
                    SortOrder="Descending">
                    <Settings AllowAutoFilter="False" AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" VisibleIndex="3" SortIndex="4" 
                    SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" 
                        HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Work Days" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Average" ReadOnly="True" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="All Driver Average" ReadOnly="True" 
                    VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager>
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
            <Styles>
                <DetailRow HorizontalAlign="Center" Wrap="False">
                </DetailRow>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            
            SelectCommand="SELECT * FROM [Driver days worked and revenue with monthly average - Pittsburg only]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
