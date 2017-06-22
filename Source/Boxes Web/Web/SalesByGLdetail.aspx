<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SalesByGLdetail.aspx.vb" Inherits="SalesByGLdetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sales By GL Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Sales by GL - detail<br />
        </h3>
        <p>
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Theme="Office2003Olive">
            </dx:ASPxButton>
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            KeyFieldName="Invoice#" Theme="Office2003Olive">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Bill To" 
                    VisibleIndex="2" SortIndex="1" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Invoice Date" SortIndex="0" SortOrder="Descending" VisibleIndex="0">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="1" 
                    SortIndex="2" SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Invoice#" ReadOnly="True" VisibleIndex="3" 
                    SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SLGL#" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SLSub" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Service" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowGroupFooter="VisibleAlways" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" MinWidth="300px" />
            </SettingsPopup>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Total" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT * FROM [Invoice Totals by GL v2] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Sales by GL detail" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
