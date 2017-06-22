<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Driver Scheduled Arrivals.aspx.vb" Inherits="Driver_Scheduled_Arrivals" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Sch Arrivals</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver Scheduled Arrivals<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LastName" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load Ref" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Destination" FieldName="Name-city" 
                    ReadOnly="True" VisibleIndex="6">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Sch Arrive" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="7">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Planned Arrivals 7 day lookback]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Filter for Fleet and Date to show the Scheduled Arrival times as updated by Load 
        Planner.</p>
    <p>
        Requested by Carlos so he could estimate final return times to terminal, but 
        shows arrival time for all planned destinations.</p>
</body>
</html>
