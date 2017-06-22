<%@ Page Title="BOL List" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="BOLs.aspx.cs" Inherits="Customers__All_BOLs" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h3>All Loads, POD&#39;s and Tallys</h3>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="BOLs" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
        DataSourceID="SqlDataSource1" KeyFieldName="Load ID" Width="98%">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn Caption="BOL Date" FieldName="BOL Date"
                VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
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
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PO Ref" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper Number" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" FieldName="Receiver"
                ReadOnly="True" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <%--<dx:GridViewDataTextColumn FieldName="PDF File" ReadOnly="True" Visible="False"
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            

            <dx:GridViewDataHyperLinkColumn Caption="POD Link" FieldName="PDF File Name" PropertiesHyperLinkEdit-TextField="PDF File"
                VisibleIndex="12">
                <PropertiesHyperLinkEdit Target="_blank" NavigateUrlFormatString="http//budwaydirect.com/pods/indexed pods/{0}" 
                    EncodeHtml="False" TextField="PDF File" TextFormatString="">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataHyperLinkColumn Caption="POD Link" FieldName="PDF File Name" PropertiesHyperLinkEdit-TextField="PDF File"
                VisibleIndex="12">
                <PropertiesHyperLinkEdit Target="_blank" NavigateUrlFormatString="http//budwaydirect.com/pods/indexed pods/{0}<% Eval(GetFileName()) %>" 
                    EncodeHtml="False" TextField="PDF File" TextFormatString="">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>--%>

            <dx:GridViewDataHyperLinkColumn FieldName="PDF File" VisibleIndex="12">
                <DataItemTemplate>
                    <%# SetTarget(Eval("PDF File")) %>
                </DataItemTemplate>
            </dx:GridViewDataHyperLinkColumn>


            <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Shipped" VisibleIndex="5">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn FieldName="POD Signed" VisibleIndex="11">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Tally Data" FieldName="Tally Load"
                VisibleIndex="13">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="tally_detail.aspx?load_ref={0}"
                    TextFormatString="Tally">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="6">
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1" /><br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"

        SelectCommand="SELECT [Shipment Date], [Load ID], [Load Type], Shipper, Receiver, [Shipping Client Ref], [Delivery Client Ref], [PDF File], [PDF File Name], Age, LogOut AS Shipped, POD AS [POD Signed], [Tally Load], [Shipper Number], Fleet, [PO Ref], [BOL Date] FROM COPSallBOLs WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) OR ([Delivery Client Ref] = @Delivery_Client_Ref)">        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
            <asp:SessionParameter Name="Delivery_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

