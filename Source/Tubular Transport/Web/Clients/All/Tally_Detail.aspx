<%@ Page Title="Tally" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Tally_Detail.aspx.cs" Inherits="Clients_All_Tally_Detail" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Tally Detail</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" 
            onclick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis" 
            Width="88px" Height="23px">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" Height="23px" OnClick="ASPxButton2_Click" Text="Export PDF" Theme="Metropolis" Width="88px">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" Theme="Metropolis">
            <Columns>
                <dx:GridViewDataTextColumn Caption="BOL" FieldName="Load_ID" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product Code" FieldName="Group_1" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Mill" FieldName="Group_2" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inspection" FieldName="Group_3" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="LNFT Measured" FieldName="LnFt_Actual" 
                    VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Rec_Detail_ID" SortIndex="0" 
                    SortOrder="Ascending" Visible="False" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="40">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowGroupPanel="True" ShowFooter="True" />
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="LnFt_Actual" ShowInColumn="LNFT Measured" SummaryType="Sum" />
            </TotalSummary>
        </dx:ASPxGridView>
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load ID] AS Load_ID, [Fleet], [Profile], [Description], [Group 1] AS Group_1, [Group 2] AS Group_2, [Group 3] AS Group_3, [LnFt Actual] AS LnFt_Actual, [Rec Detail ID] AS Rec_Detail_ID FROM [Tally Detail] WHERE ([Load ID] = @Load_ID) ORDER BY [Description], [Rec Detail ID]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Load_ID" QueryStringField="load_ref" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Tally" 
            GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

