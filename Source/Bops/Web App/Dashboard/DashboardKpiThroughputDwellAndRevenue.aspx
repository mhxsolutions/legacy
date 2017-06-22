<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master"
    Inherits="Dashboard_DashboardKpiThroughputDwellAndRevenue" Codebehind="DashboardKpiThroughputDwellAndRevenue.aspx.cs" %>

<%@ Register Assembly="DundasWebGauge" Namespace="Dundas.Gauges.WebControl" TagPrefix="DGWC" %>
<%@ Register Assembly="DundasWebChart" Namespace="Dundas.Charting.WebControl" TagPrefix="DCWC" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <table>
        <tr align="center">
            <td>
                Estimated Revenue / Planned Minute</td>
            <td>
                Estimated Revenue / Actual Minute History</td>
        </tr>
        <tr align="center">
            <td>
                <DGWC:GaugeContainer ID="GaugeContainer1" runat="server" BackColor="White" DataSourceID="PlannedRevenuePerMinuteToday"
                    Width="220px">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Ranges>
                                <DGWC:CircularRange Name="Range1" />
                            </Ranges>
                            <Scales>
                                <DGWC:CircularScale Maximum="2" Name="Default">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="50" Y="50" />
                            <Pointers>
                                <DGWC:CircularPointer Name="Default" ValueSource="Default" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Values>
                        <DGWC:InputValue Name="Default" ValueFieldMember="Planned Revenue Per Minute">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="PlannedRevenuePerMinuteToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="BopsPlannedRevenuePerMinuteToday" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="ThroughputToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT LogOutDate, SUM([Man Rev]) / SUM([Transit Minutes] + [Dwell Minutes]) AS Throughput FROM [Load Rev] GROUP BY LogOutDate HAVING (LogOutDate > DATEADD(d, - 15, GETDATE())) ORDER BY LogOutDate DESC">
                </asp:SqlDataSource>
            </td>
            <td>
                <DCWC:Chart ID="Chart1" runat="server" DataSourceID="ThroughputHistory" Palette="Pastel"
                    Height="240px" Width="280px">
                    <Legends>
                        <DCWC:Legend Enabled="False" Name="Default">
                        </DCWC:Legend>
                    </Legends>
                    <BorderSkin PageColor="AliceBlue" />
                    <Series>
                        <DCWC:Series BorderColor="64, 64, 64" Name="Series1" ShadowOffset="1" ValueMembersY="Throughput"
                            ValueMemberX="LogOutDate">
                        </DCWC:Series>
                    </Series>
                    <ChartAreas>
                        <DCWC:ChartArea Name="Default">
                            <AxisY StartFromZero="False">
                            </AxisY>
                        </DCWC:ChartArea>
                    </ChartAreas>
                    <Titles>
                        <DCWC:Title Name="Title1">
                        </DCWC:Title>
                    </Titles>
                </DCWC:Chart>
                <asp:SqlDataSource ID="ThroughputHistory" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT LogOutDate, SUM([Man Rev]) / SUM([Transit Minutes] + [Dwell Minutes]) AS Throughput FROM [Load Rev] GROUP BY LogOutDate HAVING (LogOutDate > DATEADD(DAY, - 30, GETDATE())) AND (LogOutDate < CONVERT (VARCHAR(15), GETDATE(), 1)) ORDER BY LogOutDate">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr align="center">
            <td>
                Budway Dwell</td>
            <td>
                Budway Dwell History</td>
        </tr>
        <tr align="center">
            <td>
                <DGWC:GaugeContainer ID="GaugeContainer2" runat="server" BackColor="White" DataSourceID="BudwayDwellToday"
                    Width="220px">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Ranges>
                                <DGWC:CircularRange Name="Range1" />
                            </Ranges>
                            <Scales>
                                <DGWC:CircularScale Maximum="60" Name="Default">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="50" Y="50" />
                            <Pointers>
                                <DGWC:CircularPointer Name="Default" ValueSource="Default" />
                                <DGWC:CircularPointer FillGradientEndColor="Chartreuse" MarkerStyle="Wedge" Name="Trailing"
                                    Type="Marker" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Values>
                        <DGWC:InputValue DateFieldMember="Date" Name="Default" ValueFieldMember="Dwell">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="BudwayDwellToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Date, Dwell FROM [Agilis Budway Dwell Summary] WHERE (Date >= CONVERT (VARCHAR(30), GETDATE(), 1)) ORDER BY Date">
                </asp:SqlDataSource>
            </td>
            <td>
                <DCWC:Chart ID="Chart2" runat="server" DataSourceID="BudwayDwellHistory" Palette="Pastel"
                    Height="240px" Width="280px">
                    <Legends>
                        <DCWC:Legend Enabled="False" Name="Default">
                        </DCWC:Legend>
                    </Legends>
                    <Series>
                        <DCWC:Series BorderColor="64, 64, 64" Name="Dwell" ShadowOffset="1" ValueMembersY="Dwell"
                            ValueMemberX="Date">
                        </DCWC:Series>
                    </Series>
                    <ChartAreas>
                        <DCWC:ChartArea Name="Default">
                        </DCWC:ChartArea>
                    </ChartAreas>
                    <Titles>
                        <DCWC:Title Name="Title1">
                        </DCWC:Title>
                    </Titles>
                </DCWC:Chart>
                <asp:SqlDataSource ID="BudwayDwellHistory" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Date, Dwell FROM [Agilis Budway Dwell Summary] WHERE (Date >= CONVERT (VARCHAR(30), DATEADD(DAY, - 30, GETDATE()), 1)) ORDER BY Date">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr align="center">
            <td>
                MTD and Trailing Year<br />
                Estimated Revenue / Load</td>
            <td>
                MTD and Trailing Year<br />
                Estimated Revenue / Minute</td>
        </tr>
        <tr align="center">
            <td>
                <DGWC:GaugeContainer ID="GaugeContainer3" runat="server" BackColor="White" Height="300px"
                    Width="140px" DataSourceID="RevenuePerLoadMonthToDate">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Scales>
                                <DGWC:CircularScale FillColor="Black" Maximum="300" Minimum="100" Name="Default"
                                    Radius="57.88889" StartAngle="0" SweepAngle="180" Width="15.333333">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="74.44444" Y="26.666666" />
                            <Pointers>
                                <DGWC:CircularPointer CapReflection="True" Name="Default" ValueSource="Default" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Labels>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Revenue" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="98.2" />
                        </DGWC:GaugeLabel>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Load Count" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="124" />
                        </DGWC:GaugeLabel>
                    </Labels>
                    <NumericIndicators>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="8" FormatString="C0" LedDimColor="" Name="NumericIndicator1" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Revenue">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="108.8" />
                        </DGWC:NumericIndicator>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="5" FormatString="N0" LedDimColor="" Name="NumericIndicator2" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Loads">
                            <Size Height="12" Width="40" />
                            <Location X="57" Y="135" />
                        </DGWC:NumericIndicator>
                    </NumericIndicators>
                    <Values>
                        <DGWC:InputValue Name="Default" ValueFieldMember="Revenue Per Load">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Revenue" ValueFieldMember="Revenue">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Loads" ValueFieldMember="Loads">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="RevenuePerLoadMonthToDate" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(COUNT([Load]), 0) AS Loads, ISNULL(SUM([Man Rev]) / COUNT([Load]), 0) AS [Revenue Per Load] FROM [Load Rev] WHERE (LogOutDate >= CAST(MONTH(GETDATE()) AS VARCHAR(5)) + '/1/' + CAST(YEAR(GETDATE()) AS VARCHAR(5)))">
                </asp:SqlDataSource>
                <DGWC:GaugeContainer ID="GaugeContainer4" runat="server" BackColor="White" Height="300px"
                    Width="140px" DataSourceID="RevenuePerLoadTrailingYear">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Scales>
                                <DGWC:CircularScale FillColor="Black" Maximum="300" Minimum="100" Name="Default"
                                    Radius="57.88889" Reversed="True" StartAngle="180" SweepAngle="180" Width="15.333333">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="24.4444427" Y="26.666666" />
                            <Pointers>
                                <DGWC:CircularPointer CapReflection="True" Name="Default" ValueSource="Default" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Labels>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Revenue" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="98.2" />
                        </DGWC:GaugeLabel>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Load Count" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="124" />
                        </DGWC:GaugeLabel>
                    </Labels>
                    <NumericIndicators>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="9" FormatString="C0" LedDimColor="" Name="NumericIndicator1" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Revenue">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="108.8" />
                        </DGWC:NumericIndicator>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            FormatString="N0" LedDimColor="" Name="NumericIndicator2" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Loads">
                            <Size Height="12" Width="48" />
                            <Location X="49" Y="135" />
                        </DGWC:NumericIndicator>
                    </NumericIndicators>
                    <Values>
                        <DGWC:InputValue Name="Default" ValueFieldMember="Revenue Per Load">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Revenue" ValueFieldMember="Revenue">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Loads" ValueFieldMember="Loads">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="RevenuePerLoadTrailingYear" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(COUNT([Load]), 0) AS Loads, ISNULL(SUM([Man Rev]) / COUNT([Load]), 0) AS [Revenue Per Load] FROM [Load Rev] WHERE (LogOutDate >= DATEADD(DAY, - 365, GETDATE()))">
                </asp:SqlDataSource>
            </td>
            <td>
                <DGWC:GaugeContainer ID="GaugeContainer5" runat="server" BackColor="White" Height="300px"
                    Width="140px" DataSourceID="RevenuePerMinuteMonthToDate">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Scales>
                                <DGWC:CircularScale FillColor="Black" Maximum="3" Name="Default" Radius="57.88889"
                                    StartAngle="0" SweepAngle="180" Width="15.333333">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="74.44444" Y="26.666666" />
                            <Pointers>
                                <DGWC:CircularPointer CapReflection="True" Name="Default" ValueSource="Default" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Labels>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Revenue" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="98.2" />
                        </DGWC:GaugeLabel>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Minutes" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="124" />
                        </DGWC:GaugeLabel>
                    </Labels>
                    <NumericIndicators>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="8" FormatString="C0" LedDimColor="" Name="NumericIndicator1" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Revenue">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="108.8" />
                        </DGWC:NumericIndicator>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="8" FormatString="N0" LedDimColor="" Name="NumericIndicator2" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Minutes">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="135" />
                        </DGWC:NumericIndicator>
                    </NumericIndicators>
                    <Values>
                        <DGWC:InputValue Name="Default" ValueFieldMember="Revenue Per Minute">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Revenue" ValueFieldMember="Revenue">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Minutes" ValueFieldMember="Minutes">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Loads" ValueFieldMember="Minutes">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="RevenuePerMinuteMonthToDate" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(SUM([Transit Minutes] + [Dwell Minutes]), 0) AS Minutes, CASE ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) WHEN 0 THEN 0 ELSE ISNULL(SUM([Man Rev]) , 0) / ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) END AS [Revenue Per Minute] FROM [Load Rev] WHERE (LogOutDate >= CAST(MONTH(GETDATE()) AS VARCHAR(2)) + '/01/' + CAST(YEAR(GETDATE()) AS VARCHAR(4)))">
                </asp:SqlDataSource>
                <DGWC:GaugeContainer ID="GaugeContainer6" runat="server" BackColor="White" Height="300px"
                    Width="140px" DataSourceID="RevenuePerMinuteTrailingYear">
                    <CircularGauges>
                        <DGWC:CircularGauge Name="Default">
                            <Scales>
                                <DGWC:CircularScale FillColor="Black" Maximum="3" Name="Default" Radius="57.88889"
                                    Reversed="True" StartAngle="180" SweepAngle="180" Width="15.333333">
                                </DGWC:CircularScale>
                            </Scales>
                            <Size Height="100" Width="100" />
                            <PivotPoint X="24.4444427" Y="26.666666" />
                            <Pointers>
                                <DGWC:CircularPointer CapReflection="True" Name="Default" ValueSource="Default" />
                            </Pointers>
                            <BackFrame />
                            <Location X="0" Y="0" />
                        </DGWC:CircularGauge>
                    </CircularGauges>
                    <Labels>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Revenue" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="98.2" />
                        </DGWC:GaugeLabel>
                        <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                            ResizeMode="None" Text="Total Minutes" TextAlignment="TopRight">
                            <Size Height="50" Width="80" />
                            <Location X="17" Y="124" />
                        </DGWC:GaugeLabel>
                    </Labels>
                    <NumericIndicators>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="9" FormatString="C0" LedDimColor="" Name="NumericIndicator1" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Revenue">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="108.8" />
                        </DGWC:NumericIndicator>
                        <DGWC:NumericIndicator BackColor="Transparent" BackGradientEndColor="Transparent"
                            BorderColor="Transparent" BorderWidth="0" Decimals="0" DigitColor="Firebrick"
                            Digits="9" FormatString="N0" LedDimColor="" Name="NumericIndicator2" Parent="CircularGauges.Default"
                            SeparatorColor="Transparent" SeparatorWidth="0" ShowLeadingZeros="False" ShowSign="None"
                            ValueSource="Minutes">
                            <Size Height="12" Width="80" />
                            <Location X="17" Y="135" />
                        </DGWC:NumericIndicator>
                    </NumericIndicators>
                    <Values>
                        <DGWC:InputValue Name="Default" ValueFieldMember="Revenue Per Minute">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Revenue" ValueFieldMember="Revenue">
                        </DGWC:InputValue>
                        <DGWC:InputValue Name="Minutes" ValueFieldMember="Minutes">
                        </DGWC:InputValue>
                    </Values>
                    <BackFrame />
                </DGWC:GaugeContainer>
                <asp:SqlDataSource ID="RevenuePerMinuteTrailingYear" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(SUM([Transit Minutes] + [Dwell Minutes]), 0) AS Minutes, CASE ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) WHEN 0 THEN 0 ELSE ISNULL(SUM([Man Rev]) , 0) / ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) END AS [Revenue Per Minute] FROM [Load Rev] WHERE (LogOutDate >= DATEADD(DAY, - 365, GETDATE()))">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
