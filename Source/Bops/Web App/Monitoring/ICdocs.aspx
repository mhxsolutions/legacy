<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Monitoring_ICdocs" Title="Untitled Page" Codebehind="ICdocs.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Independent Contractors Documents Report<br />
    </h3>
    ICs used on given month that need documentation.<br />
    Month:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Month" DataValueField="Month">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Month] FROM [Sub Haul Requirements] ORDER BY [Month] DESC">
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
            <asp:BoundField DataField="DOT-ICA Number" HeaderText="DOT-ICA Number" SortExpression="DOT-ICA Number" />
            <asp:CheckBoxField DataField="DOT-ICA checked" HeaderText="DOT-ICA checked" SortExpression="DOT-ICA checked">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="IC Agreement" HeaderText="IC Agreement" SortExpression="IC Agreement">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="W9 Form" HeaderText="W9 Form" SortExpression="W9 Form">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="CDL" HeaderText="CDL" SortExpression="CDL">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="CDL Expiration" DataFormatString="{0:d}" HeaderText="CDL Expiration"
                SortExpression="CDL Expiration" />
            <asp:CheckBoxField DataField="CA Resident" HeaderText="CA Resident" SortExpression="CA Resident">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="Insurance Cert" HeaderText="Insurance Cert" SortExpression="Insurance Cert">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:CheckBoxField DataField="Named Ins" HeaderText="Named Ins" SortExpression="Named Ins">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="Ins Cert Expiration" DataFormatString="{0:d}" HeaderText="Ins Cert Expiration"
                SortExpression="Ins Cert Expiration" />
            <asp:BoundField DataField="Auto Coverage" DataFormatString="{0:c0}" HeaderText="Auto Coverage"
                SortExpression="Auto Coverage">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Cargo Coverage" DataFormatString="{0:c0}" HeaderText="Cargo Coverage"
                SortExpression="Cargo Coverage">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Sub Haul Requirements] WHERE ([Month] = @Month)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Month" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

