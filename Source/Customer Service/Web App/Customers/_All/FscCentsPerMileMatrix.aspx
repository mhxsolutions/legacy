<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_FscCentsPerMileMatrix" 
    Title="BudwayDirect - FSC Matrix" CodeBehind="FscCentsPerMileMatrix.aspx.cs" CodeFile="FscCentsPerMileMatrix.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>FSC Fuel Price Cents Per Mile Matrix</h2>
    <p>The <a href="FscFuelPriceHistory.aspx">fuel price</a> is used as an index into the following matrix to determine the FSC in cents per mile.</p>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="MatrixDatasource" ForeColor="#333333" GridLines="None">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Minimum" HeaderText="Minimum" SortExpression="Minimum" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Maximum" HeaderText="Maximum" SortExpression="Maximum" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Cents Per Mile" DataFormatString="{0:f3}" HeaderText="Cents Per Mile"
                HtmlEncode="False" ReadOnly="True" SortExpression="Cents Per Mile">
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="MatrixDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Index Minimum] AS Minimum, [Index Maximum] AS Maximum, [FSC Value] AS [Cents Per Mile] FROM [FSC Detail Float Indexed] WHERE ([FSC Ref] = @FscId) ORDER BY Minimum, Maximum">
        <SelectParameters>
            <asp:QueryStringParameter Name="FscId" QueryStringField="FSCID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="MatrixDatasource" EnableTheming="True" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Minimum" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Maximum" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Cents Per Mile" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>
