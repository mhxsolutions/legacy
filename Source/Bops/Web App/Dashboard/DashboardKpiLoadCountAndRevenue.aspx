<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master"
    Inherits="DashboardKpiLoadCountAndRevenue" Codebehind="DashboardKpiLoadCountAndRevenue.aspx.cs" %>

<%@ Register Assembly="DundasWebGauge" Namespace="Dundas.Gauges.WebControl" TagPrefix="DGWC" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <DGWC:GaugeContainer ID="GaugeContainer1" runat="server" BackColor="White" Height="425px"
        Width="181px">
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
                    <DGWC:CircularPointer CapReflection="True" Name="Default" />
                </Pointers>
                <BackFrame />
                <Location X="0" Y="0" />
            </DGWC:CircularGauge>
        </CircularGauges>
        <Labels>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Revenue">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="98.2" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Load Count">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="124" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Font="Arial, 9.75pt, style=Bold"
                Name="Label3" Parent="CircularGauges.Default" ResizeMode="None" Text=" MTD Revenue / Load">
                <Size Height="20" Width="90" />
                <Location X="10" Y="-55" />
            </DGWC:GaugeLabel>
        </Labels>
        <NumericIndicators>
            <DGWC:NumericIndicator Decimals="2" Digits="8" LedDimColor="" Name="NumericIndicator1"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="56" />
                <Location X="21.29" Y="108.8" />
            </DGWC:NumericIndicator>
            <DGWC:NumericIndicator Decimals="0" Digits="4" LedDimColor="" Name="NumericIndicator2"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="28" />
                <Location X="21.29" Y="135" />
            </DGWC:NumericIndicator>
        </NumericIndicators>
        <BackFrame />
    </DGWC:GaugeContainer>
    <DGWC:GaugeContainer ID="GaugeContainer2" runat="server" BackColor="White" Height="425px"
        Width="181px">
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
                    <DGWC:CircularPointer CapReflection="True" Name="Default" />
                </Pointers>
                <BackFrame />
                <Location X="0" Y="0" />
            </DGWC:CircularGauge>
        </CircularGauges>
        <Labels>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Revenue">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="98.2" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Load Count">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="124" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Font="Arial, 9.75pt, style=Bold"
                Name="Label3" Parent="CircularGauges.Default" ResizeMode="None" Text="TY Revenue / Load">
                <Size Height="20" Width="90" />
                <Location X="10" Y="-55" />
            </DGWC:GaugeLabel>
        </Labels>
        <NumericIndicators>
            <DGWC:NumericIndicator Decimals="2" Digits="10" LedDimColor="" Name="NumericIndicator1"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="70" />
                <Location X="21.29" Y="108.8" />
            </DGWC:NumericIndicator>
            <DGWC:NumericIndicator Decimals="0" Digits="5" LedDimColor="" Name="NumericIndicator2"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="35" />
                <Location X="21.29" Y="135" />
            </DGWC:NumericIndicator>
        </NumericIndicators>
        <BackFrame />
    </DGWC:GaugeContainer>
    <DGWC:GaugeContainer ID="GaugeContainer3" runat="server" BackColor="White" Height="425px"
        Width="181px">
        <CircularGauges>
            <DGWC:CircularGauge Name="Default">
                <Scales>
                    <DGWC:CircularScale FillColor="Black" Name="Default" Radius="57.88889" StartAngle="0"
                        SweepAngle="180" Width="15.333333" Maximum="80" Minimum="40">
                    </DGWC:CircularScale>
                </Scales>
                <Size Height="100" Width="100" />
                <PivotPoint X="74.44444" Y="26.666666" />
                <Pointers>
                    <DGWC:CircularPointer CapReflection="True" Name="Default" />
                </Pointers>
                <BackFrame />
                <Location X="0" Y="0" />
            </DGWC:CircularGauge>
        </CircularGauges>
        <Labels>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Revenue">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="98.2" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Hours">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="124" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Font="Arial, 9.75pt, style=Bold"
                Name="Label3" Parent="CircularGauges.Default" ResizeMode="None" Text=" MTD Revenue / Hour">
                <Size Height="20" Width="90" />
                <Location X="10" Y="-55" />
            </DGWC:GaugeLabel>
        </Labels>
        <NumericIndicators>
            <DGWC:NumericIndicator Decimals="2" Digits="8" LedDimColor="" Name="NumericIndicator1"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="56" />
                <Location X="21.29" Y="108.8" />
            </DGWC:NumericIndicator>
            <DGWC:NumericIndicator Decimals="2" Digits="8" LedDimColor="" Name="NumericIndicator2"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="56" />
                <Location X="21.29" Y="135" />
            </DGWC:NumericIndicator>
        </NumericIndicators>
        <BackFrame />
    </DGWC:GaugeContainer>
    <DGWC:GaugeContainer ID="GaugeContainer4" runat="server" BackColor="White" Height="425px"
        Width="181px">
        <CircularGauges>
            <DGWC:CircularGauge Name="Default">
                <Scales>
                    <DGWC:CircularScale FillColor="Black" Name="Default" Radius="57.88889" Reversed="True"
                        StartAngle="180" SweepAngle="180" Width="15.333333" Maximum="80" Minimum="40">
                    </DGWC:CircularScale>
                </Scales>
                <Size Height="100" Width="100" />
                <PivotPoint X="24.4444427" Y="26.666666" />
                <Pointers>
                    <DGWC:CircularPointer CapReflection="True" Name="Default" />
                </Pointers>
                <BackFrame />
                <Location X="0" Y="0" />
            </DGWC:CircularGauge>
        </CircularGauges>
        <Labels>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label1" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Revenue">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="98.2" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Name="Label2" Parent="CircularGauges.Default"
                ResizeMode="None" Text="Total Hours">
                <Size Height="50" Width="80" />
                <Location X="21.29" Y="124" />
            </DGWC:GaugeLabel>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Font="Arial, 9.75pt, style=Bold"
                Name="Label3" Parent="CircularGauges.Default" ResizeMode="None" Text="TY Revenue / Hour">
                <Size Height="20" Width="90" />
                <Location X="10" Y="-55" />
            </DGWC:GaugeLabel>
        </Labels>
        <NumericIndicators>
            <DGWC:NumericIndicator Decimals="2" Digits="10" LedDimColor="" Name="NumericIndicator1"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="70" />
                <Location X="21.29" Y="108.8" />
            </DGWC:NumericIndicator>
            <DGWC:NumericIndicator Decimals="2" Digits="9" LedDimColor="" Name="NumericIndicator2"
                Parent="CircularGauges.Default">
                <Size Height="12" Width="63" />
                <Location X="21.29" Y="135" />
            </DGWC:NumericIndicator>
        </NumericIndicators>
        <BackFrame />
    </DGWC:GaugeContainer>
</asp:Content>
