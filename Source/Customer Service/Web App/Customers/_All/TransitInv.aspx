<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_TransitInv" Title="In-Transit Inventory" CodeBehind="TransitInv.aspx.cs" CodeFile="TransitInv.aspx.cs"%>
<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        In-Transit Inventory<br />
    </h2>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the Excel" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [E T A] AS E_T_A, [Car Number] AS Car_Number, Receiver, [Product Group 1] AS Product_Group_1, [Item Count] AS Item_Count, Pounds, Shipper, LNFT, Profile, Type FROM [inventory in Transit PG1 summary] WHERE (ReceiverID = @ReceiverID) ORDER BY E_T_A, Car_Number">
        <SelectParameters>
            <asp:SessionParameter Name="ReceiverID" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Silver">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Car_Number" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Desc" FieldName="Receiver" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_1" Visible="False" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item Ct" FieldName="Item_Count" 
                VisibleIndex="9">
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Footage" FieldName="LNFT" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="2">
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
    <dx:ASPxGridViewExporter ID="TransInvExport" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>

