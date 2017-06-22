<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PUR.aspx.vb" Inherits="PUR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PUR List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Pick Up Requests<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
            Theme="Office2003Blue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="PUR" SortIndex="1" SortOrder="Ascending" 
                    VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Pick Up Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                    <Settings ShowFilterRowMenu="True" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver" ReadOnly="True" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="12">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [PUR with and without TPL]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        All PURs assigned to Loads and not assigned to Loads</p>
    <p>
        A blank in Load means that PUR has not been dispatched.</p>
</body>
</html>
