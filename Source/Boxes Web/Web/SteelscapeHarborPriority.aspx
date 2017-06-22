<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SteelscapeHarborPriority.aspx.vb" Inherits="SteelscapeHarborPriority" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Steelscape Priority</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Steelscape Harbor Priority<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="iOS">
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" />
            <SettingsBehavior AllowEllipsisInText="True" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Mat#" FieldName="Product_Ordered" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product_Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="First Wk" FieldName="Wk_First_Needed" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Remaining to Pick Up" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Priority Tons" ReadOnly="True" SortIndex="1" SortOrder="Descending" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Priority Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Remaining to Pick Up" SummaryType="Sum" />
            </TotalSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [SteelscapeOpenClientOrders_withPriorityTons]"></asp:SqlDataSource>
        <br />
    
    </div>
    </form>
    <p>
        Open and not Complete Client Orders for this week and next with balances needed from Port or Rail</p>
    <p>
        Orders are summed by Material# and may be spread over both weeks.</p>
    <p>
        Priority Tons are tons needed to fulfill the earliest demand.
    </p>
</body>
</html>
