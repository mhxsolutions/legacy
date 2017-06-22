<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Fon_PhoneReview.aspx.vb" Inherits="Fon_PhoneReview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fon Phone Times</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Phone Review - Fontana - <a href="fon.aspx">home</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            KeyFieldName="Planner Detail ID" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone Start" FieldName="STA Time" 
                    VisibleIndex="4">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone Arrive" FieldName="ARV Time" 
                    VisibleIndex="5">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn Caption="Phone End" FieldName="CMP Time" 
                    VisibleIndex="7">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="10">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="12">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn Caption="Plan Arrive" FieldName="Sch Arrive" 
                    VisibleIndex="6">
                </dx:GridViewDataTimeEditColumn>
            </Columns>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <Styles>
                <DetailRow Wrap="False">
                </DetailRow>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Agilis work order Progression INFO - Fontana]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
