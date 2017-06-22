<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pitt_PhoneReview.aspx.vb" Inherits="Pitt_PhoneReview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pitt - Phone Review</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        Phone Review - Pittsburg - <a href="pitt_default.aspx">home</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" 
            DataSourceID="SqlDataSource1" AutoGenerateColumns="False" 
            EnableTheming="True" KeyFieldName="Planner Detail ID" Theme="Aqua">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone Start" FieldName="STA Time" 
                    VisibleIndex="3">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone Arrive" FieldName="ARV Time" 
                    VisibleIndex="4">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone End" FieldName="CMP Time" 
                    VisibleIndex="8">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn Caption="Plan Arrive" FieldName="Sch Arrive" 
                    VisibleIndex="5">
                </dx:GridViewDataTimeEditColumn>
            </Columns>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Agilis work order progression INFO - Pitt]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
