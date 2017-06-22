<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Consigned_Loads" Title="Consigned Inventory Deliveries" 
    CodeBehind="Consigned_Loads.aspx.cs" CodeFile="Consigned_Loads.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Consigned Inventory Loads</h3>
    Loads shipped by 3rd party for current User.<br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="Load_ID" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Shipment_Date" DataFormatString="{0:d}" HeaderText="Date"
                SortExpression="Shipment_Date" />
            <asp:BoundField DataField="PDF_File" HeaderText="Load PDF" HtmlEncode="False" ReadOnly="True"
                SortExpression="PDF_File" />
            <asp:BoundField DataField="Load_Type" HeaderText="Type" SortExpression="Type" />
            <asp:CheckBoxField DataField="LogOut" HeaderText="Shipped" SortExpression="LogOut" />
            <asp:BoundField DataField="Shipper" HeaderText="Shipper" ReadOnly="True" SortExpression="Shipper" />
            <asp:BoundField DataField="Receiver" HeaderText="Receiver" ReadOnly="True" SortExpression="Receiver" />
            <asp:CheckBoxField DataField="POD" HeaderText="POD Signed" SortExpression="POD" />
            <asp:HyperLinkField DataNavigateUrlFields="Tally Load" 
                DataNavigateUrlFormatString="tally_detail.aspx?Load_Ref={0}" 
                HeaderText="Tally Data" Text="Tally" />
            <asp:BoundField DataField="Age" HeaderText="Age" ReadOnly="True" SortExpression="Age" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT [Load ID] AS Load_ID, [Shipment Date] AS Shipment_Date, [Load Type] AS Load_Type, Shipper, Receiver, [PDF File] AS PDF_File, [PDF File Name] AS PDF_File_Name, Age, LogOut, POD, [Tally Load] FROM [COPS consigned BOLs] WHERE ([Auth Client ref] = @Auth_Client_ref) ORDER BY Shipment_Date DESC, Load_ID">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_Client_ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>