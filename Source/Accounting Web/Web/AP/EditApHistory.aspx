<%@ Page Language="C#" MasterPageFile="~/Accounting Web.master" AutoEventWireup="true" CodeFile="EditApHistory.aspx.cs" 
    Inherits="AR_EditApHistory" Title="Budway Accounting Web | Edit AP History" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>AP History</h2>
    <p>Use the grid to make changes to the AP history.</p>
    <p>
        <a href="../Default.aspx">Home</a></p>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="Apid" DataSourceID="ApHistoryDatasource" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True">
        <FooterStyle BackColor="#950000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
        
            <asp:TemplateField HeaderText="Current" SortExpression="Current">
                <EditItemTemplate>
                    <asp:TextBox ID="CurrentTextbox" runat="server" Text='<%# Bind("Current", "{0:N2}") %>'></asp:TextBox><br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="CurrentLabel" runat="server" Text='<%# Bind("Current", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="30" SortExpression="Thirty">
                <EditItemTemplate>
                    <asp:TextBox ID="ThirtyTextbox" runat="server" Text='<%# Bind("Thirty", "{0:N2}") %>'></asp:TextBox><br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ThirtyLabel" runat="server" Text='<%# Bind("Thirty", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="45" SortExpression="Fortyfive">
                <EditItemTemplate>
                    <asp:TextBox ID="FortyfiveTextbox" runat="server" Text='<%# Bind("Fortyfive", "{0:N2}") %>'></asp:TextBox><br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="FortyfiveLabel" runat="server" Text='<%# Bind("Fortyfive", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="60" SortExpression="Sixty">
                <EditItemTemplate>
                    <asp:TextBox ID="SixtyTextbox" runat="server" Text='<%# Bind("Sixty", "{0:N2}") %>'></asp:TextBox><br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="SixtyLabel" runat="server" Text='<%# Bind("Sixty", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="90" SortExpression="Ninety">
                <EditItemTemplate>
                    <asp:TextBox ID="NinetyTextbox" runat="server" Text='<%# Bind("Ninety", "{0:N2}") %>'></asp:TextBox><br />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="NinetyLabel" runat="server" Text='<%# Bind("Ninety", "{0:N2}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
        
            <asp:TemplateField HeaderText="Date" SortExpression="Date">
                <EditItemTemplate>
                    <asp:TextBox ID="DateTextbox" runat="server" Text='<%# Bind("Date", "{0:MM/dd/yy}") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="DateExistsValidator" runat="server" ControlToValidate="DateTextbox"
                        ValidationGroup="GridviewValidationGroup" Display="dynamic" ErrorMessage="Date is required">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("Date", "{0:MM/dd/yy}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the row?");' Text="Delete" ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:CommandField>
        
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#950000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="ApHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>"
        InsertCommand="INSERT [AP History] ([AP current], [AP 30], [AP 45], [AP 60], [AP 90], [AP Date]) VALUES (@Current, @Thirty, @Fortyfive, @Sixty, @Ninety, @Date)"
        SelectCommand="SELECT [AP ID] AS Apid, [AP current] AS [Current], [AP 30] AS Thirty, [AP 45] AS Fortyfive, [AP 60] AS Sixty, [AP 90] AS Ninety, [AP Date] AS Date FROM [AP History]"
        UpdateCommand="UPDATE [AP History] SET [AP current] = @Current, [AP 30] = @Thirty, [AP 45] = @Fortyfive, [AP 60] = @Sixty, [AP 90] = @Ninety, [AP Date] = @Date WHERE [AP ID] = @Apid"
        DeleteCommand="DELETE FROM [AP History] WHERE [AP ID] = @Apid" >
        <InsertParameters>
            <asp:Parameter Name="Current" />
            <asp:Parameter Name="Thirty" />
            <asp:Parameter Name="Fortyfive" />
            <asp:Parameter Name="Sixty" />
            <asp:Parameter Name="Ninety" />
            <asp:Parameter Name="Date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Apid" />
            <asp:Parameter Name="Current" />
            <asp:Parameter Name="Thirty" />
            <asp:Parameter Name="Fortyfive" />
            <asp:Parameter Name="Sixty" />
            <asp:Parameter Name="Ninety" />
            <asp:Parameter Name="Date" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Apid" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <h3>Insert New AP History</h3>
    <p>To add a new AP history record, provide at least a date in the fields below and click the button.</p>
    
    <table>
        <tr>
            <td style="width: 75px">Current:</td>
            <td style="width: 75px">30:</td>
            <td style="width: 75px">45:</td>
            <td style="width: 75px">60:</td>
            <td style="width: 75px">90:</td>
            <td style="width: 75px">Date:</td>
            <td></td>
        </tr>
        <tr>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewCurrentTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewThirtyTextBox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewFortyfiveTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewSixtyTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewNinetyTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox></td>
            <td style="width: 75px; vertical-align: top;">
                <asp:TextBox ID="NewDateTextbox" runat="server" ValidationGroup="NewValueValidation"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewDateExistsValidator" runat="server" ControlToValidate="NewDateTextbox"
                    Display="Dynamic" ErrorMessage="Date is required" ValidationGroup="NewValueValidation"></asp:RequiredFieldValidator></td>
            <td style="vertical-align: top;">
                <asp:Button ID="SaveButton" runat="server" Text="Add New History" ValidationGroup="NewValueValidation" OnClick="SaveButton_Click" /></td>
        </tr>
    </table>


</asp:Content>

