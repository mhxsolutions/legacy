<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fldcatactname.aspx.cs" Inherits="fldcatactname" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Category: Activity</title>
</head>
<body style="font-family: Times New Roman">
    <form id="form1" runat="server">
    <div>
        
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                <tr>
                    <td colspan="2" style="height: 45px">
                        <h3>
                            Category - Activity - Name</h3>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px" valign="top">
                        <span style="background-color: white"><a href="fld.aspx">
                            FLD Review<br />
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
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="catact" DataValueField="catact">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [catact], [FLD Activity Index] AS FLD_Activity_Index, [FLD Category Index] AS FLD_Category_Index FROM [FLD5 Catagory Activity Name Totals] ORDER BY [FLD Category Index], [FLD Activity Index]">
        </asp:SqlDataSource>
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="FLD_Date" DataValueField="FLD_Date">
        </asp:DropDownList><br />
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [FLD Date] AS FLD_Date FROM [FLD5 Catagory Activity Name Totals] ORDER BY [FLD Date] DESC">
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [FLD5 Catagory Activity Name Totals] WHERE (([FLD Date] = @FLD_Date) AND ([catact] = @catact)) ORDER BY [Name]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="FLD_Date" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList1" Name="catact" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        
        <br />
        <br />
        <br />
        &nbsp;<br />
        <br />
        <a href="activityrep.aspx"></a>
    </div>
    </form>
</body>
</html>
