<%@ Page Title="Receiving History" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Customers__All_Receiving" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Receiving History</h2>
    <div class="contentDiv">
        <table>
            <tr>
                <td align="left" style="width: 100px" valign="top">
                    <strong>Start Date</strong></td>
                <td align="left" style="width: 100px" valign="top">
                    <strong>End Date</strong></td>
            </tr>
            <tr>
                <td style="padding: 5px">
                    <dx:ASPxDateEdit ID="deStart" ClientInstanceName="deStart" runat="server" AutoPostBack="true" Width="90">
                        <ClientSideEvents DateChanged="UpdateInfo"></ClientSideEvents>
                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="True" ErrorText="Start date is required"></RequiredField>
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
                <td style="padding: 5px">
                    <dx:ASPxDateEdit ID="deEnd" ClientInstanceName="deEnd" runat="server" AutoPostBack="true" Width="90">
                        <DateRangeSettings StartDateEditID="deStart"></DateRangeSettings>
                        <ClientSideEvents DateChanged="UpdateInfo"></ClientSideEvents>
                        <ValidationSettings Display="Dynamic" SetFocusOnError="True" CausesValidation="True" ErrorDisplayMode="ImageWithTooltip">
                            <RequiredField IsRequired="True" ErrorText="End date is required"></RequiredField>
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </td>
            </tr>
        </table>
    </div>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="Receiving" />

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
            <dx:GridViewDataTextColumn FieldName="Receiver_ID" Caption="Receiver" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date_Received" Caption="Date Received" VisibleIndex="4" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_1" Caption="Label 1" VisibleIndex="6"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group_1" Caption="Group 1" VisibleIndex="7"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Label_2" Caption="Label 2" VisibleIndex="8"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group_2" Caption="Group 2" VisibleIndex="9"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Label_3" Caption="Label 3" VisibleIndex="10"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group_3" Caption="Group 3" VisibleIndex="11"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Item_ID" Caption="Item ID" VisibleIndex="12"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Extended_Description" Caption="Ext Desc" VisibleIndex="12"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="LnFt" Caption="Footage" VisibleIndex="5" PropertiesTextEdit-DisplayFormatString="{0:f1}"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct_in_Pkg" Caption="Pcs" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" Caption="Pounds" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pkg" Caption="Units" VisibleIndex="5"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Terminal], [Receiver ID] AS Receiver_ID, [Type], [Date Received] AS Date_Received, [Profile], [Label 1] AS Label_1, [Group 1] AS Group_1, [Label 2] AS Label_2, [Group 2] AS Group_2, [Label 3] AS Label_3, [Group 3] AS Group_3, [Item ID] AS Item_ID, [Ct in Pkg] AS Ct_in_Pkg, [Pounds], [Pkg], [Carrier], [Extended Description] AS Extended_Description, [LnFt] FROM [Receivers semi summarized] WHERE (([client] = @client) AND ([Date Received] >= @Date_Received) AND ([Date Received] <= @Date_Received2)) ORDER BY [Terminal], [Receiver ID], [Group 1]">
        <SelectParameters>
            <asp:SessionParameter Name="client" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="deStart" DbType="DateTime" Name="Date_Received" PropertyName="Date" />
            <asp:ControlParameter ControlID="deEnd" DbType="DateTime" Name="Date_Received2" PropertyName="Date" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>

