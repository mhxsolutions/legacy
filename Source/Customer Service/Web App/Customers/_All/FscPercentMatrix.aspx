<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_FscPercentMatrix" 
    Title="BudwayDirect - FSC" CodeBehind="FscPercentMatrix.aspx.cs" CodeFile="FscPercentMatrix.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>FSC Fuel Price Percent Matrix</h2>
    <p>The <a href="FscFuelPriceHistory.aspx">fuel price</a> is used as an index into the following matrix to determine the FSC percentage.</p>
    <p>
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
                <asp:BoundField DataField="Percent" DataFormatString="{0:f2}%" HeaderText="Percent"
                    HtmlEncode="False" ReadOnly="True" SortExpression="Percent">
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
            SelectCommand="SELECT [Index Minimum] AS Minimum, [Index Maximum] AS Maximum, [FSC Value] * 100 AS [Percent] FROM [FSC Detail Float Indexed] WHERE ([FSC Ref] = @FscId) ORDER BY Minimum, Maximum">
            <SelectParameters>
                <asp:QueryStringParameter Name="FscId" QueryStringField="FSCID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

