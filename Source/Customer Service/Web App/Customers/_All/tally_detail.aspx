<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_tally_detail" Title="Tally Detail" CodeBehind="tally_detail.aspx.cs" CodeFile="tally_detail.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG Tally Detail<br />
    </h3>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load ID] AS Load_ID, [Fleet], [Profile], [Description], [Group 1] AS Group_1, [Group 2] AS Group_2, [Group 3] AS Group_3, [LnFt Actual] AS LnFt_Actual, [Rec Detail ID] AS Rec_Detail_ID FROM [Tally Detail] WHERE ([Load ID] = @Load_ID) ORDER BY [Description], [Rec Detail ID]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Load_ID" QueryStringField="load_ref" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export To Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Silver">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="LnFt_Actual" SummaryType="Sum" />
        </TotalSummary>
        <Columns>
            <dx:GridViewDataTextColumn Caption="BOL" FieldName="Load_ID" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Group_1" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mill" FieldName="Group_2" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Inspection" FieldName="Group_3" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="LNFT Measured" FieldName="LnFt_Actual" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rec_Detail_ID" SortIndex="0" 
                SortOrder="Ascending" Visible="False" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager AlwaysShowPager="True" PageSize="40">
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="Exporter1" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
</asp:Content>

