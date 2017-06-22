<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master"
    Inherits="Dashboard_DashboardBudwayDwellTime" Codebehind="DashboardBudwayDwellTime.aspx.cs" %>
<%@ Register Assembly="DundasWebGauge" Namespace="Dundas.Gauges.WebControl" TagPrefix="DGWC" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <DGWC:GaugeContainer ID="GaugeContainer1" runat="server" BackColor="White">
        <CircularGauges>
            <DGWC:CircularGauge Name="Default">
                <Ranges>
                    <DGWC:CircularRange Name="Range1" />
                </Ranges>
                <Scales>
                    <DGWC:CircularScale Maximum="60" Name="Default">
                        <LabelStyle RotateLabels="False" />
                    </DGWC:CircularScale>
                </Scales>
                <Size Height="100" Width="100" />
                <PivotPoint X="50" Y="50" />
                <Pointers>
                    <DGWC:CircularPointer Name="Default" />
                    <DGWC:CircularPointer FillGradientEndColor="Chartreuse" MarkerLength="15" MarkerStyle="Wedge"
                        Name="TrailingMonth" Type="Marker" Width="10" />
                </Pointers>
                <BackFrame />
                <Location X="0" Y="0" />
            </DGWC:CircularGauge>
        </CircularGauges>
        <Values>
            <DGWC:InputValue Name="Default">
            </DGWC:InputValue>
        </Values>
        <BackFrame ></BackFrame>
        <Labels>
            <DGWC:GaugeLabel BackColor="" BackGradientEndColor="" Font="Microsoft Sans Serif, 12pt"
                Name="Label1" Parent="CircularGauges.Default" Text="Today and 30-Day Trailing (marker)">
                <Size Height="20" Width="100" />
                <Location X="0" Y="-10" />
            </DGWC:GaugeLabel>
        </Labels>
    </DGWC:GaugeContainer>
</asp:Content>
