<%@ Page Title="Hydra Metrics" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Metrics.aspx.cs" Inherits="Web.Clients.Assigned.Metrics" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Hydra Metrics</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Data to XLSX" Theme="Office2010Silver">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Grid to XLSX" Theme="Office2010Silver">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All" Theme="Office2010Silver">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All" Theme="Office2010Silver">
    </dx:ASPxButton>
    <p>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Silver">
            <Fields>
                <dx:PivotGridField ID="fieldYr" Area="ColumnArea" AreaIndex="0" FieldName="Yr" SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMo" Area="ColumnArea" AreaIndex="1" FieldName="Mo" SortMode="Value" SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldClient" Area="RowArea" AreaIndex="1" FieldName="Client">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldProduct" Area="RowArea" AreaIndex="0" FieldName="Product">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTerminal" AreaIndex="0" FieldName="Terminal">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldProfile" Area="RowArea" AreaIndex="2" FieldName="Profile">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldRailRcd" Area="DataArea" AreaIndex="0" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Rail Rcd" Caption="Rail In">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldRailOut" Area="DataArea" AreaIndex="1" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Rail Out">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTruckRcd" Area="DataArea" AreaIndex="2" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Truck Rcd" Caption="Truck In">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTruckOut" Area="DataArea" AreaIndex="3" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Truck Out">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTons" Area="DataArea" AreaIndex="4" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Tons" Caption="Tons In">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonsOut" Area="DataArea" AreaIndex="5" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Tons Out">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCount" Area="DataArea" AreaIndex="6" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Count" Caption="Count In">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCountOut" Area="DataArea" AreaIndex="7" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Count Out">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCurrentUnitCount" Area="DataArea" AreaIndex="9" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Current Unit Count">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCurrentTons" Area="DataArea" AreaIndex="8" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Current Tons">
                </dx:PivotGridField>
            </Fields>
            <OptionsView ColumnTotalsLocation="Near" />
            <OptionsPager RowsPerPage="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
            <OptionsData AutoExpandGroups="False" />
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Hydra Metrics Repot]"></asp:SqlDataSource>
    </p>
    <ul>
        <li>Right click data column headers for sort options.</li>
        <li>Right click field names for option to hide data.</li>
    </ul>
    <p>
        <dx:ASPxPivotGridExporter ID="PivotGridExporter1" runat="server" ASPxPivotGridID="ASPxPivotGrid1">
            <OptionsPrint MergeColumnFieldValues="False" PrintColumnHeaders="True" PrintDataHeaders="True">
            </OptionsPrint>
        </dx:ASPxPivotGridExporter>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Metrics" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Theme="Metropolis" Visible="False">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Yr" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mo" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rail Rcd" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rail Out" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Truck Rcd" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Truck Out" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Out" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count Out" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
    </p>
</asp:Content>
