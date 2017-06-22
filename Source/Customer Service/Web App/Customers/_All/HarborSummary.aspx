<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_HarborSummary" 
    Title="BudwayDirect - Harbor Summary" CodeBehind="HarborSummary.aspx.cs" CodeFile="HarborSummary.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Harbor Projects Summary</h2>
    <p>
        Select Status:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="Status" DataValueField="Status">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Status] FROM [COPSharborSummaryStatus] ORDER BY [Status]">
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <RowStyle BackColor="White" Font-Size="Small" ForeColor="#330099" />
            <Columns>
                <asp:BoundField DataField="Start Project" DataFormatString="{0:d}" HeaderText="FFD"
                    HtmlEncode="False" SortExpression="Start Project" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" />
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
                <asp:BoundField DataField="Delivery Order" HeaderText="Delivery Order" SortExpression="Delivery Order" />
                <asp:BoundField DataField="Client Ref" HeaderText="Client Ref" SortExpression="Client Ref" />
                <asp:BoundField DataField="Ct Tendered" HeaderText="Ct Tendered" SortExpression="Ct Tendered" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Ct Recd" HeaderText="Ct Recd" SortExpression="Ct Recd" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Loads Received" HeaderText="Loads Received" SortExpression="Loads Received" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <EditRowStyle Font-Size="Small" />
            <AlternatingRowStyle Font-Size="Small" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT Client, [Start Project], Vessel, [Delivery Order], Destination, [Client Ref], [Ct Tendered], [Ct Recd], [Loads Received], Status, [Parent ref] FROM COPSharborSummaryStatus WHERE ([Parent ref] = @Parent_ref) AND (Status = @status_ref) ORDER BY [Start Project] DESC, Vessel, Destination">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="context_clientid" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="open" Name="status_ref"
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

