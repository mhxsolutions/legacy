<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan_dest_Fon.aspx.vb" Inherits="Plan_dest_Fon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan by Destination</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Today&#39;s Plan by Destination (Fontana) - <a href="fon.aspx">home</a></h3>
        <br />
        Select Plan Date:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Plan_Date" 
            DataValueField="Plan_Date">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] WHERE ([Fleet] = @Fleet) ORDER BY [Plan Date] DESC">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
    
        <asp:Button ID="Button1" runat="server" Text="Export XLSX" />
        <asp:Button ID="Button2" runat="server" Text="Export PDF" />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">

                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn Caption="Schedule Arrive" FieldName="Sch_Arrive" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn Caption="Load" FieldName="Load_Ref" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="7">
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT [Plan Date] AS Plan_Date, [Fleet], [Driver], [Order], [Destination], [Sch Arrive] AS Sch_Arrive, [Load Ref] AS Load_Ref, [LogOut], [POD] FROM [Planned loads by fleet and driver for today] WHERE (([Fleet] = @Fleet) AND ([control date] = @control_date))">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
                <asp:ControlParameter ControlID="DropDownList1" Name="control_date" 
                    PropertyName="SelectedValue" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Plan by Destination" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
