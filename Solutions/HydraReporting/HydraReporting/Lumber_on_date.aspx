<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Lumber_on_date.aspx.vb" Inherits="HydraReporting.Lumber_on_date" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lumber Inventory</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Lumber Inventory on Selected Date<br />
        </h3>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="PDF" Theme="Metropolis">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 1" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 2" GroupIndex="3" SortIndex="3" SortOrder="Ascending" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 3" GroupIndex="4" SortIndex="4" SortOrder="Ascending" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Label" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Count" VisibleIndex="20">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pcs Each Unit" FieldName="Count In Package" VisibleIndex="21">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="25">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="28">
                </dx:GridViewDataDateColumn>
            </Columns>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Unit Count" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary] WHERE (([Recd Date] &lt;= @Recd_Date) AND ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = @Company_ID_ref))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="inventory on Select Date" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
