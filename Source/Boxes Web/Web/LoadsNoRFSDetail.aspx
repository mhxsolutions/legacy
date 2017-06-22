<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadsNoRFSDetail.aspx.vb" Inherits="LoadsNoRFSDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load No RFS</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Loads without RFS Detail (<a href="index.aspx">home</a>)<br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue">
            <SettingsPager PageSize="20" Position="TopAndBottom">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RFS ref" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="5">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
            </Columns>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS loads without RFS] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
