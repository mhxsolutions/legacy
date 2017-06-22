<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Administration_ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        var visibleIndex;
        function OnCustomButtonClick(s, e) {
            visibleIndex = e.visibleIndex;
            popup.Show();
        }
        function OnClickYes(s, e) {
            gridManageUsers.DeleteRow(visibleIndex);
            popup.Hide();
        }
        function OnClickNo(s, e) {
            popup.Hide();
        }
    </script>

    <h2>Manage Users</h2>
    <dx:ASPxGridView ID="gvManageUsers" ClientInstanceName="gridManageUsers" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="UserId" SettingsPager-PageSize="20"
        OnRowUpdating="gvManageUsers_RowUpdating" OnRowDeleting="gvManageUsers_RowDeleting">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsDataSecurity AllowInsert="False"></SettingsDataSecurity>

        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <ClientSideEvents CustomButtonClick="OnCustomButtonClick" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewDataCheckColumn FieldName="IsApproved" Caption="Approved" VisibleIndex="1" Width="90"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="IsLockedOut" Caption="Locked" VisibleIndex="2" Width="80"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="UserName" VisibleIndex="3" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="UserRole" VisibleIndex="4" Width="115" PropertiesComboBox-DataSourceID="odsRoles" PropertiesComboBox-DropDownStyle="DropDownList" SettingsHeaderFilter-Mode="List"></dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ClientId" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="odsClients" TextField="Client" ValueField="ClientId" ValueType="System.Int32" DropDownStyle="DropDownList" ValidationSettings-RequiredField-IsRequired="true"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="6" PropertiesTextEdit-MaxLength="256"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MobileAlias" Caption="Mobile" VisibleIndex="7" PropertiesTextEdit-MaxLength="16"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Comment" VisibleIndex="8"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="CreateDate" Caption="Created" VisibleIndex="9" Width="100" EditFormSettings-Visible="False"></dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="LastActivityDate" Caption="Last Activity" VisibleIndex="10" Width="120" EditFormSettings-Visible="False"></dx:GridViewDataDateColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="UserName" Caption="Details" VisibleIndex="11" EditFormSettings-Visible="False" Width="70" Visible="false">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="UserDetails.aspx?UserName={0}" Text="View"></PropertiesHyperLinkEdit>
                <EditFormSettings Visible="False"></EditFormSettings>
                <FilterTemplate></FilterTemplate>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewCommandColumn ShowEditButton="True" ShowDeleteButton="false" VisibleIndex="12" ShowNewButton="true" Width="90">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="deleteButton" Text="Delete" />
                </CustomButtons>
            </dx:GridViewCommandColumn>

        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="IsApproved = 0" FieldName="IsApproved" Format="GreenFillWithDarkGreenText"></dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="IsLockedOut = 1" FieldName="IsLockedOut"></dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight FieldName="UserRole" Expression="UserRole = 'Administrators'" ShowInColumn="UserName" Format="BoldText"></dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight FieldName="UserRole" Expression="UserRole = 'Power Users'" ShowInColumn="UserName" Format="Custom" CellStyle-Font-Underline="true"></dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionIconSet Format="Ratings5" FieldName="LastActivityDate"></dx:GridViewFormatConditionIconSet>
        </FormatConditions>
        <FormatConditions>
        </FormatConditions>
    </dx:ASPxGridView>
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="Confirm" Text="Are you sure, want to delete this user?" Width="300" PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" Modal="true" ClientInstanceName="popup">
        <ContentCollection>
            <dx:PopupControlContentControl>
                <br />
                <br />
                <hr style="border-color: #efefef" />
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





    <asp:ObjectDataSource ID="odsRoles" runat="server" TypeName="UserCompany" SelectMethod="GetRoles"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="UserCompany" SelectMethod="GetClientList"></asp:ObjectDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Sql1MembershipDatabase %>'
        SelectCommand="
SELECT * FROM
(
	SELECT U.UserId, U.UserName, U.MobileAlias,
		M.IsApproved, M.IsLockedOut, M.Email, M.Comment, M.CreateDate, U.LastActivityDate, 
		[aspnetdb].dbo.GetRoleName(UserName, 'MhxWeb') AS UserRole,
		C.[Company Name] AS CompanyName, C.[Company ID] AS CompanyId,
		CL.[Destination Id] AS ClientId,
		[DWS No Rep Data].dbo.GetClientName(UserName, 'MhxWeb') as Client 
	FROM dbo.aspnet_Users U  
		JOIN dbo.aspnet_Applications A ON A.ApplicationId = U.ApplicationId  AND A.ApplicationName = 'MhxWeb' 
		JOIN dbo.aspnet_Membership M ON M.UserId = U.UserId
		LEFT JOIN [DWS No Rep Data].dbo.[MhxWeb_UserDetails] D ON D.[User Id] collate SQL_Latin1_General_CP437_BIN = U.UserName
		LEFT JOIN [DWS Rep Data].[dbo].[tbldestinationList] CL ON CL.[Destination Id] = D.[Client Filter Destination Ref] 
		LEFT JOIN [DWS No Rep Data].[dbo].[Company] C ON C.[Company ID] = CL.[Company ID Ref] 
) T
WHERE @Role = 'Administrators' OR (CompanyId = @CompanyId AND UserRole = 'Users')"
        UpdateCommand="
UPDATE [aspnetdb].dbo.aspnet_Membership SET
    IsApproved = @IsApproved,
    IsLockedOut = @IsLockedOut,
    Email = @Email,
    Comment = @Comment
WHERE UserId = @UserId;

UPDATE [aspnetdb].dbo.aspnet_Users SET
MobileAlias = @MobileAlias
WHERE UserId = @UserId;

IF NOT EXISTS(SELECT 1 FROM [DWS No Rep Data].dbo.[MhxWeb_UserDetails] U WHERE U.[User Id] = @UserName)
BEGIN INSERT INTO [DWS No Rep Data].dbo.[MhxWeb_UserDetails] VALUES (@UserName, @ClientId) END 
ELSE BEGIN UPDATE U SET U.[Client Filter Destination Ref] = @ClientId
FROM [DWS No Rep Data].dbo.[MhxWeb_UserDetails] U WHERE U.[User Id] = @UserName END
        
        "
        UpdateCommandType="Text"
        DeleteCommand="SELECT GETDATE()" DeleteCommandType="Text">

        <SelectParameters>
            <asp:SessionParameter Name="Role" SessionField="Role" DefaultValue="Administrators" Type="String" />
            <asp:SessionParameter Name="CompanyId" SessionField="CompanyId" DefaultValue="9" Type="String" />
        </SelectParameters>

        <UpdateParameters>
            <asp:Parameter Name="IsApproved" />
            <asp:Parameter Name="IsLockedOut" />
            <asp:Parameter Name="Email" />
            <asp:Parameter Name="MobileAlias" />
            <asp:Parameter Name="Comment" />
            <asp:Parameter Name="UserId" />
            <asp:Parameter Name="UserName" />
            <asp:Parameter Name="Client" />
            <asp:Parameter Name="ClientId" />

        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>

