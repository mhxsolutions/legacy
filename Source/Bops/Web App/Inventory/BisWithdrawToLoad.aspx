<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisWithdrawToLoad" Title="BOPS | Bulk Inventory System | Withdraw To Load" Codebehind="BisWithdrawToLoad.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Withdraw To Load</h2>
    <p>
        To withdraw bulk material from a silo to a truck load, choose the source from which it will be withdrawn, 
        the load, and the amount (in pounds). Click the "Withdraw" button to record the transaction.
    </p>

    <h3>1. Select Storage Source For Withdraw</h3>
    <asp:GridView ID="_SourceGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="_SourceDatasource" 
        ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, no active storage assets with material are available." AllowPaging="True" AllowSorting="True" AutoGenerateSelectButton="True" PageSize="6" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_SourceDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Current Quantity] > 0) AND ([BIS Storage Assets].[Storage Type Ref] = 3)">
    </asp:SqlDataSource>
    
    <p>
        <asp:Label ID="_SourceErrorLabel" runat="server" Visible="false" Text="You must select a storage source for withdraw" ForeColor="red"/>
    </p>

    <h3>2. Select Truck Load</h3>
    
    <p>
        <asp:Label ID="_LoadErrorLabel" runat="server" Visible="false" Text="You must select a load" ForeColor="red"/>
    </p>

    <h3>3. Withdraw Details</h3>    
    
    <table cellpadding="2">
        <tr>
            <td>Quantity (pounds):</td>
            <td>
                <asp:TextBox ID="_QuantityTextbox" runat="server" MaxLength="5" />
                <asp:RequiredFieldValidator ID="_QuantityRequiredValidator" runat="server" ControlToValidate="_QuantityTextbox" Display="dynamic"
                    ErrorMessage="Required field" />
                <asp:CompareValidator ID="_QuantityNumberValidator" runat="server" ControlToValidate="_QuantityTextbox" Operator="DataTypeCheck" 
                    Type="Integer" Display="dynamic" ErrorMessage="Must be a whole number" />
                <asp:CompareValidator ID="_QuantityPositiveValidator" runat="server" ControlToValidate="_QuantityTextbox" ValueToCompare="0" Operator="GreaterThan" 
                    Display="dynamic" ErrorMessage="Must be greater than zero" />
                <asp:CompareValidator ID="_QuantityMaximumValidator" runat="server" ControlToValidate="_QuantityTextbox" ValueToCompare="60000" Operator="LessThanEqual"
                    Display="dynamic" ErrorMessage="Must be less than or equal to 60,000" />
            </td>
        </tr>
    
        <asp:Panel ID="_ContainerDetailsPanel" runat="server">
            <tr>
                <td>Seal Id:</td>
                <td>
                    <asp:TextBox ID="_SealNumberTextbox" runat="server" /> 
                    <asp:RequiredFieldValidator ID="_SealNumberRequiredValidator1" runat="server" ControlToValidate="_SealNumberTextbox" Display="dynamic" ErrorMessage="Required field" />
                </td>
            </tr>
            <tr>
                <td>Test Id:</td>
                <td>
                    <asp:TextBox ID="_TestNumberTextbox" runat="server" />
                    <asp:RequiredFieldValidator ID="_TestNumberRequiredValidator" runat="server" ControlToValidate="_TestNumberTextbox" Display="dynamic" ErrorMessage="Required field" />
                </td>
            </tr>
            <tr>
                <td>Bill of Lading:</td>
                <td>
                    <asp:TextBox ID="_BolTextbox" runat="server" />
                    <asp:RequiredFieldValidator ID="BolRequiredValidator" runat="server" ControlToValidate="_BolTextbox" Display="dynamic" ErrorMessage="Required field" />
                </td>
            </tr>
        </asp:Panel>

    </table>
    
    <p>
        <asp:Label ID="_WithrawErrorLabel" runat="server" Visible="false" Text="An error occurred while trying to record the transaction. You may try again or contact IT support." ForeColor="red"/>
    </p>
    
    <asp:Button ID="_WithdrawButton" runat="server" Text="Withdraw"/>

</asp:Content>
