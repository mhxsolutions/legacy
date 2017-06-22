<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SteelscapeClientOrderAssignmentAudit.aspx.vb" Inherits="SteelscapeClientOrderAssignmentAudit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Steelscape Client Order Assignment Audit<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Mat#" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="2" Caption="Tons Del">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Week" VisibleIndex="3" Caption="Week Del">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Year" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Order# Assigned" FieldName="Client_Order_ref" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Steelscape material tons delivered]"></asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        If Order# Assigned is NULL, that delivery was not assigned to a Client Order.</p>
</body>
</html>
