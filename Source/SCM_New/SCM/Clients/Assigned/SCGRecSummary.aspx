<%@ Page Title="Received Summary" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SCGRecSummary.aspx.cs" Inherits="Web.Clients.Assigned.SCGRecSummary" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function UpdateInfo() {
            var daysTotal = deEnd.GetRangeDayCount();
            tbInfo.SetText(daysTotal !== -1 ? daysTotal + ' days' : '');
        }
    </script>
    <h3>Consigned PSEP Stock Received between Dates</h3>
    <div class="contentDiv">
        <table>
            <tr>
                <td>Start Date:</td>
                <td>End Date: </td>
                <td></td><td></td>
            </tr>
            <tr>
                <td style="padding-right: 10px">
                    <dx:ASPxDateEdit ID="deStart" ClientInstanceName="deStart" runat="server" AutoPostBack="true">
                        <ClientSideEvents DateChanged="UpdateInfo"></ClientSideEvents>
                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td style="padding-right: 10px">
                    <dx:ASPxDateEdit ID="deEnd" ClientInstanceName="deEnd" runat="server" AutoPostBack="true">
                        <DateRangeSettings StartDateEditID="deStart"></DateRangeSettings>
                        <ClientSideEvents DateChanged="UpdateInfo"></ClientSideEvents>
                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="True" ErrorText="End date is required"></RequiredField>
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td style="padding-right: 30px">
                    <dx:ASPxTextBox ID="tbInfo" ClientInstanceName="tbInfo" runat="server" ReadOnly="True" Width="100"></dx:ASPxTextBox>
                </td>
                <td><dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX">
            </dx:ASPxButton></td>
            </tr>
           
        </table>

        <p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Width="100%">
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                </SettingsAdaptivity>
                <SettingsPager PageSize="20">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" AutoExpandAllGroups="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Units" VisibleIndex="13" Caption="Count">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="SCG Stock Code" FieldName="Prod 1" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Description" FieldName="Prod 4" SortIndex="3" SortOrder="Ascending" VisibleIndex="9">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="New Description" FieldName="Prod 5" VisibleIndex="11">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="12">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Pounds" FieldName="WT" VisibleIndex="15">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="20">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="22">
                    </dx:GridViewDataDateColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LNFT" ShowInColumn="LNFT" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Units" ShowInColumn="Units" SummaryType="Sum" />
                </TotalSummary>
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Units" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LNFT" SummaryType="Sum" />
                </GroupSummary>
            </dx:ASPxGridView>
            <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Stock Received by Date" GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [inventory Received Summary] WHERE (([Auth_Viewer] = @Auth_Viewer) AND ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2))">
                <SelectParameters>
                    <asp:SessionParameter Name="Auth_Viewer" SessionField="context_clientID" Type="Int32" />
                    <asp:ControlParameter ControlID="deStart" Name="Date_Received" PropertyName="Date" Type="DateTime" />
                    <asp:ControlParameter ControlID="deEnd" Name="Date_Received2" PropertyName="Date" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </div>
</asp:Content>
