<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FlyAshDashboard.aspx.vb" Inherits="FlyAshDashboard" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 695px;
        }
        .style3
        {
        }
        .style4
        {
            width: 695px;
            height: 60px;
        }
        .style6
        {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table class="style1">
        <tr>
            <td class="style2" colspan="2">
                <h3>
                    Fly Ash Dashboard</h3>
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
                <strong>Select Date</strong></td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                    BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                    DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                    ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" 
                        Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
            <td class="style3" valign="top">
                &nbsp;</td>
            <td valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" colspan="2">
                <strong>Loads on Selected Date</strong></td>
            <td class="style3" valign="top">
                &nbsp;</td>
            <td valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4" valign="top" colspan="2">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" 
                    Width="1037px">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Pre_Scale_Time" ShowInColumn="Arrive" 
                            SummaryType="Count" />
                    </TotalSummary>
                    <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                    <SettingsSearchPanel Visible="True" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataDateColumn FieldName="Arrive" SortIndex="0" 
                            SortOrder="Ascending" VisibleIndex="1">
                            <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn FieldName="Depart" VisibleIndex="2">
                            <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Wait Time" FieldName="Pre_Scale_Time" 
                            ReadOnly="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Scale Time" FieldName="Scale_Time" 
                            ReadOnly="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Total Time" FieldName="Total_Time" 
                            ReadOnly="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Customer" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Ticket" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="10">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Lot" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tractor" FieldName="Unit_Number" 
                            VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Trailer" VisibleIndex="11">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tare" VisibleIndex="12">
                            <PropertiesTextEdit DisplayFormatString="{0:n0}">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="13">
                            <PropertiesTextEdit DisplayFormatString="{0:n1}">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="14">
                            <PropertiesTextEdit DisplayFormatString="{0:n0}">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                    </SettingsContextMenu>
                    <SettingsPager PageSize="15">
                        <AllButton Visible="True">
                        </AllButton>
                        <PageSizeItemSettings Visible="True">
                        </PageSizeItemSettings>
                    </SettingsPager>
                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                        ShowGroupPanel="True" ShowFilterBar="Visible" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                    
                    SelectCommand="SELECT [Arrive], [Depart], [Pre Scale Time] AS Pre_Scale_Time, [Scale Time] AS Scale_Time, [Total Time] AS Total_Time, [Customer], [Ticket], [Carrier], [Lot], [Unit Number] AS Unit_Number, [Trailer], [Pounds], [Tons], [Tare] FROM [fly ash time calcs] WHERE (([Product] = @Product) AND ([Date] = @Date))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="fly ash" Name="Product" Type="String" />
                        <asp:ControlParameter ControlID="Calendar1" DbType="Date" Name="Date" 
                            PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td align="right" class="style6" valign="top">
            </td>
            <td align="left" class="style3" rowspan="5" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <strong>Tons Delivered MTD by Customer</strong></td>
            <td class="style2" valign="top">
                <strong>On-Site Inventory</strong></td>
            <td align="right" class="style3" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView5" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource5" EnableTheming="True" Theme="Aqua">
                    <Settings ShowFilterRow="True" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="Customer" SortIndex="0" 
                            SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="2">
                            <PropertiesTextEdit DisplayFormatString="{0:n1}">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="25">
                        <AllButton Visible="True">
                        </AllButton>
                        <PageSizeItemSettings Visible="True">
                        </PageSizeItemSettings>
                    </SettingsPager>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                    SelectCommand="SELECT * FROM [fly ash customer tons MTD]">
                </asp:SqlDataSource>
            </td>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView4" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource4" EnableTheming="True" Theme="BlackGlass">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Unload_Status" SummaryType="Sum" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="Rail Car On Site" FieldName="Car_Number" 
                            SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Loads Remaining" FieldName="Unload_Status" 
                            VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="25">
                        <AllButton Visible="True">
                        </AllButton>
                    </SettingsPager>
                    <Settings ShowFilterRow="True" ShowFooter="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
                    SelectCommand="SELECT [Car Number] AS Car_Number, [Unload Status] AS Unload_Status FROM [fly ash pipeline inventory detail] WHERE (([Product Type] = @Product_Type) AND ([WhseComplete] = @WhseComplete) AND ([Status Flag] = @Status_Flag))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="fly ash" Name="Product_Type" Type="String" />
                        <asp:Parameter DefaultValue="false" Name="WhseComplete" Type="Boolean" />
                        <asp:Parameter DefaultValue="3" Name="Status_Flag" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>
            <td align="right" class="style3" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <strong style="text-align: left">Tons Delivered by Month</strong></td>
            <td class="style2" valign="top">
                <strong>Today&#39;s Rail Pipeline</strong></td>
            <td align="right" class="style3" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Aqua">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Ct" ShowInColumn="Ct" SummaryType="Sum" />
                        <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Yr" SortIndex="0" SortOrder="Descending" 
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Mo" SortIndex="1" SortOrder="Descending" 
                            VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Ct" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="3">
                            <PropertiesTextEdit DisplayFormatString="{0:n1}">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="30">
                        <AllButton Visible="True">
                        </AllButton>
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                    SelectCommand="SELECT [Yr], [Mo], [Ct], [Tons] FROM [fly ash weight summary tons for phone] WHERE ([Product] = @Product) ORDER BY [Yr] DESC, [Mo] DESC">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="fly ash" Name="Product" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource3" EnableTheming="True" Theme="BlackGlass">
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Loads" SummaryType="Sum" />
                    </TotalSummary>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="ETA" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Loads" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="15">
                        <AllButton Visible="True">
                        </AllButton>
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
                    SelectCommand="SELECT [Status], [ETA], [Loads] FROM [fly ash pipeline inventory summary]">
                </asp:SqlDataSource>
            </td>
            <td align="right" class="style3" valign="top">
                &nbsp;</td>
        </tr>
    </table>
    <div>
    
    </div>
    </form>
</body>
</html>
