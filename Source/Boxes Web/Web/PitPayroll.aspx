<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PitPayroll.aspx.vb" Inherits="PitPayroll" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load Pay Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Payroll - Load Pay Data</h3>
        <br />
        Filter for first day of Payroll:<br />
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
    
        <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" 
            Text="Export to Excel" Theme="Office2003Blue" Width="131px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Origin" 
            Theme="Office2003Blue">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin City" ReadOnly="True" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination City" ReadOnly="True" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Origin" SortIndex="4" 
                    SortOrder="Ascending" VisibleIndex="9">
                    <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Arrive Destination" VisibleIndex="10">
                    <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Destination" VisibleIndex="11">
                    <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Transit" ReadOnly="True" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LastName" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FirstName" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Pay" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Payroll Rate Description" 
                    VisibleIndex="4">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
    
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        
        SelectCommand="SELECT [Plan Date], Origin, [Origin City], Destination, [Destination City], [Depart Origin], [Arrive Destination], [Depart Destination], Transit, Dwell, Fleet, Subhauler, ServiceDriver, LastName, FirstName, [Load Pay], [Payroll Rate Description] FROM [Payroll data in Pittsburg] WHERE ([Plan Date] BETWEEN @Plan_Date AND DATEADD(d, 7, @Plan_Date))">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        FileName="Load Pay" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    <br />
    This report shows one week&#39;s data from the selected date.<br />
    Load pay will only show for weeks that have been posted by Load Pay Tool in DWS.</form>
</body>
</html>
