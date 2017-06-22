<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" CodeFile="Rev.aspx.cs" Inherits="Rev" Title="Operations Revenue Performance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 599px; height: 433px; background-color: black;">
        <tr>
            <td style="width: 48px;" rowspan="2" valign="bottom">
                
            </td>
            <td style="height: 6px; width: 115px;" valign="bottom">
                
            </td>
            <td style="width: 77px; height: 247px" rowspan="2" valign="middle">
                
            </td>
            <td style="width: 77px; height: 6px" valign="bottom">
                
            </td>
            <td rowspan="2" style="width: 87px" valign="bottom">
                
            </td>
        </tr>
        <tr>
            <td style="width: 115px; height: 195px" valign="top">
                
            </td>
            <td style="width: 77px; height: 195px" valign="top">
                
            </td>
        </tr>
        <tr>
            <td rowspan="1" style="width: 48px; height: 99px" valign="bottom">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" BackColor="Black"
                    DataSourceID="months" DataTextField="Month" DataValueField="Month" ForeColor="White">
                </asp:DropDownList><asp:SqlDataSource ID="months" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT DISTINCT [Month] FROM [DataMart of Monthly Thruput- Revenue- Time and Driver data] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" BackColor="Black"
                    DataSourceID="SqlDataSource5" DataTextField="Year" DataValueField="Year" ForeColor="White">
                </asp:DropDownList></td>
            <td align="center" colspan="3" rowspan="1" style="height: 99px" valign="top">
                
            </td>
        </tr>
        <tr>
        </tr>
    </table>
    &nbsp;&nbsp;
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [DataMart of Monthly Thruput- Revenue- Time and Driver data] WHERE (([Year] = @Year2) AND ([Month] = @Month)) ORDER BY [Year] DESC, [Month] DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="2008" Name="Year2"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="12" Name="Month" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Year] FROM [DataMart of Monthly Thruput- Revenue- Time and Driver data] ORDER BY [Year] DESC">
    </asp:SqlDataSource>
</asp:Content>

