<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="wellsite transaction.aspx.cs" Inherits="Customers__Assigned_wellsite_transaction" Title="Transactions by Well Site" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Transactions by Well Site (BETA)</h3>
    <br />
    Select Product:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Product" DataValueField="Product">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Product] FROM [TTL well site transactions] WHERE ([Client Ref] = @Client_Ref) ORDER BY [Product]">
        <SelectParameters>
            <asp:SessionParameter Name="Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridViewExporter ID="WellSitedExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Transaction Date" ReadOnly="True" 
                VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Well_Site" ReadOnly="True" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" ReadOnly="True" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Inspection" ReadOnly="True" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct_to_Rig" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LnFt_to_Rig" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct_Returned" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LnFt_Returned" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Items="10, 30, 50, 100, 200" ShowAllItem="True" 
                Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Transaction Date], [Well Site] AS Well_Site, Description, Inspection, [Ct to Rig] AS Ct_to_Rig, [LnFt to Rig] AS LnFt_to_Rig, [Ct Returned] AS Ct_Returned, [LnFt Returned] AS LnFt_Returned FROM [TTL well site transactions] WHERE ([Client Ref] = @Client_Ref) AND (Product = @Product ) ORDER BY [Transaction Date] DESC, Well_Site">
        <SelectParameters>
            <asp:SessionParameter Name="Client_Ref" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Product" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>

