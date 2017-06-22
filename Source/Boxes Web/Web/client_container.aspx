<%@ Page Language="VB" AutoEventWireup="false" CodeFile="client_container.aspx.vb" Inherits="client_container" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Appointments</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Client Report for Container Appointments<br />
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue" Width="808px">
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
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowSelectCheckbox="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Container" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release#" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Arrived" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="Arrived At" VisibleIndex="12">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Ref#" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Devanned" VisibleIndex="13">
                </dx:GridViewDataCheckColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [PUR Appointments] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
