<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_MobileReview.aspx.vb" Inherits="NorCal_MobileReview" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mobile Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <div>
    
        <h3>NorCal Driver App Review&nbsp; (<a href="index.aspx">home</a>)</h3>
        <p>
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
        </p>
    
    </div>
        <p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Theme="MetropolisBlue">
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsAdaptivity AdaptivityMode="HideDataCells">
                </SettingsAdaptivity>
                <SettingsPager PageSize="100">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AutoExpandAllGroups="True" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataDateColumn FieldName="Start Time" VisibleIndex="7">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Payroll Start" VisibleIndex="8">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Clock In Time" VisibleIndex="9">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Break1 Start" VisibleIndex="11">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Break1 End" VisibleIndex="12">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Break2 Start" VisibleIndex="13">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Break2 End" VisibleIndex="14">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Order" VisibleIndex="15" SortIndex="3" SortOrder="Ascending">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="16">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Depart Origin" VisibleIndex="17">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Arrive Destination" VisibleIndex="18">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Depart Destination" VisibleIndex="19">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Clock Out Time" VisibleIndex="10">
                        <PropertiesDateEdit DisplayFormatString="t">
                        </PropertiesDateEdit>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="3" SortIndex="1" SortOrder="Ascending">
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataTextColumn FieldName="Driver" VisibleIndex="4" SortIndex="2" SortOrder="Ascending" ReadOnly="True">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="WorkPhone_formatted" VisibleIndex="6" Caption="Work Phone" ReadOnly="True">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                </Columns>
                <Styles>
                    <Row Wrap="False">
                    </Row>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT [Fleet ID], Fleet, [Company ID ref], LastName, FirstName, Driver, WorkPhone, WorkPhone_formatted, [Plan Date], [Start Time], [Payroll Start], [Clock In Time], [Break1 Start], [Break1 End], [Break2 Start], [Break2 End], [Order], Destination, [Depart Origin], [Arrive Destination], [Depart Destination], Subhauler, [Clock Out Time] FROM DriverMobileClickData WHERE ([Company ID ref] = @Company_ID_ref) AND ([Plan Date] = @Plan_Date)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    
    </div>
        <br />
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br />
        <br />
    </form>
</body>
</html>
