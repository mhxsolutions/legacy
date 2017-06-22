<%@ Page Title="Quarantine on Date" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Quarantine On Date.aspx.cs" Inherits="Web.Clients.Assigned.Quarantine_On_Date" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Stock in Quarantine on Selected Date</h3>
    <p>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
    </p>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Rec Detail ref" Visible="False" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Into_Quar" VisibleIndex="14">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Out_Quar" VisibleIndex="15">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="16">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Company ID ref" Visible="False" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Exit Date" ReadOnly="True" Visible="False" VisibleIndex="18">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Long Description" VisibleIndex="9" SortIndex="4" SortOrder="Ascending">
                    <Settings AllowEllipsisInText="True" />
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="LNFT" ShowInCustomizationForm="True" VisibleIndex="12">
    <PropertiesTextEdit DisplayFormatString="n1">
    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="SCG Load Ref" VisibleIndex="3" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PO#" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn VisibleIndex="8" Caption="NCR#" FieldName="Inspection">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PSEP" SortIndex="5" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Damage Comments" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver#" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Serial#" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Heat#" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Account" FieldName="Client Name" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count" ShowInColumn="Count" SummaryType="Sum" DisplayFormat="Count = {0:n0}" />
                <dx:ASPxSummaryItem FieldName="LNFT" ShowInColumn="LNFT" SummaryType="Sum" DisplayFormat="LNFT= {0:n0}" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Count = {0:n0}" FieldName="Count" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Quarantine On Date" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Rec Detail ref], Date_Into_Quar, Date_Out_Quar, [Shipment Date], [Company ID ref], [Exit Date], PSEP, [Stock Code], [Long Description], LNFT, [Date Received], Project, [SCG Load Ref], Count, PO#, Inspection, [Damage Comments], Receiver#, Serial#, Heat#, [Client ID], [Client Name] FROM [Inventory quarantine history] WHERE ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = @curr_co) AND (Date_Into_Quar &lt;= @Date_Into_Quarq)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:Parameter DefaultValue="7" Name="curr_co" />
                <asp:ControlParameter ControlID="Calendar1" Name="Date_Into_Quarq" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <ul>
        <li>This report shows all stock that was in locations with status = Quarantine on the selected date.</li>
        <li>&nbsp;No pre-receiver inventory is included in report.</li>
    </ul>
</asp:Content>
