<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_BOLs" 
    Title="Shipments" CodeBehind="BOLs.aspx.cs" CodeFile="BOLs.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        All Bills of Lading<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="Load ID" DataSourceID="SqlDataSource1" 
        AllowPaging="True" Visible="False">
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Shipment Date" DataFormatString="{0:d}" HeaderText="Date"
                SortExpression="Shipment Date" />
            <asp:HyperLinkField DataNavigateUrlFields="Load ID" DataNavigateUrlFormatString="LoadTrackingReport.aspx?LoadRef={0}FON"
                DataTextField="Load ID" HeaderText="Load" SortExpression="Load ID" />
            <asp:BoundField DataField="Load Type" HeaderText="Load Type" SortExpression="Load Type" />
            <asp:CheckBoxField DataField="Shipped" HeaderText="Shipped" SortExpression="Shipped" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="Shipper" HeaderText="Shipper" ReadOnly="True" SortExpression="Shipper" />
            <asp:BoundField DataField="Receiver" HeaderText="Destination" ReadOnly="True" SortExpression="Receiver" >
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="POD Signed" HeaderText="POD Signed" SortExpression="POD Signed">
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="PDF File" HeaderText="POD link" HtmlEncode="False" ReadOnly="True"
                SortExpression="PDF File" />
            <asp:HyperLinkField DataNavigateUrlFields="Tally Load" 
                DataNavigateUrlFormatString="tally_detail.aspx?Load_ref={0}" 
                HeaderText="Tally Data" Text="Tally" />
            <asp:BoundField DataField="Age" HeaderText="Age" ReadOnly="True" SortExpression="Age" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" Wrap="False" />
    </asp:GridView>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load ID" 
        Theme="Metropolis">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn Caption="Date" FieldName="Shipment Date" 
                VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Load" FieldName="Load ID" 
                ReadOnly="True" VisibleIndex="3">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="loadtrackingreport.aspx?loadref={0}FON">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Load Type" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PO Ref" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper Number" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" FieldName="Receiver" 
                ReadOnly="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PDF File" ReadOnly="True" Visible="False" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="POD Link" FieldName="PDF File Name" 
                VisibleIndex="12">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="http//budwaydirect.com/pods/indexed pods/{0}" 
                    EncodeHtml="False" TextField="PDF File" TextFormatString="">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Shipped" VisibleIndex="5">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="POD Signed" VisibleIndex="10">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Tally Data" FieldName="Tally Load" 
                VisibleIndex="13">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="tally_detail.aspx?load_ref={0}" 
                    TextFormatString="Tally">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="True">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        
        SelectCommand="SELECT [Shipment Date], [Load ID], [Load Type], Shipper, Receiver, [Shipping Client Ref], [Delivery Client Ref], [PDF File], [PDF File Name], Age, LogOut AS Shipped, POD AS [POD Signed], [Tally Load], [Shipper Number], Fleet, [PO Ref] FROM COPSallBOLs WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) OR ([Delivery Client Ref] = @Delivery_Client_Ref) ORDER BY [Shipment Date] DESC, [Load ID] DESC">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
            <asp:SessionParameter Name="Delivery_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

