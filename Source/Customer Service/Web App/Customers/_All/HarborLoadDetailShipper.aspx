<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_HarborLoadDetailShipper" 
    Title="BudwayDirect - Harbor Load Detail" CodeBehind="HarborLoadDetailShipper.aspx.cs" CodeFile="HarborLoadDetailShipper.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Monitor Pending and Current Harbor Load Details</h3>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" DataKeyNames="Pdid" >
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <Columns>
            
                <asp:CommandField ShowEditButton="True" />
                <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                    <EditItemTemplate>
                        <asp:TextBox ID="NotesTextbox" runat="server" MaxLength="49" Text='<%# Bind("Notes") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="NotesLabel" runat="server" Text='<%# Bind("Notes") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" ReadOnly="true" />
                <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" ReadOnly="true" />
                <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" ReadOnly="true" />
                <asp:BoundField DataField="Stop" HeaderText="Stop" SortExpression="Stop" ReadOnly="true" />
                <asp:BoundField DataField="Sch_Arrive" HeaderText="Sch_Arrive" SortExpression="Sch_Arrive" ReadOnly="true" />
                <asp:BoundField DataField="Load_Ct" HeaderText="Load_Ct" SortExpression="Load_Ct" ReadOnly="true" />
                <asp:BoundField DataField="Load_Wt" DataFormatString="{0:f0}" HeaderText="Load_Wt" HtmlEncode="False" SortExpression="Load_Wt" ReadOnly="true" />
                <asp:BoundField DataField="BL1" HeaderText="Desc" SortExpression="BL1" ReadOnly="true" />
                <asp:BoundField DataField="BL2" HeaderText="Desc 2" SortExpression="BL2" ReadOnly="true" />
                <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" ReadOnly="true" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" ReadOnly="true" />
            </Columns>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Load], [Origin], [Action], [Stop], [Sch Arrive] AS Sch_Arrive, [Load Ct] AS Load_Ct, [Load Wt] AS Load_Wt, [BL1], [BL2], [Unit], [Vessel], [Pdid], [Notes] FROM [COPS planned del with Harbor Data] WHERE ([Parent ref] = @Parent_ref) ORDER BY [Sch Arrive]" 
            UpdateCommand="UPDATE [Planner Detail] SET [Client Notes] = @Notes WHERE [Planner Detail ID] = @Pdid">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="context_clientid" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Pdid" Type="Int32" />
                <asp:Parameter Name="Notes" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

