<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="CB_Inventory_on_date.aspx.cs" Inherits="Web.Clients.All.CB_Inventory_on_date" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory as of Selected Date</h3>
    <table class="dxic-fileManager">
        <tr>
            <td style="width: 273px"><b>Select Date</b></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 273px">
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
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
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
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 1" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="Product Group 3" SortIndex="3" SortOrder="Ascending" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Product Group 4" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="18">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Roll Ct" FieldName="Count In Package" VisibleIndex="22">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="23">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="25">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="26">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="29">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Width" GroupIndex="2" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Damage" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Wt" ShowInColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Count In Package" ShowInColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Wt" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Count In Package" ShowInGroupFooterColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="LnFt" ShowInGroupFooterColumn="Ln Ft" SummaryType="Sum" />
            </GroupSummary>
            <FormatConditions>
                <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Status] = 'Damaged'" FieldName="Product Profile Description" Format="LightRedFill">
                </dx:GridViewFormatConditionHighlight>
            </FormatConditions>

<Styles AdaptiveDetailButtonWidth="22">
    <Cell Wrap="False">
    </Cell>
            </Styles>
        </dx:ASPxGridView>
    </p>
    <p>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory on date" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Wt, Tons, [Unit Label], [Unit Count], [Count In Package], LnFt, Terminal, [Terminal Abr], [Recd Date], [Exit Date], [Company ID ref], [Ship Date], CAST([Product Group 2] AS float) AS Width, Status, Location, [Damage Comments] AS Damage FROM [Inventory All Received and Shipped Summary with Loc] WHERE ([Recd Date] &lt;= @Recd_Date) AND ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = 3) AND ([Receiving Client Ref] = @Client_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" />
                <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <uc1:SaveLayout runat="server" id="SaveLayout" GridViewID="ASPxGridView1" />
</asp:Content>
