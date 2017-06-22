<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Invoice_Line_Detail.aspx.vb" Inherits="Invoice_Line_Detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoice Line Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Invoice Line Detail</h3>
        Year:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT DISTINCT [Year] FROM [RFS Invoice Line Items with GL] ORDER BY [Year] DESC"></asp:SqlDataSource>
        Month:
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT DISTINCT [Month] FROM [RFS Invoice Line Items with GL] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="RFS Invoice Id" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Invoice Date" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Line Number" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item Description" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Service" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="GL Act" FieldName="SLCOA" VisibleIndex="7">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="SUB Act" FieldName="SLSUB" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Cost Center" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Calc Type" ReadOnly="True" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Item Total" ShowInColumn="Item Total" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Item Total" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [RFS Invoice Line Items with GL] WHERE (([Year] = @Year) AND ([Month] = @Month) AND ([Cost Ctr Abr] NOT LIKE '%' + @Cost_Ctr_Abr + '%'))">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter DefaultValue="tt" Name="Cost_Ctr_Abr" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
