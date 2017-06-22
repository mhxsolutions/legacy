<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rail.aspx.vb" Inherits="rail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail to Container</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Match Rail to Containers</h3>
    
    </div>
    <p>
        Select Railcar:<asp:DropDownList ID="DropDownList1" runat="server" 
            AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Railcar_Ref" 
            DataValueField="Railcar_Ref">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Railcar Ref] AS Railcar_Ref FROM [CPS rail to container] ORDER BY [Railcar Ref]">
        </asp:SqlDataSource>
    </p>
    <p>
        The following containers can be loaded from the selected railcar.</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Container_Id" 
            DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="Container_Id" HeaderText="Container" ReadOnly="True" 
                    SortExpression="Container_Id" />
                <asp:BoundField DataField="Booking_Id" HeaderText="Booking" 
                    SortExpression="Booking_Id" />
                <asp:BoundField DataField="Remaining_Hours" HeaderText="Remaining Hours" 
                    ReadOnly="True" SortExpression="Remaining_Hours">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Container Id] AS Container_Id, [Booking Id] AS Booking_Id, [Remaining Hours] AS Remaining_Hours FROM [CPS rail to container] WHERE ([Railcar Ref] = @Railcar_Ref)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Railcar_Ref" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    </form>
<p>
    &nbsp;</p>
</body>
</html>
