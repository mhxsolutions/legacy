
<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers__All_ContainerProjectDetail" Title="BudwayDirect - Container Project Detail" 
    CodeBehind="ContainerProjectDetail.aspx.cs" CodeFile="ContainerProjectDetail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Container Project Detail</h2>
    
    <h3>Project Details</h3>
    <asp:SqlDataSource ID="_ProjectDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill To Client], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].Berth, [CPS Projects].[Shipping Line], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS [Default Origin], tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS [Default Destination], [CPS Projects].[Begin Date], [CPS Projects].[Demurrage Days], [CPS Projects].[Total Containers], CASE WHEN [Complete] = 1 THEN 'Yes' ELSE 'No' END AS Complete FROM [CPS Projects] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [CPS Projects].[Default Origin Ref] = tbldestinationList_1.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [CPS Projects].[Default Destination Ref] = tbldestinationList_2.[Destination id] WHERE ([CPS Projects].[Project Id] = @ProjectId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h3>Container Details<dx:ASPxGridView ID="ASPxGridView1" runat="server" 
            AutoGenerateColumns="False" DataSourceID="_ProjectDatasource" 
            EnableTheming="True" KeyFieldName="Project Id" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn Caption="ID" FieldName="Project Id" ReadOnly="True" 
                VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Booking" FieldName="Bill To Client" 
                ReadOnly="True" Visible="False" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Booking Id" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Berth" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipping Line" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Origin" FieldName="Default Origin" 
                ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" 
                FieldName="Default Destination" ReadOnly="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Begin" FieldName="Begin Date" 
                VisibleIndex="9">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Demurrage Days" Visible="False" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count" FieldName="Total Containers" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Complete" ReadOnly="True" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter" runat="server">
        </dx:ASPxGridViewExporter>
    </h3>

    <p>
        <asp:Button ID="_ExportToExcelButton" runat="server" Text="Export to Excel" OnClick="_ExportToExcelButton_Click" />
    </p>
    
    <asp:SqlDataSource ID="_ContainersDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id] AS Booking, [CPS Projects].[Shipping Line], [CPS Projects].Complete, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS CPS Transactions].[Container Ref] AS [Container Id], COUNT([BIS Transactions].[Transaction Id]) AS [Tx Count], SUM([BIS Transactions].Quantity) AS [Total Weight], [BIS CPS Container Data].[Seal Id], [BIS CPS Container Data].[Test Id], [BIS CPS Container Data].[Bill Of Lading], Clients.[Client Name] AS Location, [CPS Containers].[Last Known Location Timestamp] AS [Location Date] FROM [BIS CPS Transactions] INNER JOIN [BIS Transactions] ON [BIS CPS Transactions].[BIS Transaction Ref] = [BIS Transactions].[Transaction Id] INNER JOIN [CPS Projects] ON [BIS CPS Transactions].[Project Ref] = [CPS Projects].[Project Id] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Transactions].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [BIS CPS Container Data] ON [BIS CPS Transactions].[Project Ref] = [BIS CPS Container Data].[Project Ref] AND [BIS CPS Transactions].[Container Ref] = [BIS CPS Container Data].[Container Ref] INNER JOIN [CPS Containers] ON [BIS CPS Transactions].[Container Ref] = [CPS Containers].[Container Id] INNER JOIN Clients ON [CPS Containers].[Last Known Location Ref] = Clients.[Client ID] GROUP BY [CPS Projects].[Booking Id], [CPS Projects].[Shipping Line], [BIS CPS Transactions].[Container Ref], [DWS Rep Data].dbo.[ATSF Product Type].[Product Type], [CPS Projects].Complete, [CPS Projects].[Project Id], [BIS CPS Container Data].[Seal Id], [BIS CPS Container Data].[Test Id], [BIS CPS Container Data].[Bill Of Lading], [CPS Projects].[Bill To Client Ref], Clients.[Client Name], [CPS Containers].[Last Known Location Timestamp] HAVING ([CPS Projects].[Bill To Client Ref] = @ClientId) AND ([CPS Projects].[Project Id] = @ProjectId)">
        <SelectParameters>
            <asp:SessionParameter Name="ClientId" SessionField="CONTEXT_CLIENTID" />
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="_ContainersDatasource" EnableTheming="True" 
        KeyFieldName="Project Id" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Project Id" ReadOnly="True" 
                Visible="False" VisibleIndex="0">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Booking" Visible="False" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipping Line" Visible="False" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Complete" Visible="False" 
                VisibleIndex="3">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Product" Visible="False" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Container" FieldName="Container Id" 
                SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tx Count" ReadOnly="True" Visible="False" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Net Weight" FieldName="Total Weight" 
                ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Seal" FieldName="Seal Id" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Test" FieldName="Test Id" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="BOL" FieldName="Bill Of Lading" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Location Date" VisibleIndex="12">
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>

</asp:Content>

