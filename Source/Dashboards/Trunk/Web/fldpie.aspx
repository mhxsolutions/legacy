<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fldpie.aspx.cs" Inherits="fldpie" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FLD Pies</title>
</head>
<body>
    <form id="form1" runat="server">
    <div><span style="color: #0000ff; text-decoration: underline"></span>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
            <tr>
                <td colspan="2" style="height: 45px">
                    <h3>
            Goal to Actual</h3>
                </td>
            </tr>
            <tr>
                <td style="width: 150px" valign="top">
                    <span style="background-color: white"><a href="fld.aspx">FLD Review<br />
                    </a>
                        <br />
                        <strong>O</strong></span><strong>ffice<br />
                        </strong><a href="fldcat.aspx">Category</a><br />
                    <a href="fldact.aspx">Activities</a><br />
                    <a href="fldpie.aspx">Activity Pie</a><br />
                    <br />
                    <strong>
        Compare Reps</strong><br />
                    <a href="fldcatname.aspx">Category - Reps</a><br />
                    <a href="fldcatactname.aspx">Activity - Reps</a><br />
                    <br />
                    <strong>
        Rep Performance</strong><br />
                    <a href="activityrep.aspx">Rep Activity Totals</a></td>
                <td>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="FLD_Date" DataValueField="FLD_Date">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [FLD Date] AS FLD_Date FROM [FLD3 Activity Totals] ORDER BY FLD_Date DESC">
        </asp:SqlDataSource>
        <br />
        
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [FLD Date], [FLD Category], Goal, Actual, [FLD Category Index] FROM [FLD1 Category totals] WHERE ([FLD Date] = @FLD_Date) AND ([FLD Category] <> N'revenue') ORDER BY [FLD Category Index]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <br />
        <br />
        <span style="color: #0000ff; text-decoration: underline"><a href="fld.aspx"></a></span>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
