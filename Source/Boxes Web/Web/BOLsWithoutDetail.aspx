<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BOLsWithoutDetail.aspx.vb" Inherits="BOLsWithoutDetail" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BOL no Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>BOLs without Detail (<a href="index.aspx">home</a>)<br />
            <br />
        </h3>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [BOLINFO without detail] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load ID" Theme="MetropolisBlue">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20" Position="TopAndBottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Client" FieldName="Shipper" ReadOnly="True" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="4">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="BOL" FieldName="Load ID" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangeCalendar">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <br />
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br /><br />
    </div>
    </form>
</body>
</html>
