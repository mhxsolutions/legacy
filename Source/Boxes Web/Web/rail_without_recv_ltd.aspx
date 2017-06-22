<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rail_without_recv_ltd.aspx.vb" Inherits="rail_without_recv_ltd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail - no Receiver</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Rail without Receivers - filtered<br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Release Date" FieldName="daterel" 
                    VisibleIndex="7">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Content" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="WhseComplete" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="5">
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
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [railcars without receivers detail ltd]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Report prefiltered to remove most cars that don&#39;t have receivers (i.e. UPI, 
        SRMG, DDGS).</p>
    <p>
        Report only includes cars that have been placed.</p>
</body>
</html>
