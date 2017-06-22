<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisContainerProjectsNEW" 
    Title="BOPS | Bulk Inventory System | Container Projects" Codebehind="BisContainerProjectsNEW.aspx.cs" %>
    
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <h2>Container Projects<dx:ASPxGridView ID="_ProjectsGridviewNEW" runat="server" 
            AutoGenerateColumns="False" DataSourceID="_ProjectsDatasource"
            KeyFieldName="Project Id" EnableTheming="True" Theme="Aqua">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Project Id" ReadOnly="True" 
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Booking" VisibleIndex="2" ReadOnly="True" 
                GroupIndex="0" SortIndex="0" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Bill-To" ReadOnly="True" VisibleIndex="3">
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipping Line" VisibleIndex="4" 
                ReadOnly="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Complete" VisibleIndex="5" 
                ReadOnly="True">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="6" ReadOnly="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="Url" 
                ReadOnly="True" VisibleIndex="7" Caption="Container Id">
                <PropertiesHyperLinkEdit TextField="Container Id">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Tx Count" ReadOnly="True" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Weight" ReadOnly="True" 
                VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="###,###,###,###,###">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
    </h2>
    <asp:SqlDataSource ID="_ProjectsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                       SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id] AS Booking, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill-To], [CPS Projects].[Shipping Line], [CPS Projects].Complete, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS CPS Transactions].[Container Ref] AS [Container Id], 'BisContainerProjectTransactions.aspx?ProjectId='  + CAST([CPS Projects].[Project Id] AS CHAR(7)) + '&ContainerId=' + [BIS CPS Transactions].[Container Ref] AS Url, COUNT([BIS Transactions].[Transaction Id]) AS [Tx Count], SUM([BIS Transactions].Quantity) AS [Total Weight] FROM [BIS CPS Transactions] INNER JOIN [BIS Transactions] ON [BIS CPS Transactions].[BIS Transaction Ref] = [BIS Transactions].[Transaction Id] INNER JOIN [CPS Projects] ON [BIS CPS Transactions].[Project Ref] = [CPS Projects].[Project Id] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Transactions].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] GROUP BY [CPS Projects].[Booking Id], [CPS Projects].[Shipping Line], [BIS CPS Transactions].[Container Ref], [DWS Rep Data].dbo.[ATSF Product Type].[Product Type], [CPS Projects].Complete, [CPS Projects].[Project Id], [DWS Rep Data].dbo.tbldestinationList.Destination, [DWS Rep Data].dbo.tbldestinationList.City, [DWS Rep Data].dbo.tbldestinationList.State">
    </asp:SqlDataSource>
    
</asp:Content>
