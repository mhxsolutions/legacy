<%@ Page Title="COPS | Administer Users" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AdministerUsers.aspx.cs" Inherits="Web.Administration.AdministerUsers" %>

<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var visibleIndex;
        function OnCustomButtonClick(s, e) {
            visibleIndex = e.visibleIndex;
            popup.Show();
        }
        function OnClickYes(s, e) {
            grdUsers.DeleteRow(visibleIndex);
            popup.Hide();
        }
        function OnClickNo(s, e) {
            popup.Hide();
        }
        function OnLinkClick(a) {
            txtUserId.SetValue(a);
            txtNewPassword.SetValue('');
            popupChangePassword.Show();
        }

        function OnClickYesChange(s, e) {
            popupChangePassword.Hide();
            grdUsers.PerformCallback(txtUserId.GetValue() + '|' + txtNewPassword.GetValue());
        }
        function OnClickNoChange(s, e) {
            popupChangePassword.Hide();
        }

    </script>

    <h2>Administer Users</h2>
    <div class="contentDiv">
        <dx:ASPxGridView ID="grdUsers" runat="server" DataSourceID="UsersDataSource" KeyFieldName="UserId" ClientInstanceName="grdUsers" Width="98%"
            AutoGenerateColumns="False" OnRowInserting="grdUsers_RowInserting" OnRowUpdating="grdUsers_RowUpdating" OnCustomCallback="grdUsers_CustomCallback"
            OnRowDeleting="grdUsers_RowDeleting" OnCellEditorInitialize="grdUsers_CellEditorInitialize">
            <SettingsBehavior AllowEllipsisInText="True" ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />

            <SettingsCommandButton>
                <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

                <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
            </SettingsCommandButton>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <Settings ShowFilterRow="true" VerticalScrollableHeight="250" VerticalScrollBarMode="Auto" ShowFilterBar="Visible"></Settings>
            <SettingsPager PageSize="20">
                <PageSizeItemSettings Visible="true" ShowAllItem="true" />
            </SettingsPager>
            <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="deleteButton" Text="Delete" />
                    </CustomButtons>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="UserId" VisibleIndex="1" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True"></RequiredField>
                        </ValidationSettings>
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn FieldName="UserRole" VisibleIndex="2" PropertiesComboBox-DataSourceID="odsRoles" PropertiesComboBox-ValidationSettings-RequiredField-IsRequired="true">
                    <PropertiesComboBox DataSourceID="odsRoles">
                        <ValidationSettings>
                            <RequiredField IsRequired="True"></RequiredField>
                        </ValidationSettings>
                    </PropertiesComboBox>

                    <SettingsHeaderFilter Mode="List"></SettingsHeaderFilter>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="Password" Caption="Password" Visible="false" VisibleIndex="1" PropertiesTextEdit-ValidationSettings-RequiredField-IsRequired="true">
                    <PropertiesTextEdit>
                        <ValidationSettings>
                            <RequiredField IsRequired="True"></RequiredField>
                        </ValidationSettings>
                    </PropertiesTextEdit>

                    <EditFormSettings Visible="True" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataComboBoxColumn FieldName="Client" VisibleIndex="2" PropertiesComboBox-DataSourceID="StakeholderList" PropertiesComboBox-TextField="Destination" PropertiesComboBox-ValueField="DestinationId" PropertiesComboBox-ValidationSettings-RequiredField-IsRequired="true">
                    <PropertiesComboBox DataSourceID="StakeholderList" TextField="Destination" ValueField="DestinationId">
                        <ValidationSettings>
                            <RequiredField IsRequired="True"></RequiredField>
                        </ValidationSettings>
                    </PropertiesComboBox>

                    <SettingsHeaderFilter Mode="List"></SettingsHeaderFilter>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="UserId" Caption="Password" VisibleIndex="4" EditFormSettings-Visible="False">
                    <PropertiesHyperLinkEdit NavigateUrlFormatString="javascript:OnLinkClick('{0}');" Text="Change"></PropertiesHyperLinkEdit>
                    <EditFormSettings Visible="False"></EditFormSettings>
                    <FilterTemplate></FilterTemplate>
                </dx:GridViewDataHyperLinkColumn>
            </Columns>
        </dx:ASPxGridView>
        <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="Confirm" Text="Are you sure, want to delete this record?" Width="300" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" Modal="true" ClientInstanceName="popup">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <br />
                    <br />
                    <hr />
                    <div style="float: right">
                        <dx:ASPxButton ID="yesButton" runat="server" Text="Yes" AutoPostBack="false">
                            <ClientSideEvents Click="OnClickYes" />
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="noButton" runat="server" Text="No" AutoPostBack="false">
                            <ClientSideEvents Click="OnClickNo" />
                        </dx:ASPxButton>
                    </div>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" HeaderText="Change Password" Text="To change the password, enter new password." PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" Modal="true" ClientInstanceName="popupChangePassword">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <br />
                    <br />
                    <table>
                        <tr>
                            <td>User Id: </td>
                            <td>
                                <dx:ASPxTextBox ID="txtUserId" runat="server" Text="" ReadOnly="true" ClientInstanceName="txtUserId"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Password: </td>
                            <td>
                                <dx:ASPxTextBox ID="txtNewPassword" runat="server" Text="" Password="true" ClientInstanceName="txtNewPassword" MaxLength="25" ValidationSettings-RequiredField-IsRequired="true"></dx:ASPxTextBox>
                            </td>
                        </tr>
                    </table>
                    <hr />
                    <div style="float: right">
                        <dx:ASPxButton ID="btnChangePassword" runat="server" Text="Change" AutoPostBack="false">
                            <ClientSideEvents Click="OnClickYesChange" />
                        </dx:ASPxButton>
                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" AutoPostBack="false">
                            <ClientSideEvents Click="OnClickNoChange" />
                        </dx:ASPxButton>
                    </div>

                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>


        <asp:SqlDataSource ID="UsersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [MhxWeb_UserDetails].[User Id] as UserId, [aspnetdb].dbo.GetRoleName([MhxWeb_UserDetails].[User Id], 'MhxWeb') as UserRole, '' as Password, '' as Change, [Client Filter Destination Ref] as DestinationId, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Client FROM [MhxWeb_UserDetails] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [MhxWeb_UserDetails].[Client Filter Destination Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] ORDER BY [MhxWeb_UserDetails].[User Id]"
            InsertCommand="INSERT INTO [MhxWeb_UserDetails] ([User Id], [Client Filter Destination Ref]) VALUES (@UserId, @Client)"
            UpdateCommand="UPDATE [MhxWeb_UserDetails] SET [Client Filter Destination Ref] = @Client WHERE [User Id] = @UserId"
            DeleteCommand="DELETE FROM [MhxWeb_UserDetails] WHERE [User Id]=@UserId">
            <InsertParameters>
                <asp:Parameter Name="UserId" />
                <asp:Parameter Name="Client" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserId" />
                <asp:Parameter Name="Client" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:Parameter Name="UserId" Type="String" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="StakeholderList" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
            SelectCommand="SELECT [Destination id] AS DestinationId, Destination + ': ' + City + ', ' + ISNULL(State, '') AS Destination FROM tbldestinationList WHERE ([Parent Ref] = [Destination id])"></asp:SqlDataSource>

        <asp:ObjectDataSource ID="odsRoles" runat="server" TypeName="System.Web.Security.Roles"
            SelectMethod="GetAllRoles"></asp:ObjectDataSource>
    </div>
</asp:Content>
