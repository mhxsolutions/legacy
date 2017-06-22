<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Trip List for MPG Analysis.aspx.vb" Inherits="Trip_List_for_MPG_Analysis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trips</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 408px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Trip List for MPG Analysis</h3>
        <p>
            <table class="style1">
                <tr>
                    <td class="style2">
                        Start Date</td>
                    <td>
                        End Date</td>
                </tr>
                <tr>
                    <td class="style2">
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
                    <td>
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
                </tr>
            </table>
        </p>
        <p>
            &nbsp;</p>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="BlackGlass">
            <Fields>
                <dx:PivotGridField ID="fieldDriver" Area="RowArea" AreaIndex="0" 
                    FieldName="Driver">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldPlanDate" AreaIndex="1" FieldName="Plan Date">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldFleet" AreaIndex="0" FieldName="Fleet">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTruck" AreaIndex="2" FieldName="Truck">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCount" Area="DataArea" AreaIndex="0" 
                    FieldName="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldOrigin" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Origin">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDestination" Area="ColumnArea" AreaIndex="1" 
                    FieldName="Destination">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldSubhauler" AreaIndex="3" FieldName="Subhauler">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTons" Area="DataArea" AreaIndex="1" Caption="Tons" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" FieldName="Tons">
                </dx:PivotGridField>
            </Fields>
            <OptionsView ShowColumnTotals="False" />
            <OptionsPager RowsPerPage="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Planned Legs for MPG analysis] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                    PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                    PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Use this pivot table to review trip legs of a driver or group of drivers.
        <br />
        The comparison can be used to analyze trip differences when analyzing MPG.<br />
        1. Select Start and End dates.<br />
        2. Filter for Fleet.<br />
        IMPORTNAT: If you filter for Truck number only delivery trips will display. 
        Return trips will be removed.<br />
        3. Remove sub-haulers by choosing Subhauler False.<br />
        4. Move Tons to group pannel if you want to show only counts in the grid.</p>
</body>
</html>
