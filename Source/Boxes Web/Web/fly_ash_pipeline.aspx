<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fly_ash_pipeline.aspx.cs" Inherits="fly_ash_pipeline" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            SRMG Fly Ash Pipeline Estimates</h3>
        <br />

 
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       <%-- <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
            Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="5in" 
            Width="4.6in" ShowBackButton="False" ShowFindControls="False" 
            SizeToReportContent="True" style="margin-right: 0px">
            <LocalReport ReportPath="ReprotDefinition\fly_ash_pipeline_proj.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSet1" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>--%>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="DWS_Rep_DataDataSetTableAdapters.fly_ash_pipeline_inventory_summary_running_totalTableAdapter">
        </asp:ObjectDataSource>
    
        <dx:ASPxGridView ID="gridFlyAsh" runat="server"  
            DataSourceID="ObjectDataSource2" AutoGenerateColumns="True" KeyFieldName="ETA"
         CssFilePath="~/App_Themes/Aqua/{0}/styles.css"  CssPostfix="Aqua" 
            OnCustomUnboundColumnData="gridFlyAsh_CustomUnboundColumnData" 
            OnCustomSummaryCalculate="gridFlyAsh_CustomSummaryCalculate" 
            Theme="Office2003Blue" >
             <Columns>
                <dx:GridViewDataTextColumn FieldName="ETA" VisibleIndex="0" Caption="Date" PropertiesTextEdit-DisplayFormatString="MM/dd/yyyy" >
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Est In" VisibleIndex="1" Caption="On Site and Est Inbound">
                </dx:GridViewDataTextColumn>
                 <dx:GridViewDataTextColumn FieldName="Avg Out" VisibleIndex="2" Caption="Avg Daily Outbound">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Balance" UnboundType="Integer" VisibleIndex="3" Caption="Running Balance">
                      <Settings AllowSort="False" AllowGroup="False"></Settings>
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowFooter="true" />
            <TotalSummary>
                <dx:ASPxSummaryItem SummaryType="Custom" FieldName="Date" ShowInColumn="Date" DisplayFormat="{0}" />
                <dx:ASPxSummaryItem SummaryType="Sum"  FieldName="Est In" ShowInColumn="Est In" DisplayFormat="{0}"  />   
                <dx:ASPxSummaryItem SummaryType="Sum" FieldName="Avg Out" ShowInColumn="Avg Out" DisplayFormat="{0}" />
                <dx:ASPxSummaryItem SummaryType="Custom" FieldName="Balance" ShowInColumn="Balance" DisplayFormat="{0}" />
            </TotalSummary>
            <SettingsPager PageSize="10" Position="Top">
                <AllButton Visible="False"></AllButton>
                <PageSizeItemSettings Visible="false"></PageSizeItemSettings>
                <Summary Visible="true" Position="Inside" />
            </SettingsPager>
            <SettingsLoadingPanel ImagePosition="Top" />
            <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="gridExportFlyAsh" runat="server" GridViewID="gridFlyAsh"></dx:ASPxGridViewExporter>
        <table cellpadding="0" cellspacing="0" style="margin-top: 16px">
            <tr>
                <td style="padding-right: 4px">
                    <dx:ASPxButton ID="btnPdfExport" runat="server" Text="Export to PDF" UseSubmitBehavior="False"
                        OnClick="btnPdfExport_Click" Theme="Office2003Blue" />
                </td>
                <td style="padding-right: 4px">
                    <dx:ASPxButton ID="btnXlsExport" runat="server" Text="Export to XLS" UseSubmitBehavior="False"
                        OnClick="btnXlsExport_Click" Theme="Office2003Blue" />
                </td>
                <td style="padding-right: 4px">
                    <dx:ASPxButton ID="btnXlsxExport" runat="server" Text="Export to XLSX" UseSubmitBehavior="False"
                        OnClick="btnXlsxExport_Click" Theme="Office2003Blue" />
                </td>
                <td style="padding-right: 4px">
                    <dx:ASPxButton ID="btnRtfExport" runat="server" Text="Export to RTF" UseSubmitBehavior="False"
                        OnClick="btnRtfExport_Click" Theme="Office2003Blue" />
                </td>
            </tr>
        </table>

    </div>
    </form>
</body>
</html>
