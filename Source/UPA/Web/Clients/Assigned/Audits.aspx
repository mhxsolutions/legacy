<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Audits.aspx.cs" Inherits="Web.Clients.Assigned.Audits" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h3>Audits<br />
            </h3>
    </div>
<h3>
        Unlocked Receivers - Inbound Scheduled<br />
    <br />
    </h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export PDF" Theme="Metropolis">
    </dx:ASPxButton>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Office2010Blue" Width="427px">
        <SettingsPager PageSize="200">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" />

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
            <dx:GridViewDataDateColumn FieldName="Receiver Date" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Truck Arrived" VisibleIndex="3">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Whse Tally" VisibleIndex="5">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="Package_Received" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="Package_Complete" VisibleIndex="6">
            </dx:GridViewDataCheckColumn>
        </Columns>
    </dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Receivers count by date for Inbound Scheduled] WHERE ([Company ID ref] = @Company_ID_ref)">
    <SelectParameters>
        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Unlocked Receivers" GridViewID="ASPxGridView2">
    </dx:ASPxGridViewExporter>
<p>
    <br />
    Truck not arrived = advance receiver<br />
    Packaged Received = Carrier copy of receiving documents received in office<br />
    Truck Arrived, no Warehouse Tally = waiting for warehouse to confirm stock<br />
    Package Received and Warehouse Tally = Receiver should be locked<br />
    <br />
    Note: unloced receivers do not show stock in inventory</p>
<h3>Open Loads</h3>
<dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Load" Theme="Office2010Blue" EnableTheming="True">
    <SettingsPager PageSize="200">
        <AllButton Visible="True">
        </AllButton>
    </SettingsPager>
    <Settings ShowFilterRow="True" />

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
        <dx:GridViewDataDateColumn FieldName="Scheduled Date" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            <Settings AllowHeaderFilter="True" />
            <SettingsHeaderFilter Mode="DateRangePicker">
            </SettingsHeaderFilter>
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="3">
        </dx:GridViewDataTextColumn>
    </Columns>
</dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Loads Open] WHERE ([Company ID ref] = @Company_ID_ref)">
    <SelectParameters>
        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<p>
    Loads that have not been marked as Arrive/Depart (LogOut).</p>
<h3>
    <br />
    Loads without Receivers</h3>
<dx:ASPxGridView ID="ASPxGridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="Office2010Blue" Width="556px">
    <SettingsAdaptivity AdaptivityMode="HideDataCells">
    </SettingsAdaptivity>
    <SettingsPager PageSize="200">
        <AllButton Visible="True">
        </AllButton>
        <PageSizeItemSettings ShowAllItem="True" Visible="True">
        </PageSizeItemSettings>
    </SettingsPager>
    <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" />
    <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

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
        <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Load" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="Load Date" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            <Settings AllowHeaderFilter="True" />
            <SettingsHeaderFilter Mode="DateRangePicker">
            </SettingsHeaderFilter>
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataCheckColumn FieldName="Arrive/Depart" VisibleIndex="6">
        </dx:GridViewDataCheckColumn>
        <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="7">
        </dx:GridViewDataTextColumn>
    </Columns>
    <Styles>
        <Cell Wrap="False">
        </Cell>
    </Styles>
</dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Loads without Receiver] WHERE ([Company ID ref] = @Company_ID_ref)">
    <SelectParameters>
        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<p>
    Loads in system that have not had a Receiver attached.<br />
    <br />
    <br />
</p>
    <dx:ASPxGridViewExporter ID="GridViewExporter2" runat="server" FileName="Openn Loads" GridViewID="ASPxGridView3">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridViewExporter ID="GridViewExporter3" runat="server" FileName="Loads without Receivers" GridViewID="ASPxGridView4">
    </dx:ASPxGridViewExporter>
    

    
</asp:Content>
