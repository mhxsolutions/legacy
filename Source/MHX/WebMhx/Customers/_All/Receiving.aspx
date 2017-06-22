<%@ Page Title="Receiving History" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="Customers__All_Receiving" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Receiving History</h2>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="MetropolisBlue">
        </dx:ASPxButton>
    </p>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Receiving History" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Product Profile Description" Caption="Profile" VisibleIndex="5" SortIndex="2" SortOrder="Ascending"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="4" Caption="Terminal"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Recd Date" Caption="Received" VisibleIndex="0" PropertiesDateEdit-DisplayFormatString="{0:d}" MinWidth="110" SortIndex="0" SortOrder="Ascending">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="BOL" FieldName="Ship Date" MinWidth="110" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="6" Caption="Product"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group Label 1" VisibleIndex="7" Caption="Lable 1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 1" Caption="Product 1" VisibleIndex="8" SortIndex="3" SortOrder="Ascending"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Group Label 2" Caption="Label 2" VisibleIndex="9"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 2" Caption="Product 2" VisibleIndex="10" SortIndex="4" SortOrder="Ascending"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Group Label 3" Caption="Label 3" VisibleIndex="11"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 3" Caption="Product 3" VisibleIndex="12"></dx:GridViewDataTextColumn>

<dx:GridViewDataTextColumn FieldName="Group Label 4" Caption="Label 4" VisibleIndex="13" Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 4" Caption="Product 4" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Group Label 5" Caption="Lable 5" VisibleIndex="15" Visible="False"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product Group 5" Caption="Product 5" VisibleIndex="16" Visible="False"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="17"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Weight Label" Caption="Wt UoM" VisibleIndex="18"></dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Wt" Caption="Weight" VisibleIndex="19">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Unit" FieldName="Unit Label" VisibleIndex="20">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unit Count" VisibleIndex="21">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pcs in Pkg" FieldName="Count In Package" VisibleIndex="22">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Pcs" VisibleIndex="23">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="24" PropertiesTextEdit-DisplayFormatString="{0:f1}">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Status" Visible="False" VisibleIndex="25">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Terminal - Long" FieldName="Terminal" Visible="False" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons" Visible="False" VisibleIndex="26">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Shipped (logout)" FieldName="LogOutDate" MinWidth="110" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1" />

    <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Inventory All received and shipped summary with logoutdate] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


</asp:Content>

