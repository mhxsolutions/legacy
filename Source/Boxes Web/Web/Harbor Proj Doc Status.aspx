<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Harbor Proj Doc Status.aspx.vb" Inherits="Harbor_Proj_Doc_Status" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Proj Doc Status</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harbor Project Documents Status<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="PMID" Theme="Metropolis">
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <SettingsEditing Mode="Inline">
            </SettingsEditing>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="PMID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Delivery Order" FieldName="Delivery_Order" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Complete" SortIndex="0" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="PO_Number" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pier" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Berth" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn Caption="Packing List Rcd" FieldName="Packing_List_Rcd" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn Caption="DO Rcd" FieldName="DO_Rcd" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="Start_Project" VisibleIndex="9">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="End_Project" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" DeleteCommand="DELETE FROM [Project Manager DO] WHERE [PMID] = @original_PMID " InsertCommand="INSERT INTO [Project Manager DO] ([Vessel], [Delivery Order], [Complete], [PO Number], [Pier], [Berth], [Packing List Rcd], [DO Rcd], [Start Project], [End Project]) VALUES (@Vessel, @Delivery_Order, @Complete, @PO_Number, @Pier, @Berth, @Packing_List_Rcd, @DO_Rcd, @Start_Project, @End_Project)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [PMID], [Vessel], [Delivery Order] AS Delivery_Order, [Complete], [PO Number] AS PO_Number, [Pier], [Berth], [Packing List Rcd] AS Packing_List_Rcd, [DO Rcd] AS DO_Rcd, [Start Project] AS Start_Project, [End Project] AS End_Project FROM [Project Manager DO]" UpdateCommand="UPDATE [Project Manager DO] SET [Vessel] = @Vessel, [Delivery Order] = @Delivery_Order, [Complete] = @Complete, [PO Number] = @PO_Number, [Pier] = @Pier, [Berth] = @Berth, [Packing List Rcd] = @Packing_List_Rcd, [DO Rcd] = @DO_Rcd, [Start Project] = @Start_Project, [End Project] = @End_Project WHERE [PMID] = @original_PMID" ProviderName="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4.ProviderName %>">
            <DeleteParameters>
                <asp:Parameter Name="original_PMID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Vessel" Type="String" />
                <asp:Parameter Name="Delivery_Order" Type="String" />
                <asp:Parameter Name="Complete" Type="Boolean" />
                <asp:Parameter Name="PO_Number" Type="String" />
                <asp:Parameter Name="Pier" Type="String" />
                <asp:Parameter Name="Berth" Type="String" />
                <asp:Parameter Name="Packing_List_Rcd" Type="Boolean" />
                <asp:Parameter Name="DO_Rcd" Type="Boolean" />
                <asp:Parameter Name="Start_Project" Type="DateTime" />
                <asp:Parameter Name="End_Project" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Vessel" Type="String" />
                <asp:Parameter Name="Delivery_Order" Type="String" />
                <asp:Parameter Name="Complete" Type="Boolean" />
                <asp:Parameter Name="PO_Number" Type="String" />
                <asp:Parameter Name="Pier" Type="String" />
                <asp:Parameter Name="Berth" Type="String" />
                <asp:Parameter Name="Packing_List_Rcd" Type="Boolean" />
                <asp:Parameter Name="DO_Rcd" Type="Boolean" />
                <asp:Parameter Name="Start_Project" Type="DateTime" />
                <asp:Parameter Name="End_Project" Type="DateTime" />
                <asp:Parameter Name="original_PMID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
