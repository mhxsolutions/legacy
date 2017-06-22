<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" CodeBehind="dhtest.aspx.cs" CodeFile="dhtest.aspx.cs" 
    Inherits="Web_App.Customers._All.dhtest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <a href="/PODs/indexed%20PODs/2015/6/Receiver/10117_Receiver_2123.PDF">link</a></p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="flag" VisibleIndex="1">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="note" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="value" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [a test table]"></asp:SqlDataSource>
    </p>
</asp:Content>
