<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Harbor Project DO Editor.aspx.vb" Inherits="Harbor_Project_DO_Editor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Proj DO</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harbor Project DO Editor<br />
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
                <BatchEditSettings StartEditAction="DblClick" />
            </SettingsEditing>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="PMID" ReadOnly="True" VisibleIndex="1" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Start_Project" VisibleIndex="6" Caption="Start Project">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="End_Project" VisibleIndex="11" Caption="End Project">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Delivery Order(s)" FieldName="Delivery_Order" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Complete" VisibleIndex="10" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="PO_Number" VisibleIndex="5" Caption="PO Number(s)">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pier" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Berth" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Packing_List_Rcd" VisibleIndex="7" Caption="Packing List Rcd">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="DO_Rcd" VisibleIndex="8" Caption="DO Rcd">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewBandColumn Caption="Clients" VisibleIndex="3">
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="Project" FieldName="Proj_Client" ReadOnly="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Bill To" FieldName="Bill_To_Client" ReadOnly="True" VisibleIndex="2">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Load Counts" VisibleIndex="9">
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="Start" FieldName="Loads" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Received" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Balance" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:GridViewBandColumn>
            </Columns>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT PMID, [Project Description] AS Project_Description, [Start Project] AS Start_Project, [End Project] AS End_Project, [Delivery Order] AS Delivery_Order, Vessel, Instructions, Complete, [Completion Date] AS Completion_Date, [DR Description] AS DR_Description, [PO Number] AS PO_Number, [Client Number] AS Client_Number, Pier, Berth, [Packing List Rcd] AS Packing_List_Rcd, [DO Rcd] AS DO_Rcd, Proj_Client, Deliver_To_Client, Bill_To_Client, Loads, Received, Balance FROM [Project Manager DO INFO]" UpdateCommand="UPDATE [Project Manager DO] SET Vessel = @Vessel, [Delivery Order] = @Delivery_Order, Complete = @Complete, [PO Number] = @PO_Number, Pier = @Pier, Berth = @Berth, [Packing List Rcd] = @Packing_List_Rcd, [DO Rcd] = @DO_Rcd, [Start Project] = @Start_Project, [End Project] = @End_Project WHERE (PMID = @original_PMID)" OldValuesParameterFormatString="original_{0}" ProviderName="System.Data.SqlClient">
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
