<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Vessel_Loads" Title="BudwayDirect | Loads by Vessel" CodeBehind="Vessel_Loads.aspx.cs" CodeFile="Vessel_Loads.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Loads by Vessel<br />
    </h3>
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Vessel" DataValueField="Vessel">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Vessel], [FFD], [LFD] FROM [COPSHarborLoadsByVessel] WHERE ([Ship Client Ref] = @Ship_Client_Ref) ORDER BY [Vessel]">
        <SelectParameters>
            <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
        <Columns>
            <asp:BoundField DataField="FFD" DataFormatString="{0:d}" HeaderText="FFD" HtmlEncode="False"
                SortExpression="FFD" />
            <asp:BoundField DataField="LFD" DataFormatString="{0:d}" HeaderText="LFD" HtmlEncode="False"
                SortExpression="LFD" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [FFD], [LFD] FROM [COPSHarborLoadsByVessel] WHERE (([Vessel] = @Vessel) AND ([Ship Client Ref] = @Ship_Client_Ref))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Vessel" PropertyName="SelectedValue"
                Type="String" />
            <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;<br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333"
        GridLines="None" PageSize="50">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False"
                SortExpression="Date" />
            <asp:BoundField DataField="DR" HeaderText="DR" SortExpression="DR" />
            <asp:BoundField DataField="column1" HeaderText="Load/PUR" SortExpression="column1" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
            <asp:BoundField DataField="PDF_File" HeaderText="PDF_File" HtmlEncode="False" ReadOnly="True"
                SortExpression="PDF_File" />
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DR, [Load/PUR] AS column1, [PDF File] AS PDF_File, Date, [Dest Client Ref], [Recv Client Ref], Destination FROM COPSHarborLoadsByVessel WHERE (Vessel = @Vessel) AND ([Ship Client Ref] = @Ship_Client_Ref) OR (Vessel = @Vessel) AND ([Dest Client Ref] = @Ship_Client_Ref) OR (Vessel = @Vessel) AND ([Recv Client Ref] = @Ship_Client_Ref) ORDER BY Date">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Vessel" PropertyName="SelectedValue"
                Type="String" />
            <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

