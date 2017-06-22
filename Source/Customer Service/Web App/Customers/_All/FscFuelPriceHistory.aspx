<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_FscFuelPriceHistory" 
    Title="BudwayDirect - FSC History" CodeBehind="FscFuelPriceHistory.aspx.cs" CodeFile="FscFuelPriceHistory.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Fuel Price History</h2>
    <p>
        <a href="http://tonto.eia.doe.gov/oog/info/wohdp/diesel.asp">source</a></p>
    <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Export to the Excel" />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="FuelPriceHistoryDatasource">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Begin Date" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="End Date" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Fuel Price" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="FuelPriceHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Begin Date], [End Date], [Fuel Price] FROM [FSC Fuel Price History] WHERE ([Begin Date] >= DATEADD(YEAR, - 1, GETDATE())) ORDER BY [Begin Date] DESC, [End Date] DESC">
        </asp:SqlDataSource>
    </p>
    
</asp:Content>
