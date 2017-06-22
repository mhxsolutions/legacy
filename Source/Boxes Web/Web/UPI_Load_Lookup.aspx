<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPI_Load_Lookup.aspx.vb" Inherits="UPI_Load_Lookup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UPI Load Lookup</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            UPI Load Lookup</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Theme="Office2003Blue" Width="134px">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Invoice" 
            Theme="Office2003Blue">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Invoice" ReadOnly="True" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Invoice Total" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Invoice Date" VisibleIndex="6">
                    <Settings AutoFilterCondition="GreaterOrEqual" />
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True" ShowAllItem="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [USS Invoice to Load]"></asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="UPI Loads" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        Designed for use with UPI AR so that the user can find the load given an unpaid 
        invoice. UPI pays by load number not our invoice number.</p>
</body>
</html>
