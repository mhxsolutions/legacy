<%@ Page Title="QAQC" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="QAQC_Entry.aspx.cs" Inherits="Web.Clients.Assigned.QAQC_Entry" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        QA/QC Inspection Data Entry</h3>
    <p>
        <dx:ASPxGridView ID="QAQC_Grid_header" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="QAQC_ID" Theme="MetropolisBlue">
            <SettingsDetail ShowDetailRow="True" />
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="QAQC_Grid_detail" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" KeyFieldName="QAQC_Detail_ID" OnBeforePerformDataSelect="QAQC_Grid_detail_BeforePerformDataSelect" Theme="Office2010Blue" OnRowValidating="QAQC_Grid_detail_RowValidating" OnInitNewRow="QAQC_Grid_detail_InitNewRow">
                        <SettingsPager>
                            <AllButton Visible="True">
                            </AllButton>
                        </SettingsPager>
                        <SettingsEditing Mode="Inline">
                        </SettingsEditing>
                        <Columns>
                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn Caption="Detail ID" FieldName="QAQC_Detail_ID" ReadOnly="True" VisibleIndex="1" Visible="False">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="QAQC ID" FieldName="QAQC_ID_Ref" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Line#" FieldName="Line" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewBandColumn Caption="Item Details" VisibleIndex="4">
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Heat#" FieldName="Heat_no" ShowInCustomizationForm="True" VisibleIndex="0">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Serial#" FieldName="Serial_no" ShowInCustomizationForm="True" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Manufacturer" ShowInCustomizationForm="True" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Quantity" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="SCG PO#" FieldName="SCG_PO_no" ShowInCustomizationForm="True" VisibleIndex="4">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Item Description" FieldName="Item_Description" ShowInCustomizationForm="True" VisibleIndex="5">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Inspections" VisibleIndex="8">
                                <Columns>
                                    <dx:GridViewDataCheckColumn Caption="QA Accepted" FieldName="QA_Accept" ShowInCustomizationForm="True" VisibleIndex="0">
                                        <PropertiesCheckEdit ValueGrayed="False">
                                        </PropertiesCheckEdit>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="MTR COC" FieldName="MTR_COC" ShowInCustomizationForm="True" VisibleIndex="1">
                                        <PropertiesCheckEdit AllowGrayedByClick="False" ConvertEmptyStringToNull="False" ValueChecked="1" ValueGrayed="0" ValueType="System.Byte" ValueUnchecked="0">
                                        </PropertiesCheckEdit>
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Signature Required" FieldName="Approved_SCG_Sig_Required" ShowInCustomizationForm="True" VisibleIndex="2">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Approved SCG Signature" FieldName="Approved_SCG_Signature" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Length Required" FieldName="Correct_Length_Required" ShowInCustomizationForm="True" VisibleIndex="4">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Correct Length" FieldName="Correct_Length" ShowInCustomizationForm="True" VisibleIndex="5">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Diameter Required" FieldName="Correct_Diameter_Required" ShowInCustomizationForm="True" VisibleIndex="6">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Correct Diameter" FieldName="Correct_Diameter" ShowInCustomizationForm="True" VisibleIndex="7">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Wall Required" FieldName="Correct_Wall_Thickness" ShowInCustomizationForm="True" VisibleIndex="8">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Correct Wall Thickness" FieldName="Correct_Wall_Thickness_Required" ShowInCustomizationForm="True" VisibleIndex="9">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Roundness Required" FieldName="Roundness_Required" ShowInCustomizationForm="True" VisibleIndex="10">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Roundness" ShowInCustomizationForm="True" VisibleIndex="11">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Coating Required" FieldName="Coating_Applied_Required" ShowInCustomizationForm="True" VisibleIndex="12">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Coating Applied" FieldName="Coating_Applied" ShowInCustomizationForm="True" VisibleIndex="13">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Coating Failures" FieldName="Coating_Failures" ShowInCustomizationForm="True" VisibleIndex="14">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Stencil Required" FieldName="Correct_Stencil_Required" ShowInCustomizationForm="True" VisibleIndex="15">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Correct Stencil" FieldName="Correct_Stencil" ShowInCustomizationForm="True" VisibleIndex="16">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="API/ATSM Stamp Required" FieldName="API_ATSM_Stencil_Required" ShowInCustomizationForm="True" VisibleIndex="17">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="API/ATSM Stamp Stencil" FieldName="API_ATSM_Stamp_Stencil" ShowInCustomizationForm="True" VisibleIndex="18">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Other Insp Required" FieldName="Other_Inspection_Required" ShowInCustomizationForm="True" VisibleIndex="19">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataTextColumn Caption="Other Inspection Desc" FieldName="Other_Inspection" ShowInCustomizationForm="True" VisibleIndex="20">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn Caption="Other Inspection Passed" FieldName="Other_Inspection_Passed" ShowInCustomizationForm="True" VisibleIndex="21">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataTextColumn Caption="Inspection Notes" FieldName="Inspection_Notes" ShowInCustomizationForm="True" VisibleIndex="22">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Inspection Failure Class" VisibleIndex="32">
                                <Columns>
                                    <dx:GridViewDataCheckColumn Caption="Failed for Docs" FieldName="Failed_Documentation" ShowInCustomizationForm="True" VisibleIndex="0">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Failed for Markings" FieldName="Failed_Markings" ShowInCustomizationForm="True" VisibleIndex="1">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Failed for Mfg" FieldName="Failed_Manufacturer" ShowInCustomizationForm="True" VisibleIndex="2">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Failed for Mech Damage" FieldName="Failed_Mechanical_Damage" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Failed for Coating" FieldName="Failed_Coating" ShowInCustomizationForm="True" VisibleIndex="4">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn Caption="Failed - Incorrect Part" FieldName="Failed_Incorrect_Part" ShowInCustomizationForm="True" VisibleIndex="5">
                                    </dx:GridViewDataCheckColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                            <dx:GridViewBandColumn Caption="Action" VisibleIndex="39">
                                <Columns>
                                    <dx:GridViewDataDateColumn Caption="Date NCR Reported" FieldName="NCR_Reported" ShowInCustomizationForm="True" VisibleIndex="0">
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataDateColumn Caption="Date QDR Dispositioned" FieldName="QDR_Dispositioned" ShowInCustomizationForm="True" VisibleIndex="1">
                                    </dx:GridViewDataDateColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Repaired" ShowInCustomizationForm="True" VisibleIndex="2">
                                    </dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataTextColumn Caption="Release Notes" FieldName="Release_Notes" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataDateColumn Caption="Date Released" FieldName="Release_Date" ShowInCustomizationForm="True" VisibleIndex="4">
                                    </dx:GridViewDataDateColumn>
                                </Columns>
                            </dx:GridViewBandColumn>
                        </Columns>
                        <Styles>
                            <Header Wrap="True">
                            </Header>
                        </Styles>
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>
            <SettingsEditing Mode="Inline">
            </SettingsEditing>
            <Settings ShowFilterRow="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="QAQC_ID" ReadOnly="True" VisibleIndex="1" Visible="False">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspector" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection_Co" VisibleIndex="3" Caption="Inspection Company">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="MSP_Ref" VisibleIndex="4" Caption="MSP Reference">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Truck" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Trailer" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOD_no" VisibleIndex="7" Caption="NOD#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Received" VisibleIndex="8" Caption="Date Received">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Date_Inspected" VisibleIndex="9" Caption="Date Inspected">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Date_of_Report" VisibleIndex="10" Caption="Date of Report">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn Caption="QA Accepted" FieldName="QA_Accepted" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection_Failure_Type" VisibleIndex="12" Caption="Inspection Failure Type">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date NCR Reported" FieldName="Date_NCR_Reported" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn Caption="Date QDR Dispositioned" FieldName="Date_QDR_Dispositioned" VisibleIndex="14">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn Caption="Date Released" FieldName="Date_Released" VisibleIndex="15">
                </dx:GridViewDataDateColumn>
            </Columns>
            <Styles>
                <Header Wrap="True">
                </Header>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [QAQC_Header] WHERE [QAQC_ID] = @original_QAQC_ID " InsertCommand="INSERT INTO [QAQC_Header] ([Inspector], [Inspection_Co], [MSP_Ref], [Truck], [Trailer], [NOD_no], [Date_Received], [Date_Inspected], [Date_of_Report], [QA_Accepted], [Inspection_Failure_Type], [Date_NCR_Reported], [Date_QDR_Dispositioned], [Date_Released]) VALUES (@Inspector, @Inspection_Co, @MSP_Ref, @Truck, @Trailer, @NOD_no, @Date_Received, @Date_Inspected, @Date_of_Report, @QA_Accepted, @Inspection_Failure_Type, @Date_NCR_Reported, @Date_QDR_Dispositioned, @Date_Released)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [QAQC_Header]" UpdateCommand="UPDATE [QAQC_Header] SET [Inspector] = @Inspector, [Inspection_Co] = @Inspection_Co, [MSP_Ref] = @MSP_Ref, [Truck] = @Truck, [Trailer] = @Trailer, [NOD_no] = @NOD_no, [Date_Received] = @Date_Received, [Date_Inspected] = @Date_Inspected, [Date_of_Report] = @Date_of_Report, [QA_Accepted] = @QA_Accepted, [Inspection_Failure_Type] = @Inspection_Failure_Type, [Date_NCR_Reported] = @Date_NCR_Reported, [Date_QDR_Dispositioned] = @Date_QDR_Dispositioned, [Date_Released] = @Date_Released WHERE [QAQC_ID] = @original_QAQC_ID">
            <DeleteParameters>
                <asp:Parameter Name="original_QAQC_ID" Type="Int32"  />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Inspector" Type="String" />
                <asp:Parameter Name="Inspection_Co" Type="String" />
                <asp:Parameter Name="MSP_Ref" Type="String" />
                <asp:Parameter Name="Truck" Type="String" />
                <asp:Parameter Name="Trailer" Type="String" />
                <asp:Parameter Name="NOD_no" Type="String" />
                <asp:Parameter DbType="Date" Name="Date_Received" />
                <asp:Parameter DbType="Date" Name="Date_Inspected" />
                <asp:Parameter DbType="Date" Name="Date_of_Report" />
                <asp:Parameter Name="QA_Accepted" Type="Boolean" />
                <asp:Parameter Name="Inspection_Failure_Type" Type="String" />
                <asp:Parameter Name="Date_NCR_Reported" Type="DateTime" />
                <asp:Parameter Name="Date_QDR_Dispositioned" Type="DateTime" />
                <asp:Parameter Name="Date_Released" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Inspector" Type="String" />
                <asp:Parameter Name="Inspection_Co" Type="String" />
                <asp:Parameter Name="MSP_Ref" Type="String" />
                <asp:Parameter Name="Truck" Type="String" />
                <asp:Parameter Name="Trailer" Type="String" />
                <asp:Parameter Name="NOD_no" Type="String" />
                <asp:Parameter DbType="Date" Name="Date_Received" />
                <asp:Parameter DbType="Date" Name="Date_Inspected" />
                <asp:Parameter DbType="Date" Name="Date_of_Report" />
                <asp:Parameter Name="QA_Accepted" Type="Boolean" />
                <asp:Parameter Name="Inspection_Failure_Type" Type="String" />
                <asp:Parameter Name="Date_NCR_Reported" Type="DateTime" />
                <asp:Parameter Name="Date_QDR_Dispositioned" Type="DateTime" />
                <asp:Parameter Name="Date_Released" Type="DateTime" />
                <asp:Parameter Name="original_QAQC_ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [QAQC_Detail] WHERE [QAQC_Detail_ID] = @original_QAQC_Detail_ID " InsertCommand="INSERT INTO [QAQC_Detail] ([QAQC_ID_Ref], [Line], [Heat_no], [Serial_no], [Manufacturer], [Quantity], [SCG_PO_no], [Item_Description], [QA_Accept], [MTR_COC], [Approved_SCG_Signature], [Approved_SCG_Sig_Required], [Correct_Length], [Correct_Length_Required], [Correct_Diameter], [Correct_Diameter_Required], [Correct_Wall_Thickness], [Correct_Wall_Thickness_Required], [Roundness], [Roundness_Required], [Coating_Applied], [Coating_Failures], [Coating_Applied_Required], [Correct_Stencil], [Correct_Stencil_Required], [API_ATSM_Stamp_Stencil], [API_ATSM_Stencil_Required], [Other_Inspection], [Other_Inspection_Passed], [Other_Inspection_Required], [Inspection_Notes], [Failed_Documentation], [Failed_Markings], [Failed_Manufacturer], [Failed_Mechanical_Damage], [Failed_Coating], [Failed_Incorrect_Part], [NCR_Reported], [QDR_Dispositioned], [Repaired], [Release_Notes], [Release_Date]) VALUES (@QAQC_ID_Ref, @Line, @Heat_no, @Serial_no, @Manufacturer, @Quantity, @SCG_PO_no, @Item_Description, @QA_Accept, @MTR_COC, @Approved_SCG_Signature, @Approved_SCG_Sig_Required, @Correct_Length, @Correct_Length_Required, @Correct_Diameter, @Correct_Diameter_Required, @Correct_Wall_Thickness, @Correct_Wall_Thickness_Required, @Roundness, @Roundness_Required, @Coating_Applied, @Coating_Failures, @Coating_Applied_Required, @Correct_Stencil, @Correct_Stencil_Required, @API_ATSM_Stamp_Stencil, @API_ATSM_Stencil_Required, @Other_Inspection, @Other_Inspection_Passed, @Other_Inspection_Required, @Inspection_Notes, @Failed_Documentation, @Failed_Markings, @Failed_Manufacturer, @Failed_Mechanical_Damage, @Failed_Coating, @Failed_Incorrect_Part, @NCR_Reported, @QDR_Dispositioned, @Repaired, @Release_Notes, @Release_Date)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [QAQC_Detail] WHERE ([QAQC_ID_Ref] = @QAQC_ID_Ref)" UpdateCommand="UPDATE QAQC_Detail SET QAQC_ID_Ref = @QAQC_ID_Ref, Line = @Line, Heat_no = @Heat_no, Serial_no = @Serial_no, Manufacturer = @Manufacturer, Quantity = @Quantity, SCG_PO_no = @SCG_PO_no, Item_Description = @Item_Description, QA_Accept = @QA_Accept, MTR_COC = @MTR_COC, Approved_SCG_Signature = @Approved_SCG_Signature, Approved_SCG_Sig_Required = @Approved_SCG_Sig_Required, Correct_Length = @Correct_Length, Correct_Length_Required = @Correct_Length_Required, Correct_Diameter = @Correct_Diameter, Correct_Diameter_Required = @Correct_Diameter_Required, Correct_Wall_Thickness = @Correct_Wall_Thickness, Correct_Wall_Thickness_Required = @Correct_Wall_Thickness_Required, Roundness = @Roundness, Roundness_Required = @Roundness_Required, Coating_Applied = @Coating_Applied, Coating_Failures = @Coating_Failures, Coating_Applied_Required = @Coating_Applied_Required, Correct_Stencil = @Correct_Stencil, Correct_Stencil_Required = @Correct_Stencil_Required, API_ATSM_Stamp_Stencil = @API_ATSM_Stamp_Stencil, API_ATSM_Stencil_Required = @API_ATSM_Stencil_Required, Other_Inspection = @Other_Inspection, Other_Inspection_Passed = @Other_Inspection_Passed, Other_Inspection_Required = @Other_Inspection_Required, Inspection_Notes = @Inspection_Notes, Failed_Documentation = @Failed_Documentation, Failed_Markings = @Failed_Markings, Failed_Manufacturer = @Failed_Manufacturer, Failed_Mechanical_Damage = @Failed_Mechanical_Damage, Failed_Coating = @Failed_Coating, Failed_Incorrect_Part = @Failed_Incorrect_Part, NCR_Reported = @NCR_Reported, QDR_Dispositioned = @QDR_Dispositioned, Repaired = @Repaired, Release_Notes = @Release_Notes, Release_Date = @Release_Date WHERE (QAQC_Detail_ID = @original_QAQC_Detail_ID)">
            <DeleteParameters>
                <asp:Parameter Name="original_QAQC_Detail_ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="QAQC_ID_Ref" Type="Int32" />
                <asp:Parameter Name="Line" Type="Int32" />
                <asp:Parameter Name="Heat_no" Type="String" />
                <asp:Parameter Name="Serial_no" Type="String" />
                <asp:Parameter Name="Manufacturer" Type="String" />
                <asp:Parameter Name="Quantity" Type="Int32" />
                <asp:Parameter Name="SCG_PO_no" Type="String" />
                <asp:Parameter Name="Item_Description" Type="String" />
                <asp:Parameter Name="QA_Accept" Type="Boolean" />
                <asp:Parameter Name="MTR_COC" Type="Boolean" />
                <asp:Parameter Name="Approved_SCG_Signature" Type="Boolean" />
                <asp:Parameter Name="Approved_SCG_Sig_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Length" Type="Boolean" />
                <asp:Parameter Name="Correct_Length_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Diameter" Type="Boolean" />
                <asp:Parameter Name="Correct_Diameter_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Wall_Thickness" Type="Boolean" />
                <asp:Parameter Name="Correct_Wall_Thickness_Required" Type="Boolean" />
                <asp:Parameter Name="Roundness" Type="Boolean" />
                <asp:Parameter Name="Roundness_Required" Type="Boolean" />
                <asp:Parameter Name="Coating_Applied" Type="Boolean" />
                <asp:Parameter Name="Coating_Failures" Type="Boolean" />
                <asp:Parameter Name="Coating_Applied_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Stencil" Type="Boolean" />
                <asp:Parameter Name="Correct_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="API_ATSM_Stamp_Stencil" Type="Boolean" />
                <asp:Parameter Name="API_ATSM_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="Other_Inspection" Type="String" />
                <asp:Parameter Name="Other_Inspection_Passed" Type="Boolean" />
                <asp:Parameter Name="Other_Inspection_Required" Type="Boolean" />
                <asp:Parameter Name="Inspection_Notes" Type="String" />
                <asp:Parameter Name="Failed_Documentation" Type="Boolean" />
                <asp:Parameter Name="Failed_Markings" Type="Boolean" />
                <asp:Parameter Name="Failed_Manufacturer" Type="Boolean" />
                <asp:Parameter Name="Failed_Mechanical_Damage" Type="Boolean" />
                <asp:Parameter Name="Failed_Coating" Type="Boolean" />
                <asp:Parameter Name="Failed_Incorrect_Part" Type="Boolean" />
                <asp:Parameter Name="NCR_Reported" Type="DateTime" />
                <asp:Parameter Name="QDR_Dispositioned" Type="DateTime" />
                <asp:Parameter Name="Repaired" Type="Boolean" />
                <asp:Parameter Name="Release_Notes" Type="String" />
                <asp:Parameter Name="Release_Date" Type="DateTime" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="QAQC_ID_Ref" SessionField="PID" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:SessionParameter Name="QAQC_ID_Ref" SessionField="PID" Type="Int32" />
                <asp:Parameter Name="Line" Type="Int32" />
                <asp:Parameter Name="Heat_no" Type="String" />
                <asp:Parameter Name="Serial_no" Type="String" />
                <asp:Parameter Name="Manufacturer" Type="String" />
                <asp:Parameter Name="Quantity" Type="Int32" />
                <asp:Parameter Name="SCG_PO_no" Type="String" />
                <asp:Parameter Name="Item_Description" Type="String" />
                <asp:Parameter Name="QA_Accept" Type="Boolean" />
                <asp:Parameter Name="MTR_COC" Type="Boolean" />
                <asp:Parameter Name="Approved_SCG_Signature" Type="Boolean" />
                <asp:Parameter Name="Approved_SCG_Sig_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Length" Type="Boolean" />
                <asp:Parameter Name="Correct_Length_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Diameter" Type="Boolean" />
                <asp:Parameter Name="Correct_Diameter_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Wall_Thickness" Type="Boolean" />
                <asp:Parameter Name="Correct_Wall_Thickness_Required" Type="Boolean" />
                <asp:Parameter Name="Roundness" Type="Boolean" />
                <asp:Parameter Name="Roundness_Required" Type="Boolean" />
                <asp:Parameter Name="Coating_Applied" Type="Boolean" />
                <asp:Parameter Name="Coating_Failures" Type="Boolean" />
                <asp:Parameter Name="Coating_Applied_Required" Type="Boolean" />
                <asp:Parameter Name="Correct_Stencil" Type="Boolean" />
                <asp:Parameter Name="Correct_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="API_ATSM_Stamp_Stencil" Type="Boolean" />
                <asp:Parameter Name="API_ATSM_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="Other_Inspection" Type="String" />
                <asp:Parameter Name="Other_Inspection_Passed" Type="Boolean" />
                <asp:Parameter Name="Other_Inspection_Required" Type="Boolean" />
                <asp:Parameter Name="Inspection_Notes" Type="String" />
                <asp:Parameter Name="Failed_Documentation" Type="Boolean" />
                <asp:Parameter Name="Failed_Markings" Type="Boolean" />
                <asp:Parameter Name="Failed_Manufacturer" Type="Boolean" />
                <asp:Parameter Name="Failed_Mechanical_Damage" Type="Boolean" />
                <asp:Parameter Name="Failed_Coating" Type="Boolean" />
                <asp:Parameter Name="Failed_Incorrect_Part" Type="Boolean" />
                <asp:Parameter Name="NCR_Reported" Type="DateTime" />
                <asp:Parameter Name="QDR_Dispositioned" Type="DateTime" />
                <asp:Parameter Name="Repaired" Type="Boolean" />
                <asp:Parameter Name="Release_Notes" Type="String" />
                <asp:Parameter Name="Release_Date" Type="DateTime" />
                <asp:Parameter Name="original_QAQC_Detail_ID" Type="Int32" />
                <asp:Parameter Name="original_QAQC_ID_Ref" Type="Int32" />
                <asp:Parameter Name="original_Line" Type="Int32" />
                <asp:Parameter Name="original_Heat_no" Type="String" />
                <asp:Parameter Name="original_Serial_no" Type="String" />
                <asp:Parameter Name="original_Manufacturer" Type="String" />
                <asp:Parameter Name="original_Quantity" Type="Int32" />
                <asp:Parameter Name="original_SCG_PO_no" Type="String" />
                <asp:Parameter Name="original_Item_Description" Type="String" />
                <asp:Parameter Name="original_QA_Accept" Type="Boolean" />
                <asp:Parameter Name="original_MTR_COC" Type="Boolean" />
                <asp:Parameter Name="original_Approved_SCG_Signature" Type="Boolean" />
                <asp:Parameter Name="original_Approved_SCG_Sig_Required" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Length" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Length_Required" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Diameter" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Diameter_Required" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Wall_Thickness" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Wall_Thickness_Required" Type="Boolean" />
                <asp:Parameter Name="original_Roundness" Type="Boolean" />
                <asp:Parameter Name="original_Roundness_Required" Type="Boolean" />
                <asp:Parameter Name="original_Coating_Applied" Type="Boolean" />
                <asp:Parameter Name="original_Coating_Failures" Type="Boolean" />
                <asp:Parameter Name="original_Coating_Applied_Required" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Stencil" Type="Boolean" />
                <asp:Parameter Name="original_Correct_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="original_API_ATSM_Stamp_Stencil" Type="Boolean" />
                <asp:Parameter Name="original_API_ATSM_Stencil_Required" Type="Boolean" />
                <asp:Parameter Name="original_Other_Inspection" Type="String" />
                <asp:Parameter Name="original_Other_Inspection_Passed" Type="Boolean" />
                <asp:Parameter Name="original_Other_Inspection_Required" Type="Boolean" />
                <asp:Parameter Name="original_Inspection_Notes" Type="String" />
                <asp:Parameter Name="original_Failed_Documentation" Type="Boolean" />
                <asp:Parameter Name="original_Failed_Markings" Type="Boolean" />
                <asp:Parameter Name="original_Failed_Manufacturer" Type="Boolean" />
                <asp:Parameter Name="original_Failed_Mechanical_Damage" Type="Boolean" />
                <asp:Parameter Name="original_Failed_Coating" Type="Boolean" />
                <asp:Parameter Name="original_Failed_Incorrect_Part" Type="Boolean" />
                <asp:Parameter Name="original_NCR_Reported" Type="DateTime" />
                <asp:Parameter Name="original_QDR_Dispositioned" Type="DateTime" />
                <asp:Parameter Name="original_Repaired" Type="Boolean" />
                <asp:Parameter Name="original_Release_Notes" Type="String" />
                <asp:Parameter Name="original_Release_Date" Type="DateTime" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
