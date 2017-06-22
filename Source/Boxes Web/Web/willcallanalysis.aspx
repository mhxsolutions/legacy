<%@ Page Language="VB" AutoEventWireup="false" CodeFile="willcallanalysis.aspx.vb" Inherits="willcallanalysis" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Will Call Analysis</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        Will Call Time Analysis<br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="WC Log In" SummaryType="Count" />
                <dx:ASPxSummaryItem DisplayFormat="Load Avg ={0:n0}" FieldName="Load Time" 
                    SummaryType="Average" />
                <dx:ASPxSummaryItem DisplayFormat="Total Avg={0:n0}" FieldName="Total Time" 
                    SummaryType="Average" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="WC Log In" GroupIndex="1" 
                    SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                    <Settings GroupInterval="Date" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Type" FieldName="WC Type" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Company" FieldName="WC Note" GroupIndex="0" 
                    SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Carrier" FieldName="WC Carrier" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Ref No." FieldName="Will Call Reference" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn Caption="Arrive Time" FieldName="WC Log In" 
                    VisibleIndex="6">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Start Load" FieldName="AssignTime" 
                    VisibleIndex="7">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="End Load" FieldName="LogOutTime" 
                    VisibleIndex="8">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="End Time" FieldName="WC Comp Time" 
                    SortIndex="3" SortOrder="Ascending" VisibleIndex="9">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Total Time" ReadOnly="True" 
                    VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Time" ReadOnly="True" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Post Load Time" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wait Time" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupedColumns="True" 
                ShowGroupFooter="VisibleIfExpanded" ShowGroupPanel="True" 
                ShowFilterRowMenu="True" ShowFilterBar="Visible" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <SettingsCustomizationWindow Enabled="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [willcall time analysis]"></asp:SqlDataSource>
        <br />
    
    </div>
    </form>
    <p>
        Arrive Time - Entered by will call clerk</p>
    <p>
        Start Time - auto entered when load is Assigned to driver</p>
    <p>
        End Load - auto entered when load is marked LogOut</p>
    <p>
        End Time - Entered by will call clerk</p>
    <p>
        Wait Time = (Start Time) - (Arrive Time)</p>
    <p>
        Load Time = (End Load) - (Start Load)</p>
    <p>
        Post Load = (End Time) - (End Load)</p>
    <p>
        Total Time = (End Time) - (Arrive Time)</p>
</body>
</html>
