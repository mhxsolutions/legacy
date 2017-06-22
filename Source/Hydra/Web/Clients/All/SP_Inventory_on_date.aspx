<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="SP_Inventory_on_date.aspx.cs" Inherits="Web.Clients.All.SP_Inventory_on_date" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory as of Selected Date</h3>
    <table style="width: 100%">
        <tr>
            <td>
    <strong>Select Date</strong></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
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
            <td>&nbsp;</td>
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
<p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="200">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Vendor/Supplier" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" ReadOnly="True" VisibleIndex="11">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Release#" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Grade" SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="#Bales" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Wt Lb" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Avg_Wt" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Ship Date" ReadOnly="True" VisibleIndex="13">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Damage" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="#Bales" ShowInColumn="#Bales" SummaryType="Sum" DisplayFormat="#Bales={0:n0}" />
            <dx:ASPxSummaryItem DisplayFormat="Avg={0:n1}" FieldName="Avg_Wt" ShowInColumn="Avg_Wt" SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" DisplayFormat="Tons={0:n0}" />
            <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInColumn="Wt Lb" SummaryType="Sum" DisplayFormat="Wt Lb={0:n0}" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="#Bales" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" DisplayFormat="#Bales={0:n0}" />
            <dx:ASPxSummaryItem DisplayFormat="Avg={0:n1}" FieldName="Avg_Wt" ShowInGroupFooterColumn="Avg_Wt" SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" DisplayFormat="Tons={0:n0}" />
            <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" DisplayFormat="Wt Lb={0:n0}" />
        </GroupSummary>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory on Date" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Hydra Inventory All rcd and ship summary for scrap paper] WHERE (([Date Received] &lt;= @Date_Received) AND ([Exit Date] &gt; @Exit_Date) AND ([Receiving Client Ref] = @Receiving_Client_Ref))">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<p>
    &nbsp;</p>
</asp:Content>
