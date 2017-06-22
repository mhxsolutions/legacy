<%@ Page Title="Yard Utilization" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Yard_Utilization.aspx.cs" Inherits="Web.Clients.Assigned.Yard_Utilization" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Yard Utilization</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2010Blue">
    </dx:ASPxButton>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager>
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Location Code" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location Status" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location Type" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="7" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Units" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Inventory Available" VisibleIndex="6">
                </dx:GridViewDataCheckColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Location Code], [Location Status], [Inventory Available], [Location Type], [tblDestination ref], Active, [Company ID ref], Description, Units, [As Of] FROM [Location Utilization] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Yard Utilization" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
    <p>
        All Active Locations with Unit count of given stock Description including open locations.</p>
</asp:Content>
