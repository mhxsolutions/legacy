<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisWithdrawToContainer" 
    Title="BOPS | Bulk Inventory System | Withdraw To Container" Codebehind="BisWithdrawToContainer.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <script language="javascript" type="text/javascript">
    
        function GetObj(name)
        {
            // DHTML Micro API
            // Source: http://www.quirksmode.org/js/dhtmloptions.html
            
            if (document.getElementById) // test if browser supports document.getElementById
            {
                this.obj = document.getElementById(name);
                this.style = document.getElementById(name).style;
            }
            else if (document.all) // test if browser supports document.all
            {
                this.obj = document.all[name];
                this.style = document.all[name].style;
            }
            else if (document.layers) // test if browser supports document.layers
            {
                this.obj = document.layers[name];
                this.style = document.layers[name].style;
            }
        }

        function ClientValidateQuantity(source, arguments)
        {
            var Rx = /[0-9]+$/;
            var Ctl = new GetObj("<%=_QuantityTextbox.ClientID%>");
            arguments.IsValid = Rx.test(Ctl.obj.value);
        }
        
    </script>

    <h2>Withdraw To Container</h2>
    <p>
        To withdraw bulk material to a container, choose the source from which it will be withdrawn, the container 
        into which it will be loaded, and the amount (in pounds). Click the "Withdraw" button to record
        the transaction.
    </p>

    <table cellpadding="4">
        <tr>
            <td valign="top">
                <h3>1. Select Storage Source For Withdraw</h3>
                <asp:GridView ID="_SourceGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="_SourceDatasource" 
                    ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, no active storage assets with material are available." AllowPaging="True" AllowSorting="True" AutoGenerateSelectButton="True" PageSize="6" OnSelectedIndexChanged="_SourceGridview_SelectedIndexChanged" >
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
                    SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Current Quantity] > 0)">
                </asp:SqlDataSource>
            </td>
            <td valign="top">
                <asp:Panel ID="_BookingsPanel" runat="server" Visible="false">
                    <h3>Valid Bookings</h3>
                        <asp:GridView ID="_BookingsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_BookingsDatasource" 
                            ForeColor="#333333" GridLines="None" EmptyDataText="No railcar pre-assignments found." AllowPaging="True" AllowSorting="True" DataKeyNames="Project Id" PageSize="6">
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:BoundField DataField="Project Id" HeaderText="Project Id" InsertVisible="False"
                                    ReadOnly="True" SortExpression="Project Id">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Booking" HeaderText="Booking" SortExpression="Booking">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="_BookingsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id] AS Booking FROM [CPS Project Railcars] INNER JOIN [BIS Storage Assets] ON [CPS Project Railcars].[Railcar Ref] = [BIS Storage Assets].[Original Asset Ref] INNER JOIN [CPS Projects] ON [CPS Project Railcars].[Project Ref] = [CPS Projects].[Project Id] WHERE ([BIS Storage Assets].[Storage Type Ref] = 1) AND ([BIS Storage Assets].[Storage Asset Id] = @SourceId)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_SourceGridview" Name="SourceId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:Panel>
            </td>
        </tr>
    </table>
    
    <p>
        <asp:Label ID="_SourceErrorLabel" runat="server" Visible="false" Text="You must select a storage source for withdraw" ForeColor="red"/>
    </p>

    <h3>2. Select Container To Load</h3>
    <p>NB: Containers highlighted in yellow are already partially loaded.</p>
    <asp:GridView ID="_ContainerGridview" runat="server" AutoGenerateColumns="False" DataKeyNames="Container" CellPadding="4" DataSourceID="_ContainerDatasource" 
        ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, no containers are available for loading." AutoGenerateSelectButton="True" AllowSorting="True" OnRowDataBound="_ContainerGridview_RowDataBound" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="Project Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Project Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking" HeaderText="Booking" SortExpression="Booking">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Container" HeaderText="Container" SortExpression="Container">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Partially Loaded" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="_PartialLabel" runat="server" Text='<%# Eval("Tx Count").ToString().Equals("0") ? "No" : "Yes" %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_ContainerDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id] AS Booking, [CPS Projects].Description, [CPS Containers].[Container Id] AS Container, COUNT([BIS CPS Transactions].[BIS Transaction Ref]) AS [Tx Count] FROM [CPS Demurrage] INNER JOIN [CPS Containers] ON [CPS Demurrage].[Container Ref] = [CPS Containers].[Container Id] INNER JOIN [CPS Projects] ON [CPS Demurrage].[Project Ref] = [CPS Projects].[Project Id] LEFT OUTER JOIN [BIS CPS Transactions] ON [CPS Demurrage].[Project Ref] = [BIS CPS Transactions].[Project Ref] AND [CPS Demurrage].[Container Ref] = [BIS CPS Transactions].[Container Ref] WHERE ([CPS Demurrage].[Clock End] IS NULL) AND ([CPS Demurrage].[Clock End Movement Ref] IS NULL) AND ([CPS Demurrage].[BIS Exclude] = 0) GROUP BY [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Containers].[Container Id]">
    </asp:SqlDataSource>
    
    <p>
        <asp:Label ID="_ContainerErrorLabel" runat="server" Visible="false" Text="You must select a container to load" ForeColor="red"/>
    </p>

    <h3>3. Withdraw Details</h3>    
    
    <p>
        <asp:CheckBox ID="_PartialCheckbox" runat="server" Text="Partial load (check to leave the container available for another withdraw)" AutoPostBack="True" OnCheckedChanged="_PartialCheckbox_CheckedChanged" />
    </p>
    
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
                <asp:CompareValidator ID="_QuantityMaximumValidator" runat="server" ControlToValidate="_QuantityTextbox"
                    ValueToCompare="60000" Operator="LessThanEqual" Display="dynamic" ErrorMessage="Must be less than or equal to 60,000" />
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
    
    <asp:Button ID="_WithdrawButton" runat="server" Text="Withdraw" OnClick="_WithdrawButton_Click"/>
        
</asp:Content>
