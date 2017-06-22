<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportAllDr.aspx.cs" Inherits="Mobile_ReportAllDr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Harbor Web | Report All DR</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>Report All DR</h2>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="DRID" DataSourceID="DrDatasource"
            ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="DRID" DataNavigateUrlFormatString="Default.aspx?DrId={0}" DataTextField="DRID"
                    HeaderText="DR" SortExpression="DRID" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Count" HeaderText="CT" SortExpression="Count" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Weight" HeaderText="WT" SortExpression="Weight" DataFormatString="{0:f0}" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Gate Pass" HeaderText="Gate" SortExpression="Gate Pass" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Load Ref" HeaderText="PUR" SortExpression="Load Ref" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Tractor" HeaderText="Tractor" SortExpression="Tractor" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Finalized" HeaderText="Final" SortExpression="Finalized" >
                    <HeaderStyle VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Last Update Time" HeaderText="Last Update" SortExpression="Last Update Time" 
                    HtmlEncode="False" DataFormatString="{0:MM-dd HH:mm}" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
            No DRs have been entered.
            </EmptyDataTemplate>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="DrDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep Data ConnectionString %>"
            SelectCommand="SELECT DRID, Count, Weight, [Last Update Time], Finalized, [Gate Pass], [Load Ref], Tractor FROM [Hops DR Entry]"></asp:SqlDataSource>
        
        <p>
            <a href="default.aspx">Home</a> | <a href="ReportTodayDr.aspx">Report Today</a> | <a href="ReportAllDr.aspx">Report All</a><br /><br />
        </p>
    </div>
    </form>
</body>
</html>
