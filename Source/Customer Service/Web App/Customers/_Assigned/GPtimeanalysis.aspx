<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_GPtimeanalysis" Codebehind="GPtimeanalysis.aspx.cs" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Truck Time Analysis</h3>
    <h3>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Export All" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
            Text="Export Selected" />
    </h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
            CssPostfix="Office2010Silver" DataSourceID="SqlDataSource1" Width="995px" 
            KeyFieldName="WillCall ID" EnableTheming="True" Theme="Office2010Silver">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="WC Log In" ShowInColumn="Arrive" 
                    SummaryType="Count" />
                <dx:ASPxSummaryItem FieldName="Wait Time" ShowInColumn="Wait Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Load Time" ShowInColumn="Load Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Total Time" ShowInColumn="Total Time" 
                    SummaryType="Average" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="WC Log In" SummaryType="Count" />
                <dx:ASPxSummaryItem DisplayFormat="Wait Avg = {0:n0}" FieldName="Wait Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Load Avg = {0:n0}" FieldName="Load Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Total Avg = {0:n0}" FieldName="Total Time" 
                    SummaryType="Average" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowSelectCheckbox="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="WC Log In" GroupIndex="0" 
                    SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                    <PropertiesDateEdit DisplayFormatString="" EditFormatString="d">
                    </PropertiesDateEdit>
                    <Settings GroupInterval="Date" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Type" FieldName="WC Type" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Carrier" FieldName="WC Carrier" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Reference" FieldName="Will Call Reference" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn Caption="Arrive" FieldName="WC Log In" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="5">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Start Load" FieldName="AssignTime" 
                    VisibleIndex="6">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="End Load" FieldName="LogOutTime" 
                    VisibleIndex="7">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Complete" FieldName="WC Comp Time" 
                    VisibleIndex="8">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Total Time" ReadOnly="True" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Time" ReadOnly="True" 
                    VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wait Time" ReadOnly="True" 
                    VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Post Load Time" ReadOnly="True" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupedColumns="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <Images SpriteCssFilePath="~/App_Themes/Office2010Silver/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
                CssPostfix="Office2010Silver">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <LoadingPanel ImageSpacing="5px">
                </LoadingPanel>
            </Styles>
            <SettingsBehavior AllowSelectByRowClick="True" ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <StylesEditors ButtonEditCellSpacing="0">
                <ProgressBar Height="21px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            
            SelectCommand="SELECT * FROM [willcall time analysis] WHERE ([WC Note] = @WC_Note)" 
            ProviderName="<%$ ConnectionStrings:DWS No Rep DataConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:Parameter DefaultValue="gp" Name="WC_Note" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="exportall" runat="server" 
            FileName="TruckTimeAnalysis" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <dx:ASPxGridViewExporter ID="exportsel" runat="server" 
            ExportedRowType="Selected" FileName="TruckTimeAnalysisSel" 
            GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

