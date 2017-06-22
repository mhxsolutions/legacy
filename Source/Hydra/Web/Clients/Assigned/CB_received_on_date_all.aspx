<%@ Page Title="Paper Rolls Received" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="CB_received_on_date_all.aspx.cs" Inherits="Web.Clients.Assigned.CB_received_on_date_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Paper Rolls Formatted Receiving</h3>
    <table class="dxic-fileManager">
        <tr>
            <td style="width: 268px"><b>Start Date</b></td>
            <td><b>End Date</b></td>
        </tr>
        <tr>
            <td style="width: 268px">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="257px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
            <td>
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="257px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
        </tr>
    </table>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    </p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Office2003Olive" Width="100%">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="200">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowGroupFooter="VisibleAlways" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="0">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Width" ReadOnly="True" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PO#" VisibleIndex="5" Caption="Inbound PO#">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="InboundLoad#" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Roll Ct" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons" ReadOnly="True" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="16">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Type" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="17" Caption="Product">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Rcvr Type" FieldName="Receiver Type" VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Damage Comment" FieldName="Damage" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Pounds" ShowInColumn="Pounds" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Roll Ct" ShowInColumn="Roll Ct" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="LNFT" ShowInColumn="LNFT" SummaryType="Sum" DisplayFormat="Sum={0:n0}" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="LNFT" ShowInGroupFooterColumn="LNFT" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Roll Ct" ShowInGroupFooterColumn="Roll Ct" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Pounds" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" />
        </GroupSummary>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Receiving History" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Terminal Abr], Client, Profile, [Receiver ID], [Date Received], Description, [Prod 2] AS Width, PO#, InboundLoad#, [Item ID], [Unit Ct], [Roll Ct], Pounds, Tons, LNFT, R_Cleint_Ref, [Company ID ref], [Product Type], [Receiver Type], Location, Damage, Status FROM [Hydra Receiving History for containerboard] WHERE ([Date Received] &lt;= @Date_Received2) AND ([Date Received] &gt;= @Date_Received) AND ([Company ID ref] = @current_co)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter DefaultValue="3" Name="current_co" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
</asp:Content>
