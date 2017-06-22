<%@ Page Title="Trucks Sch/Recd" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="TruckSchRecd.aspx.cs" Inherits="Web.Clients.All.TruckSchRecd" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Trucks Scheduled vs. Received</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Office2010Blue" OnClick="ASPxButton1_Click">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue" Width="3in">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Trucks Arrived" ShowInColumn="Trucks Arrived" SummaryType="Sum" DisplayFormat="Arrived = {0:n0}" />
                <dx:ASPxSummaryItem FieldName="Trucks Scheduled" ShowInColumn="Trucks Scheduled" SummaryType="Sum" DisplayFormat="Scheduled = {0:n0}" />
                <dx:ASPxSummaryItem FieldName="Docs in Office" ShowInColumn="Docs in Office" SummaryType="Sum" DisplayFormat="Docs = {0:n0}" />
                <dx:ASPxSummaryItem FieldName="Receivers Started" ShowInColumn="Receivers Started" SummaryType="Sum" DisplayFormat="Receivers = {0:n0}" />
                <dx:ASPxSummaryItem FieldName="Receivers Complete" ShowInColumn="Receivers Complete" SummaryType="Sum" DisplayFormat="Receivers Comp = {0:n0}" />
            </TotalSummary>
            <SettingsBehavior EnableCustomizationWindow="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="1" SortIndex="0" SortOrder="Descending">
                    <Settings AutoFilterCondition="GreaterOrEqual" AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Trucks Scheduled" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Trucks Arrived" VisibleIndex="3" Caption="Trucks (Sch) Arrived">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Docs in Office" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receivers Started" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receivers Complete" VisibleIndex="6" Caption="Receivers Dated Complete">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowFooter="True" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA trucks sch vs recd] WHERE ([Client ID] = @Client_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="trucks scheduled and received" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
    <ul>
        <li>Trucks Scheduled may show arrived early or late.</li>
        <li>Trucks (Sch) Arrived - counts of scheduled trucks on actual arrival date.</li>
        <li>Unscheduled Trucks - under development</li>
        <li>Documents in Office - time/date stamped when completed materials management, inspection and carrier paperwork is returned to logistics.</li>
        <li>Receivers Started - based on the system creation date of receipt document.</li>
        <li>Receivers Dated Complete - often back dated from Documents in Office and/or Receivers Started to reflect actual date stock arrived.</li>
    </ul>
</asp:Content>
