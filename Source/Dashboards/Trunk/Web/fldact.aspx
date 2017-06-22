<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fldact.aspx.cs" Inherits="fldact" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FLD Activity Totals</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
            <tr>
                <td colspan="2" style="height: 45px">
                    <h3>
                        Activity Totals</h3>
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
                    &nbsp;<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
            DataTextField="FLD_Date" DataValueField="FLD_Date">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [FLD Date] AS FLD_Date FROM [FLD3 Activity Totals] ORDER BY [FLD Date] DESC">
        </asp:SqlDataSource>
        <br />
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [FLD Date], [FLD Activity], Goal, catact, Actual, [FLD Category Index], [FLD Activity Index] FROM [FLD3 Activity Totals] WHERE ([FLD Date] = @FLD_Date) ORDER BY [FLD Category Index] DESC, [FLD Activity Index] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="FLD_Date" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <a href="activityrep.aspx"></a></div>
    </form>
</body>
</html>
