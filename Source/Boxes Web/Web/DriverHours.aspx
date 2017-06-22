<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DriverHours.aspx.vb" Inherits="DriverHours" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Hours</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 248px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Driver Hours (<a href="index.aspx">home</a>)</h3>
        <table class="auto-style1">
            <tr>
                <td class="auto-style2"><b>Start Date</b></td>
                <td><b>End Date</b></td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
        <strong>Driver Hours (Planner Payroll)</strong><br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export xlsx" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Expand All" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Plan_ID" Theme="MetropolisBlue">
            <SettingsDetail ShowDetailRow="True" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="plannerpayrolldetail" EnableTheming="True" KeyFieldName="Plan ID" Theme="Metropolis" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect">
                        <SettingsPager Visible="False">
                        </SettingsPager>
                        <SettingsEditing Mode="Inline">
                        </SettingsEditing>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="True">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="Plan ID" Visible="False" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Driver Ref" VisibleIndex="4" Visible="False">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="WorkPhone" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="Payroll Start" VisibleIndex="7">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt" EditFormat="DateTime">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Clock_Out" VisibleIndex="8">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt" EditFormat="DateTime">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Break1 Start" VisibleIndex="9">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt" EditFormat="DateTime">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Break1 End" VisibleIndex="10">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt" EditFormat="DateTime">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Break2 Start" VisibleIndex="11">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataDateColumn FieldName="Break2 End" VisibleIndex="12">
                                <PropertiesDateEdit DisplayFormatString="M/d/yy hh:mm tt" EditFormat="DateTime">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="Break1" ReadOnly="True" VisibleIndex="13">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Break2" ReadOnly="True" VisibleIndex="14">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ClockTime" ReadOnly="True" VisibleIndex="16">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" GroupIndex="1" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan_Date" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="LunchTotal" VisibleIndex="4" Caption="Lunch (min)">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Payroll Hours" FieldName="TotalHrs" ReadOnly="True" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Plan_ID" ReadOnly="True" Visible="False" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Payroll Hrs= {0:n2}" FieldName="TotalHrs" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT Driver, WorkPhone, [Plan Date] AS Plan_Date, LunchTotal, TotalHrs, Fleet, [Plan ID] AS Plan_ID FROM [Planner Payroll Driver Daily Hours less Lunch] WHERE ([Company ID ref] = 1 OR [Company ID ref] = 9) AND ([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Driver Hours" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <br />
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br />


        Payroll Hours are calculated: Clock In - Clock Out - Total Lunch Time<br />
        <asp:SqlDataSource ID="plannerpayrolldetail" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Planner Payroll Driver Clock In Out with breaks] WHERE ([Plan ID] = @Plan_ID)" OldValuesParameterFormatString="original_{0}" ConflictDetection="CompareAllValues" UpdateCommand="UPDATE       Planner
SET                [Payroll Start] = @Payroll_Start, [Break1 Start] = @Break1_Start, [Break1 End] = @Break1_End, [Break2 Start] = @Break2_Start, [Break2 End] = @Break2_End, 
                         Clock_Out = @Clock_Out
WHERE        ([Plan ID] = @original_Plan_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Plan_ID" SessionField="PrimID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Payroll_Start" Type="DateTime" />
                <asp:Parameter Name="Break1_Start" Type="DateTime" />
                <asp:Parameter Name="Break1_End" Type="DateTime" />
                <asp:Parameter Name="Break2_Start" Type="DateTime" />
                <asp:Parameter Name="Break2_End" Type="DateTime" />
                <asp:Parameter Name="Clock_Out" Type="DateTime" />
                <asp:Parameter Name="original_Plan_ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    </form>
</body>
</html>
