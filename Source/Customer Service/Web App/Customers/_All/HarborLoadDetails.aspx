<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_HarborLoadDetails" 
    Title="BudwayDirect - Harbor Load Detail" CodeBehind="HarborLoadDetails.aspx.cs" CodeFile="HarborLoadDetails.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Driver Notes on Loads</h3>
    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
        DataTextField="Plan_Date" DataValueField="Plan_Date">
    </asp:DropDownList>
    Select Plan Date<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [COPS planned del with Harbor Data] ORDER BY [Plan Date]">
    </asp:SqlDataSource>
    &nbsp;&nbsp;
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="20" 
        DataKeyNames="Pdid" >
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

            <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" ReadOnly="True" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" ReadOnly="True" />
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" ReadOnly="True" />
            <asp:BoundField DataField="Stop" HeaderText="Stop" SortExpression="Stop" ReadOnly="True" />
            <asp:BoundField DataField="Sch_Arrive" HeaderText="Sch_Arrive" SortExpression="Sch_Arrive" DataFormatString="{0:t}" HtmlEncode="False" ReadOnly="True" />
            <asp:BoundField DataField="Load_Ct" HeaderText="Load_Ct" SortExpression="Load_Ct" ReadOnly="True" />
            <asp:BoundField DataField="Load_Wt" DataFormatString="{0:n0}" HeaderText="Load_Wt" HtmlEncode="False" SortExpression="Load_Wt" ReadOnly="True" />
            <asp:BoundField DataField="BL1" HeaderText="Desc" SortExpression="BL1" ReadOnly="True" />
            <asp:BoundField DataField="BL2" HeaderText="Desc 2" SortExpression="BL2" ReadOnly="True" />
            <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" ReadOnly="True" />
            <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" ReadOnly="True" />
            <asp:BoundField DataField="Client Number" HeaderText="Client Number" SortExpression="Client Number" ReadOnly="True" />
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load], Origin, Action, Stop, [Sch Arrive] AS Sch_Arrive, [Load Ct] AS Load_Ct, [Load Wt] AS Load_Wt, BL1, BL2, Unit, Vessel, [Plan Date], Pdid, Notes, [PMBOL Client Number] AS [Client Number], [Parent ref], [origin ref] FROM [COPS planned del with Harbor Data] WHERE ([destination ref] = @destination_ref) AND ([Plan Date] = @sel_date) OR ([Plan Date] = @sel_date) AND ([Parent ref] = @destination_ref) OR ([Plan Date] = @sel_date) AND ([origin ref] = @destination_ref) ORDER BY Sch_Arrive"
        UpdateCommand="UPDATE [Planner Detail] SET [Client Notes] = @Notes WHERE [Planner Detail ID] = @Pdid">
        <SelectParameters>
            <asp:SessionParameter Name="destination_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="sel_date" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Pdid" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
