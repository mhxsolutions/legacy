<%@ Page Title="Rollover" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="UPIrollovers.aspx.cs" Inherits="Customers__Assigned_UPIrollovers" %>

<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Linear" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Circular" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.State" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxGauges.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGauges.Gauges.Digital" tagprefix="dx" %>
<%@ Register assembly="DevExpress.XtraCharts.v16.2.Web, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.XtraCharts.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Rollover Loads</h2>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Settings ShowFooter="True" ShowTitlePanel="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsText Title="Current Rollovers" />
            <Columns>
                <dx:GridViewDataDateColumn FieldName="LoadDate" SortIndex="0" SortOrder="Descending" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Scheduled Count" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Planned Rollover Count" ReadOnly="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Planned Rollover Count" SummaryType="Sum" />
            </TotalSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [posco current rollover ct cp to sch ct]"></asp:SqlDataSource>
    </p>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [posco monthly rollover ct cp to sch ct]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [posco daily rolled and delivered]"></asp:SqlDataSource>
    <dx:WebChartControl ID="WebChartControl2" runat="server" AutoLayout="True" CrosshairEnabled="True" DataSourceID="SqlDataSource4" Height="311px" PaletteBaseColorNumber="2" Width="900px">
        <DiagramSerializable>
            <dx:XYDiagram>
                <AxisX VisibleInPanesSerializable="-1">
                </AxisX>
                <AxisY Title-Text="Count" Title-Visibility="True" VisibleInPanesSerializable="-1">
                </AxisY>
            </dx:XYDiagram>
        </DiagramSerializable>
<Legend Name="Default Legend"></Legend>
        <SeriesSerializable>
            <dx:Series ArgumentDataMember="LoadDate" Name="On-Time" ValueDataMembersSerializable="Delivered Ct">
                <ViewSerializable>
                    <dx:StackedBarSeriesView>
                    </dx:StackedBarSeriesView>
                </ViewSerializable>
            </dx:Series>
            <dx:Series ArgumentDataMember="LoadDate" Name="Rollover" ValueDataMembersSerializable="Rollover Ct">
                <ViewSerializable>
                    <dx:StackedBarSeriesView>
                    </dx:StackedBarSeriesView>
                </ViewSerializable>
            </dx:Series>
        </SeriesSerializable>
        <SeriesTemplate>
            <ViewSerializable>
                <dx:StackedBarSeriesView>
                </dx:StackedBarSeriesView>
            </ViewSerializable>
        </SeriesTemplate>
        <Titles>
            <dx:ChartTitle Text="60 Day Lookback" />
        </Titles>
    </dx:WebChartControl>
    <br />
    <dx:WebChartControl ID="WebChartControl1" runat="server" CrosshairEnabled="True" DataSourceID="SqlDataSource3" Height="356px" PaletteBaseColorNumber="2" Width="900px">
        <DiagramSerializable>
            <dx:XYDiagram>
                <AxisX Title-Text="Month" Title-Visibility="True" VisibleInPanesSerializable="-1">
                    <Tickmarks MinorVisible="False" />
                </AxisX>
                <AxisY Title-Text="% Rollover" Title-Visibility="True" VisibleInPanesSerializable="-1">
                </AxisY>
            </dx:XYDiagram>
        </DiagramSerializable>
<Legend Name="Default Legend" markervisible="False" textvisible="False"></Legend>
        <SeriesSerializable>
            <dx:Series ArgumentDataMember="First Day" Name="Series 1" ValueDataMembersSerializable="Percent Rollover">
                <ViewSerializable>
                    <dx:LineSeriesView>
                    </dx:LineSeriesView>
                </ViewSerializable>
            </dx:Series>
        </SeriesSerializable>
        <SeriesTemplate ArgumentDataMember="First Day" ValueDataMembersSerializable="Percent Rollover">
            <ViewSerializable>
                <dx:LineSeriesView>
                </dx:LineSeriesView>
            </ViewSerializable>
        </SeriesTemplate>
        <Titles>
            <dx:ChartTitle Text="Monthly Rollover Rate" />
        </Titles>
    </dx:WebChartControl>
    <p>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" KeyFieldName="Load" Width="98%">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowTitlePanel="True" />
            <SettingsBehavior AllowEllipsisInText="True" ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
            <SettingsText Title="60 Day Lookback Rollover Detail" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" Visible="False" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Schedule Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" Width="2in">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="5" Width="1.5in">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LoadNotes" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Delivery Date" VisibleIndex="2" Width="1.5in">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Delay" ReadOnly="True" VisibleIndex="3" Width="1in">
                    <HeaderStyle HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [posco rollover load detail]"></asp:SqlDataSource>
    </p>
</asp:Content>

