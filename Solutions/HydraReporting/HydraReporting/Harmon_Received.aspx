<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Harmon_Received.aspx.vb" Inherits="HydraReporting.Harmon_Received" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harmon Received</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harmon Receiving Review [<a href="default.aspx">home</a>]<br />
        </h3>
        <table class="auto-style1">
            <tr>
                <td>Start Date (inclusive)</td>
                <td>End Date (inclusive)</td>
            </tr>
            <tr>
                <td>
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
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px">
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
    
    </div>
        <br />
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Avg_WT" ShowInColumn="Avg Wt" SummaryType="Average" ValueDisplayFormat="n2" />
                <dx:ASPxSummaryItem FieldName="WT" ShowInColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Avg_WT" ShowInGroupFooterColumn="Avg Wt" SummaryType="Average" ValueDisplayFormat="n2" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="WT" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="n0" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vendor/Supplier" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release#" SortIndex="2" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Grade" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="#Bales" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Wt Lb" FieldName="WT" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Avg Wt" FieldName="Avg_WT" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="n2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" ReadOnly="True" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver ID" VisibleIndex="5">
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [hydra received harmon] WHERE (([Date Received] &lt;= @Date_Received2) AND ([Date Received] &gt;= @Date_Received))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="String" />
                <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Harmon Receiving Review" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
