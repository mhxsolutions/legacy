<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_TransitConsigned" Title="In-Transit Consigned" CodeBehind="TransitConsigned.aspx.cs" CodeFile="TransitConsigned.aspx.cs"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        In-Transit Consigned Inventory<br />
    </h3>
    <p>
        Inventory held by 3rd party for current User, not owned by current User.</p>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Car Number" FieldName="Car_Number" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_1" Visible="False" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item Ct" FieldName="Item_Count" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="6">
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
    <dx:ASPxGridViewExporter ID="TransConExport" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [E T A] AS E_T_A, [Car Number] AS Car_Number, Receiver, [Product Group 1] AS Product_Group_1, [Item Count] AS Item_Count, Pounds, Shipper, LNFT, Type, Description FROM [Inventory in Transit Consignment PG1 Summary] WHERE ([Auth Viewer Ref] = @ReceiverID) ORDER BY E_T_A, Car_Number">
        <SelectParameters>
            <asp:SessionParameter Name="ReceiverID" SessionField="context_clientid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

