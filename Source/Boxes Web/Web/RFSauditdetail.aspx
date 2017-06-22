<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RFSauditdetail.aspx.vb" Inherits="RFSauditdetail" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RFS Audit Detail</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            RFS Audit Detail</h3>
        <br />
        <table class="style1">
            <tr>
                <td>
                    <b>Receiver no RFS</b></td>
                <td>
                    <b>Receiver no Revenue</b></td>
                <td>
                    <b>BOL no RFS</b></td>
                <td>
                    <b>BOL no Revnue</b></td>
                <td>
                    <b>Load no RFS</b></td>
                <td>
                    <b>Load no Revenue</b></td>
                <td>
                    <strong>Loads not on Invoice
                    <asp:Button ID="Button1" runat="server" Text="Export xlsx" />
                    </strong></td>
            </tr>
            <tr>
                <td valign="top">
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Receiver_ID" 
                        DataSourceID="SqlDataSource1" EnableModelValidation="True" ForeColor="#333333" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" 
                                SortExpression="Terminal" />
                            <asp:BoundField DataField="Date_Received" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="Date_Received" />
                            <asp:BoundField DataField="Receiver_ID" HeaderText="Receiver_ID" 
                                ReadOnly="True" SortExpression="Receiver_ID" />
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Terminal], [Date Received] AS Date_Received, [Receiver ID] AS Receiver_ID FROM [RFS receivers with no RFS] ORDER BY [Terminal], [Date Received], [Receiver ID]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Receiver_ID" 
                        DataSourceID="SqlDataSource2" EnableModelValidation="True" ForeColor="#333333" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" 
                                SortExpression="Terminal" />
                            <asp:BoundField DataField="Date_Received" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="Date_Received" />
                            <asp:BoundField DataField="Receiver_ID" HeaderText="Receiver_ID" 
                                ReadOnly="True" SortExpression="Receiver_ID" />
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Terminal], [Date Received] AS Date_Received, [Receiver ID] AS Receiver_ID FROM [RFS Receivers with RFS but no revenue] ORDER BY [Terminal], [Date Received], [Receiver ID]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView3" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load_ID" 
                        DataSourceID="SqlDataSource3" EnableModelValidation="True" ForeColor="#333333" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="Shipment_Date" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="Shipment_Date" />
                            <asp:BoundField DataField="Load_ID" HeaderText="BOL" ReadOnly="True" 
                                SortExpression="Load_ID" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Shipment Date] AS Shipment_Date, [Load ID] AS Load_ID FROM [RFS BOL without RFS] ORDER BY [Fleet], [Shipment Date], [Load ID]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView4" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load_ID" 
                        DataSourceID="SqlDataSource4" EnableModelValidation="True" ForeColor="#333333" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="Shipment_Date" DataFormatString="{0:d}" 
                                HeaderText="Date" SortExpression="Shipment_Date" />
                            <asp:BoundField DataField="Load_ID" HeaderText="BOL" ReadOnly="True" 
                                SortExpression="Load_ID" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Shipment Date] AS Shipment_Date, [Load ID] AS Load_ID FROM [RFS BOL with RFS but no revenue] ORDER BY [Fleet], [Shipment Date], [Load ID]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView5" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="Load" 
                        DataSourceID="SqlDataSource5" EnableModelValidation="True">
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="LoadDate" DataFormatString="{0:d}" HeaderText="Date" 
                                SortExpression="LoadDate" />
                            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" 
                                SortExpression="Load" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [LoadDate], [Load] FROM [RFS loads without RFS] ORDER BY [Fleet], [LoadDate], [Load]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView6" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="Load" 
                        DataSourceID="SqlDataSource6" EnableModelValidation="True">
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="LoadDate" DataFormatString="{0:d}" HeaderText="Date" 
                                SortExpression="LoadDate" />
                            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" 
                                SortExpression="Load" />
                        </Columns>
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [LoadDate], [Load] FROM [RFS loads with rfs no rev] ORDER BY [Fleet], [LoadDate], [Load]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                        CssPostfix="Office2003Olive" DataSourceID="SqlDataSource7" KeyFieldName="Load">
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
                        </GroupSummary>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowSelectCheckbox="True" ShowClearFilterButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" 
                                SortOrder="Ascending" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Yr" ReadOnly="True" SortIndex="2" 
                                SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Mo" GroupIndex="1" ReadOnly="True" 
                                SortIndex="1" SortOrder="Descending" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsPager PageSize="100">
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
                        <Images SpriteCssFilePath="~/App_Themes/Office2003Olive/{0}/sprite.css">
                            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Olive/GridView/gvLoadingOnStatusBar.gif">
                            </LoadingPanelOnStatusBar>
                            <LoadingPanel Url="~/App_Themes/Office2003Olive/GridView/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <ImagesFilterControl>
                            <LoadingPanel Url="~/App_Themes/Office2003Olive/Editors/Loading.gif">
                            </LoadingPanel>
                        </ImagesFilterControl>
                        <Styles CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                            CssPostfix="Office2003Olive">
                            <Header ImageSpacing="5px" SortingImageSpacing="5px">
                            </Header>
                            <LoadingPanel ImageSpacing="10px">
                            </LoadingPanel>
                        </Styles>
                        <StylesEditors>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                    </dx:ASPxGridView>
                    <dx:ASPxGridViewExporter ID="exportloads" runat="server" 
                        ExportedRowType="Selected" FileName="LoadsNotOnInvoice" 
                        GridViewID="ASPxGridView1">
                    </dx:ASPxGridViewExporter>
                    <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                        SelectCommand="SELECT * FROM [Loads not on Invoices detail]">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
