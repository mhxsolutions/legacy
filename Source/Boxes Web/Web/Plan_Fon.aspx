<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan_Fon.aspx.vb" Inherits="Plan_Fon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan by Driver - Fon</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        Plan by Driver - Fontana - <a href="fon.aspx">home</a></h3>
        Select Plan Date:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Plan_Date" 
            DataValueField="Plan_Date">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] ORDER BY [Plan Date] DESC">
        </asp:SqlDataSource>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" 
                    VisibleIndex="4" SortIndex="2" SortOrder="Ascending" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch Arrive" VisibleIndex="5" 
                    SortIndex="1" SortOrder="Ascending">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Load" FieldName="Load Ref" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
            </Columns>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT [Plan Date], Fleet, Driver, [Order], Destination, [Sch Arrive], [Load Ref], [control date], LogOut, POD FROM [Planned loads by fleet and driver for today] WHERE (Fleet = @Fleet) AND ([Plan Date] = @Date)">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="Date" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
