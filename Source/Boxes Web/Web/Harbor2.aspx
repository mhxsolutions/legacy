<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Harbor2.aspx.vb" Inherits="Harbor2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Reports</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harbor Reports</h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" Caption="Open Client Orders in Tons" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Client Order#" Theme="iOS">
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Client Order#" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2" Caption="Order#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mat#" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4" AdaptivePriority="1" AllowTextTruncationInAdaptiveMode="True">
                    <CellStyle Font-Size="Large" Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons_Ordered" VisibleIndex="6" Caption="Ordered">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons on DR" ReadOnly="True" VisibleIndex="7" Caption="On DRs">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Over/(Short)" ReadOnly="True" VisibleIndex="8" Caption="Over/(Short)">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Location" FieldName="Product_Location" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Deliver By" FieldName="Order_Deliver_By" VisibleIndex="1" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataDateColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Tons on DR" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons Over/(Short)" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons_Ordered" SummaryType="Sum" />
            </TotalSummary>
            <Styles>
                <Cell Font-Size="X-Large">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapePickUpSummaryByOrder]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
