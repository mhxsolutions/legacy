<%@ Page Title="Paper Rolls Inventory" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="CB_Inventory_on_date_all.aspx.cs" Inherits="Web.Clients.Assigned.CB_Inventory_on_date_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Paper Rolls Formatted Inventory</h3>
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
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive" Width="100%">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" AutoFilterCondition="Contains" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 1" GroupIndex="3" SortIndex="3" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="Product Group 3" SortIndex="5" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Product Group 4" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Roll Ct" FieldName="Count In Package" VisibleIndex="18">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="23">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="25">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="29">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Width" GroupIndex="4" ReadOnly="True" SortIndex="4" SortOrder="Ascending" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client Name" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1" Caption="Client">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="27" Caption="Product">
                    <settings allowheaderfilter="True" headerfiltermode="CheckedList" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="22">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="24">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Damage Comments" VisibleIndex="21">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Wt" ShowInColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n1}" FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Count In Package" ShowInColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Wt" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n1}" FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Count In Package" ShowInGroupFooterColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="LnFt" ShowInGroupFooterColumn="Ln Ft" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
    </p>
    <p>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory on date" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Wt, Tons, [Unit Label], [Unit Count], [Count In Package], LnFt, Terminal, [Terminal Abr], [Recd Date], [Exit Date], [Company ID ref], [Ship Date], [Product Group 2] AS Width, [Product Type], [ATSF Product ID], Status, Location, [Damage Comments] FROM [Inventory All Received and Shipped Summary with Loc] WHERE ([Recd Date] &lt;= @Recd_Date) AND ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = 3) AND ([ATSF Product ID] = 78)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
</asp:Content>
