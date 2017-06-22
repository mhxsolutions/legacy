<%@ Page Language="VB" AutoEventWireup="false" CodeFile="rail_without_prerecv.aspx.vb" Inherits="rail_without_prerecv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail wout Pre-Receiver</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Rail Without Pre-Receiver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Theme="Metropolis">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="E T A" VisibleIndex="3">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Shipper" ShowInCustomizationForm="True" VisibleIndex="5"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Content" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [Railcars without prereceiver]">
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        Report filters out UPI and SRMG.</p>
    <p>
        Report only includes cars in transit or at rail yard.</p>
    <p>
        All cars on report are missing pre-receiver.</p>
</body>
</html>
