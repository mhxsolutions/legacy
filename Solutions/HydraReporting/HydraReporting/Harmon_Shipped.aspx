<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Harmon_Shipped.aspx.vb" Inherits="HydraReporting.Harmon_Shipped" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harmon Shipped</title>
    <style type="text/css">
        .auto-style1 {
            width: 443px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harmon Shipped (not currently filtered for locked BOL) [<a href="default.aspx">home</a>]<br />
        </h3>
        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Metropolis">
            </dx:ASPxButton>
        </p>
        <table class="dxflInternalEditorTable_Metropolis">
            <tr>
                <td class="auto-style1">Start Date (inclusive)</td>
                <td>End Date (inclusive)</td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px">
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                        <DayStyle Width="14%" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                        <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                        <TodayDayStyle BackColor="#CCCC99" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" style="margin-left: 0px" TitleFormat="Month" Width="400px">
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                        <DayStyle Width="14%" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                        <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                        <TodayDayStyle BackColor="#CCCC99" />
                    </asp:Calendar>
                </td>
            </tr>
        </table>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="n0" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="n0" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Type" SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="4" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper Number" SortIndex="5" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="2" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Vendor/Supplier" SortIndex="6" SortOrder="Ascending" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release#" SortIndex="7" SortOrder="Ascending" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Seal#" FieldName="Seal Numbers" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="#Bales" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt Lb" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="17">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Booking Number" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Container#" FieldName="Container Number" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Comment" FieldName="Withdrawl Comment" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Carrier" FieldName="Equipment Reference" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BOL" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Hydra Harmon Shipped Summary] WHERE (([Shipment Date] &gt;= @Shipment_Date2) AND ([Shipment Date] &lt;= @Shipment_Date))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Shipment_Date2" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Shipment_Date" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Harmon Shipped" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
