<%@ Page Title="Transaction History" Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" CodeBehind="BisTransactionHistoryDX.aspx.cs" Inherits="Web_App.Inventory.BisTransactionHistoryDX" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Transaction History</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0">
                    <ClearFilterButton Visible="True">
                    </ClearFilterButton>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Origin Type" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Name" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tx Id" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tx Type" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="User" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Storage Asset ID" FieldName="Origin Id" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Time" VisibleIndex="5">
                    <PropertiesDateEdit DisplayFormatString="g">
                    </PropertiesDateEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination Type" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination Ref" VisibleIndex="10">
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS [Origin Id], [BIS Storage Types].Name AS [Origin Type], [BIS Storage Assets].Name, [BIS Transactions].[Transaction Id] AS [Tx Id], [BIS Transaction Types].Description AS [Tx Type], [BIS Transactions].[User Id] AS [User], [BIS Transactions].Timestamp AS Time, [BIS Transactions].Quantity, [BIS Storage Types_1].Name AS [Destination Type], [BIS Transactions].[Destination Storage Asset Ref] AS [Destination Ref] FROM [BIS Transactions] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [BIS Storage Types] AS [BIS Storage Types_1] ON [BIS Transactions].[Destination Storage Asset Type Ref] = [BIS Storage Types_1].[Storage Type Id]">
        </asp:SqlDataSource>
    </p>
</asp:Content>
