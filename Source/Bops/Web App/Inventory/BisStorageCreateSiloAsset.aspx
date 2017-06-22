<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisStorageCreateSiloAsset" Title="BOPS | Bulk Inventory System | Create Silo" Codebehind="BisStorageCreateSiloAsset.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Create Silo</h2>
    <p>To create a new silo, provide the information below and click the Create button.</p>
    <table>
        <tr>
            <td>Name:</td>
            <td>
                <asp:TextBox ID="_NameTextbox" runat="server" />
                <asp:RequiredFieldValidator ID="_NameRequiredValidator" runat="server" Display="dynamic" ErrorMessage="Required" ControlToValidate="_NameTextbox" />
            </td>
        </tr>
        <tr>
            <td>Description:</td>
            <td>
                <asp:TextBox ID="_DescriptionTextbox" runat="server" />
                <asp:RequiredFieldValidator ID="_DescriptionRequiredValidator" runat="server" Display="dynamic" ErrorMessage="Required" ControlToValidate="_DescriptionTextbox" />
            </td>
        </tr>
        <tr>
            <td>Product Type:</td>
            <td>
                <asp:DropDownList ID="_ProductTypeDropdownlist" runat="server" DataSourceID="_ProductTypeDatasource" DataTextField="Product_Type" DataValueField="ATSF_Product_ID" /><asp:SqlDataSource
                    ID="_ProductTypeDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [ATSF Product ID] AS ATSF_Product_ID, [Product Type] AS Product_Type FROM [ATSF Product Type] WHERE ([BIS Enable] = @BIS_Enable) ORDER BY [Product Type]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="True" Name="BIS_Enable" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="_CreateButton" runat="server" Text="Create" OnClick="_CreateButton_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
