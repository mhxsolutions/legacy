<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="encana_release_review.aspx.cs" Inherits="Customers__All_encana_release_review" Title="Release Review" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Release Review</h3>
    Part Number:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
        DataTextField="part_number" DataValueField="part_number">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [part number] AS part_number FROM [encana cardex] ORDER BY [part number]">
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Silver">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Release" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="part number" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT encana" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT TTL" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Delta" ReadOnly="True" VisibleIndex="5">
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
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Release, [part number], [LNFT encana], [LNFT TTL], Delta FROM [encana release cp ttl] WHERE ([part number] = @PN) ORDER BY Release">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="PN" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

