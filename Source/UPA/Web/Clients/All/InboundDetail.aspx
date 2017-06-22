<%@ Page Title="Inbound Detail" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="InboundDetail.aspx.cs" Inherits="Web.Clients.All.InboundDetail" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inbound Truck Detail Status</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewBandColumn Caption="Release/Notice of Dispatch">
                        <Columns>
                <dx:GridViewDataDateColumn FieldName="Schedule Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="UPA Schedule ID" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release/NOD" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PO#" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Release/NOD Level Comments" FieldName="Schedule Comments" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mode" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Shipper BOL" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            </Columns>
                        <HeaderStyle BackColor="#6699FF" Font-Bold="True" />
                    </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Scheduled Load" VisibleIndex="4">
                    <Columns>
                        <dx:GridViewDataCheckColumn FieldName="Arrive" ShowInCustomizationForm="True" VisibleIndex="0">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn FieldName="Arrive Date" ShowInCustomizationForm="True" VisibleIndex="1">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataCheckColumn FieldName="Docs Received" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Yard Doc/POD">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn FieldName="Docs Recd Date" ShowInCustomizationForm="True" VisibleIndex="4" Caption="POD Recd Date">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Load Level Comments" FieldName="Load Comments" ShowInCustomizationForm="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn Caption="Load Rejected" FieldName="Reject" VisibleIndex="2">
                        </dx:GridViewDataCheckColumn>
                    </Columns>
                    <HeaderStyle BackColor="#6666FF" Font-Bold="True" />
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Item Detail" VisibleIndex="11">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Item ID" ShowInCustomizationForm="True" VisibleIndex="0" Caption="Serial #">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Heat Number" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Heat Code">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Location" ShowInCustomizationForm="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Item Level Comments" FieldName="Item Comment" ShowInCustomizationForm="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Description" ShowInCustomizationForm="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Receiver ID" FieldName="Receiver ID" ShowInCustomizationForm="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="Accepted" ShowInCustomizationForm="True" VisibleIndex="6">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn FieldName="Goods Received" ShowInCustomizationForm="True" VisibleIndex="7">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <HeaderStyle BackColor="#6600FF" Font-Bold="True" />
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Inspection Package" VisibleIndex="10">
                    <Columns>
                        <dx:GridViewDataCheckColumn Caption="Pkg Complete" FieldName="Package_Complete" VisibleIndex="3">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn Caption="Received Date" FieldName="Package_Received_Date" VisibleIndex="2">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Pkg Status" FieldName="Package_Status" VisibleIndex="0">
                            <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn Caption="Pkg Received" FieldName="Package_Received" VisibleIndex="1">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn Caption="Complete Date" FieldName="Package_Complete_Date" VisibleIndex="4">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataCheckColumn Caption="Inspection Complete" FieldName="Inspection_Complete" VisibleIndex="5">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn Caption="Inspection Date" FieldName="Inspection_Complete_Date" VisibleIndex="6">
                            <Settings AllowHeaderFilter="True" />
                            <SettingsHeaderFilter Mode="DateRangePicker">
                            </SettingsHeaderFilter>
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <HeaderStyle BackColor="#3333FF" Font-Bold="True" />
                </dx:GridViewBandColumn>
            </Columns>
            <SettingsContextMenu EnableColumnMenu="True" Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="15">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" AllowFixedGroups="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="UPA Schedule ID" SummaryType="Count" />
            </GroupSummary>
            <Styles>
                <DetailCell Wrap="False">
                </DetailCell>
                <AlternatingRow Enabled="True">
                </AlternatingRow>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA Inbound Scheduled Detail with Load Notes] WHERE ([ClientID] = @ClientID)">
            <SelectParameters>
                <asp:SessionParameter Name="ClientID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inbound Detail" GridViewID="ASPxGridView1" Landscape="True" PreserveGroupRowStates="True">
        </dx:ASPxGridViewExporter>
    </p>
    <p>
        Notes on Interpreting Table Data</p>
    <ol>
        <li>Each line is a Truck or Truck Load Item with Issue Comments</li>
        <li>A Scheduled Date and UPA Schedule ID is assigned to each notice of dispatch</li>
        <li>When truck arrives at facility, record is marked &quot;Arrive&quot; and includes date stamp</li>
        <li>When packing list and MTR&#39;s received from QA/QC record is marked &quot;Docs Received&quot;</li>
        <li>Load Comments are general comments for truck</li>
        <li>Item Comments are specific items with QA/QC issues</li>
        <li>If Receiver is not marked &quot;Accepted,&quot; parts are shows in &quot;Inbound Material - Inventory Pending to Terminal&quot;</li>
        <li>Receivers marked Accepted have parts in Stock On Hand with the exception of parts on QA/QC hold.</li>
    </ol>
</asp:Content>
