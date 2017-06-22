<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Clients.All.Default" %>
<%@ Register assembly="DevExpress.XtraCharts.v16.2.Web, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts.Web" tagprefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Dashboard</h3>
    <p>
        &nbsp;</p>
    <p>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue" Visible="False">
            <Fields>
                <dx:PivotGridField ID="fieldScheduled" Area="DataArea" AreaIndex="0" FieldName="Scheduled" GrandTotalText="Scheduled-">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldArrived" Area="DataArea" AreaIndex="1" FieldName="Arrived" GrandTotalText="Arrived-">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDocsinOffice" Area="DataArea" AreaIndex="2" FieldName="Docs in Office">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldReceiversStarted" Area="DataArea" AreaIndex="3" FieldName="Receivers Started">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldReceiversComp" Area="DataArea" AreaIndex="4" FieldName="Receivers Comp">
                </dx:PivotGridField>
            </Fields>
            <OptionsView ShowColumnGrandTotalHeader="False" />
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA trucks sch vs recd summary] WHERE ([Client ID] = @Client_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        </p>
    <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" CrosshairEnabled="True" DataSourceID="ASPxPivotGrid1" Height="300px" SeriesDataMember="Series" Width="500px">
        <diagramserializable>
            <cc1:XYDiagram>
                <axisx visibleinpanesserializable="-1">
                    <label visible="False">
                    </label>
                </axisx>
                <axisy title-text="Scheduled Arrived Docs in Office Receivers Started Receivers Comp" visibleinpanesserializable="-1">
                </axisy>
            </cc1:XYDiagram>
        </diagramserializable>
        <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" direction="LeftToRight" maxverticalpercentage="30"></legend>
        <seriestemplate argumentdatamember="Arguments" argumentscaletype="Qualitative" valuedatamembersserializable="Values">
        </seriestemplate>
        <titles>
            <cc1:ChartTitle Text="Inbound Trucks" />
        </titles>
    </dxchartsui:WebChartControl>
    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2010Blue">
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFooter="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Trucks Scheduled" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Trucks Arrived" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Docs in Office" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receivers Started" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receivers Complete" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Docs in Office" ShowInColumn="Docs in Office" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Receivers Complete" ShowInColumn="Receivers Complete" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Receivers Started" ShowInColumn="Receivers Started" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Trucks Arrived" ShowInColumn="Trucks Arrived" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Trucks Scheduled" ShowInColumn="Trucks Scheduled" SummaryType="Sum" />
        </TotalSummary>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA trucks sch vs recd] WHERE ([Client ID] = @Client_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
