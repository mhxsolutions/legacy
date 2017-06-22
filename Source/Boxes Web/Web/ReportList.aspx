<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReportList.aspx.vb" Inherits="ReportList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Menu Editor <a href="default.aspx">(home)</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="web_report_ID" Theme="Metropolis">
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <SettingsEditing Mode="Inline">
            </SettingsEditing>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupedColumns="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="web_report_ID" ReadOnly="True" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Category" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Requested" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Report_Title" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Report_Link" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Company_ID_ref" Visible="False" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" DeleteCommand="DELETE FROM [Web_Report_List] WHERE [web_report_ID] = @original_web_report_ID " InsertCommand="INSERT INTO [Web_Report_List] ([Description], [Category], [Requested], [Report_Title], [Report_Link], [Company_ID_ref], [Active]) VALUES (@Description, @Category, @Requested, @Report_Title, @Report_Link, 1, @Active)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT web_report_ID, Description, Category, Requested, Report_Title, Report_Link, Company_ID_ref, Active FROM Web_Report_List WHERE (Company_ID_ref = @company) " UpdateCommand="UPDATE Web_Report_List SET Description = @Description, Category = @Category, Requested = @Requested, Report_Title = @Report_Title, Report_Link = @Report_Link, Company_ID_ref = @Company_ID_ref, Active = @Active WHERE (web_report_ID = @original_web_report_ID)">
            <DeleteParameters>
                <asp:Parameter Name="original_web_report_ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="Requested" Type="String" />
                <asp:Parameter Name="Report_Title" Type="String" />
                <asp:Parameter Name="Report_Link" Type="String" />
                <asp:Parameter Name="Active" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="company" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="Requested" Type="String" />
                <asp:Parameter Name="Report_Title" Type="String" />
                <asp:Parameter Name="Report_Link" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Active" />
                <asp:Parameter Name="original_web_report_ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    
    </div>
    </form>
</body>
</html>
