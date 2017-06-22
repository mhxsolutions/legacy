<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Plan.aspx.vb" Inherits="HydraReporting.Plan" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Plan</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Plan by Driver<br />
            <br />
            Select Date
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Plan_Date" DataValueField="Plan_Date">
            </asp:DropDownList>
        </h3>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] ORDER BY [Plan Date] DESC"></asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch_Arrive" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load_Ref" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="4">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="5">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Destination], [Sch Arrive] AS Sch_Arrive, [Load Ref] AS Load_Ref, [LogOut], [POD], [Fleet] FROM [Planned loads by fleet and driver for today] WHERE (([Plan Date] = @Plan_Date) AND ([Company ID ref] = @Company_ID_ref))">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Plan_Date" PropertyName="SelectedValue" Type="String" />
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
