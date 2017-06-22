<%@ Page Title="MHX | Inventory" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="inventoryatFON.aspx.cs" Inherits="Customers__All_inventoryatFON" %>

<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>
<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Inventory at Terminal</h2>

    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="InventoryAtFON" />


    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ReceiverID" Width="98%">
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
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0" SortIndex="0" SortOrder="Ascending" AdaptivePriority="2" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="1" SortIndex="1" SortOrder="Ascending" AdaptivePriority="2" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="2" Caption="Date Rcd" AdaptivePriority="2" ReadOnly="true" EditFormSettings-Visible="False">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Pkg Ct" FieldName="Items" VisibleIndex="3" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 1" FieldName="Group Label 1" VisibleIndex="4" AdaptivePriority="3" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 1" FieldName="Product Group 1" VisibleIndex="5" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 2" FieldName="Group Label 2" VisibleIndex="6" AdaptivePriority="3" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 2" FieldName="Product Group 2" VisibleIndex="7" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 3" FieldName="Group Label 3" VisibleIndex="8" AdaptivePriority="3" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 3" FieldName="Product Group 3" VisibleIndex="9" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 4" FieldName="Product Group 4" VisibleIndex="10" AdaptivePriority="3" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Data 5" FieldName="Product Group 5" VisibleIndex="11" AdaptivePriority="3" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" VisibleIndex="12" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Unit" FieldName="Weight Label" VisibleIndex="13" AdaptivePriority="4" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Weight" FieldName="weight" VisibleIndex="14" AdaptivePriority="1" ReadOnly="true" EditFormSettings-Visible="False">
                <PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NetWeight" VisibleIndex="15" AdaptivePriority="5" ReadOnly="true" EditFormSettings-Visible="False">
                <PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pkg Type" FieldName="Package Label" VisibleIndex="16" AdaptivePriority="4" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pcs" FieldName="Count In Package" VisibleIndex="17" AdaptivePriority="4" ReadOnly="true" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Rerceiver" FieldName="ReceiverID" ReadOnly="True" VisibleIndex="18" AdaptivePriority="5" EditFormSettings-Visible="False"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="19" AdaptivePriority="5" EditFormSettings-Visible="False">
                <PropertiesDateEdit DisplayFormatString="" EditFormat="DateTime"></PropertiesDateEdit>
                <CellStyle Wrap="False"></CellStyle>
            </dx:GridViewDataDateColumn>
<dx:GridViewDataCheckColumn Caption="Client Processed" FieldName="Client_A" VisibleIndex="20"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn Caption="Client Note" FieldName="Client_Note" VisibleIndex="21"></dx:GridViewDataTextColumn>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="22"></dx:GridViewCommandColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="Client_A = 1" FieldName="Client_A" Format="GreenFillWithDarkGreenText"></dx:GridViewFormatConditionHighlight>
        </FormatConditions>

        <SettingsContextMenu Enabled="True" EnableRowMenu="True">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" VerticalScrollableHeight="400" />
        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" AdaptiveDetailColumnCount="2"></SettingsAdaptivity>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT *,[Receiver ID] as ReceiverID FROM [COPS_detail_inv] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref)"
        UpdateCommand="update [Inventory Detail] Set Client_A=@Client_A, Client_Note=@Client_Note where [Receiver Ref]=@ReceiverID">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Client_A" />
            <asp:Parameter Name="Client_Note" />
            <asp:Parameter Name="ReceiverID" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <br />
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


