<%@ Page Title="Physical Inventory" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Physical Inventory Counts.aspx.cs" Inherits="Web.Clients.Assigned.Physical_Inventory_Counts" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Physical Inventory - all data</h3>
    <p>
        &nbsp;</p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" Width="98%">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsBehavior AllowEllipsisInText="True" ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn Caption="Snapshot" FieldName="Inventory_Snapshot" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                    <PropertiesDateEdit DisplayFormatInEditMode="True" DisplayFormatString="G" EditFormat="Custom" EditFormatString="dd/MM/yyyy hh:mm:ss tt" UseMaskBehavior="True">
                    </PropertiesDateEdit>
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="List">
                        <DateRangePickerSettings DisplayFormatString="G" EditFormatString="G" />
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Flag" FieldName="Inventory_PC_Flag" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Location" FieldName="Location_PC" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PSEP" FieldName="Inventory_PC_Code" SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Serial#" FieldName="Inventory_PC_Serial" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Unit Ct" FieldName="Inventory_PC_Units" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Inventory_PC_Desc" VisibleIndex="7">
                    <Settings AllowEllipsisInText="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Cleared" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Count1" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Counter1" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Count1_datetime" VisibleIndex="12">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Count2" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Counter2" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Count2_datetime" VisibleIndex="15">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Count3" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Counter3" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Count3_datetime" VisibleIndex="18">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory Physical Count web data]"></asp:SqlDataSource>
    </p>
</asp:Content>
