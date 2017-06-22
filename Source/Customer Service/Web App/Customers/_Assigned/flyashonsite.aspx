<%@ Page Title="Rail Inventory" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_flyashonsite" CodeFile="flyashonsite.aspx.cs" Codebehind="flyashonsite.aspx.cs" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Fly Ash Rail Inventory on-site</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Silver">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Unload_Status" ShowInColumn="Loads Remaining" 
                    SummaryType="Sum" />
            </TotalSummary>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn Caption="Car Number" FieldName="Car_Number" 
                    SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Type" 
                    VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Loads Remaining" FieldName="Unload_Status" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT [Car Number] AS Car_Number, [Product Type] AS Product_Type, [Unload Status] AS Unload_Status FROM [fly ash on site inventory]">
        </asp:SqlDataSource>
    </p>
</asp:Content>

