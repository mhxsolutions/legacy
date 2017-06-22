<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ScanReview.aspx.vb" Inherits="ScanReview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scan Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Scan Review</h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="100">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Scan Link" FieldName="PDF_link_w_load" VisibleIndex="6">
                    <PropertiesTextEdit EncodeHtml="False">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn Caption="POD" FieldName="POD_Flag" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="POD Time" VisibleIndex="9">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load" Visible="False" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Planned Load" FieldName="Load Ref" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Planner Loads with Scans] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        List of all Planned Loads for Budway and any scans linked to those loads.</p>
</body>
</html>
