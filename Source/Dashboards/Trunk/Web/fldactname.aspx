<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fldactname.aspx.cs" Inherits="fldactname" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FLD Category Name</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span style="color: #0000ff; text-decoration: underline"></span>
            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                <tr>
                    <td colspan="2" style="height: 45px">
                        <h3>
            Activity and Rep Totals</h3>
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
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="FLD_Category" DataValueField="FLD_Category">
        </asp:DropDownList><br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [FLD Category] AS FLD_Category FROM [FLD4 Activity and Name totals] ORDER BY [FLD Category]">
        </asp:SqlDataSource>
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="Name" DataValueField="Name">
        </asp:DropDownList><br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Name] FROM [FLD4 Activity and Name totals] ORDER BY [Name]">
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [FLD4 Activity and Name totals] WHERE (([FLD Category] = @FLD_Category) AND ([Name] = @Name))">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Category" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Name" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <span style="color: #0000ff; text-decoration: underline"><a href="fld.aspx"></a></span>
                    </td>
                </tr>
            </table>
            <a href="activityrep.aspx"></a>
       
        </div>
    </form>
</body>
</html>
