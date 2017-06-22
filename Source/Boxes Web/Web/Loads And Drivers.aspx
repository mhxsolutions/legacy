<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Loads And Drivers.aspx.vb" Inherits="Loads_And_Drivers" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Loads with Drivers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Loads with Drivers and Sub Pay (<a href="index.aspx">home</a>)<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="export XLSX" Theme="MetropolisBlue">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
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
                <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="EmployeeID" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NetSuiteVendorID" VisibleIndex="12" Caption="Assigned Vendor ID">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Planned Drivers" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Title" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Planned Fleet" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Assigned Driver" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Assigned fleet" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vendor" VisibleIndex="18" Caption="Paid Vendor">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Invoice Total" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date of Subhaul Export" VisibleIndex="17">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Subhaul Exporter" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Available Rate" FieldName="OD Rate" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Override Rate" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Container" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Review all loads with driver and sub pay and OD rate] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="loads and drivers" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>

        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" /><br />
    </form>
    <p>
        Subhauler Pay requires: A subhauler, Logout, POD Date, New Suite Vendor ID, Assigned Driver and Available Rate or Load Rate</p>
</body>
</html>
