<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Truck_Cost_Model.aspx.vb" Inherits="Cost_Truck_Cost_Model" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Truck Cost</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Truck Cost Model</h3>
        <p>
            Constants</p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ModelID" Theme="Metropolis">
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Variable Driver" FieldName="A" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Variable Truck" FieldName="B" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Fixed Cost per Mile" FieldName="C" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Overhead" FieldName="D" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Min/day Utilization" FieldName="E" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="COC/day" FieldName="F" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ModelID" ReadOnly="True" VisibleIndex="7">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" DeleteCommand="DELETE FROM [CostModelConstants] WHERE [ModelID] = @original_ModelID AND [A] = @original_A AND [B] = @original_B AND [C] = @original_C AND [D] = @original_D AND [E] = @original_E AND [F] = @original_F" InsertCommand="INSERT INTO [CostModelConstants] ([A], [B], [C], [D], [E], [F]) VALUES (@A, @B, @C, @D, @E, @F)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [CostModelConstants]" UpdateCommand="UPDATE [CostModelConstants] SET [A] = @A, [B] = @B, [C] = @C, [D] = @D, [E] = @E, [F] = @F WHERE [ModelID] = @original_ModelID AND [A] = @original_A AND [B] = @original_B AND [C] = @original_C AND [D] = @original_D AND [E] = @original_E AND [F] = @original_F">
            <DeleteParameters>
                <asp:Parameter Name="original_ModelID" Type="Int32" />
                <asp:Parameter Name="original_A" Type="Double" />
                <asp:Parameter Name="original_B" Type="Double" />
                <asp:Parameter Name="original_C" Type="Double" />
                <asp:Parameter Name="original_D" Type="Double" />
                <asp:Parameter Name="original_E" Type="Double" />
                <asp:Parameter Name="original_F" Type="Double" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="A" Type="Double" />
                <asp:Parameter Name="B" Type="Double" />
                <asp:Parameter Name="C" Type="Double" />
                <asp:Parameter Name="D" Type="Double" />
                <asp:Parameter Name="E" Type="Double" />
                <asp:Parameter Name="F" Type="Double" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="A" Type="Double" />
                <asp:Parameter Name="B" Type="Double" />
                <asp:Parameter Name="C" Type="Double" />
                <asp:Parameter Name="D" Type="Double" />
                <asp:Parameter Name="E" Type="Double" />
                <asp:Parameter Name="F" Type="Double" />
                <asp:Parameter Name="original_ModelID" Type="Int32" />
                <asp:Parameter Name="original_A" Type="Double" />
                <asp:Parameter Name="original_B" Type="Double" />
                <asp:Parameter Name="original_C" Type="Double" />
                <asp:Parameter Name="original_D" Type="Double" />
                <asp:Parameter Name="original_E" Type="Double" />
                <asp:Parameter Name="original_F" Type="Double" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        Cost = Variable Driver * Minutes + Variable Truck * Miles + Fixed per Mile * Miles + OH + ((Minutes/Utilization) * COC)<br />
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" KeyFieldName="Plan ID" Theme="Metropolis" Width="1219px">
            <SettingsDetail ShowDetailRow="True" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="Office2010Blue" OnBeforePerformDataSelect="ASPxGridView3_BeforePerformDataSelect">
                        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                        </SettingsContextMenu>
                        <SettingsPager PageSize="12">
                            <AllButton Visible="True">
                            </AllButton>
                        </SettingsPager>
                        <Settings ShowFooter="True" />
                        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="Miles" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Leg" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Plan ID" Visible="False" VisibleIndex="11">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewBandColumn Caption="Phone Times (Actual Min = Last Depart Destination - First Depart Origin)" VisibleIndex="5">
                                <Columns>
                                    <dx:GridViewDataDateColumn FieldName="Depart Origin" ShowInCustomizationForm="True" VisibleIndex="0">
                                        <PropertiesDateEdit DisplayFormatString="t">
                                        </PropertiesDateEdit>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn FieldName="Arrive Destination" ShowInCustomizationForm="True" VisibleIndex="1">
                                        <PropertiesDateEdit DisplayFormatString="t">
                                        </PropertiesDateEdit>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn FieldName="Depart Destination" ShowInCustomizationForm="True" VisibleIndex="2">
                                        <PropertiesDateEdit DisplayFormatString="t">
                                        </PropertiesDateEdit>
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataTextColumn Caption="Drive Hrs" FieldName="Hrs" VisibleIndex="3">
                                        <PropertiesTextEdit DisplayFormatString="n1">
                                        </PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewDataTextColumn FieldName="MPH" VisibleIndex="8">
                                <PropertiesTextEdit DisplayFormatString="n1">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Private Rev" ReadOnly="True" VisibleIndex="10">
                                <PropertiesTextEdit DisplayFormatString="c">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Miles" ShowInColumn="Miles" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="MPH" ShowInColumn="MPH" SummaryType="Average" />
                            <dx:ASPxSummaryItem FieldName="Private Rev" ShowInColumn="Private Rev" SummaryType="Sum" ValueDisplayFormat="c" />
                        </TotalSummary>
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>
            <SettingsPager PageSize="35">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowGroupFooter="VisibleAlways" />
            <SettingsBehavior ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="2" SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="4" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Miles" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Planned Min" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ModelID" ReadOnly="True" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="3" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Actual Min" FieldName="Act_Min" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Private Revenue" FieldName="Priv_Rev" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PlannedCost" ReadOnly="True" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ActualCost" ReadOnly="True" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Estimated Profit (Revenue - Actual Cost)" FieldName="Est_Profit" ReadOnly="True" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Month" GroupIndex="1" SortIndex="1" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Year" GroupIndex="0" SortIndex="0" SortOrder="Descending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Plan ID" Visible="False" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Planned Profit (Revenue - Planned Cost)" FieldName="Planned_Profit" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="ActualCost" ShowInColumn="Actual Cost" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="Est_Profit" ShowInColumn="Estimated Profit (Revenue - Actual Cost)" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="Priv_Rev" ShowInColumn="Private Revenue" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="PlannedCost" ShowInColumn="Planned Cost" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="Planned_Profit" ShowInColumn="Planned Profit (Revenue - Planned Cost)" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="ActualCost" ShowInGroupFooterColumn="Actual Cost" SummaryType="Sum" DisplayFormat="{0:c}" />
                <dx:ASPxSummaryItem FieldName="Est_Profit" ShowInGroupFooterColumn="Estimated Profit (Revenue - Actual Cost)" SummaryType="Sum" DisplayFormat="{0:c}" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="Priv_Rev" ShowInGroupFooterColumn="Private Revenue" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="Planned_Profit" ShowInGroupFooterColumn="Planned Profit (Revenue - Planned Cost)" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:c}" FieldName="PlannedCost" ShowInGroupFooterColumn="Planned Cost" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [CostModel_PlannedDrivers]"></asp:SqlDataSource>
    
        <br />
        Company Drivers Only<br />
        Actual Minutes is Total Day less Break 1 and Break 2 (lunch times go there)<br />
        Planned Cost uses Planned Minutes<br />
        Actual Cost uses Actual Minutes<br />
        Estimated Profit = Private Revenue - Actual Cost unless Actual Cost is null, then = Private Revenue -&nbsp; Planned Cost.<br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT * FROM [Driver Plan Miles Audit miles] WHERE ([Plan ID] = @Plan_ID)">
            <SelectParameters>
                <asp:SessionParameter Name="Plan_ID" SessionField="PID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
