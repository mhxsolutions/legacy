<%@ Page Title="Proj Summary" Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" CodeBehind="BisProjSummary.aspx.cs" Inherits="Web_App.Inventory.BisProjSummary" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>BIS Project Summary</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Project Ref" 
            Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0">
                    <ClearFilterButton Visible="True">
                    </ClearFilterButton>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Transaction" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Timestamp" SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Seal Id" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Bill Of Lading" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Source Type" FieldName="Name" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Booking" FieldName="Booking Id" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Booking Date" FieldName="Create Timestamp" GroupIndex="0" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Source" FieldName="Rail" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Balance" FieldName="Current Quantity" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Container" FieldName="Container Ref" ReadOnly="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="50">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <Styles>
                <DetailRow Wrap="False">
                </DetailRow>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [CPS project summary by container]"></asp:SqlDataSource>
    </p>
</asp:Content>
