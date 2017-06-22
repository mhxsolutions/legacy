<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Invoices by GL.aspx.vb" Inherits="Invoices_by_GL" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>invoices by Customer</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Invoices by Customer (GL and Sub Account) - <a href="default.aspx">home</a></h3>
        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
            </dx:ASPxButton>
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Invoice#" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="350px" MinWidth="350px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Bill To" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Invoice Date" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Invoice#" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SLGL#" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SLSub" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Service" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Invoice Totals by GL v2] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Invoices by GL" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <br />
    
    </div>
    </form>
</body>
</html>
