<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Payroll_Times.aspx.vb" Inherits="Payroll_Times" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payroll Times</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Driver Payroll Times - <a href="default.aspx">(home)</a><br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Plan ID" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
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
                <dx:GridViewDataTextColumn FieldName="Drivers" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Origin" VisibleIndex="4">
                    <PropertiesDateEdit DisplayFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Arrive Destination" VisibleIndex="5">
                    <PropertiesDateEdit DisplayFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Depart Destination" VisibleIndex="6">
                    <PropertiesDateEdit DisplayFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="link_date_driver" ReadOnly="True" Visible="False" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Transit" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Leg" ReadOnly="True" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch Depart" VisibleIndex="11">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Plan Delta" ReadOnly="True" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Transit" ShowInColumn="Transit" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Leg" ShowInColumn="Leg" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Dwell" ShowInColumn="Dwell" SummaryType="Sum" />
            </TotalSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Drivers Payroll Time Detail] WHERE (([link_date_driver] = @link_date_driver) AND ([Company ID ref] = @Company_ID_ref))">
            <SelectParameters>
                <asp:QueryStringParameter Name="link_date_driver" QueryStringField="link" Type="String" />
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
