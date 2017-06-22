<%@ Page Title="Stock Net Totals" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Invnetory_Sums.aspx.cs" Inherits="Web.Clients.All.Invnetory_Sums" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Stock on Hand - Net Totals</h3>
<p>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
    </dx:ASPxButton>
</p>
    <p>
        Zero count stock is reported to review over/short pipe after tally out.*</p>
<p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue" Width="85%">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsPopup>
            <HeaderFilter MinHeight="300px" />
        </SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="PSEP" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" SortIndex="2" SortOrder="Ascending" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PO#" VisibleIndex="4">
                <PropertiesTextEdit>
                    <Style Wrap="False">
                    </Style>
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Pounds-net" ReadOnly="True" VisibleIndex="5" Width="1in">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="LNFT" FieldName="LNFT-net" ReadOnly="True" VisibleIndex="6" Width="1in">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count" FieldName="Count-net" ReadOnly="True" VisibleIndex="7" Width="0.75in">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Status" FieldName="Location Status" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Project" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Count-net" ShowInGroupFooterColumn="Count" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="LNFT-net" ShowInGroupFooterColumn="LNFT" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Pounds-net" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" />
        </TotalSummary>

<Styles AdaptiveDetailButtonWidth="22">
    <Header Wrap="True">
    </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA Products Recd sum less Shipped sum] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Stock on Hand Net Totals" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
</p>
Net Totals calculation = Sum In - Sum Out<br />
This calculation is not equivalent to sum of remaining inventory because of change in pipe lengths/weights on tally out.<br />
    *When revising lengths/weights with tally check on shipment, over/short can be left in inventory when count = 0. 
</asp:Content>
