<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EmpireContainers.aspx.vb" Inherits="EmpireContainers" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Empire</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Empire Containers Inbound (<a href="index.aspx">home</a>)<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export Excel" Theme="MetropolisBlue">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Container" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Customer Ref#" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                    <SettingsHeaderFilter Mode="List">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Arrived" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Unloaded" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [MHXwebEmpireContainersInbound]"></asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Empire Containers" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" /><br /><br />
    </form>
</body>
</html>
