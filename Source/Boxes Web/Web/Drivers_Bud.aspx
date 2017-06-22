<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Drivers_Bud.aspx.vb" Inherits="Drivers_Bud" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Budway Drivers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver List - Budway<br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Mulberry">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="FirstName" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LastName" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Title" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" 
                        ShowFilterRowMenu="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Based at" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="HomePhone" VisibleIndex="5">
                    <PropertiesTextEdit>
                        <MaskSettings Mask="(999) 000-0000" ShowHints="True" />
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="WorkPhone" VisibleIndex="6">
                    <PropertiesTextEdit>
                        <MaskSettings Mask="(999) 000-0000" />
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="City" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="State" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PostalCode" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" 
                ShowFilterRowMenuLikeItem="True" ShowGroupPanel="True" />
            <SettingsDataSecurity AllowDelete="False" 
                AllowInsert="False" />
            <Styles>
                <DetailRow Wrap="False">
                </DetailRow>
                <DetailCell Wrap="False">
                </DetailCell>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Driver List - Budway]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
