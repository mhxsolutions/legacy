<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Tons Handled.aspx.vb" Inherits="Tons_Handled" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tons Handled</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
        }
        .style3
        {
            width: 422px;
        }
        .style4
        {
            width: 422px;
            font-weight: bold;
        }
        .style5
        {
            width: 381px;
            font-weight: bold;
        }
        .style6
        {
            width: 381px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Tons Handled</h3>
        Proper analysis 
        of all tons handled by warehouse/yard staff requires advanced filtering.<br />
        <table class="style1">
            <tr>
                <td class="style5">
                    Types of Tons on Report</td>
                <td class="style4">
                    Assembly Formulas</td>
                <td>
                    <b>Abbrebriations</b></td>
            </tr>
            <tr>
                <td class="style6" valign="top">
                    Received at Terminal<br />
                    Handled Out on BOL<br />
                    UPI - tons on Load not BOL<br />
                    Warehouse/Yard - tons transfered on Rack Transfer.<br />
                    Inspection Transfer - tons counted on both Receiver and BOL duplicate tons, only 
                    use one.<br />
                    System Transfer - no handling</td>
                <td class="style3" valign="top">
          Tons by client = Warehouse + additional truck 
                    <br />
                    Warehouse &lt;&gt; W2T &lt;&gt; truck + rail
                              <br />
                    Warehouse = W2T + W2R + Receivers (W2W + T2W + R2W)<br />
                    Additional Truck = B2B and B2T
                    <br />
                    Truck = W2T + B2B + UPI</td>
                <td valign="top">
                    B2B - loads carried business-to-business (PUR loads)<br />
                    B2T - loads carried business-to-terminal (tons on receiver)<br />
                    W2T - tons handled from warehouse/yard to truck (on BOL with UPI exception)<br />
                    W2R - warehouse/yard to rail (on BOL)<br />
                    W2W - warehouse/yard to warehouse/yard such as rack transfer<br />
                    T2W - truck-to-warehouse are client origin loads (B2T), but included in 
                    Receivers<br />
                    Load Origin shows if load is B2B/B2T or T2B</td>
            </tr>
            <tr>
                <td class="style2" valign="top" colspan="3">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="style6" valign="top">
                    <strong>Start Date</strong></td>
                <td class="style3" valign="top">
                  End Date</strong></td>
                <td valign="top">
                    Basic Instructions</td>
            </tr>
            <tr>
                <td class="style6" valign="top">
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                        BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                        ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                            VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                            Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                        <TodayDayStyle BackColor="#CCCCCC" />
                    </asp:Calendar>
                </td>
                <td class="style3" valign="top">
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                        BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
                        ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                            VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                            Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                        <TodayDayStyle BackColor="#CCCCCC" />
                    </asp:Calendar>
                </td>
                <td valign="top">
                    <p>
                        1. Choose Start Date<br />
                        2. Choose End Date<br />
                        3. Select of filter Terminal/Fleet<br />
                        4. Filter out non-handling Receiver/BOL types.</p>
                </td>
            </tr>
        </table>
        <br />
        <hr />
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue" 
            Caption="All Receivers - Received Tons">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count of Receivers" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons Received" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons Received" SummaryType="Sum" />
            </GroupSummary>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="Date Received" 
                    VisibleIndex="6" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1" GroupIndex="0">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver Type" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="4" GroupIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count of Receivers" VisibleIndex="8" 
                    Caption="Count">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Received" VisibleIndex="9" 
                    Caption="Tons">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inventory Client" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="7" Caption="Client">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager>
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" 
                ShowFooter="True" ShowGroupedColumns="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT * FROM [Count of Receivers with tons] WHERE (([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" 
                    PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" 
                    PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" EnableTheming="True" 
            Theme="Office2003Olive" 
            Caption="All BOLs - Handled Out and Paper Transfers">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count of BOL" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons Shipped" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons Shipped" SummaryType="Sum" />
            </GroupSummary>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="2" GroupIndex="0">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BOL Type" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="3" GroupIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count of BOL" VisibleIndex="6" 
                    Caption="Count">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Shipped" VisibleIndex="8" 
                    Caption="Tons">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inventory Client" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="5" Caption="Client">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="Shipment Date" 
                    SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager>
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" 
                ShowFooter="True" ShowGroupedColumns="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT * FROM [Count of BOLs with Tons] WHERE (([Shipment Date] &gt;= @Shipment_Date) AND ([Shipment Date] &lt;= @Shipment_Date2))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Shipment_Date" 
                    PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Shipment_Date2" 
                    PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" 
            Caption="Loads not from BOLs" DataSourceID="SqlDataSource3" 
            EnableTheming="True" Theme="Office2003Silver">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count of Loads" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons on Load" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Tons on Load" SummaryType="Sum" />
            </GroupSummary>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1" GroupIndex="0">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count of Loads" VisibleIndex="5" 
                    Caption="Count">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons on Load" VisibleIndex="7" 
                    Caption="Tons">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="LogOutDate" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager>
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupPanel="True" ShowGroupedColumns="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT * FROM [Count of Loads with Tons not from BOL] WHERE (([LogOutDate] &gt;= @LogOutDate) AND ([LogOutDate] &lt;= @LogOutDate2))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="LogOutDate" 
                    PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="LogOutDate2" 
                    PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        Loads based on Load Date not Plan Date Plan Date</div>
    </form>
</body>
</html>
