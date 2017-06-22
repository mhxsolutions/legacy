<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Container_Proj.aspx.vb" Inherits="Container_Proj" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Container Proj</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Container Project Summary</h3>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Transaction" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Timestamp" SortIndex="5" 
                    SortOrder="Ascending" VisibleIndex="5">
                    <PropertiesDateEdit DisplayFormatString="g" EditFormat="DateTime">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Seal Id" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Bill Of Lading" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Source" FieldName="Rail" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Source Type" FieldName="Name" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Booking" FieldName="Booking Id" 
                    GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Booking Date" FieldName="Create Timestamp" 
                    GroupIndex="0" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Balance" FieldName="Current Quantity" 
                    VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Container" FieldName="Container Ref" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [CPS project summary by container]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
