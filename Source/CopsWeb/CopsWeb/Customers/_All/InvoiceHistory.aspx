<%@ Page Title="BudwayDirect | Invoice History" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="InvoiceHistory.aspx.cs" Inherits="Customers__All_InvoiceHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Invoice History</h2>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="InvoiceHistoryDatasource" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>

        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataHyperLinkColumn FieldName="ID" Caption="Invoice" VisibleIndex="0" PropertiesHyperLinkEdit-NavigateUrlFormatString="InvoiceDisplay.aspx?InvoiceId={0}">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="InvoiceDisplay.aspx?InvoiceId={0}"></PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataDateColumn FieldName="Date" Caption="Date" VisibleIndex="1" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <PropertiesDateEdit DisplayFormatString="{0:d}"></PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Hide From Clients" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Bill-To" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="6"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="7"></dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="ID" Caption="POD scans" PropertiesHyperLinkEdit-Text="View" VisibleIndex="8" PropertiesHyperLinkEdit-NavigateUrlFormatString="InvoiceSupportingDocumentsDisplay.aspx?InvoiceId={0}">
                <PropertiesHyperLinkEdit Text="View" NavigateUrlFormatString="InvoiceSupportingDocumentsDisplay.aspx?InvoiceId={0}" EncodeHtml="False"></PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="InvoiceHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Invoices].[RFS Invoice Id] AS ID, [RFS Invoices].[Invoice Date] AS Date, [RFS Invoices].[Shipper Client Ref], tbldestinationList1.Destination AS Shipper, [RFS Invoices].[Bill To Client Ref], tbldestinationList2.Destination AS [Bill-To], [RFS Invoices].[Invoice Total] AS Total, [RFS Invoices].[Public Notes] AS Notes, [RFS Invoices].[Hide From Clients] FROM [RFS Invoices] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList1 ON [RFS Invoices].[Shipper Client Ref] = tbldestinationList1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList2 ON [RFS Invoices].[Bill To Client Ref] = tbldestinationList2.[Destination id] WHERE ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND ([RFS Invoices].[Bill To Client Ref] = @BillToClient) AND ([RFS Invoices].[Hide From Clients] = 0) OR ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND (166073081 = @BillToClient) ORDER BY ID DESC">
        <SelectParameters>
            <asp:SessionParameter Name="BillToClient" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

