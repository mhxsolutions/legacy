<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rail wout Recv.aspx.vb" Inherits="Rail_wout_Recv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail wout Receivers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Railcars without Receivers (expert)</h3>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="PlasticBlue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Release" FieldName="daterel" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="WhseComplete" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="PL Date" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [railcars without receivers detail]">
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        Report filtered to eliminate UPI only.</p>
    <p>
        Placed or Released cars. No In Transit cars.</p>
</body>
</html>
