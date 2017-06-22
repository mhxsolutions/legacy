<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_boxinfo" Title="Box Info" 
    CodeBehind="boxinfo.aspx.cs" CodeFile="boxinfo.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Container List<br />
    </h3>
    Select Booking:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Booking_Id" DataValueField="Booking_Id">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Booking Id] AS Booking_Id FROM [Container Detail] WHERE ([Bill To Client Ref] = @Bill_To_Client_Ref) ORDER BY [Booking Id]">
        <SelectParameters>
            <asp:SessionParameter Name="Bill_To_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the excel" />
    <br />
    &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="Container_Id,Location" DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="Booking_Id" HeaderText="Booking_Id" SortExpression="Booking_Id" />
            <asp:BoundField DataField="Container_Id" HeaderText="Container_Id" ReadOnly="True"
                SortExpression="Container_Id" />
            <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="True" SortExpression="Location" />
            <asp:BoundField DataField="Location_Date" DataFormatString="{0:d}" HeaderText="Location_Date"
                SortExpression="Location_Date" />
            <asp:BoundField DataField="Seal_Id" HeaderText="Seal_Id" SortExpression="Seal_Id" />
            <asp:BoundField DataField="Test_Id" HeaderText="Test_Id" SortExpression="Test_Id" />
            <asp:BoundField DataField="Belt_Net_Wt" HeaderText="Net_Wt" SortExpression="Belt_Net_Wt" />
        </Columns>
    </asp:GridView>
    <dx:ASPxGridViewExporter ID="BoxInfoExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Booking Id] AS Booking_Id, [Container Id] AS Container_Id, [Location], [Location Date] AS Location_Date, [Seal Id] AS Seal_Id, [Test Id] AS Test_Id, [Belt Net Wt] AS Belt_Net_Wt FROM [Container Detail] WHERE ([Booking Id] = @Booking_Id) ORDER BY [Container Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Booking_Id" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Booking_Id" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Container_Id" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Location" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Location_Date" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Seal_Id" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Test_Id" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Net Wt" FieldName="Belt_Net_Wt" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <br />
</asp:Content>

