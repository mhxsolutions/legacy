<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PorjectTotals.aspx.vb" Inherits="PorjectTotals" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Summary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harbor Projects<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export Excel" Theme="MetropolisBlue">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="PMID" Theme="MetropolisBlue">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Project#" FieldName="PMID" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" SortIndex="1" SortOrder="Ascending" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="FFD" FieldName="Start Project" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="9">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product" FieldName="Product Type" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Port" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pier" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Berth" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewBandColumn Caption="Pieces" VisibleIndex="12">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Start" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Recd" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Balance" ReadOnly="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Loads" VisibleIndex="14">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="Start" FieldName="Loads" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Recd" FieldName="Loads Rcd" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Balance" FieldName="Load Balance" ReadOnly="True" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewDataDateColumn Caption="LFD" FieldName="End Project" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [wProjectTotalsWBal] WHERE ([company ID ref] = @company_ID_ref) and ([product type] not like '%closed%') and ([status] &lt;&gt;'billing')">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="harbor" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>


        <br />

        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />

        <br />

        <br />


    </form>
    <p>
        No Status closed or billing</p>
</body>
</html>
