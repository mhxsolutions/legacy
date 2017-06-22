<%@ Page AutoEventWireup="true" CodeFile="SearchInventoryAtFON.aspx.cs" Inherits="Customers__All_SearchInventoryAtFON" Language="C#" MasterPageFile="~/Main.master" Title="BudwayDirect | Search Fontana Inventory" %>

<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Inventory at Terminal</h2>
    <p>
        Search Item ID:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Customers/_All/SearchInventoryAtFON.aspx" Text="Search" />
    </p>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" Caption="Date Received" VisibleIndex="1" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Product Profile Description" Caption="Profile Description" VisibleIndex="2"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Group Label 1" Caption="Label 1" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 1" Caption="Product 1" VisibleIndex="4"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Group Label 2" Caption="Label 2" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 2" Caption="Product 2" VisibleIndex="6"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Group Label 3" Caption="Label 3" VisibleIndex="7"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 3" Caption="Product Group 3" VisibleIndex="8"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Item_ID" Caption="Item ID" VisibleIndex="9"></dx:GridViewDataTextColumn>
            <%--<dx:GridViewDataTextColumn FieldName="Weight" Caption="Weight" VisibleIndex="10"></dx:GridViewDataTextColumn>--%>
            <dx:GridViewDataTextColumn FieldName="Package Label" Caption="Package" VisibleIndex="11"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Count In Package" Caption="Count In Package" VisibleIndex="12"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1" />
    <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSfontanaInventory] WHERE (([Parent ref] = @Parent_ref) AND ([Item_ID] LIKE '%' + @Item_ID + '%'))">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="%" Name="Item_ID" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

