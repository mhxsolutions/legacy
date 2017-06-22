<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductCatalog.aspx.cs" Inherits="Web.Clients.All.ProductCatalog" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Master Product Catalog<br />
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Item Template ID" Theme="Metropolis">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Item Template ID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client Ref" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile Ref" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Part No" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Alt Part No" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Group 1" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Group 2" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Group 3" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Group 4" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Group 5" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Weight" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Linear Ft" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Count" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="rowguid" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 1 Label" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 1" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 2 Label" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 2" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 3 Label" VisibleIndex="18">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data 3" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data Numeric Label" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Data Numeric" VisibleIndex="21">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="22">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="ATSF Product Type ref" VisibleIndex="23">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description_T" VisibleIndex="24">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dimensions_T" VisibleIndex="25">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Class_T_ref" VisibleIndex="26">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Class_Type_T_ref" VisibleIndex="27">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Coating_Wt_T" VisibleIndex="28">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Country_of_Origin_T_ref" VisibleIndex="29">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="End_Finish_T_ref" VisibleIndex="30">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Gage_T" VisibleIndex="31">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Grade_T_ref" VisibleIndex="32">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ID_Size_T" VisibleIndex="33">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Mill_T_ref" VisibleIndex="34">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="OD_Size_T" VisibleIndex="35">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="QC Required" VisibleIndex="36">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Range_T_ref" VisibleIndex="37">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Size_T" VisibleIndex="38">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Source_T_ref" VisibleIndex="39">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template Ext Description" VisibleIndex="40">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Template lb per ft" VisibleIndex="41">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Thread_T_ref" VisibleIndex="42">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Type_T_ref" VisibleIndex="43">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UoM" VisibleIndex="44">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wall_T" VisibleIndex="45">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Width_T" VisibleIndex="46">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [Item Templates] WHERE [Item Template ID] = @original_Item_Template_ID AND (([Client Ref] = @original_Client_Ref) OR ([Client Ref] IS NULL AND @original_Client_Ref IS NULL)) AND (([Profile Ref] = @original_Profile_Ref) OR ([Profile Ref] IS NULL AND @original_Profile_Ref IS NULL)) AND (([Template Part No] = @original_Template_Part_No) OR ([Template Part No] IS NULL AND @original_Template_Part_No IS NULL)) AND (([Template Alt Part No] = @original_Template_Alt_Part_No) OR ([Template Alt Part No] IS NULL AND @original_Template_Alt_Part_No IS NULL)) AND (([Template Group 1] = @original_Template_Group_1) OR ([Template Group 1] IS NULL AND @original_Template_Group_1 IS NULL)) AND (([Template Group 2] = @original_Template_Group_2) OR ([Template Group 2] IS NULL AND @original_Template_Group_2 IS NULL)) AND (([Template Group 3] = @original_Template_Group_3) OR ([Template Group 3] IS NULL AND @original_Template_Group_3 IS NULL)) AND (([Template Group 4] = @original_Template_Group_4) OR ([Template Group 4] IS NULL AND @original_Template_Group_4 IS NULL)) AND (([Template Group 5] = @original_Template_Group_5) OR ([Template Group 5] IS NULL AND @original_Template_Group_5 IS NULL)) AND (([Template Weight] = @original_Template_Weight) OR ([Template Weight] IS NULL AND @original_Template_Weight IS NULL)) AND (([Template Linear Ft] = @original_Template_Linear_Ft) OR ([Template Linear Ft] IS NULL AND @original_Template_Linear_Ft IS NULL)) AND (([Template Count] = @original_Template_Count) OR ([Template Count] IS NULL AND @original_Template_Count IS NULL)) AND [rowguid] = @original_rowguid AND (([Template Data 1 Label] = @original_Template_Data_1_Label) OR ([Template Data 1 Label] IS NULL AND @original_Template_Data_1_Label IS NULL)) AND (([Template Data 1] = @original_Template_Data_1) OR ([Template Data 1] IS NULL AND @original_Template_Data_1 IS NULL)) AND (([Template Data 2 Label] = @original_Template_Data_2_Label) OR ([Template Data 2 Label] IS NULL AND @original_Template_Data_2_Label IS NULL)) AND (([Template Data 2] = @original_Template_Data_2) OR ([Template Data 2] IS NULL AND @original_Template_Data_2 IS NULL)) AND (([Template Data 3 Label] = @original_Template_Data_3_Label) OR ([Template Data 3 Label] IS NULL AND @original_Template_Data_3_Label IS NULL)) AND (([Template Data 3] = @original_Template_Data_3) OR ([Template Data 3] IS NULL AND @original_Template_Data_3 IS NULL)) AND (([Template Data Numeric Label] = @original_Template_Data_Numeric_Label) OR ([Template Data Numeric Label] IS NULL AND @original_Template_Data_Numeric_Label IS NULL)) AND (([Template Data Numeric] = @original_Template_Data_Numeric) OR ([Template Data Numeric] IS NULL AND @original_Template_Data_Numeric IS NULL)) AND [Active] = @original_Active AND (([ATSF Product Type ref] = @original_ATSF_Product_Type_ref) OR ([ATSF Product Type ref] IS NULL AND @original_ATSF_Product_Type_ref IS NULL)) AND (([Description_T] = @original_Description_T) OR ([Description_T] IS NULL AND @original_Description_T IS NULL)) AND (([Dimensions_T] = @original_Dimensions_T) OR ([Dimensions_T] IS NULL AND @original_Dimensions_T IS NULL)) AND (([Class_T_ref] = @original_Class_T_ref) OR ([Class_T_ref] IS NULL AND @original_Class_T_ref IS NULL)) AND (([Class_Type_T_ref] = @original_Class_Type_T_ref) OR ([Class_Type_T_ref] IS NULL AND @original_Class_Type_T_ref IS NULL)) AND (([Coating_Wt_T] = @original_Coating_Wt_T) OR ([Coating_Wt_T] IS NULL AND @original_Coating_Wt_T IS NULL)) AND (([Country_of_Origin_T_ref] = @original_Country_of_Origin_T_ref) OR ([Country_of_Origin_T_ref] IS NULL AND @original_Country_of_Origin_T_ref IS NULL)) AND (([End_Finish_T_ref] = @original_End_Finish_T_ref) OR ([End_Finish_T_ref] IS NULL AND @original_End_Finish_T_ref IS NULL)) AND (([Gage_T] = @original_Gage_T) OR ([Gage_T] IS NULL AND @original_Gage_T IS NULL)) AND (([Grade_T_ref] = @original_Grade_T_ref) OR ([Grade_T_ref] IS NULL AND @original_Grade_T_ref IS NULL)) AND (([ID_Size_T] = @original_ID_Size_T) OR ([ID_Size_T] IS NULL AND @original_ID_Size_T IS NULL)) AND (([Mill_T_ref] = @original_Mill_T_ref) OR ([Mill_T_ref] IS NULL AND @original_Mill_T_ref IS NULL)) AND (([OD_Size_T] = @original_OD_Size_T) OR ([OD_Size_T] IS NULL AND @original_OD_Size_T IS NULL)) AND [QC Required] = @original_QC_Required AND (([Range_T_ref] = @original_Range_T_ref) OR ([Range_T_ref] IS NULL AND @original_Range_T_ref IS NULL)) AND (([Size_T] = @original_Size_T) OR ([Size_T] IS NULL AND @original_Size_T IS NULL)) AND (([Source_T_ref] = @original_Source_T_ref) OR ([Source_T_ref] IS NULL AND @original_Source_T_ref IS NULL)) AND (([Template Ext Description] = @original_Template_Ext_Description) OR ([Template Ext Description] IS NULL AND @original_Template_Ext_Description IS NULL)) AND (([Template lb per ft] = @original_Template_lb_per_ft) OR ([Template lb per ft] IS NULL AND @original_Template_lb_per_ft IS NULL)) AND (([Thread_T_ref] = @original_Thread_T_ref) OR ([Thread_T_ref] IS NULL AND @original_Thread_T_ref IS NULL)) AND (([Type_T_ref] = @original_Type_T_ref) OR ([Type_T_ref] IS NULL AND @original_Type_T_ref IS NULL)) AND (([UoM] = @original_UoM) OR ([UoM] IS NULL AND @original_UoM IS NULL)) AND (([Wall_T] = @original_Wall_T) OR ([Wall_T] IS NULL AND @original_Wall_T IS NULL)) AND (([Width_T] = @original_Width_T) OR ([Width_T] IS NULL AND @original_Width_T IS NULL))" InsertCommand="INSERT INTO [Item Templates] ([Client Ref], [Profile Ref], [Template Part No], [Template Alt Part No], [Template Group 1], [Template Group 2], [Template Group 3], [Template Group 4], [Template Group 5], [Template Weight], [Template Linear Ft], [Template Count], [rowguid], [Template Data 1 Label], [Template Data 1], [Template Data 2 Label], [Template Data 2], [Template Data 3 Label], [Template Data 3], [Template Data Numeric Label], [Template Data Numeric], [Active], [ATSF Product Type ref], [Description_T], [Dimensions_T], [Class_T_ref], [Class_Type_T_ref], [Coating_Wt_T], [Country_of_Origin_T_ref], [End_Finish_T_ref], [Gage_T], [Grade_T_ref], [ID_Size_T], [Mill_T_ref], [OD_Size_T], [QC Required], [Range_T_ref], [Size_T], [Source_T_ref], [Template Ext Description], [Template lb per ft], [Thread_T_ref], [Type_T_ref], [UoM], [Wall_T], [Width_T]) VALUES (@Client_Ref, @Profile_Ref, @Template_Part_No, @Template_Alt_Part_No, @Template_Group_1, @Template_Group_2, @Template_Group_3, @Template_Group_4, @Template_Group_5, @Template_Weight, @Template_Linear_Ft, @Template_Count, @rowguid, @Template_Data_1_Label, @Template_Data_1, @Template_Data_2_Label, @Template_Data_2, @Template_Data_3_Label, @Template_Data_3, @Template_Data_Numeric_Label, @Template_Data_Numeric, @Active, @ATSF_Product_Type_ref, @Description_T, @Dimensions_T, @Class_T_ref, @Class_Type_T_ref, @Coating_Wt_T, @Country_of_Origin_T_ref, @End_Finish_T_ref, @Gage_T, @Grade_T_ref, @ID_Size_T, @Mill_T_ref, @OD_Size_T, @QC_Required, @Range_T_ref, @Size_T, @Source_T_ref, @Template_Ext_Description, @Template_lb_per_ft, @Thread_T_ref, @Type_T_ref, @UoM, @Wall_T, @Width_T)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Item Templates]" UpdateCommand="UPDATE [Item Templates] SET [Client Ref] = @Client_Ref, [Profile Ref] = @Profile_Ref, [Template Part No] = @Template_Part_No, [Template Alt Part No] = @Template_Alt_Part_No, [Template Group 1] = @Template_Group_1, [Template Group 2] = @Template_Group_2, [Template Group 3] = @Template_Group_3, [Template Group 4] = @Template_Group_4, [Template Group 5] = @Template_Group_5, [Template Weight] = @Template_Weight, [Template Linear Ft] = @Template_Linear_Ft, [Template Count] = @Template_Count, [rowguid] = @rowguid, [Template Data 1 Label] = @Template_Data_1_Label, [Template Data 1] = @Template_Data_1, [Template Data 2 Label] = @Template_Data_2_Label, [Template Data 2] = @Template_Data_2, [Template Data 3 Label] = @Template_Data_3_Label, [Template Data 3] = @Template_Data_3, [Template Data Numeric Label] = @Template_Data_Numeric_Label, [Template Data Numeric] = @Template_Data_Numeric, [Active] = @Active, [ATSF Product Type ref] = @ATSF_Product_Type_ref, [Description_T] = @Description_T, [Dimensions_T] = @Dimensions_T, [Class_T_ref] = @Class_T_ref, [Class_Type_T_ref] = @Class_Type_T_ref, [Coating_Wt_T] = @Coating_Wt_T, [Country_of_Origin_T_ref] = @Country_of_Origin_T_ref, [End_Finish_T_ref] = @End_Finish_T_ref, [Gage_T] = @Gage_T, [Grade_T_ref] = @Grade_T_ref, [ID_Size_T] = @ID_Size_T, [Mill_T_ref] = @Mill_T_ref, [OD_Size_T] = @OD_Size_T, [QC Required] = @QC_Required, [Range_T_ref] = @Range_T_ref, [Size_T] = @Size_T, [Source_T_ref] = @Source_T_ref, [Template Ext Description] = @Template_Ext_Description, [Template lb per ft] = @Template_lb_per_ft, [Thread_T_ref] = @Thread_T_ref, [Type_T_ref] = @Type_T_ref, [UoM] = @UoM, [Wall_T] = @Wall_T, [Width_T] = @Width_T WHERE [Item Template ID] = @original_Item_Template_ID AND (([Client Ref] = @original_Client_Ref) OR ([Client Ref] IS NULL AND @original_Client_Ref IS NULL)) AND (([Profile Ref] = @original_Profile_Ref) OR ([Profile Ref] IS NULL AND @original_Profile_Ref IS NULL)) AND (([Template Part No] = @original_Template_Part_No) OR ([Template Part No] IS NULL AND @original_Template_Part_No IS NULL)) AND (([Template Alt Part No] = @original_Template_Alt_Part_No) OR ([Template Alt Part No] IS NULL AND @original_Template_Alt_Part_No IS NULL)) AND (([Template Group 1] = @original_Template_Group_1) OR ([Template Group 1] IS NULL AND @original_Template_Group_1 IS NULL)) AND (([Template Group 2] = @original_Template_Group_2) OR ([Template Group 2] IS NULL AND @original_Template_Group_2 IS NULL)) AND (([Template Group 3] = @original_Template_Group_3) OR ([Template Group 3] IS NULL AND @original_Template_Group_3 IS NULL)) AND (([Template Group 4] = @original_Template_Group_4) OR ([Template Group 4] IS NULL AND @original_Template_Group_4 IS NULL)) AND (([Template Group 5] = @original_Template_Group_5) OR ([Template Group 5] IS NULL AND @original_Template_Group_5 IS NULL)) AND (([Template Weight] = @original_Template_Weight) OR ([Template Weight] IS NULL AND @original_Template_Weight IS NULL)) AND (([Template Linear Ft] = @original_Template_Linear_Ft) OR ([Template Linear Ft] IS NULL AND @original_Template_Linear_Ft IS NULL)) AND (([Template Count] = @original_Template_Count) OR ([Template Count] IS NULL AND @original_Template_Count IS NULL)) AND [rowguid] = @original_rowguid AND (([Template Data 1 Label] = @original_Template_Data_1_Label) OR ([Template Data 1 Label] IS NULL AND @original_Template_Data_1_Label IS NULL)) AND (([Template Data 1] = @original_Template_Data_1) OR ([Template Data 1] IS NULL AND @original_Template_Data_1 IS NULL)) AND (([Template Data 2 Label] = @original_Template_Data_2_Label) OR ([Template Data 2 Label] IS NULL AND @original_Template_Data_2_Label IS NULL)) AND (([Template Data 2] = @original_Template_Data_2) OR ([Template Data 2] IS NULL AND @original_Template_Data_2 IS NULL)) AND (([Template Data 3 Label] = @original_Template_Data_3_Label) OR ([Template Data 3 Label] IS NULL AND @original_Template_Data_3_Label IS NULL)) AND (([Template Data 3] = @original_Template_Data_3) OR ([Template Data 3] IS NULL AND @original_Template_Data_3 IS NULL)) AND (([Template Data Numeric Label] = @original_Template_Data_Numeric_Label) OR ([Template Data Numeric Label] IS NULL AND @original_Template_Data_Numeric_Label IS NULL)) AND (([Template Data Numeric] = @original_Template_Data_Numeric) OR ([Template Data Numeric] IS NULL AND @original_Template_Data_Numeric IS NULL)) AND [Active] = @original_Active AND (([ATSF Product Type ref] = @original_ATSF_Product_Type_ref) OR ([ATSF Product Type ref] IS NULL AND @original_ATSF_Product_Type_ref IS NULL)) AND (([Description_T] = @original_Description_T) OR ([Description_T] IS NULL AND @original_Description_T IS NULL)) AND (([Dimensions_T] = @original_Dimensions_T) OR ([Dimensions_T] IS NULL AND @original_Dimensions_T IS NULL)) AND (([Class_T_ref] = @original_Class_T_ref) OR ([Class_T_ref] IS NULL AND @original_Class_T_ref IS NULL)) AND (([Class_Type_T_ref] = @original_Class_Type_T_ref) OR ([Class_Type_T_ref] IS NULL AND @original_Class_Type_T_ref IS NULL)) AND (([Coating_Wt_T] = @original_Coating_Wt_T) OR ([Coating_Wt_T] IS NULL AND @original_Coating_Wt_T IS NULL)) AND (([Country_of_Origin_T_ref] = @original_Country_of_Origin_T_ref) OR ([Country_of_Origin_T_ref] IS NULL AND @original_Country_of_Origin_T_ref IS NULL)) AND (([End_Finish_T_ref] = @original_End_Finish_T_ref) OR ([End_Finish_T_ref] IS NULL AND @original_End_Finish_T_ref IS NULL)) AND (([Gage_T] = @original_Gage_T) OR ([Gage_T] IS NULL AND @original_Gage_T IS NULL)) AND (([Grade_T_ref] = @original_Grade_T_ref) OR ([Grade_T_ref] IS NULL AND @original_Grade_T_ref IS NULL)) AND (([ID_Size_T] = @original_ID_Size_T) OR ([ID_Size_T] IS NULL AND @original_ID_Size_T IS NULL)) AND (([Mill_T_ref] = @original_Mill_T_ref) OR ([Mill_T_ref] IS NULL AND @original_Mill_T_ref IS NULL)) AND (([OD_Size_T] = @original_OD_Size_T) OR ([OD_Size_T] IS NULL AND @original_OD_Size_T IS NULL)) AND [QC Required] = @original_QC_Required AND (([Range_T_ref] = @original_Range_T_ref) OR ([Range_T_ref] IS NULL AND @original_Range_T_ref IS NULL)) AND (([Size_T] = @original_Size_T) OR ([Size_T] IS NULL AND @original_Size_T IS NULL)) AND (([Source_T_ref] = @original_Source_T_ref) OR ([Source_T_ref] IS NULL AND @original_Source_T_ref IS NULL)) AND (([Template Ext Description] = @original_Template_Ext_Description) OR ([Template Ext Description] IS NULL AND @original_Template_Ext_Description IS NULL)) AND (([Template lb per ft] = @original_Template_lb_per_ft) OR ([Template lb per ft] IS NULL AND @original_Template_lb_per_ft IS NULL)) AND (([Thread_T_ref] = @original_Thread_T_ref) OR ([Thread_T_ref] IS NULL AND @original_Thread_T_ref IS NULL)) AND (([Type_T_ref] = @original_Type_T_ref) OR ([Type_T_ref] IS NULL AND @original_Type_T_ref IS NULL)) AND (([UoM] = @original_UoM) OR ([UoM] IS NULL AND @original_UoM IS NULL)) AND (([Wall_T] = @original_Wall_T) OR ([Wall_T] IS NULL AND @original_Wall_T IS NULL)) AND (([Width_T] = @original_Width_T) OR ([Width_T] IS NULL AND @original_Width_T IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Item_Template_ID" Type="Int32" />
                <asp:Parameter Name="original_Client_Ref" Type="Int32" />
                <asp:Parameter Name="original_Profile_Ref" Type="Int32" />
                <asp:Parameter Name="original_Template_Part_No" Type="String" />
                <asp:Parameter Name="original_Template_Alt_Part_No" Type="String" />
                <asp:Parameter Name="original_Template_Group_1" Type="String" />
                <asp:Parameter Name="original_Template_Group_2" Type="String" />
                <asp:Parameter Name="original_Template_Group_3" Type="String" />
                <asp:Parameter Name="original_Template_Group_4" Type="String" />
                <asp:Parameter Name="original_Template_Group_5" Type="String" />
                <asp:Parameter Name="original_Template_Weight" Type="Decimal" />
                <asp:Parameter Name="original_Template_Linear_Ft" Type="Decimal" />
                <asp:Parameter Name="original_Template_Count" Type="Int32" />
                <asp:Parameter Name="original_rowguid" Type="Object" />
                <asp:Parameter Name="original_Template_Data_1_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_1" Type="String" />
                <asp:Parameter Name="original_Template_Data_2_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_2" Type="String" />
                <asp:Parameter Name="original_Template_Data_3_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_3" Type="String" />
                <asp:Parameter Name="original_Template_Data_Numeric_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_Numeric" Type="Decimal" />
                <asp:Parameter Name="original_Active" Type="Boolean" />
                <asp:Parameter Name="original_ATSF_Product_Type_ref" Type="Int32" />
                <asp:Parameter Name="original_Description_T" Type="String" />
                <asp:Parameter Name="original_Dimensions_T" Type="String" />
                <asp:Parameter Name="original_Class_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Class_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Coating_Wt_T" Type="Decimal" />
                <asp:Parameter Name="original_Country_of_Origin_T_ref" Type="Int32" />
                <asp:Parameter Name="original_End_Finish_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Gage_T" Type="Decimal" />
                <asp:Parameter Name="original_Grade_T_ref" Type="Int32" />
                <asp:Parameter Name="original_ID_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_Mill_T_ref" Type="Int32" />
                <asp:Parameter Name="original_OD_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_QC_Required" Type="Boolean" />
                <asp:Parameter Name="original_Range_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_Source_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Template_Ext_Description" Type="String" />
                <asp:Parameter Name="original_Template_lb_per_ft" Type="Decimal" />
                <asp:Parameter Name="original_Thread_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="original_UoM" Type="String" />
                <asp:Parameter Name="original_Wall_T" Type="Decimal" />
                <asp:Parameter Name="original_Width_T" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Client_Ref" Type="Int32" />
                <asp:Parameter Name="Profile_Ref" Type="Int32" />
                <asp:Parameter Name="Template_Part_No" Type="String" />
                <asp:Parameter Name="Template_Alt_Part_No" Type="String" />
                <asp:Parameter Name="Template_Group_1" Type="String" />
                <asp:Parameter Name="Template_Group_2" Type="String" />
                <asp:Parameter Name="Template_Group_3" Type="String" />
                <asp:Parameter Name="Template_Group_4" Type="String" />
                <asp:Parameter Name="Template_Group_5" Type="String" />
                <asp:Parameter Name="Template_Weight" Type="Decimal" />
                <asp:Parameter Name="Template_Linear_Ft" Type="Decimal" />
                <asp:Parameter Name="Template_Count" Type="Int32" />
                <asp:Parameter Name="rowguid" Type="Object" />
                <asp:Parameter Name="Template_Data_1_Label" Type="String" />
                <asp:Parameter Name="Template_Data_1" Type="String" />
                <asp:Parameter Name="Template_Data_2_Label" Type="String" />
                <asp:Parameter Name="Template_Data_2" Type="String" />
                <asp:Parameter Name="Template_Data_3_Label" Type="String" />
                <asp:Parameter Name="Template_Data_3" Type="String" />
                <asp:Parameter Name="Template_Data_Numeric_Label" Type="String" />
                <asp:Parameter Name="Template_Data_Numeric" Type="Decimal" />
                <asp:Parameter Name="Active" Type="Boolean" />
                <asp:Parameter Name="ATSF_Product_Type_ref" Type="Int32" />
                <asp:Parameter Name="Description_T" Type="String" />
                <asp:Parameter Name="Dimensions_T" Type="String" />
                <asp:Parameter Name="Class_T_ref" Type="Int32" />
                <asp:Parameter Name="Class_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="Coating_Wt_T" Type="Decimal" />
                <asp:Parameter Name="Country_of_Origin_T_ref" Type="Int32" />
                <asp:Parameter Name="End_Finish_T_ref" Type="Int32" />
                <asp:Parameter Name="Gage_T" Type="Decimal" />
                <asp:Parameter Name="Grade_T_ref" Type="Int32" />
                <asp:Parameter Name="ID_Size_T" Type="Decimal" />
                <asp:Parameter Name="Mill_T_ref" Type="Int32" />
                <asp:Parameter Name="OD_Size_T" Type="Decimal" />
                <asp:Parameter Name="QC_Required" Type="Boolean" />
                <asp:Parameter Name="Range_T_ref" Type="Int32" />
                <asp:Parameter Name="Size_T" Type="Decimal" />
                <asp:Parameter Name="Source_T_ref" Type="Int32" />
                <asp:Parameter Name="Template_Ext_Description" Type="String" />
                <asp:Parameter Name="Template_lb_per_ft" Type="Decimal" />
                <asp:Parameter Name="Thread_T_ref" Type="Int32" />
                <asp:Parameter Name="Type_T_ref" Type="Int32" />
                <asp:Parameter Name="UoM" Type="String" />
                <asp:Parameter Name="Wall_T" Type="Decimal" />
                <asp:Parameter Name="Width_T" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Client_Ref" Type="Int32" />
                <asp:Parameter Name="Profile_Ref" Type="Int32" />
                <asp:Parameter Name="Template_Part_No" Type="String" />
                <asp:Parameter Name="Template_Alt_Part_No" Type="String" />
                <asp:Parameter Name="Template_Group_1" Type="String" />
                <asp:Parameter Name="Template_Group_2" Type="String" />
                <asp:Parameter Name="Template_Group_3" Type="String" />
                <asp:Parameter Name="Template_Group_4" Type="String" />
                <asp:Parameter Name="Template_Group_5" Type="String" />
                <asp:Parameter Name="Template_Weight" Type="Decimal" />
                <asp:Parameter Name="Template_Linear_Ft" Type="Decimal" />
                <asp:Parameter Name="Template_Count" Type="Int32" />
                <asp:Parameter Name="rowguid" Type="Object" />
                <asp:Parameter Name="Template_Data_1_Label" Type="String" />
                <asp:Parameter Name="Template_Data_1" Type="String" />
                <asp:Parameter Name="Template_Data_2_Label" Type="String" />
                <asp:Parameter Name="Template_Data_2" Type="String" />
                <asp:Parameter Name="Template_Data_3_Label" Type="String" />
                <asp:Parameter Name="Template_Data_3" Type="String" />
                <asp:Parameter Name="Template_Data_Numeric_Label" Type="String" />
                <asp:Parameter Name="Template_Data_Numeric" Type="Decimal" />
                <asp:Parameter Name="Active" Type="Boolean" />
                <asp:Parameter Name="ATSF_Product_Type_ref" Type="Int32" />
                <asp:Parameter Name="Description_T" Type="String" />
                <asp:Parameter Name="Dimensions_T" Type="String" />
                <asp:Parameter Name="Class_T_ref" Type="Int32" />
                <asp:Parameter Name="Class_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="Coating_Wt_T" Type="Decimal" />
                <asp:Parameter Name="Country_of_Origin_T_ref" Type="Int32" />
                <asp:Parameter Name="End_Finish_T_ref" Type="Int32" />
                <asp:Parameter Name="Gage_T" Type="Decimal" />
                <asp:Parameter Name="Grade_T_ref" Type="Int32" />
                <asp:Parameter Name="ID_Size_T" Type="Decimal" />
                <asp:Parameter Name="Mill_T_ref" Type="Int32" />
                <asp:Parameter Name="OD_Size_T" Type="Decimal" />
                <asp:Parameter Name="QC_Required" Type="Boolean" />
                <asp:Parameter Name="Range_T_ref" Type="Int32" />
                <asp:Parameter Name="Size_T" Type="Decimal" />
                <asp:Parameter Name="Source_T_ref" Type="Int32" />
                <asp:Parameter Name="Template_Ext_Description" Type="String" />
                <asp:Parameter Name="Template_lb_per_ft" Type="Decimal" />
                <asp:Parameter Name="Thread_T_ref" Type="Int32" />
                <asp:Parameter Name="Type_T_ref" Type="Int32" />
                <asp:Parameter Name="UoM" Type="String" />
                <asp:Parameter Name="Wall_T" Type="Decimal" />
                <asp:Parameter Name="Width_T" Type="Decimal" />
                <asp:Parameter Name="original_Item_Template_ID" Type="Int32" />
                <asp:Parameter Name="original_Client_Ref" Type="Int32" />
                <asp:Parameter Name="original_Profile_Ref" Type="Int32" />
                <asp:Parameter Name="original_Template_Part_No" Type="String" />
                <asp:Parameter Name="original_Template_Alt_Part_No" Type="String" />
                <asp:Parameter Name="original_Template_Group_1" Type="String" />
                <asp:Parameter Name="original_Template_Group_2" Type="String" />
                <asp:Parameter Name="original_Template_Group_3" Type="String" />
                <asp:Parameter Name="original_Template_Group_4" Type="String" />
                <asp:Parameter Name="original_Template_Group_5" Type="String" />
                <asp:Parameter Name="original_Template_Weight" Type="Decimal" />
                <asp:Parameter Name="original_Template_Linear_Ft" Type="Decimal" />
                <asp:Parameter Name="original_Template_Count" Type="Int32" />
                <asp:Parameter Name="original_rowguid" Type="Object" />
                <asp:Parameter Name="original_Template_Data_1_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_1" Type="String" />
                <asp:Parameter Name="original_Template_Data_2_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_2" Type="String" />
                <asp:Parameter Name="original_Template_Data_3_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_3" Type="String" />
                <asp:Parameter Name="original_Template_Data_Numeric_Label" Type="String" />
                <asp:Parameter Name="original_Template_Data_Numeric" Type="Decimal" />
                <asp:Parameter Name="original_Active" Type="Boolean" />
                <asp:Parameter Name="original_ATSF_Product_Type_ref" Type="Int32" />
                <asp:Parameter Name="original_Description_T" Type="String" />
                <asp:Parameter Name="original_Dimensions_T" Type="String" />
                <asp:Parameter Name="original_Class_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Class_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Coating_Wt_T" Type="Decimal" />
                <asp:Parameter Name="original_Country_of_Origin_T_ref" Type="Int32" />
                <asp:Parameter Name="original_End_Finish_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Gage_T" Type="Decimal" />
                <asp:Parameter Name="original_Grade_T_ref" Type="Int32" />
                <asp:Parameter Name="original_ID_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_Mill_T_ref" Type="Int32" />
                <asp:Parameter Name="original_OD_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_QC_Required" Type="Boolean" />
                <asp:Parameter Name="original_Range_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Size_T" Type="Decimal" />
                <asp:Parameter Name="original_Source_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Template_Ext_Description" Type="String" />
                <asp:Parameter Name="original_Template_lb_per_ft" Type="Decimal" />
                <asp:Parameter Name="original_Thread_T_ref" Type="Int32" />
                <asp:Parameter Name="original_Type_T_ref" Type="Int32" />
                <asp:Parameter Name="original_UoM" Type="String" />
                <asp:Parameter Name="original_Wall_T" Type="Decimal" />
                <asp:Parameter Name="original_Width_T" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
