<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AuditPlannedLoads.aspx.vb" Inherits="AuditPlannedLoads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit Planned Loads</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Audit Planned Loads (<a href="index.aspx">home</a>)<br />
        </h3>
        <p>
            Use this audit to clean up Planed Loads not completed.</p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue">
            <SettingsContextMenu Enabled="True" EnableGroupPanelMenu="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20" Position="TopAndBottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangeCalendar">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangeCalendar">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Audit Planned Loads without logout or POD] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        No LogOut Date or LogOut but no POD</p>
    <p>
        Loads planned for Delivery only</p>
</body>
</html>
