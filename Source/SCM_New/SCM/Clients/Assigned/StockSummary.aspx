<%@ Page Title="Stock Summary" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="StockSummary.aspx.cs" Inherits="Web.Clients.Assigned.StockSummary" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Consigned PSEP Stock Summary on Date</h2>
    <br />
    <div class="contentDiv">
        <p>
            Select Inventory Date:
        </p>
        <p>
            <dx:ASPxCalendar ID="Calendar1" runat="server" AutoPostBack="True"></dx:ASPxCalendar>
        </p>
        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX">
            </dx:ASPxButton>
        </p>
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
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="6" SortIndex="1" SortOrder="Ascending">
                        <CellStyle Wrap="False">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="SCG Stock Code" FieldName="Product Group 1" VisibleIndex="8" SortIndex="2" SortOrder="Ascending" Width="150px">
                        <Settings AllowHeaderFilter="True" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" VisibleIndex="14" Width="150px">
                        <Settings AllowEllipsisInText="True" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="New Description" FieldName="Product Group 5" VisibleIndex="16" Width="150px">
                        <Settings AllowEllipsisInText="True" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="17">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="23">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Count" FieldName="Unit Count" VisibleIndex="22">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="26">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="4" SortIndex="0" SortOrder="Ascending">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="28">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="31">
                    </dx:GridViewDataDateColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Unit Count" ShowInColumn="Unit Count" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
                </TotalSummary>
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Unit Count" SummaryType="Sum" />
                    <dx:ASPxSummaryItem DisplayFormat="LNFT={0:n0}" FieldName="LnFt" SummaryType="Sum" />
                </GroupSummary>
            </dx:ASPxGridView>
            <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Stock Summary" GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary auth viewer] WHERE (([Exit Date] &gt; @Exit_Date) AND ([Recd Date] &lt;= @Recd_Date) AND ([Auth_Viewer] = @Auth_Viewer))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
                    <asp:SessionParameter Name="Auth_Viewer" SessionField="context_clientID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </div>
</asp:Content>
