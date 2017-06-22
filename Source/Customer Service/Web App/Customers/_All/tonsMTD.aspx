<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="tonsMTD" Title="BudwayDirect | Tons MTD" CodeBehind="tonsMTD.aspx.cs" CodeFile="tonsMTD.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
    Tons Shipped MTD</h3>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Visible="False">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
            <asp:BoundField DataField="Final_Destination" HeaderText="Destination" SortExpression="Final_Destination" />
            <asp:BoundField DataField="Load_Ct" HeaderText="Load Ct" SortExpression="Load_Ct" />
            <asp:BoundField DataField="Tons_Delivered_MTD" DataFormatString="{0:f1}" HeaderText="Tons MTD"
                SortExpression="Tons_Delivered_MTD" />
            <asp:BoundField DataField="Avg_Ton_per_Load" DataFormatString="{0:f1}" HeaderText="Avg Ton per Load"
                HtmlEncode="False" ReadOnly="True" SortExpression="Avg_Ton_per_Load" />
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Month, [Final Destination] AS Final_Destination, [Load Ct] AS Load_Ct, [Tons Delivered MTD] AS Tons_Delivered_MTD, [Avg Ton per Load] AS Avg_Ton_per_Load FROM [COPS tons del mtd] WHERE ([Shipper Ref] = @Shipper_Ref) OR ([Dest ref] = @Shipper_Ref) ORDER BY Final_Destination">
        <SelectParameters>
            <asp:SessionParameter Name="Shipper_Ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" FieldName="Final_Destination" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Load Ct MTD" FieldName="Load_Ct" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tons MTD" FieldName="Tons_Delivered_MTD" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Avg Tons per Load" FieldName="Avg_Ton_per_Load" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Shipper" FieldName="Shipper" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Load Ct MTD" FieldName="Loads_MTD" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tons MTD" FieldName="Tons_MTD" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Avg Tons per Load" FieldName="Avg_Ton_per_Load" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" Visible="False">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
            <asp:BoundField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper" />
            <asp:BoundField DataField="Loads_MTD" HeaderText="Loads MTD" SortExpression="Loads_MTD">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Tons_MTD" DataFormatString="{0:f1}" HeaderText="Tons MTD"
                HtmlEncode="False" SortExpression="Tons_MTD">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Avg_Ton_per_Load" DataFormatString="{0:f1}" HeaderText="Avg Ton per Load"
                HtmlEncode="False" ReadOnly="True" SortExpression="Avg_Ton_per_Load">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Month], [Shipper], [Loads MTD] AS Loads_MTD, [Tons MTD] AS Tons_MTD, [Avg Ton per Load] AS Avg_Ton_per_Load FROM [COPS tons del mtd summary by client] WHERE ([Shipper Ref] = @Shipper_Ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Shipper_Ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

