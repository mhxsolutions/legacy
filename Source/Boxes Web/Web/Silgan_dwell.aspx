<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Silgan_dwell.aspx.vb" Inherits="Silgan_dwell" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Silgan Dwell</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Silgan Dwell of UPI deliveries</h3>
        <br />
        
        <dx:aspxbutton ID="ASPxButton1" runat="server" Height="16px" 
            Text="Export Chart to Excel" Width="169px" AutoPostBack="False" 
            Theme="DevEx">
            <ClientSideEvents Click="function(s, e) {
	WebChartControl1.SaveToDisk('xlsx');
}" />
        </dx:aspxbutton>
        <br />
        <dx:WebChartControl ID="WebChartControl1" runat="server" 
            CrosshairEnabled="True" DataSourceID="SqlDataSource1" Height="390px" 
            SideBySideBarDistanceFixed="2" SideBySideBarDistanceVariable="2" 
            SideBySideEqualBarWidth="True" Width="1024px">
            <emptycharttext text="no data" />
            <diagramserializable>
                <dx:XYDiagram>
                    <axisx color="255, 255, 255" interlacedcolor="255, 255, 192" 
                        visibleinpanesserializable="-1">
                        <autoscalebreaks enabled="True" maxcount="4" />
                        <tickmarks length="10" />
                        <label angle="-45" enableantialiasing="True">
                            
                        </label>
                        <range alwaysshowzerolevel="True" sidemarginsenabled="True" />
                        <datetimescaleoptions gridalignment="Hour" measureunit="Hour" 
                            scalemode="Automatic" workdaysonly="True">
                        </datetimescaleoptions>
                    </axisx>
                    <axisy visibleinpanesserializable="-1">
                        <range alwaysshowzerolevel="True" sidemarginsenabled="True" />
                    </axisy>
                </dx:XYDiagram>
            </diagramserializable>
<FillStyle><OptionsSerializable>
<dx:SolidFillOptions></dx:SolidFillOptions>
</OptionsSerializable>
</FillStyle>

            <seriesserializable>
                <dx:Series ArgumentDataMember="Arrive Destination" 
                    ArgumentScaleType="Qualitative" LegendText="Unload time" Name="Dwell Time" 
                    SeriesPointsSorting="Ascending" ValueDataMembersSerializable="Dwell">
                    <viewserializable>
                        <dx:SideBySideBarSeriesView>
                        </dx:SideBySideBarSeriesView>
                    </viewserializable>
                    <labelserializable>
                        <dx:SideBySideBarSeriesLabel LineVisible="True">
                            <fillstyle>
                                <optionsserializable>
                                    <dx:SolidFillOptions />
                                </optionsserializable>
                            </fillstyle>
                            <pointoptionsserializable>
                                <dx:PointOptions>
                                </dx:PointOptions>
                            </pointoptionsserializable>
                        </dx:SideBySideBarSeriesLabel>
                    </labelserializable>
                    <legendpointoptionsserializable>
                        <dx:PointOptions>
                        </dx:PointOptions>
                    </legendpointoptionsserializable>
                </dx:Series>
            </seriesserializable>

<SeriesTemplate><ViewSerializable>
<dx:SideBySideBarSeriesView></dx:SideBySideBarSeriesView>
</ViewSerializable>
<LabelSerializable>
<dx:SideBySideBarSeriesLabel LineVisible="True">
<FillStyle><OptionsSerializable>
<dx:SolidFillOptions></dx:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
<PointOptionsSerializable>
<dx:PointOptions></dx:PointOptions>
</PointOptionsSerializable>
</dx:SideBySideBarSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
<dx:PointOptions></dx:PointOptions>
</LegendPointOptionsSerializable>
</SeriesTemplate>

<CrosshairOptions><CommonLabelPositionSerializable>
<dx:CrosshairMousePosition></dx:CrosshairMousePosition>
</CommonLabelPositionSerializable>
</CrosshairOptions>

<ToolTipOptions><ToolTipPositionSerializable>
<dx:ToolTipMousePosition></dx:ToolTipMousePosition>
</ToolTipPositionSerializable>
</ToolTipOptions>
        </dx:WebChartControl>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Silgan dwell on UPI to Silgan moves last 7 days]">
        </asp:SqlDataSource>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Silgan Dwell" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataDateColumn FieldName="Arrive Destination" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="4">
                    <PropertiesDateEdit DisplayFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
    
    </div>
    </form>
</body>
</html>
