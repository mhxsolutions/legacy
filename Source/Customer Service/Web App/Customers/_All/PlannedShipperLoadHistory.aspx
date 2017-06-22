<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_PlannedShipperLoadHistory" 
    Title="BudwayDirect | Planned Load History" CodeBehind="PlannedShipperLoadHistory.aspx.cs" CodeFile="PlannedShipperLoadHistory.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Planned and will-call
        Load History 
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Font-Bold="True"
            Font-Names="Times New Roman" Font-Size="16pt">
            <asp:ListItem Value="10">10 Days</asp:ListItem>
            <asp:ListItem Selected="True" Value="30">30 Days</asp:ListItem>
            <asp:ListItem Value="60">60 Days</asp:ListItem>
            <asp:ListItem Value="90">90 Days</asp:ListItem>
            <asp:ListItem Value="120">120 Days</asp:ListItem>
            <asp:ListItem Value="150">150 Days</asp:ListItem>
        </asp:DropDownList></h2>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None"
        BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" PageSize="100">
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <RowStyle BackColor="White" ForeColor="#330099" Font-Size="Small" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Load" DataNavigateUrlFormatString="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}"
                DataTextField="Load" HeaderText="Load" Text="LoadTrack" >
                <HeaderStyle Font-Underline="True" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date"
                HtmlEncode="False" SortExpression="Plan Date" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
            <asp:BoundField DataField="Arrive" DataFormatString="{0:t}" HeaderText="Arrive" SortExpression="Arrive" />
            <asp:BoundField DataField="Final Destination" HeaderText="Final Destination" SortExpression="Final Destination" />
            <asp:BoundField DataField="PDF File" HeaderText="PDF File" HtmlEncode="False" SortExpression="PDF File" />
            <asp:BoundField DataField="age" HeaderText="Age" SortExpression="age" />
        </Columns>
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load], [Plan Date], Origin, Action, Arrive, Stop, [Sch Arrive], [Final Destination], Shipper, [PDF File], [Shipper Ref], [Dest ref], [Receiver ref], [PDF File Name], age, [Origin ref] FROM COPSLoadPlanHistory WHERE ([Shipper Ref] = @Shipper_Ref) AND (age <= @age_sel) OR (age <= @age_sel) AND ([Dest ref] = @Shipper_Ref) OR (age <= @age_sel) AND ([Receiver ref] = @Shipper_Ref) OR (age <= @age_sel) AND ([Origin ref] = @Shipper_Ref) ORDER BY [Plan Date], [Load]">
        <SelectParameters>
            <asp:SessionParameter Name="Shipper_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="30" Name="age_sel"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    Planned Date = Delivery Date when Action is Delivery
</asp:Content>

