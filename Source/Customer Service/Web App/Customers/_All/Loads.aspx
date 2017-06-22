<%@ Page Title="Loads Delivered" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" CodeBehind="Loads.aspx.cs" 
    CodeFile="Loads.aspx.cs" Inherits="Web_App.Customers._All.Loads" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Dispatch History</h3>
<p>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
    </dx:ASPxButton>
</p>
<p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsAdaptivity AdaptivityMode="HideDataCells">
        </SettingsAdaptivity>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BOL" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="GrossWeight" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="5">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="6">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin Terminal" ReadOnly="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PDF File" Visible="False" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="PDF link" FieldName="PDF File Name" VisibleIndex="11">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="http//budwaydirect.com/pods/indexed pods/{0}" TextField="PDF File">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="13">
            </dx:GridViewDataCheckColumn>
        </Columns>
<Styles AdaptiveDetailButtonWidth="22">
    <Cell Wrap="False">
    </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Load], BOL, LoadDate, GrossWeight, LogOutDate, [POD Date], [Client ID], Shipper, [Origin Terminal], Destination, [PDF File], [PDF File Name], [Fleet ref], Fleet, [Company ID ref], [Dest Client ref], [Will Call] FROM [All Loads with Scanned POD] WHERE ([Company ID ref] = @Company_ID_ref) AND ([Client ID] = @Client_ID) OR ([Company ID ref] = @Company_ID_ref) AND ([Dest Client ref] = @Client_ID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            <asp:SessionParameter Name="Client_ID" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Dispatch History" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
</p>
<p>
    Trucking only - does not include rail shipments</p>
</asp:Content>
