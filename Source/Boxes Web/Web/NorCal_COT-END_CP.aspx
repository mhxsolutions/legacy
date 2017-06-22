<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_COT-END_CP.aspx.vb" Inherits="NorCal_COT_END_CP" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Clock Out</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Clock In/Out to Plan&nbsp; (<a href="index.aspx">home</a>)<br />
        <br />
        Select Date<br />
        </h3>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px">
            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
            <DayStyle Width="14%" />
            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
            <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
            <TodayDayStyle BackColor="#CCCC99" />
        </asp:Calendar>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export xlsx" Theme="Metropolis">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <SettingsPager PageSize="40">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Last_COT" VisibleIndex="6" Caption="Clock Out">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Last_End" VisibleIndex="7" Caption="Last Leg End">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="1">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="COT_Delta" VisibleIndex="8" Caption="Clock Out Delta" ReadOnly="True">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CIN_Delta" ReadOnly="True" VisibleIndex="5" Caption="Clock In Delta">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" VisibleIndex="2" ReadOnly="True">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Mobile Clock In" FieldName="first_CIN" VisibleIndex="4">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn Caption="Planned Clock In" FieldName="Planned_ClockIn" VisibleIndex="3">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="0">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT COT_Delta, CIN_Delta, LastName, FirstName, Driver, [Plan Date], Last_COT, Last_End, Subhauler, ServiceDriver, [Fleet ref], Fleet, first_CIN, Planned_ClockIn, EmployeeID, [Plan ID], [company ID ref] FROM Driver_Clock_Log_lastCOT_lastEND_delta WHERE ([Plan Date] = @Plan_Date) AND (ServiceDriver = @ServiceDriver) AND ([company ID ref] = 1 OR [company ID ref] = 9)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:Parameter DefaultValue="0" Name="ServiceDriver" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Mobil App EOD Audit" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
        <br />

       <uc1:SaveLayout runat="server" id="SaveLayout" GridViewID="ASPxGridView1" />
        <br />
        <br />
    </form>
</body>
</html>
