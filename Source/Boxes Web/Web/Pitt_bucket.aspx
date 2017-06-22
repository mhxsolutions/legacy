<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pitt_bucket.aspx.vb" Inherits="Pitt_bucket" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bucket - Pittsburg</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Bucket - Pittsburg - <a href="pitt_default.aspx">home</a></h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
        Theme="Aqua">
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Destination" SummaryType="Count" />
        </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataDateColumn FieldName="LoadDate" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" GroupIndex="0" 
                ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Pitt Bucket]"></asp:SqlDataSource>
    </form>
    <p>
        Loads NOT on Plan, NO POD and NOT marked Will Call</p>
</body>
</html>
