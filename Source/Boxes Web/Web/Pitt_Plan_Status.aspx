<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pitt_Plan_Status.aspx.vb" Inherits="Pitt_Plan_Status" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Plan Status</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Plan Status Overview - Pittsburg Fleet -
            <a href="pitt_default.aspx">home</a></h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua" Width="370px">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataDateColumn FieldName="LoadDate" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="3">
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unplanned" VisibleIndex="4">
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unassigned" VisibleIndex="5">
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="No LogOut" VisibleIndex="6">
                <HeaderStyle HorizontalAlign="Right" />
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
        SelectCommand="SELECT * FROM [Planning_status_p1] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
    <p>
        &nbsp;</p>
    <p>
        <a href="planner_detail_pitt.aspx">Load Detail</a></p>
    <p>
        Analyzes all loads not marked Will Call</p>
    <p>
        Removes all days with Unplanned=0, Unassigned=0, No Log Out=0</p>
</body>
</html>
