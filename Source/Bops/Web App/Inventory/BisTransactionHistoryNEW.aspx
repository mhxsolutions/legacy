<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisTransactionHistoryNEW" Title="BOPS | Bulk Inventory System | Transaction History" Codebehind="BisTransactionHistoryNEW.aspx.cs" %>
    
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2><asp:Label ID="_PageTitleLabel" runat="server" Text="Transaction History"/></h2>
    
    <p>
        <asp:Button ID="_ShowAllButton" runat="server" Visible="false" Text="Show All Transactions" OnClick="_ShowAllButton_Click" />
        <dx:ASPxGridView ID="_HistoryGridviewNEW" runat="server" 
            AutoGenerateColumns="False" DataSourceID="_TransactionHistoryDatasource" 
            Theme="Aqua">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Origin Id" ReadOnly="True" 
                    VisibleIndex="5">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin Type" ReadOnly="True" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Name" ReadOnly="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tx Id" ReadOnly="True" VisibleIndex="0" 
                    SortIndex="0" SortOrder="Descending">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tx Type" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="User" ReadOnly="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Time" ReadOnly="True" VisibleIndex="3">
                    <PropertiesDateEdit AllowUserInput="False" DisplayFormatString="" 
                        EditFormat="DateTime" EditFormatString="hh:MM:ss">
                        <DropDownButton Enabled="False">
                        </DropDownButton>
                    </PropertiesDateEdit>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" ReadOnly="True" 
                    VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="###,###,###,###,###">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination Type" ReadOnly="True" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Destination Id" FieldName="Destination Ref" 
                    ReadOnly="True" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
    </p>
    
    
    <asp:SqlDataSource ID="_TransactionHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS [Origin Id], [BIS Storage Types].Name AS [Origin Type], [BIS Storage Assets].Name, [BIS Transactions].[Transaction Id] AS [Tx Id], [BIS Transaction Types].Description AS [Tx Type], [BIS Transactions].[User Id] AS [User], [BIS Transactions].Timestamp AS Time, [BIS Transactions].Quantity, [BIS Storage Types_1].Name AS [Destination Type], [BIS Transactions].[Destination Storage Asset Ref] AS [Destination Ref] FROM [BIS Transactions] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [BIS Storage Types] AS [BIS Storage Types_1] ON [BIS Transactions].[Destination Storage Asset Type Ref] = [BIS Storage Types_1].[Storage Type Id]">
    </asp:SqlDataSource>
</asp:Content>
