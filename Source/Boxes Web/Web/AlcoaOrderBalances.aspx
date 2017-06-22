<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AlcoaOrderBalances.aspx.vb" Inherits="AlcoaOrderBalances" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Alcoa Order Balances<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ClientOrderID" Theme="Metropolis">
            <Settings ShowFilterRow="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ClientOrderID" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Tons_Ordered" VisibleIndex="0">
                            <PropertiesTextEdit DisplayFormatString="n1">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Count_Ordered" VisibleIndex="1">
                            <PropertiesTextEdit DisplayFormatString="n0">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product_Ordered" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product_Description" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" GroupInterval="DateRange" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="closed" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Net Tons" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Net Tons" ShowInGroupFooterColumn="Net Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Count" ShowInGroupFooterColumn="Count" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [ClientOrdersDeliveredByDate] WHERE ([ClientID] = @ClientID)">
            <SelectParameters>
                <asp:Parameter DefaultValue="73" Name="ClientID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
