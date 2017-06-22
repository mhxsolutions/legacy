<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Planning_Status_Detail.aspx.vb" Inherits="Planning_Status_Detail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Planning Status Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Planning Status Detail - Budway<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
        Theme="Office2010Blue">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date" ReadOnly="True" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Planned" ReadOnly="True" VisibleIndex="5">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Assigned" ReadOnly="True" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
        <Styles>
            <Row Wrap="False">
            </Row>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Planner Status Detail] WHERE ([Fleet] LIKE '%' + @Fleet + '%')">
        <SelectParameters>
            <asp:Parameter DefaultValue="bud" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
    <p>
        Lists all loads not marked Will Call or not logged out</p>
</body>
</html>
