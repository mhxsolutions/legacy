<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PlanINFO.aspx.vb" Inherits="PlanINFO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan Info</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Plan with Performance Info</h3>
        <h3><dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to XLSX" Theme="Metropolis">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="350px" MinWidth="300px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" ReadOnly="True" SortIndex="1" SortOrder="Descending" VisibleIndex="7">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin City" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination City" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="3" SortOrder="Ascending" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch Arrive" VisibleIndex="24">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Sch Depart" VisibleIndex="25">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Load" FieldName="Load Ref" VisibleIndex="26">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Origin" VisibleIndex="28">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Arrive Destination" VisibleIndex="29">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Destination" VisibleIndex="30">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Action" FieldName="Planner Action" VisibleIndex="32">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Actual Transit" ReadOnly="True" VisibleIndex="35">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Actual Dwell" ReadOnly="True" VisibleIndex="36">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [PlannerINFO with driver fleet co] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Plan Date] &gt;= @Plan_Date))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter DefaultValue="1/1/2013" Name="Plan_Date" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Plan with Performance Info" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
