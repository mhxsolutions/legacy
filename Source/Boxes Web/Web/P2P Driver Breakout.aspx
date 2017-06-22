<%@ Page Language="VB" AutoEventWireup="false" CodeFile="P2P Driver Breakout.aspx.vb" Inherits="P2P_Driver_Breakout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>P2P Drivers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Performance to Plan Driver Breakout - <a href="Default.aspx">(home)</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" Width="738px">
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Date" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Actual Min" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Booked Min" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="P2P Driver" ReadOnly="True" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n2">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="link" VisibleIndex="7" Caption="Driver Clicks">
                    <PropertiesHyperLinkEdit NavigateUrlFormatString="driver_clicks.aspx?link={0}" Text="Phone">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataHyperLinkColumn Caption="Edited Times" FieldName="link" VisibleIndex="8">
                    <PropertiesHyperLinkEdit NavigateUrlFormatString="payroll_times.aspx?link={0}" Text="Payroll">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
            </Columns>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [P2P Driver Daily Breakout] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Plan Date] = @Plan_Date))">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                <asp:QueryStringParameter Name="Plan_Date" QueryStringField="sel_date" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <a href="PhoneReview.aspx">Review Driver Phone Data</a></div>
    </form>
    <p>
        Data on Driver Breakout from edited times.</p>
</body>
</html>
