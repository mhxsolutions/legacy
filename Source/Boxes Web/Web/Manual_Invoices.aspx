<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Manual_Invoices.aspx.vb" Inherits="Manual_Invoices" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manual Invoice Explorer</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            RFS Manual Invoice Explorer<br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Width="122px">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" KeyFieldName="ID">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Year" ReadOnly="True" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" ReadOnly="True" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Type" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Invoice" FieldName="ID" ReadOnly="True" 
                    SortIndex="2" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="General Ledger Code" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SL-GL" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Cost Center" VisibleIndex="9">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SL Cost Center Type" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [RFS Invoices Manual with cost center break breakout]">
        </asp:SqlDataSource>
    
    </div>
    <dx:ASPxGridViewExporter ID="ASPxGridView" runat="server" 
        FileName="Manual Invoices" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
    <p>
        Please note:</p>
    <p>
        These are only Manual invoices. Automated billing is not included in this list.</p>
    <p>
        Invoices will be listed twice if there is more than one cost center or GL code 
        used in the detail billing lines.</p>
</body>
</html>
