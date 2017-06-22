<%@ Page Title="SP Received" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="SP_received_on_date_all.aspx.cs" Inherits="Web.Clients.Assigned.SP_received_on_date_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>SP Formatted Receiving</h3>
    <table class="dxic-fileManager">
        <tr>
            <td style="width: 267px"><b>Start Date</b></td>
            <td><b>End Date</b></td>
        </tr>
        <tr>
            <td style="width: 267px">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" Width="257px" DayNameFormat="Shortest" TitleFormat="Month">
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
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" Width="257px" DayNameFormat="Shortest" TitleFormat="Month">
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
    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Office2003Olive">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="200">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True" ShowAllItem="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowGroupFooter="VisibleAlways" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="12" Caption="Terminal">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="0" GroupIndex="1" SortIndex="1" SortOrder="Ascending">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="1" GroupIndex="2" SortIndex="2" SortOrder="Ascending">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Vendor/Supplier" SortIndex="3" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="4" SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Release#" SortIndex="5" SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Grade" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="#Bales" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Wt Lb" FieldName="WT" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Avg Wt" FieldName="Avg_WT" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons" ReadOnly="True" VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Type" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="13" Caption="Product">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Type" FieldName="Receiver Type" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="#Bales" ShowInColumn="#Bales" SummaryType="Sum" DisplayFormat="Sum={0:n0}" />
            <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" DisplayFormat="Sum={0:n1}" />
            <dx:ASPxSummaryItem FieldName="WT" ShowInColumn="Wt Lb" SummaryType="Sum" DisplayFormat="Sum={0:n0}" />
            <dx:ASPxSummaryItem FieldName="Avg_WT" ShowInColumn="Avg Wt" SummaryType="Average" DisplayFormat="Avg={0:n1}" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="#Bales" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="WT" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            <dx:ASPxSummaryItem DisplayFormat="Avg={0:n1}" FieldName="Avg_WT" ShowInGroupFooterColumn="Avg Wt" SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" ValueDisplayFormat="{0:n1}" />
        </GroupSummary>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Received on Date" GridViewID="ASPxGridView1" BottomMargin="50" LeftMargin="50" Landscape="True" RightMargin="50" TopMargin="50">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Terminal Abr], Client, Profile, [Receiver ID], [Vendor/Supplier], [Date Received], Location, Release#, Grade, [#Bales], WT, Avg_WT, Tons, R_Cleint_Ref, [Company ID ref], [Product Type], [Receiver Type] FROM [Hydra Receiving History for scrap paper] WHERE ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2) AND ([Company ID ref] = @curr_co)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter DefaultValue="3" Name="curr_co" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
</asp:Content>
