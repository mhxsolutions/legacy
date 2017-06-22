<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_Wise_Consumption" Title="Delivered to Plant" Codebehind="Consumption.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Delivered to Plant</h2>
    <p>
        Delivered/Planned to MCC by Budway</p>
    <p>
        Select Week:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="Start" DataValueField="Start">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Start] FROM [Wise quota balance] ORDER BY [Start] DESC">
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
            CellPadding="4" DataSourceID="SqlDataSource2">
            <RowStyle BackColor="White" ForeColor="#330099" />
            <Columns>
                <asp:BoundField DataField="column1" HeaderText="Gage - Width" SortExpression="column1" />
                <asp:BoundField DataField="Pounds" HeaderText="Pounds" SortExpression="Pounds" DataFormatString="{0:n0}" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Max_Pounds_Quota" HeaderText="Max Pounds Quota" SortExpression="Max_Pounds_Quota" DataFormatString="{0:n0}" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Additional Allocation" DataFormatString="{0:n0}" HeaderText="Additional Allocation"
                    SortExpression="Additional Allocation">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Pounds_Remaining" HeaderText="Pounds_Remaining" ReadOnly="True"
                    SortExpression="Pounds_Remaining" DataFormatString="{0:n0}" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="column2" />
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Gage - Width] AS column1, Pounds, [Max Pounds Quota] AS Max_Pounds_Quota, [Pounds Remaining] AS Pounds_Remaining, [Name-city] AS Destination, [Additional Allocation] FROM [Wise quota balance] WHERE (Start = @Start) AND ([Name-city] LIKE N'metal%') ORDER BY column1">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Start" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

