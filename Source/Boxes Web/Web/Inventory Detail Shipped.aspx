<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory Detail Shipped.aspx.vb" Inherits="Web_Inventory_Detail_Shipped" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory Shipped</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Inventory Shipped</h3>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Item_ID" SortIndex="1" SortOrder="Ascending" VisibleIndex="1" Caption="Item ID">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG1" FieldName="Product_Group_1" VisibleIndex="4" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG2" FieldName="Product_Group_2" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG3" FieldName="Product_Group_3" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest_Client" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest_City" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="POD_Date" VisibleIndex="12">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver_ID" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Received" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load_ID" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inventory Client" FieldName="Client_Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Item ID] AS Item_ID, [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, Weight, [Dest Client] AS Dest_Client, [Dest City] AS Dest_City, [POD Date] AS POD_Date, [Receiver ID] AS Receiver_ID, [Date Received] AS Date_Received, [Load ID] AS Load_ID, [Client Name] AS Client_Name, [Ship Date] FROM [Inventory All received and shipped] WHERE ([Company ID ref] = @Company_ID_ref) AND ([Ship Date] IS NOT NULL)">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" ExportEmptyDetailGrid="True" FileName="Inventory Shipped" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
