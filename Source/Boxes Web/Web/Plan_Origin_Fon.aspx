<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Plan_Origin_Fon.aspx.vb" Inherits="Plan_Origin_Fon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan by Origin</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Plan by Origin (Fontana) - <a href="fon.aspx">home</a></h3>
        <p>
        <br />
        Select Plan Date:<asp:DropDownList ID="DropDownList1" runat="server" 
            AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Plan_Date" 
            DataValueField="Plan_Date">
        </asp:DropDownList>
        </p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned Loads by Fleet and Driver for Today by Origin] ORDER BY [Plan Date] DESC">
        </asp:SqlDataSource>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Aqua">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Export PDF" Theme="Aqua">
        </dx:ASPxButton>
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Aqua">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Order" Visible="False" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                VisibleIndex="3" GroupIndex="0" SortIndex="0" SortOrder="Ascending" 
                Caption="Origin">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Sch Depart" VisibleIndex="4" 
                SortIndex="1" SortOrder="Ascending">
                <PropertiesDateEdit DisplayFormatString="t">
                </PropertiesDateEdit>
                <Settings AllowAutoFilter="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ref" VisibleIndex="7" Caption="Load">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="9">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="10">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsPager PageSize="40">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" 
            AllowInsert="False" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        
        SelectCommand="SELECT [Plan Date], Fleet, Driver, [Order], Destination, [Sch Depart], [Load Ref], [control date], LogOut, POD FROM [Planned Loads by Fleet and Driver for Today by Origin] WHERE (Fleet = @Fleet) AND ([control date] = @Plan_Date)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Plan_Date" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridView" runat="server" FileName="Plan by Origin" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
