<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPIpivot.aspx.vb" Inherits="UPIpivot" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>UPI</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        UPI 
        tons delivered<br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="PlasticBlue" 
            EnableCallBacks="False" Width="800px">
            <Fields>
                <dx:PivotGridField ID="fieldYear" Area="RowArea" AreaIndex="0" FieldName="Year" 
                    SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="1" 
                    FieldName="Month" SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldFleet" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Fleet">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTons" Area="DataArea" AreaIndex="0" 
                    CellFormat-FormatString="n0" FieldName="Tons" 
                    CellFormat-FormatType="Numeric">
                </dx:PivotGridField>
            </Fields>
            <OptionsView ShowHorizontalScrollBar="True" />
            <OptionsPager RowsPerPage="13">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT [Year], [Month], [Fleet], [Tons] FROM [UPI tons and times monthly summry]">
        </asp:SqlDataSource>
        <dx:WebChartControl ID="WebChartControl1" runat="server" 
            DataSourceID="ASPxPivotGrid1" Height="400px" PaletteName="Flow" 
            SeriesDataMember="Series" Width="800px">
            <diagramserializable>
                <dx:XYDiagram>
                    <axisx visibleinpanesserializable="-1">
                        <range sidemarginsenabled="True" />
                    </axisx>
                    <axisy visibleinpanesserializable="-1">
                        <range sidemarginsenabled="True" />
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
        <br />
    </div>
    </form>
</body>
</html>
