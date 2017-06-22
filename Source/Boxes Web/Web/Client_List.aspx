<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Client_List.aspx.vb" Inherits="Client_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Client List - Fon</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Client List - Budway<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Destination" 
            Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True" ShowEditButton="True"/>
                <dx:GridViewDataTextColumn Caption="Client" FieldName="Destination" 
                    ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Address Line 2" FieldName="Address_Line_2" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="City" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="State" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Zip" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Phone" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Contact Number" FieldName="Contact_Voice" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="50">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            DeleteCommand="DELETE FROM [tbldestinationList] WHERE [Destination] = @original_Destination AND [City] = @original_City AND [Company ID ref] = @original_Company_ID_ref AND (([Address] = @original_Address) OR ([Address] IS NULL AND @original_Address IS NULL)) AND (([Address Line 2] = @original_Address_Line_2) OR ([Address Line 2] IS NULL AND @original_Address_Line_2 IS NULL)) AND (([State] = @original_State) OR ([State] IS NULL AND @original_State IS NULL)) AND (([Zip] = @original_Zip) OR ([Zip] IS NULL AND @original_Zip IS NULL)) AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND (([Contact Voice] = @original_Contact_Voice) OR ([Contact Voice] IS NULL AND @original_Contact_Voice IS NULL))" 
            InsertCommand="INSERT INTO [tbldestinationList] ([Destination], [Address], [Address Line 2], [City], [State], [Zip], [Company ID ref], [Phone], [Contact Voice]) VALUES (@Destination, @Address, @Address_Line_2, @City, @State, @Zip, @Company_ID_ref, @Phone, @Contact_Voice)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT [Destination], [Address], [Address Line 2] AS Address_Line_2, [City], [State], [Zip], [Company ID ref] AS Company_ID_ref, [Phone], [Contact Voice] AS Contact_Voice FROM [tbldestinationList] WHERE ([Company ID ref] = @Company_ID_ref)" 
            UpdateCommand="UPDATE [tbldestinationList] SET [Address] = @Address, [Address Line 2] = @Address_Line_2, [State] = @State, [Zip] = @Zip, [Phone] = @Phone, [Contact Voice] = @Contact_Voice WHERE [Destination] = @original_Destination AND [City] = @original_City AND [Company ID ref] = @original_Company_ID_ref AND (([Address] = @original_Address) OR ([Address] IS NULL AND @original_Address IS NULL)) AND (([Address Line 2] = @original_Address_Line_2) OR ([Address Line 2] IS NULL AND @original_Address_Line_2 IS NULL)) AND (([State] = @original_State) OR ([State] IS NULL AND @original_State IS NULL)) AND (([Zip] = @original_Zip) OR ([Zip] IS NULL AND @original_Zip IS NULL)) AND (([Phone] = @original_Phone) OR ([Phone] IS NULL AND @original_Phone IS NULL)) AND (([Contact Voice] = @original_Contact_Voice) OR ([Contact Voice] IS NULL AND @original_Contact_Voice IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Destination" Type="String" />
                <asp:Parameter Name="original_City" Type="String" />
                <asp:Parameter Name="original_Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="original_Address" Type="String" />
                <asp:Parameter Name="original_Address_Line_2" Type="String" />
                <asp:Parameter Name="original_State" Type="String" />
                <asp:Parameter Name="original_Zip" Type="String" />
                <asp:Parameter Name="original_Phone" Type="String" />
                <asp:Parameter Name="original_Contact_Voice" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Destination" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="Address_Line_2" Type="String" />
                <asp:Parameter Name="City" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="Zip" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Contact_Voice" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="Address_Line_2" Type="String" />
                <asp:Parameter Name="State" Type="String" />
                <asp:Parameter Name="Zip" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Contact_Voice" Type="String" />
                <asp:Parameter Name="original_Destination" Type="String" />
                <asp:Parameter Name="original_City" Type="String" />
                <asp:Parameter Name="original_Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="original_Address" Type="String" />
                <asp:Parameter Name="original_Address_Line_2" Type="String" />
                <asp:Parameter Name="original_State" Type="String" />
                <asp:Parameter Name="original_Zip" Type="String" />
                <asp:Parameter Name="original_Phone" Type="String" />
                <asp:Parameter Name="original_Contact_Voice" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
