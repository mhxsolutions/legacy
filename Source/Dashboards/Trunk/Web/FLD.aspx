<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FLD.aspx.cs" Inherits="FLD" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>FDL Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td colspan="2">
                    <h3>
                    FDL Review</h3>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px" valign="top">
                    <span style="background-color: white"><a href="fld.aspx">FLD Review<br />
                    </a>
                        <br />
                        <strong>
                        O</strong></span><strong>ffice<br />
                        </strong>
                    <a href="fldcat.aspx">Category</a><br />
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
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="date"
                        DataTextField="FLD_Date" DataValueField="FLD_Date">
                    </asp:DropDownList><asp:SqlDataSource ID="date" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT DISTINCT [FLD Date] AS FLD_Date FROM [FLD1 Category totals] ORDER BY [FLD Date] DESC">
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    
                    <asp:SqlDataSource ID="cattotals" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT * FROM [FLD1 Category totals] WHERE ([FLD Date] = @FLD_Date) ORDER BY [FLD Category Index] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="cat"
                        DataTextField="FLD_Category" DataValueField="FLD_Category">
                    </asp:DropDownList><asp:SqlDataSource ID="cat" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT DISTINCT [FLD Category] AS FLD_Category, [FLD Category Index] AS FLD_Category_Index FROM [FLD1 Category totals] WHERE ([FLD Date] = @FLD_Date) ORDER BY [FLD Category Index]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    
                    <asp:SqlDataSource ID="catacttotals" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT * FROM [FLD7 Cat and Act Totals] WHERE (([FLD Date] = @FLD_Date) AND ([FLD Category] = @FLD_Category)) ORDER BY [FLD Activity Index] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="FLD_Category" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="act"
                        DataTextField="FLD_Activity" DataValueField="FLD_Activity">
                    </asp:DropDownList><asp:SqlDataSource ID="act" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT DISTINCT [FLD Activity] AS FLD_Activity, [FLD Activity Index] AS FLD_Activity_Index FROM [FLD7 Cat and Act Totals] WHERE (([FLD Date] = @FLD_Date) AND ([FLD Category] = @FLD_Category)) ORDER BY [FLD Activity Index]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="FLD_Category" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    
                    <asp:SqlDataSource ID="nametotals" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT * FROM [FLD4 Activity and Name totals] WHERE (([FLD Date] = @FLD_Date) AND ([FLD Category] = @FLD_Category) AND ([FLD Activity] = @FLD_Activity)) ORDER BY [Name] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="FLD_Date" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="FLD_Category" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList3" Name="FLD_Activity" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
