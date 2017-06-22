<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Items_Shipped.aspx.vb" Inherits="Items_Shipped" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Data.Linq" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Items Shipped</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Intsel Inventory Shipped</h3>
        <p>
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Theme="Metropolis">
            </dx:ASPxButton>
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Item_ID" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG1" FieldName="Product_Group_1" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG2" FieldName="Product_Group_2" 
                    SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG3" FieldName="Product_Group_3" 
                    SortIndex="3" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Destination" FieldName="Dest_Client" 
                    VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="City" FieldName="Dest_City" 
                    VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="POD_Date" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver_ID" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Received" VisibleIndex="7">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load_ID" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Account" FieldName="Client_Name" 
                    VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" ReadOnly="True" 
                    VisibleIndex="11">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsPager PageSize="50">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" 
                ShowGroupedColumns="True" ShowGroupPanel="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT [Item ID] AS Item_ID, [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, Weight, [Dest Client] AS Dest_Client, [Dest City] AS Dest_City, [POD Date] AS POD_Date, [Receiver ID] AS Receiver_ID, [Date Received] AS Date_Received, [Load ID] AS Load_ID, [Client Name] AS Client_Name, [Ship Date], [Receiving Client Ref] FROM [Inventory All received and shipped] WHERE ([Ship Date] IS NOT NULL) AND ([Receiving Client Ref] = 2145373818) OR ([Ship Date] IS NOT NULL) AND ([Receiving Client Ref] = 2145293234)">
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="Intsel inventory shipped" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
