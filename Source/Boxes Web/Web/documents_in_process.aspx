<%@ Page Language="VB" AutoEventWireup="false" CodeFile="documents_in_process.aspx.vb" Inherits="documents_in_process" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Documents in Process</title>
    <style type="text/css">
        .style1
        {
            width: 177%;
        }
        .style2
        {
            width: 274px;
        }
        .style3
        {
            width: 378px;
        }
        .style4
        {
            width: 378px;
            font-weight: bold;
        }
        .style5
        {
            width: 274px;
            font-weight: bold;
        }
        .style6
        {
            width: 314px;
        }
        .style7
        {
            width: 114px;
        }
        .style8
        {
            width: 302px;
        }
        .style9
        {
            width: 219px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        CSR Documents In Process</h3>
        <br />
        <br />
        <table class="style1">
            <tr>
                <td class="style5">
                    Receivers not Locked</td>
                <td class="style4">
                    BOLs not Locked</td>
                <td class="style9">
                    <b>Loads not Logged Out Summary</b></td>
                <td class="style8">
                    <b>Loads without PODs Summary</b></td>
                <td class="style6">
                    <strong>Load Detail (missing Logout and POD)</strong></td>
                <td class="style7">
                    <strong>Loads Missing Scan</strong></td>
            </tr>
            <tr>
                <td class="style2" valign="top">
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Receiver_ID" 
                        DataSourceID="SqlDataSource1" EnableModelValidation="True" 
                        GridLines="None" ForeColor="#333333">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
                            </asp:BoundField>
                            <asp:BoundField DataField="Receiver_ID" HeaderText="Receiver_ID" 
                                ReadOnly="True" SortExpression="Receiver_ID"></asp:BoundField>
                            <asp:BoundField DataField="Date_Received" HeaderText="Date_Received" 
                                SortExpression="Date_Received" DataFormatString="{0:d}"></asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Receiver ID] AS Receiver_ID, [Date Received] AS Date_Received FROM [CSR receivers not locked] ORDER BY [Fleet], [Receiver ID]">
                    </asp:SqlDataSource>
                </td>
                <td class="style3" valign="top">
                    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Load_ID" 
                        DataSourceID="SqlDataSource2" EnableModelValidation="True" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
                            </asp:BoundField>
                            <asp:BoundField DataField="Load_Type" HeaderText="Load_Type" 
                                SortExpression="Load_Type"></asp:BoundField>
                            <asp:BoundField DataField="Load_ID" HeaderText="Load_ID" ReadOnly="True" 
                                SortExpression="Load_ID"></asp:BoundField>
                            <asp:BoundField DataField="Shipment_Date" HeaderText="Shipment_Date" 
                                SortExpression="Shipment_Date" DataFormatString="{0:d}"></asp:BoundField>
                            <asp:BoundField DataField="Ct" HeaderText="Ct" SortExpression="Ct">
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Load Type] AS Load_Type, [Load ID] AS Load_ID, [Shipment Date] AS Shipment_Date, [Ct] FROM [CSR BOLs not locked] ORDER BY [Fleet], [Load ID]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top" class="style9">
                    <asp:GridView ID="GridView4" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" 
                        DataSourceID="SqlDataSource4" EnableModelValidation="True" 
                        GridLines="None" ForeColor="#333333">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
                            <asp:BoundField DataField="Day" 
                                HeaderText="Day" SortExpression="Day" />
                            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        
                        SelectCommand="SELECT * FROM [CSR Loads not Logout summary] ORDER BY [Fleet], [year],[month],[day]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top" class="style8">
                    <asp:GridView ID="GridView5" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        DataSourceID="SqlDataSource5" EnableModelValidation="True" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
                            <asp:BoundField DataField="No_POD" HeaderText="No_POD" 
                                SortExpression="No_POD" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Year], [Month], [No POD] AS No_POD FROM [CSR missing PODs summary] ORDER BY [Fleet], [Year], [Month]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top" class="style6">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" CssPostfix="PlasticBlue" 
                        DataSourceID="SqlDataSource3" KeyFieldName="Load">
                        <Columns>
                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" ShowClearFilterButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" 
                                ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" 
                                VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" 
                                ShowInCustomizationForm="True" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="LoadDate" ShowInCustomizationForm="True" 
                                VisibleIndex="3">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataCheckColumn FieldName="Will_Call" 
                                ShowInCustomizationForm="True" VisibleIndex="4">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="LogOut" ShowInCustomizationForm="True" 
                                VisibleIndex="5">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="POD" ShowInCustomizationForm="True" 
                                VisibleIndex="6">
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                        <SettingsPager PageSize="100" ShowDefaultImages="False">
                            <AllButton Text="All">
                            </AllButton>
                            <NextPageButton Text="Next &gt;">
                            </NextPageButton>
                            <PrevPageButton Text="&lt; Prev">
                            </PrevPageButton>
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" />
                        <Images SpriteCssFilePath="~/App_Themes/PlasticBlue/{0}/sprite.css">
                            <LoadingPanelOnStatusBar Url="~/App_Themes/PlasticBlue/GridView/gvLoadingOnStatusBar.gif">
                            </LoadingPanelOnStatusBar>
                            <LoadingPanel Url="~/App_Themes/PlasticBlue/GridView/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <ImagesFilterControl>
                            <LoadingPanel Url="~/App_Themes/PlasticBlue/Editors/Loading.gif">
                            </LoadingPanel>
                        </ImagesFilterControl>
                        <Styles CssFilePath="~/App_Themes/PlasticBlue/{0}/styles.css" 
                            CssPostfix="PlasticBlue">
                            <Header ImageSpacing="10px" SortingImageSpacing="10px">
                            </Header>
                        </Styles>
                        <StylesEditors>
                            <CalendarHeader Spacing="11px">
                            </CalendarHeader>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Load], [LoadDate], [Will Call] AS Will_Call, [LogOut], [POD] FROM [CSR Loads not LogOut or not POD] ORDER BY [Fleet], [Load]">
                    </asp:SqlDataSource>
                </td>
                <td valign="top" class="style7">
                    <asp:GridView ID="GridView6" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Load" 
                        DataSourceID="SqlDataSource6" EnableModelValidation="True" 
                        GridLines="Horizontal">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <Columns>
                            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" 
                                SortExpression="Load" />
                            <asp:BoundField DataField="POD_Date" DataFormatString="{0:d}" 
                                HeaderText="POD Date" SortExpression="POD_Date" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Fleet], [Load], [POD Date] AS POD_Date FROM [Loads needing POD scans] ORDER BY [Fleet], [Load]">
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
