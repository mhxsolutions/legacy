<%@ Page Title="Enter Fly Ash Times" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_flyashentry" Codebehind="flyashentry.aspx.cs" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        Enter Fly Ash Truck Times</p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            KeyFieldName="fly ash traffic ID" Theme="BlackGlass" 
            oninitnewrow="ASPxGridView1_InitNewRow">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="True" ShowNewButton="True" ShowDeleteButton="True"/>
                <dx:GridViewDataTextColumn FieldName="fly ash traffic ID" ReadOnly="True" 
                    Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Number" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Arrive" VisibleIndex="4" PropertiesDateEdit-UseMaskBehavior="True">
                    <PropertiesDateEdit DisplayFormatString="g" EditFormat="DateTime" 
                        EditFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Scale" VisibleIndex="5" PropertiesDateEdit-UseMaskBehavior="True">
                    <PropertiesDateEdit DisplayFormatString="g" EditFormat="DateTime" 
                        EditFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Release" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="g">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Depart" VisibleIndex="6" PropertiesDateEdit-UseMaskBehavior="True">
                    <PropertiesDateEdit DisplayFormatString="g" EditFormat="DateTime" 
                        EditFormatString="g">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Customer" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tare" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Gross" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Trailer" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Lot" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ticket" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rail Car" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Grease Bottom" VisibleIndex="18">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Grease Middle" VisibleIndex="19">
                </dx:GridViewDataCheckColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [fly ash traffic] ORDER BY [Arrive] DESC">
        </asp:SqlDataSource>
    </p>
</asp:Content>

