<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory_on_date.aspx.cs" Inherits="Web.Clients.Assigned.Inventory_on_date" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.XtraReports.v16.2.Web, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory on Date</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Formatted Inventory on a Date <a href="../All/Default.aspx">(home)</a></h3>
        <p>Select control date for inventory:</p>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" Width="257px" DayNameFormat="Shortest" TitleFormat="Month">
            <DayHeaderStyle Font-Bold="True" Font-Size="7pt" BackColor="#CCCCCC" ForeColor="#333333" Height="10pt" />
            <DayStyle Width="14%" />
            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
            <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
            <TodayDayStyle BackColor="#CCCC99" />
        </asp:Calendar>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count In Package" ShowInColumn="Roll Ct" SummaryType="Sum" DisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" DisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Wt" ShowInColumn="Pounds" SummaryType="Sum" DisplayFormat="n0" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" DisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Wt" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" DisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Count In Package" ShowInGroupFooterColumn="Roll Ct" SummaryType="Sum" DisplayFormat="n0" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 1" VisibleIndex="4" Caption="Description" GroupIndex="3" SortIndex="3" SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Width" VisibleIndex="6" Caption="Width" GroupIndex="4" SortIndex="4" SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 3" VisibleIndex="8" Caption="PO#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="14" SortIndex="5" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt" VisibleIndex="16" Caption="Pounds">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="17">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count In Package" VisibleIndex="20" Caption="Roll Ct">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="21">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="23" Caption="Terminal">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="24">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="27">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load Num" FieldName="Product Group 4" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowGroupFooter="VisibleAlways" />
            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Wt, Tons, [Unit Label], [Unit Count], [Count In Package], LnFt, Terminal, [Terminal Abr], [Recd Date], [Exit Date], [Company ID ref], [Ship Date], CAST([Product Group 2] AS float) AS Width FROM [Inventory All received and shipped summary] WHERE ([Recd Date] &lt;= @Recd_Date) AND ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = 3) AND ([Receiving Client Ref] = @Client_ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" />
                <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Containerboard Inventory on Date" GridViewID="ASPxGridView1" Landscape="True" BottomMargin="50" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
