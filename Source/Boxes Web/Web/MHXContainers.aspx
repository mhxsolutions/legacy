<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MHXContainers.aspx.vb" Inherits="MHXContainers" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Containers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Containers Inbound (<a href="index.aspx">home</a>)<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export Excel" Theme="MetropolisBlue">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20" Position="TopAndBottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Container" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Customer Ref#" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Arrived" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Unloaded" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Pick Up Date" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="inbound PUR" FieldName="Load" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [MHXwebContainersInbound]"></asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="containers" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br /><br />
    </form>
</body>
</html>
