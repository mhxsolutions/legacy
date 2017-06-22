<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RailList.aspx.vb" Inherits="RailList" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Rail List - <a href="default.aspx">home</a></h3>
    
    </div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CP Date" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="PL Date" VisibleIndex="6">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="RL Date" VisibleIndex="7">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="CarType" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="E T A" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="WhseComplete" VisibleIndex="14">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings GroupInterval="Value" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status Flag" SortIndex="1" SortOrder="Ascending" Visible="False" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPS rail] WHERE ([Company ID Ref] = @Company_ID_Ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="Company_ID_Ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
