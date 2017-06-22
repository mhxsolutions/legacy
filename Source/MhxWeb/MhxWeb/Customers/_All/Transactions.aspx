<%@ Page AutoEventWireup="true" CodeFile="Transactions.aspx.cs" Inherits="Customers__All_Transactions" Language="C#" MasterPageFile="~/Main.master" Title="Transaction Log" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Transaction Log</h2>
    <br />
    <div class="contentDiv">
        <table>
            <tr>
                <td style="width: 50px">Profile:</td>
                <td>
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                        DataTextField="Profile" DataValueField="Profile">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td>Item:</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                        DataTextField="sort" DataValueField="sort">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT Profile, [Client ref] FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @CID) ORDER BY Profile">
            <SelectParameters>
                <asp:SessionParameter Name="CID" SessionField="context_clientid" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT sort FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @Client_ref) AND (Profile = @Profile_1) ORDER BY sort">
            <SelectParameters>
                <asp:SessionParameter Name="Client_ref" SessionField="context_clientid" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Profile_1" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <p>
            <i>(Reporting delayed by 20 minutes)</i></p>
    </div>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="Transactions" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server"  AutoGenerateColumns="False" Width="98%"  DataSourceID="SqlDataSource2" KeyFieldName="RowNo" OnCustomUnboundColumnData="ASPxGridView1_CustomUnboundColumnData" >
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True">
        </Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True">
        </SettingsSearchPanel>
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False">
        </SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date" PropertiesDateEdit-DisplayFormatString="{0:d}" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Group_1" Caption="Group 1" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group_2" Caption="Group 2" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group_3" Caption="Group 3" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item_Ct_In" Caption="Count In" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item_Ct_Out" Caption="Count Out" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataColumn UnboundType="Integer" FieldName="CtBalance" Caption="Ct Balance" VisibleIndex="7" Settings-AllowSort="False">
            </dx:GridViewDataColumn>
            <dx:GridViewDataTextColumn FieldName="Linear Ft In" Caption="Footage In" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Linear Ft Out" Caption="Footage Out" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataColumn UnboundType="Integer" FieldName="FtBalance" Caption="Ft Balance" VisibleIndex="10" Settings-AllowSort="False">
            </dx:GridViewDataColumn>
            <dx:GridViewDataTextColumn FieldName="RowNo" Caption="No" VisibleIndex="11" Width="20" Visible="false">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT ROW_NUMBER() over (ORDER BY Date, Terminal, sort) as RowNo, Terminal, Date, [Group 1] AS Group_1, [Group 2] AS Group_2, [Group 3] AS Group_3, [Item Ct In] AS Item_Ct_In, [Item Ct Out] AS Item_Ct_Out, Profile, [Linear Ft In], [Linear Ft Out], 0 AS Count_Total, 0 AS Feet_Total, sort FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @Client_ref) AND (Profile = @Profile_1) AND (sort = @sort) ORDER BY Date, Terminal, sort">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Profile_1" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList1" Name="sort" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

