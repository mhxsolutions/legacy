<%@ Page Title="BudwayDirect | Loads by Vessel" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Vessel_Loads.aspx.cs" Inherits="Customers__All_Vessel_Loads" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Loads by Vessel</h2>
    <div class="contentDiv">
        <p>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                DataTextField="Vessel" DataValueField="Vessel">
            </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                SelectCommand="SELECT DISTINCT [Vessel], [FFD], [LFD] FROM [COPSHarborLoadsByVessel] WHERE ([Ship Client Ref] = @Ship_Client_Ref) ORDER BY [Vessel]">
                <SelectParameters>
                    <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
        </p>
    </div>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="Vessel_Loads" />


    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource3" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <Columns>
            <dx:GridViewDataDateColumn FieldName="FFD" VisibleIndex="0" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="LFD" VisibleIndex="1" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [FFD], [LFD] FROM [COPSHarborLoadsByVessel] WHERE (([Vessel] = @Vessel) AND ([Ship Client Ref] = @Ship_Client_Ref))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Vessel" PropertyName="SelectedValue"
                Type="String" />
            <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False">
        <Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>

        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="0" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <PropertiesDateEdit DisplayFormatString="{0:d}"></PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="DR" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="column1" VisibleIndex="2" Caption="Load"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="PDF_File" VisibleIndex="4">
                <PropertiesHyperLinkEdit EncodeHtml="False">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DR, [Load/PUR] AS column1, [PDF File] AS PDF_File, Date, [Dest Client Ref], [Recv Client Ref], Destination FROM COPSHarborLoadsByVessel WHERE (Vessel = @Vessel) AND ([Ship Client Ref] = @Ship_Client_Ref) OR (Vessel = @Vessel) AND ([Dest Client Ref] = @Ship_Client_Ref) OR (Vessel = @Vessel) AND ([Recv Client Ref] = @Ship_Client_Ref) ORDER BY Date">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Vessel" PropertyName="SelectedValue" Type="String" />
            <asp:SessionParameter Name="Ship_Client_Ref" SessionField="context_clientid" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

