<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Harmon_on_date.aspx.vb" Inherits="HydraReporting.Harmon_on_date" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harmon On Date</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harmon Inventory on Date</h3>
        <p>
            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#999999" />
                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                <TodayDayStyle BackColor="#CCCCCC" />
            </asp:Calendar>
        </p>
        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Metropolis">
            </dx:ASPxButton>
            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Export PDF" Theme="Metropolis">
            </dx:ASPxButton>
        </p>
        <p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsPager PageSize="25">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings ShowAllItem="True" Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Vendor/Shipper" FieldName="Product Group 1" SortIndex="3" SortOrder="Ascending" VisibleIndex="7">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Release#" FieldName="Product Group 2" VisibleIndex="9">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Grade" FieldName="Product Group 3" VisibleIndex="11">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Wt (lb)" FieldName="Wt" VisibleIndex="19">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Avg Wt" FieldName="Avg_Wt" VisibleIndex="20">
                        <PropertiesTextEdit DisplayFormatString="n2">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="21">
                        <PropertiesTextEdit DisplayFormatString="n1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="# Bales" FieldName="Unit Count" VisibleIndex="12">
                        <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Recd Date" SortIndex="2" SortOrder="Ascending" VisibleIndex="6">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="28">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Avg = {0:n1}" FieldName="Avg_Wt" ShowInGroupFooterColumn="Avg Wt" SummaryType="Average" />
                    <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
                    <dx:ASPxSummaryItem FieldName="Unit Count" ShowInGroupFooterColumn="# Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                    <dx:ASPxSummaryItem FieldName="Wt" ShowInGroupFooterColumn="Wt (lb)" SummaryType="Sum" ValueDisplayFormat="n0" />
                </TotalSummary>
                <Styles>
                    <Cell Wrap="False">
                    </Cell>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary] WHERE (([Exit Date] &gt; @Exit_Date) AND ([Recd Date] &lt;= @Recd_Date) AND ([Client Name] LIKE '%' + @Client_Name + '%') AND ([Company ID ref] = @Company_ID_ref))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                    <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
                    <asp:Parameter DefaultValue="harmon" Name="Client_Name" Type="String" />
                    <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="harmon Inventory on Select Date" GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
        </p>
    
    </div>
    </form>
</body>
</html>
