<%@ Page Title="Shipped Summary" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SCGShippedSummary.aspx.cs" Inherits="Web.Clients.Assigned.SCGShippedSummary" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function UpdateInfo() {
            var daysTotal = deEnd.GetRangeDayCount();
            tbInfo.SetText(daysTotal !== -1 ? daysTotal + ' days' : '');
        }
    </script>
    <h2>Consigned PSEP Stock Shipped by Date</h2>
    <div class="contentDiv">
        <%--        <table class="dx-justification">
            <tr>
                <td>Start Date:</td>
                <td>End Date:</td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxCalendar ID="Calendar1" runat="server" AutoPostBack="True"></dx:ASPxCalendar>
                </td>
                <td>
                    <dx:ASPxCalendar ID="Calendar2" runat="server" AutoPostBack="True"></dx:ASPxCalendar>
                </td>
            </tr>
        </table--%>
                <table>
                    <tr>
                        <td>Start Date:</td>
                        <td>End Date: </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="padding-right: 10px">
                            <dx:ASPxDateEdit ID="deStart" ClientInstanceName="deStart" runat="server" AutoPostBack="true">
                                <ClientSideEvents DateChanged="UpdateInfo">
                                </ClientSideEvents>
                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                    <RequiredField IsRequired="True" ErrorText="Start date is required">
                                    </RequiredField>
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </td>
                        <td style="padding-right: 10px">
                            <dx:ASPxDateEdit ID="deEnd" ClientInstanceName="deEnd" runat="server" AutoPostBack="true">
                                <DateRangeSettings StartDateEditID="deStart">
                                </DateRangeSettings>
                                <ClientSideEvents DateChanged="UpdateInfo">
                                </ClientSideEvents>
                                <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                                    <RequiredField IsRequired="True" ErrorText="End date is required">
                                    </RequiredField>
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </td>
                        <td style="padding-right: 30px">
                            <dx:ASPxTextBox ID="tbInfo" ClientInstanceName="tbInfo" runat="server" ReadOnly="True" Width="100">
                            </dx:ASPxTextBox>
                        </td>
                        <td>
                            <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX">
                            </dx:ASPxButton>
                        </td>
                    </tr>
        </table>
        <%--        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX">
            </dx:ASPxButton>
        </p>--%>
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
                    <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="SCG Stock Code" FieldName="Product Group 1" SortIndex="2" SortOrder="Ascending" VisibleIndex="7">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="3" SortOrder="Ascending" VisibleIndex="13" AllowTextTruncationInAdaptiveMode="True">
                        <CellStyle Wrap="True">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="New Description" FieldName="Product Group 5" VisibleIndex="15" AllowTextTruncationInAdaptiveMode="True">
                        <CellStyle Wrap="True">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="16">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="22">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Count" FieldName="Unit Count" VisibleIndex="21">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="23">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="25">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="28">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Dest Client" VisibleIndex="29">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Dest City" VisibleIndex="30">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="PO#" FieldName="BOL_Client_PO" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Unit Count" ShowInColumn="Unit Count" SummaryType="Sum" />
                </TotalSummary>
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Unit Count" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LnFt" SummaryType="Sum" />
                </GroupSummary>
                <Styles>
                    <Row Wrap="False">
                    </Row>
                </Styles>
            </dx:ASPxGridView>
            <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Shipping by Date" GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary with dest and PO] WHERE (([Auth_Viewer] = @Auth_Viewer) AND ([Ship Date] &gt;= @Ship_Date) AND ([Ship Date] &lt;= @Ship_Date2))">
                <SelectParameters>
                    <asp:SessionParameter Name="Auth_Viewer" SessionField="context_clientID" Type="Int32" />
                    <asp:ControlParameter ControlID="deStart" Name="Ship_Date" PropertyName="Date" Type="DateTime" />
                    <asp:ControlParameter ControlID="deEnd" Name="Ship_Date2" PropertyName="Date" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </div>
</asp:Content>
