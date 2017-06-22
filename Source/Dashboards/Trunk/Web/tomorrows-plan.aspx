<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tomorrows-plan.aspx.cs" Inherits="tomorrows_plan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="refresh" content="180" />
    <title>Tomorrow's Plan</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Load Rev by Driver by day DLV no service Nex Days Plan Summary]">
        </asp:SqlDataSource>
        <h3>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                </Columns>
            </asp:GridView>
            &nbsp;</h3>
    
    </div>
    </form>
</body>
</html>
