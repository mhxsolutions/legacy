<%@ Page Title="BudwayDirect | Inventory" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="inventoryatFON.aspx.cs" Inherits="Customers__All_inventoryatFON" %>

<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>
<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Inventory at Terminal</h2>

    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="InventoryAtFON" />


    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="2" Caption="Date Rcd" AdaptivePriority="2">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0" SortIndex="0" SortOrder="Ascending" AdaptivePriority="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="1" SortIndex="1" SortOrder="Ascending" AdaptivePriority="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 1" FieldName="Group Label 1" VisibleIndex="4" AdaptivePriority="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 1" FieldName="Product Group 1" VisibleIndex="5" AdaptivePriority="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 2" FieldName="Group Label 2" VisibleIndex="6" AdaptivePriority="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 2" FieldName="Product Group 2" VisibleIndex="7" AdaptivePriority="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 3" FieldName="Group Label 3" VisibleIndex="8" AdaptivePriority="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 3" FieldName="Product Group 3" VisibleIndex="9" AdaptivePriority="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" VisibleIndex="12" AdaptivePriority="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Unit" FieldName="Weight Label" VisibleIndex="13" AdaptivePriority="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Weight" FieldName="weight" VisibleIndex="14" AdaptivePriority="1">
                <PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pkg Type" FieldName="Package Label" VisibleIndex="16" AdaptivePriority="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pcs" FieldName="Count In Package" VisibleIndex="17" AdaptivePriority="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Rerceiver" FieldName="Receiver ID" ReadOnly="True" VisibleIndex="18" AdaptivePriority="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="19" AdaptivePriority="5">
                <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime"></PropertiesDateEdit>
                <CellStyle Wrap="False"></CellStyle>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Pkg Ct" FieldName="Items" VisibleIndex="3" AdaptivePriority="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NetWeight" VisibleIndex="15" AdaptivePriority="5">
                <PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 4" FieldName="Product Group 4" VisibleIndex="10" AdaptivePriority="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 5" FieldName="Product Group 5" VisibleIndex="11" AdaptivePriority="3"></dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="True">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" VerticalScrollBarMode="Visible" VerticalScrollableHeight="400" />
        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="2"></SettingsAdaptivity>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSfontanaInventory] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl1" GridViewID="ASPxGridView1" />

    <%--    <table>
        <tr>
            <td>Layout: </td>
            <td>
                <dx:ASPxComboBox ID="cmbLayout" runat="server" DropDownStyle="DropDown" ValueType="System.String">
                    <ValidationSettings RequiredField-IsRequired="true" CausesValidation="true" ValidationGroup="LoadSaveLayout" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip"></ValidationSettings>
                </dx:ASPxComboBox>
            </td>
            <td>
                <dx:ASPxButton ID="btnLoadLayout" runat="server" OnClick="btnLoadLayout_Click" Text="Load" ValidationGroup="LoadSaveLayout"></dx:ASPxButton>
            </td>
            <td>
                <dx:ASPxButton ID="btnSaveLayout" runat="server" OnClick="btnSaveLayout_Click" Text="Save" ValidationGroup="LoadSaveLayout"></dx:ASPxButton>
            </td>
        </tr>
    </table>--%>
    <br />
    <br />
    <br />
</asp:Content>


