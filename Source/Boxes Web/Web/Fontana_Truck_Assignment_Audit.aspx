<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Fontana_Truck_Assignment_Audit.aspx.vb" Inherits="Fontana_Truck_Assignment_Audit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit Assignments</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Audit Fontana Load Assignments - no truck on record</h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LogOutDate" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Current Tractor" FieldName="Truck Default" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="25">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Audit Fontana Loads with Drive but no truck assignment]">
    </asp:SqlDataSource>
    </form>
    <p>
        Notes:</p>
    <ul>
        <li>Fontana Drivers - no sub, will call or service driver</li>
        <li>Loads have Log Out and driver assignment, but no truck assignments</li>
    </ul>
</body>
</html>
