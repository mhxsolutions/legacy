<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Driver Clock In.aspx.vb" Inherits="Driver_Clock_In" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Clock In</title>
</head>
<body>
    <h3>Driver Clock In/Out with Break Time (<a href="Default.aspx">home</a>)</h3>
    <p>
        &nbsp;</p>
    <form id="form1" runat="server">
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Expand All" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Collapse All" Theme="Metropolis">
        </dx:ASPxButton>
        <p>
            Filter by Plan Date</p>
        <p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="EmployeeID" Theme="Metropolis">
                <SettingsContextMenu Enabled="True" EnableRowMenu="True">
                </SettingsContextMenu>
                <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit" HideDataCellsAtWindowInnerWidth="800">
                </SettingsAdaptivity>
                <SettingsPager PageSize="100">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsPopup>
                    <HeaderFilter MinHeight="300px" MinWidth="300px" />
                </SettingsPopup>
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangePicker">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Plan Clock In" ReadOnly="True" VisibleIndex="4">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Clock In" VisibleIndex="5">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Payroll Start" VisibleIndex="7">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Delta (early)" ReadOnly="True" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="BreakTimeSum" VisibleIndex="9">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="End Time" VisibleIndex="10">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Clock Out" VisibleIndex="11">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="PlanBreakTotal" VisibleIndex="8">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="Exclude" VisibleIndex="16">
                    </dx:GridViewDataCheckColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Agilis Driver Plan Start - Clock In - Payroll Start] WHERE ([Company ID ref] = @Company_ID_ref)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Clock In OUt" GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
        </p>
    <div>
    
    </div>
    </form>
</body>
</html>
