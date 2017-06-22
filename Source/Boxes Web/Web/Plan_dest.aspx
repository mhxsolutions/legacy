<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan_dest.aspx.vb" Inherits="Plan_dest" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Plan by Destination</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Today&#39;s Plan&nbsp; (<a href="index.aspx">home</a>)</h3>
        <br />
        Select Plan Date:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Plan_Date" 
            DataValueField="Plan_Date">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date, [Company ID ref] FROM [Planned loads by fleet and driver for today] WHERE ([Company ID ref] = 1) OR ([Company ID ref] = 9) ORDER BY Plan_Date DESC">
        </asp:SqlDataSource>
    
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="expand all" Theme="MetropolisBlue">
        </dx:ASPxButton>
    
        <asp:Button ID="Button2" runat="server" Text="Export XLSX" />
        <asp:Button ID="Button1" runat="server" Text="Export PDF" />
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="MetropolisBlue">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Load Ref" ShowInColumn="Load" 
                SummaryType="Count" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Load Ref" SummaryType="Count" />
        </GroupSummary>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="8">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                SortIndex="0" SortOrder="Ascending" VisibleIndex="6">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Sch Arrive" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="7" Caption="Arrive Dest">
                <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Load" FieldName="Load Ref" VisibleIndex="9">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="10">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2" Caption="Driver Fleet">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Arrive at Origin" ReadOnly="True" VisibleIndex="5">
                <PropertiesDateEdit DisplayFormatString="t">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Action" FieldName="Planner Action" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="3">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load_Priority" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" 
            ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowFilterBar="Visible" />
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'must deliver'">
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'high'" FieldName="Load_Priority" Format="YellowFillWithDarkYellowText">
            </dx:GridViewFormatConditionHighlight>
        </FormatConditions>
    </dx:ASPxGridView>

        <br />

        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
        <br />
        <br />


    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT [Plan Date], Fleet, Driver, [Order], Destination, [Sch Arrive], [Load Ref], [control date], LogOut, POD, [Company ID ref], Origin, [Arrive at Origin], [Planner Action], Vessel, Load_Priority FROM [Planned loads by fleet and driver for today] WHERE ([Plan Date] = @Plan_Date) AND ([Company ID ref] = 1 OR [Company ID ref] = 9)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Plan_Date" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        FileName="load plan" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
