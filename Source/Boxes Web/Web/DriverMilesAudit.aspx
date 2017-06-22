<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DriverMilesAudit.aspx.vb" Inherits="DriverMilesAudit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit Leg Miles</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Audit Driver Plan Leg Miles</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Hrs for Day" FieldName="Hours" ReadOnly="True" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Leg" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Miles for Leg" FieldName="Miles" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Driver Plan Miles Audit] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Company ID ref] = @Company_ID_ref))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1/1/2014" Name="Plan_Date" Type="DateTime" />
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Driver Plan Leg Miles" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
