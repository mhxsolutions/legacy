<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan.aspx.vb" Inherits="Plan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Plan by Driver - NorCal</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Today&#39;s Plan by Driver 
            - NorCal - <a href="pitt_default.aspx">home</a></h3>
        <br />
        Select Plan Date: 
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Plan_Date" 
            DataValueField="Plan_Date">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] ORDER BY [Plan Date] DESC">
        </asp:SqlDataSource>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Plan Date" ReadOnly="True" 
                Visible="False" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Order" SortIndex="1" 
                SortOrder="Ascending" Visible="False" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Sch Arrive" VisibleIndex="5">
                <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Load" FieldName="Load Ref" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="8">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Planned loads by fleet and driver for today] WHERE (([Fleet] = @Fleet) AND ([Plan Date] = @Plan_Date))">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Plan_Date" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
