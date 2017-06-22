<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="encana_release_details.aspx.cs" Inherits="Customers__Assigned_encana_encana_release_details" Title="Release Details" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Release Details<br />
    </h3>
    <p>
        <strong>Encana<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Export to Excel" />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            KeyFieldName="encana cardex ID" Theme="Office2003Silver">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="encana cardex ID" ReadOnly="True" 
                    Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="part number" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="G/L Doc  Number" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Doc  Type" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Doc  Co" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PO" Visible="False" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="location" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Transaction  Date" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="G/L  Date" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Work  Area" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Trans  UoM" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Lot/Serial" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager AlwaysShowPager="True" PageSize="30">
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
        </strong></p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [encana cardex] WHERE ([Release] = @Release) ORDER BY [G/L Doc  Number], [Transaction  Date]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Release" QueryStringField="Release" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>TTL<br />
    </strong>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [encana release TTL detail] WHERE ([Release] = @Release) ORDER BY [BOL], [Product]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Release" QueryStringField="Release" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" EnableTheming="True" KeyFieldName="BOL" 
        Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Release" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BOL" ReadOnly="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT TTL" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager AlwaysShowPager="True" PageSize="30">
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
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>

