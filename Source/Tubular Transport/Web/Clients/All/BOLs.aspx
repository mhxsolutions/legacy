<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="BOLs.aspx.cs" Inherits="Customers__All_BOLs" Title="Shipments" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        All Delivery Bills of Lading<br />
    </h3>
            <script type="text/javascript">
    // <![CDATA[
                var keyValue;
                function OnMoreInfoClick(element, key) {
                    callbackPanel.SetContentHtml("");
                    popup.ShowAtElement(element);
                    keyValue = key;
                }
                function popup_Shown(s, e) {
                    callbackPanel.PerformCallback(keyValue);
                }
    // ]]> 
    </script>
    <dx:ASPxGridViewExporter ID="BOLGgrid1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" KeyFieldName="Load ID" 
        Theme="Metropolis" onhtmlrowprepared="ASPxGridView1_HtmlRowPrepared" 
        onhtmldatacellprepared="ASPxGridView1_HtmlDataCellPrepared" 
        oninit="ASPxGridView1_Init1">
        

        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFooter="True" />

        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="50">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        

<Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible"></Settings>


        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>

        <SettingsSearchPanel Visible="True" />


        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="1" 
                SortIndex="0" SortOrder="Descending">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="Load" VisibleIndex="4">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="loadtrackingreport.aspx?loadref={0}">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Load Type" VisibleIndex="5">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver" ReadOnly="True" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipping Client Ref" Visible="False" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Delivery Client Ref" Visible="False" 
                VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="PDF_link_w_load" ReadOnly="True" VisibleIndex="14" Caption="POD Scan">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="" 
                    TextFormatString="" EncodeHtml="False">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="PDF File Name" VisibleIndex="15" 
                Caption="POD Link" Visible="False">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="http://budwaydirect.com/PODs/Indexed PODs/{0}" 
                    TextFormatString="" EncodeHtml="False" TextField="PDF File">
                    
<Style ForeColor="#0066FF">
                    </Style>
                
</PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Shipped" VisibleIndex="6">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="POD Signed" VisibleIndex="11">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Tally Data (LNFT)" FieldName="Tally Load" 
                VisibleIndex="16">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="tally_detail.aspx?load_ref={0}" TextField="LNFT Measured" TextFormatString="{0:n1}">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn Caption="Shipper Number" FieldName="Shipper Number" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn Caption="Client Confirmation" FieldName="Client A" 
                VisibleIndex="18">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Client Note" VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PO Ref" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="BOL" FieldName="Load ID" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
        </Columns>

        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        
        
        SelectCommand="SELECT [Shipment Date], [Load ID], [Load Type], Shipper, Receiver, [Shipping Client Ref], [Delivery Client Ref], [PDF File], [PDF File Name], Age, LogOut AS Shipped, POD AS [POD Signed], [Tally Load], [Shipper Number], Fleet, [Client A], [Client Note], [PO Ref], PDF_link_w_load, [Load], [LNFT Measured] FROM COPSallBOLs WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) OR ([Delivery Client Ref] = @Delivery_Client_Ref) ORDER BY [Shipment Date] DESC, [Load ID] DESC">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
            <asp:SessionParameter Name="Delivery_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

