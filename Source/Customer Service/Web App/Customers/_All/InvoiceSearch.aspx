<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InvoiceSearch" 
    CodeBehind="InvoiceSearch.aspx.cs" CodeFile="InvoiceSearch.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Invoice Search</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
            CssPostfix="Office2010Silver" DataSourceID="SqlDataSource1">
            <Columns>
                <dx:GridViewDataHyperLinkColumn Caption="Invoice" FieldName="ID" 
                    VisibleIndex="1">
                    <Settings AutoFilterCondition="BeginsWith" />
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="2">
                    <Settings AutoFilterCondition="BeginsWith" />
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="{0:c}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="7">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="25">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" />
            <Images SpriteCssFilePath="~/App_Themes/Office2010Silver/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
                CssPostfix="Office2010Silver">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <LoadingPanel ImageSpacing="5px">
                </LoadingPanel>
            </Styles>
            <StylesEditors ButtonEditCellSpacing="0">
                <ProgressBar Height="21px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [RFS Invoices].[RFS Invoice Id] AS ID, [RFS Invoices].[Invoice Date] AS Date, [RFS Invoices].[Shipper Client Ref], tbldestinationList1.Destination AS Shipper, [RFS Invoices].[Bill To Client Ref], tbldestinationList2.Destination AS [Bill-To], [RFS Invoices].[Invoice Total] AS Total, [RFS Invoices].[Public Notes] AS Notes, [RFS Invoices].[Hide From Clients] FROM [RFS Invoices] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList1 ON [RFS Invoices].[Shipper Client Ref] = tbldestinationList1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList2 ON [RFS Invoices].[Bill To Client Ref] = tbldestinationList2.[Destination id] WHERE ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND ([RFS Invoices].[Bill To Client Ref] = @BillToClient) AND ([RFS Invoices].[Hide From Clients] = 0) OR ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND (166073081 = @BillToClient) ORDER BY ID DESC">
            <SelectParameters>
                <asp:SessionParameter Name="BillToClient" SessionField="context_clientID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

