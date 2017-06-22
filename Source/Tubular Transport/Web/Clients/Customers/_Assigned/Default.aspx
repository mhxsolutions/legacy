
<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" 
    Inherits="CustomersAssignedDefault" Title="STAR Tools | Custom Reports" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Custom Reports<dx:ASPxGridViewExporter ID="CopReportExporter" runat="server">
        </dx:ASPxGridViewExporter>
    </h2>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="_CustomReportsDatasource"  
        EnableTheming="True" Theme="Metropolis">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Report Id" ReadOnly="True" 
                VisibleIndex="1" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Title" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="URL" VisibleIndex="4">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="../../{0}" Text="Link">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Client Id" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    
    <asp:SqlDataSource ID="_CustomReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Cops Assignable Reports].[Report Id], [Cops Assignable Reports].Title, [Cops Assignable Reports].Description, [Cops Assignable Reports].URL, [Cops Report Assignments].[Client Id], [DWS Rep Data].dbo.tbldestinationList.Destination FROM [Cops Assignable Reports] INNER JOIN [Cops Report Assignments] ON [Cops Assignable Reports].[Report Id] = [Cops Report Assignments].[Assignable Report Ref] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Cops Report Assignments].[Client Id] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE (@ContextUserId = 166073081) OR ([Cops Report Assignments].[Client Id] = @ContextUserId) OR (@ContextUserId = 2145260460)">
        <SelectParameters>
            <asp:SessionParameter Name="ContextUserId" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>
