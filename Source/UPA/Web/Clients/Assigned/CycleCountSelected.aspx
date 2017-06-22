<%@ Page Title="CycleCount" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="CycleCountSelected.aspx.cs" Inherits="Web.Clients.Assigned.CycleCountSelected" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Cycle Count Selected</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="CycleCount_ID" Theme="iOS">
            <SettingsEditing Mode="EditForm">
            </SettingsEditing>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <EditFormLayoutProperties ColCount="2">
                <Items>
                    <dx:GridViewColumnLayoutItem ColumnName="Location">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="PSEP">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColSpan="2" ColumnName="LongDescription" RowSpan="2">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="TotalCount">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="CycleCountDate">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="CycleCount1">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="CycleCount2">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColSpan="2" ColumnName="Notes">
                    </dx:GridViewColumnLayoutItem>
                    <dx:EditModeCommandLayoutItem ColSpan="2" HorizontalAlign="Right">
                    </dx:EditModeCommandLayoutItem>
                </Items>
            </EditFormLayoutProperties>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="DateTimeRun" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Location" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LongDescription" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PSEP" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TotalWeight" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TotalLNFT" ReadOnly="True" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="TotalCount" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CycleCount1" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CycleCount2" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="CycleCountDate" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CycleCount_ID" ReadOnly="True" Visible="False" VisibleIndex="12">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [CycleCountLog] WHERE [CycleCount_ID] = @original_CycleCount_ID AND [DateTimeRun] = @original_DateTimeRun AND (([Location] = @original_Location) OR ([Location] IS NULL AND @original_Location IS NULL)) AND (([LongDescription] = @original_LongDescription) OR ([LongDescription] IS NULL AND @original_LongDescription IS NULL)) AND (([PSEP] = @original_PSEP) OR ([PSEP] IS NULL AND @original_PSEP IS NULL)) AND (([TotalWeight] = @original_TotalWeight) OR ([TotalWeight] IS NULL AND @original_TotalWeight IS NULL)) AND (([TotalLNFT] = @original_TotalLNFT) OR ([TotalLNFT] IS NULL AND @original_TotalLNFT IS NULL)) AND (([TotalCount] = @original_TotalCount) OR ([TotalCount] IS NULL AND @original_TotalCount IS NULL)) AND (([CycleCount1] = @original_CycleCount1) OR ([CycleCount1] IS NULL AND @original_CycleCount1 IS NULL)) AND (([CycleCount2] = @original_CycleCount2) OR ([CycleCount2] IS NULL AND @original_CycleCount2 IS NULL)) AND (([CycleCountDate] = @original_CycleCountDate) OR ([CycleCountDate] IS NULL AND @original_CycleCountDate IS NULL)) AND [AdjustmentComplete] = @original_AdjustmentComplete AND (([Notes] = @original_Notes) OR ([Notes] IS NULL AND @original_Notes IS NULL)) AND [Company ID ref] = @original_Company_ID_ref" InsertCommand="INSERT INTO [CycleCountLog] ([DateTimeRun], [Location], [LongDescription], [PSEP], [TotalWeight], [TotalLNFT], [TotalCount], [CycleCount1], [CycleCount2], [CycleCountDate], [AdjustmentComplete], [Notes], [Company ID ref]) VALUES (@DateTimeRun, @Location, @LongDescription, @PSEP, @TotalWeight, @TotalLNFT, @TotalCount, @CycleCount1, @CycleCount2, @CycleCountDate, @AdjustmentComplete, @Notes, @Company_ID_ref)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [CycleCountLogOpen] WHERE (([Company ID ref] = @Company_ID_ref))" UpdateCommand="UPDATE CycleCountLog SET CycleCount1 = @CycleCount1, CycleCount2 = @CycleCount2, CycleCountDate = @CycleCountDate, Notes = @Notes WHERE (CycleCount_ID = @original_CycleCount_ID)">
            <DeleteParameters>
                <asp:Parameter Name="original_CycleCount_ID" Type="Int32" />
                <asp:Parameter Name="original_DateTimeRun" Type="DateTime" />
                <asp:Parameter Name="original_Location" Type="String" />
                <asp:Parameter Name="original_LongDescription" Type="String" />
                <asp:Parameter Name="original_PSEP" Type="String" />
                <asp:Parameter Name="original_TotalWeight" Type="Decimal" />
                <asp:Parameter Name="original_TotalLNFT" Type="Decimal" />
                <asp:Parameter Name="original_TotalCount" Type="Int32" />
                <asp:Parameter Name="original_CycleCount1" Type="Int32" />
                <asp:Parameter Name="original_CycleCount2" Type="Int32" />
                <asp:Parameter Name="original_CycleCountDate" Type="DateTime" />
                <asp:Parameter Name="original_AdjustmentComplete" Type="Boolean" />
                <asp:Parameter Name="original_Notes" Type="String" />
                <asp:Parameter Name="original_Company_ID_ref" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="DateTimeRun" Type="DateTime" />
                <asp:Parameter Name="Location" Type="String" />
                <asp:Parameter Name="LongDescription" Type="String" />
                <asp:Parameter Name="PSEP" Type="String" />
                <asp:Parameter Name="TotalWeight" Type="Decimal" />
                <asp:Parameter Name="TotalLNFT" Type="Decimal" />
                <asp:Parameter Name="TotalCount" Type="Int32" />
                <asp:Parameter Name="CycleCount1" Type="Int32" />
                <asp:Parameter Name="CycleCount2" Type="Int32" />
                <asp:Parameter Name="CycleCountDate" Type="DateTime" />
                <asp:Parameter Name="AdjustmentComplete" Type="Boolean" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="DateTimeRun" Type="DateTime" />
                <asp:Parameter Name="Location" Type="String" />
                <asp:Parameter Name="LongDescription" Type="String" />
                <asp:Parameter Name="PSEP" Type="String" />
                <asp:Parameter Name="TotalWeight" Type="Decimal" />
                <asp:Parameter Name="TotalLNFT" Type="Decimal" />
                <asp:Parameter Name="TotalCount" Type="Int32" />
                <asp:Parameter Name="CycleCount1" Type="Int32" />
                <asp:Parameter Name="CycleCount2" Type="Int32" />
                <asp:Parameter Name="CycleCountDate" Type="DateTime" />
                <asp:Parameter Name="AdjustmentComplete" Type="Boolean" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="original_CycleCount_ID" Type="Int32" />
                <asp:Parameter Name="original_DateTimeRun" Type="DateTime" />
                <asp:Parameter Name="original_Location" Type="String" />
                <asp:Parameter Name="original_LongDescription" Type="String" />
                <asp:Parameter Name="original_PSEP" Type="String" />
                <asp:Parameter Name="original_TotalWeight" Type="Decimal" />
                <asp:Parameter Name="original_TotalLNFT" Type="Decimal" />
                <asp:Parameter Name="original_TotalCount" Type="Int32" />
                <asp:Parameter Name="original_CycleCount1" Type="Int32" />
                <asp:Parameter Name="original_CycleCount2" Type="Int32" />
                <asp:Parameter Name="original_CycleCountDate" Type="DateTime" />
                <asp:Parameter Name="original_AdjustmentComplete" Type="Boolean" />
                <asp:Parameter Name="original_Notes" Type="String" />
                <asp:Parameter Name="original_Company_ID_ref" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
