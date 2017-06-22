<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="LoginHistory.aspx.cs" Inherits="Power_Users_LoginHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        function UpdateInfo() {
            var daysTotal = deEnd.GetRangeDayCount();
            tbInfo.SetText(daysTotal !== -1 ? daysTotal + ' days' : '');
        }
    </script>
    <h2>Login History</h2>
    <div class="contentDiv">
        <table>
            <tr>
                <td style="padding-left: 5px">Start Date:</td>
                <td style="padding-left: 5px">End Date: </td>
                <td style="padding-left: 5px">Days:</td>
                <td style="padding-left: 5px">User Role:</td>
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
                <td style="padding: 5px">
                    <dx:ASPxTextBox ID="tbInfo" ClientInstanceName="tbInfo" runat="server" ReadOnly="True" Width="40">
                    </dx:ASPxTextBox>
                </td>
                <td style="padding: 5px">
                    <dx:ASPxComboBox ID="cmbUserRole" runat="server" ValueType="System.String" DropDownStyle="DropDownList" AutoPostBack="true" Width="100"></dx:ASPxComboBox>
                </td>
            </tr>
        </table>

        <dx:ASPxGridView ID="gvLoginHistory" runat="server" AutoGenerateColumns="false" DataSourceID="DataSource1" KeyFieldName="ID" Width="100%">
            <Settings ShowFilterRow="true"></Settings>
            <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Id" VisibleIndex="0" ReadOnly="True" Visible="False"></dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="UserName" VisibleIndex="1"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UserRole" VisibleIndex="7" Visible="False"></dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="LoginDateTime" VisibleIndex="2" UnboundType="DateTime" PropertiesDateEdit-DisplayFormatString="G"></dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="IPAddressLogin" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="ThroughMobile" Caption="Mobile" VisibleIndex="4"></dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Browser" VisibleIndex="5"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="OtherInfo" VisibleIndex="6" Visible="false"></dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        
        <asp:SqlDataSource ID="DataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM LoginHistory WHERE LoginDateTime BETWEEN @StartDate AND (@EndDate + 1) AND UserRole = @UserRole AND ApplicationName = @AppName AND (UserName in (select [User Id] from dbo.[SCM User Details] where [Client Filter Destination Ref] = @ClientId)) ORDER BY LoginDateTime Desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="deStart" Name="StartDate" PropertyName="Date" Type="DateTime" />
                <asp:ControlParameter ControlID="deEnd" Name="EndDate" PropertyName="Date" Type="DateTime" />
                <asp:ControlParameter ControlID="cmbUserRole" Name="UserRole" PropertyName="SelectedItem.Value" Type="String" />
                <asp:SessionParameter SessionField="CONTEXT_CLIENTID" Name="ClientId" Type="String" DefaultValue=""/>
                <asp:Parameter Name="AppName" Type="String" DefaultValue="ScmWeb" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>

