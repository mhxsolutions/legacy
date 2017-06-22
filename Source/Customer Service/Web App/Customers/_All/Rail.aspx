<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Rail" 
    Title="BudwayDirect | Rail Plan" CodeBehind="Rail.aspx.cs" CodeFile="Rail.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Rail Data</h3>
    Select Status:<br />
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Status" DataValueField="Status">
        <asp:ListItem Value="1">Pending</asp:ListItem>
        <asp:ListItem Value="2">Rail Yard</asp:ListItem>
        <asp:ListItem Selected="True" Value="3">Budway Unloading</asp:ListItem>
        <asp:ListItem Value="4">Budway Loading</asp:ListItem>
        <asp:ListItem Value="5">Released</asp:ListItem>
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
        SelectCommand="SELECT [Status] FROM [ATSF Status] WHERE ([Status Flag ID] <= @Status_Flag_ID) ORDER BY [Status Flag ID]">
        <SelectParameters>
            <asp:Parameter DefaultValue="5" Name="Status_Flag_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <dx:ASPxGridViewExporter ID="OCTGgrid1" runat="server">
    </dx:ASPxGridViewExporter>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
        SelectCommand="SELECT [Car Number] AS Car_Number, Status, CarType, Shipper, Carrier, [Product Type] AS Product_Type, WhseComplete, [CP Date] AS CP_Date, [PL Date] AS PL_Date, [RL Date] AS RL_Date, [E T A] AS E_T_A, Terminal FROM [COPS rail] WHERE ([Client Ref] = @Client_Ref) AND (Status = @status) ORDER BY Car_Number">
        <SelectParameters>
            <asp:SessionParameter Name="Client_Ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="unloading" Name="status"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the excel" />
    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn Caption="Car Number" FieldName="Car_Number" 
                ShowInCustomizationForm="True" SortIndex="1" SortOrder="Ascending" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Status" ShowInCustomizationForm="True" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CarType" ShowInCustomizationForm="True" 
                SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ShowInCustomizationForm="True" 
                SortIndex="3" SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" ShowInCustomizationForm="True" 
                SortIndex="4" SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Type" 
                ShowInCustomizationForm="True" SortIndex="5" SortOrder="Ascending" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="WhseComplete" 
                ShowInCustomizationForm="True" VisibleIndex="8">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataDateColumn Caption="CP" FieldName="CP_Date" 
                ShowInCustomizationForm="True" VisibleIndex="10">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="PL" FieldName="PL_Date" 
                ShowInCustomizationForm="True" VisibleIndex="11">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="RL" FieldName="RL_Date" 
                ShowInCustomizationForm="True" VisibleIndex="12">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" 
                ShowInCustomizationForm="True" VisibleIndex="9">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" ShowInCustomizationForm="True" 
                SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
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
</asp:Content>

