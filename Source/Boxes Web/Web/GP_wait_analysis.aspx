<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GP_wait_analysis.aspx.vb" Inherits="GP_wait_analysis" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GP Analysis</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            GP Wait Time Analysis<br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableCallBacks="False" EnableTheming="True" 
            Theme="Office2010Blue">
            <Fields>
                <dx:PivotGridField ID="fieldYear" AreaIndex="0" FieldName="Year">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Month">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldHour" Area="RowArea" AreaIndex="0" FieldName="Hour">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCount" Area="DataArea" AreaIndex="0" 
                    FieldName="Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldAvgWait" Area="DataArea" AreaIndex="1" 
                    FieldName="Avg Wait">
                </dx:PivotGridField>
            </Fields>
<StylesPrint Cell-BackColor2="" Cell-GradientMode="Horizontal" FieldHeader-BackColor2="" FieldHeader-GradientMode="Horizontal" TotalCell-BackColor2="" TotalCell-GradientMode="Horizontal" GrandTotalCell-BackColor2="" GrandTotalCell-GradientMode="Horizontal" CustomTotalCell-BackColor2="" CustomTotalCell-GradientMode="Horizontal" FieldValue-BackColor2="" FieldValue-GradientMode="Horizontal" FieldValueTotal-BackColor2="" FieldValueTotal-GradientMode="Horizontal" FieldValueGrandTotal-BackColor2="" FieldValueGrandTotal-GradientMode="Horizontal" Lines-BackColor2="" Lines-GradientMode="Horizontal"></StylesPrint>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [GP willcall arrival count by year month hour]">
        </asp:SqlDataSource>
        <dx:WebChartControl ID="WebChartControl1" runat="server" 
            DataSourceID="ASPxPivotGrid1" Height="400px" SeriesDataMember="Series" 
            Width="800px">
            <diagramserializable>
                <dx:XYDiagram>
                    <axisx title-text="Hour" visibleinpanesserializable="-1">
                        <range sidemarginsenabled="True" />
                        <numericoptions format="General" />
                    </axisx>
                    <axisy title-text="Count Avg Wait" visibleinpanesserializable="-1">
                        <range sidemarginsenabled="True" />
                        <numericoptions format="General" />
                    </axisy>
                </dx:XYDiagram>
            </diagramserializable>
<FillStyle><OptionsSerializable>
<dx:SolidFillOptions></dx:SolidFillOptions>
</OptionsSerializable>
</FillStyle>

            <legend maxhorizontalpercentage="30"></legend>

<SeriesTemplate argumentdatamember="Arguments" argumentscaletype="Qualitative" 
                valuedatamembersserializable="Values"><ViewSerializable>
<dx:SideBySideBarSeriesView></dx:SideBySideBarSeriesView>
</ViewSerializable>
<LabelSerializable>
<dx:SideBySideBarSeriesLabel LineVisible="True">
<FillStyle><OptionsSerializable>
<dx:SolidFillOptions></dx:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
<PointOptionsSerializable>
<dx:PointOptions>
<ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

<ValueNumericOptions Format="General"></ValueNumericOptions>
</dx:PointOptions>
</PointOptionsSerializable>
</dx:SideBySideBarSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
<dx:PointOptions>
<ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

<ValueNumericOptions Format="General"></ValueNumericOptions>
</dx:PointOptions>
</LegendPointOptionsSerializable>
</SeriesTemplate>

<CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
<dx:CrosshairMousePosition></dx:CrosshairMousePosition>
</CommonLabelPositionSerializable>
</CrosshairOptions>

<ToolTipOptions><ToolTipPositionSerializable>
<dx:ToolTipMousePosition></dx:ToolTipMousePosition>
</ToolTipPositionSerializable>
</ToolTipOptions>
        </dx:WebChartControl>
    
    </div>
    </form>
</body>
</html>
