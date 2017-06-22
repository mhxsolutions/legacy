<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Rail.aspx.cs" Inherits="Customers__All_Rail" Title="BudwayDirect | Rail Plan" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


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
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="" Name="status"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridView runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Theme="Metropolis" ID="ctl00">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Car Number" FieldName="Car_Number" 
                SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="TransitInv.aspx?Car_Number={0}">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="CarType" 
                SortIndex="2" SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" 
                SortIndex="3" SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" 
                SortIndex="4" SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Type" 
                SortIndex="5" SortOrder="Ascending" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="WhseComplete" VisibleIndex="8" 
                Caption="Complete">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataDateColumn Caption="CP" FieldName="CP_Date" VisibleIndex="10">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="PL" FieldName="PL_Date" VisibleIndex="11">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="RL" FieldName="RL_Date" VisibleIndex="12">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" VisibleIndex="9">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" 
                SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    Complete - rail car has been processed and paperwork is complete<br />
    ETA - Estimated Time of Arrival at Terminal<br />
    CP - Constructively Placed - at local rail yard and ready for placement at 
    Terminal<br />
    PL - Placed at Terminal<br />
    RL - Released from Terminal
</asp:Content>

