
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisStorageAssetsNEW" 
    Title="BOPS | Bulk Inventory System | Storage Assets" Codebehind="BisStorageAssetsNEW.aspx.cs" %>
    
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Storage Assets<dx:ASPxGridView ID="_StorageAssetsGridviewNEW" runat="server" 
            AutoGenerateColumns="False" DataSourceID="_StorageAssetsDatasource" 
            KeyFieldName="Id" 
            onhtmlrowcreated="_StorageAssetsGridviewNEW_HtmlRowCreated" Theme="Aqua">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="0" 
                SortIndex="0" SortOrder="Descending">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" ReadOnly="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Name" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" ReadOnly="True" 
                VisibleIndex="3">
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Quantity" ReadOnly="True" 
                VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="###,###,###,###,###">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="History" FieldName="Id" 
                VisibleIndex="6">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="BisTransactionHistoryNEW.aspx?AssetId={0}" 
                    Text="History">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataColumn VisibleIndex="7">
              <DataItemTemplate>
                    <asp:LinkButton ID="_TransferLinkbutton" runat="server" Text="Transfer" />               
              </DataItemTemplate>
            </dx:GridViewDataColumn>
            <dx:GridViewDataColumn VisibleIndex="8">
              <DataItemTemplate>
                    <asp:LinkButton ID="_DeactivateLinkbutton" runat="server" Text="Deactivate"  
                        OnClientClick='return confirm("Are you sure you want to deactivate the storage asset?");' />                  
              </DataItemTemplate>
            </dx:GridViewDataColumn>
        </Columns>
        <SettingsPager PageSize="30">
        </SettingsPager>
        <Settings ShowFilterRow="True" />
        </dx:ASPxGridView>
    </h2>

    <asp:SqlDataSource ID="_StorageAssetsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1)">
    </asp:SqlDataSource>
    
    <h3>Create New Storage Asset</h3>
    <p>
        <a href="BisStorageCreateAssetFromRailcar.aspx">Click here to create a new storage asset from a railcar.</a><br />
        <a href="BisStorageCreateSiloAsset.aspx">Click here to create a new silo.</a>
    </p>
</asp:Content>
