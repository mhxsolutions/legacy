<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Pitt_test.aspx.vb" Inherits="Pitt_test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
    Theme="iOS">
    <Columns>
        <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
        <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" VisibleIndex="1">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="Planned" ReadOnly="True" VisibleIndex="3">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="Assigned" ReadOnly="True" 
            VisibleIndex="4">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="Sch Depart" VisibleIndex="5">
            <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
            </PropertiesDateEdit>
        </dx:GridViewDataDateColumn>
    </Columns>
    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
</dx:ASPxGridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
    SelectCommand="SELECT * FROM [Planner Status Detail - Pitt no log out]">
</asp:SqlDataSource>
</asp:Content>

