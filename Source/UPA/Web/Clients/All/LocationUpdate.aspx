<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LocationUpdate.aspx.cs" Inherits="Web.Clients.All.LocationUpdate" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Location Update</title>

    <style type="text/css">
       .exampleFormLayoutContainer 
       {
           vertical-align: top; 
           width: 100%
       }
       .settingsFormLayoutContainer 
       {
           vertical-align: top; 
           width: 350px
       }
    </style>

</head>
<body>
    
    <form id="form1" runat="server">
    <div>
    
        <h1>Update Inventory Locations (<a href="../../Default.aspx">home</a>)<br />
        </h1>

        <div>
            <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" EnableTheming="true" Theme="Moderno">
                <Items>
                    <dx:LayoutGroup Caption="Select New Location">
                        <Items>
                            <dx:LayoutItem Caption="New Location">
                                <LayoutItemNestedControlCollection >
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxComboBox ID="cboLocations" runat="server" ValueType="System.String" EnableTheming="True" Theme="Moderno" 
                                            DataSourceID="SqlDataSource2" TextField="Location Code" ValueField="Location ID"></dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem ShowCaption="False" RequiredMarkDisplayMode="Hidden" HorizontalAlign="Right" Width="100">
                                <LayoutItemNestedControlCollection >
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="btnSubmit" runat="server" Text="Move Items To Selected New Location" OnClick="btnSubmit_Click"  EnableTheming="True" Theme="Moderno"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>


        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Rec Detail ID" Theme="iOS">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowGroupedColumns="True" />
            <SettingsBehavior AllowSelectByRowClick="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowSelectCheckbox="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Rec Detail ID" ReadOnly="True" Visible="False" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PSEP" FieldName="Product Group 1" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" VisibleIndex="14" SortIndex="1" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="Product Group 5" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Heat#" FieldName="Heat Number" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Serial#" FieldName="Item ID" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Ct in Pkg" FieldName="Count In Package" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Receiver#" FieldName="Receiver ID" SortIndex="0" SortOrder="Ascending" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count In Package" ShowInColumn="Count In Package" SummaryType="Count" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Count In Package" SummaryType="Count" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory_Onsite] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Location ID], [Location Code] FROM Locations WHERE ([tblDestination ref] = 2145401161) ORDER BY [Location Code]"></asp:SqlDataSource>
    </div>


    <dx:ASPxPopupControl ID="ErrorPopup" runat="server" Text="" HeaderText="Cannot Update Inventory Locations"
        Width="300px" Height="200px" Modal="true" ShowCloseButton="false" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        ClientInstanceName="errpopup" EnableTheming="true" Theme="Moderno">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="border-spacing:10px;width:100%;">
                    <tr>
                        <td style="text-align:left;padding: 5px;">
                            <dx:ASPxLabel runat="server" ID="lblMessage" Text="" ForeColor="Red" Font-Bold="true" EnableTheming="true" Theme="Moderno" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;padding: 5px;">
                            <dx:ASPxButton ID="btnOK" runat="server" Text="OK" AutoPostBack="false" EnableTheming="true" Theme="Moderno">
                                <ClientSideEvents Click="function(s, e) { errpopup.Hide(); }" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ConfirmPopup" runat="server" Text="" HeaderText="Confirm Location Change"
        Width="350px" Height="200px" Modal="true" ShowCloseButton="false" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        ClientInstanceName="confirmpopup" EnableTheming="true" Theme="Moderno">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <table style="border-spacing:10px;width:100%;">
                    <tr>
                        <td style="text-align:left;padding: 5px;">
                            <dx:ASPxLabel runat="server" ID="lblConfirmMessage" Font-Bold="true" EnableTheming="true" Theme="Moderno" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;padding: 5px;">
                            <dx:ASPxButton ID="btnConfirmOk" runat="server" Text="OK" AutoPostBack="false" OnClick="btnConfirmOk_Click" EnableTheming="true" Theme="Moderno">
                            </dx:ASPxButton>&nbsp;&nbsp;&nbsp;
                            <dx:ASPxButton ID="btnConfirmCancel" runat="server" Text="Cancel" AutoPostBack="false" EnableTheming="true" Theme="Moderno">
                                <ClientSideEvents Click="function(s, e) { confirmpopup.Hide(); }" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    </form>
</body>
</html>
