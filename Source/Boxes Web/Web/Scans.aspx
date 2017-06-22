<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Scans.aspx.vb" Inherits="Scans" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Scans</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>All Scans</h3>
        <p>data from [Scans] table<br />
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" Width="95%">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="20">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="DOC Scanned" VisibleIndex="1" SortIndex="1" SortOrder="Ascending">
                    <PropertiesTextEdit DisplayFormatString="{0}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="DOC Type Ref" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="POD Path" VisibleIndex="6" Caption="Access File Path">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Reject Ref" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Comment" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Signed POD" VisibleIndex="12">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="Date Scanned" VisibleIndex="0" SortIndex="0" SortOrder="Descending">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Date Confirmed" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Confirmed By" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="POD File" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="PDF Link" ReadOnly="True" VisibleIndex="3">
                    <PropertiesHyperLinkEdit EncodeHtml="False">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="Doc Link" ReadOnly="True" VisibleIndex="4">
                    <PropertiesHyperLinkEdit EncodeHtml="False">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn Caption="Web formatted file path" FieldName="web path" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
<Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Scans All - web links]"></asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        If you receive a 404 error there are two possibilities:</p>
    <p>
        (1) the path has been incorrectly saved</p>
    <p>
        (2) the file was not saved to the matching location</p>
</body>
</html>
