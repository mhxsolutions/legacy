<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MHXDriverHours.aspx.vb" Inherits="MHXDriverHours" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Hours</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>MHX Driver Hours<br />
        </h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export Excel" Theme="MetropolisBlue">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20" Position="TopAndBottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UltiProEE" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Job" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="Plan Date" SortIndex="1" SortOrder="Ascending" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Reg Hrs" FieldName="TotalHrs" ReadOnly="True" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Term" FieldName="NS_Office" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Department" ReadOnly="True" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Service Line" FieldName="NS_ServiceLine" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PayCode" FieldName="Job Code" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Planner Payroll Driver Daily Hours less Lunch] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Driver Hours" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br />
    </div>
    </form>
    <p>
        Lunch time has been removed from Reg Hrs field.</p>
    <p>
        Formatted for UltiPro</p>
</body>
</html>
