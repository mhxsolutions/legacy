<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Administration_AdministerUserReports" Title="BudwayDirect | Administer User Reports" Codebehind="AdministerUserReports.aspx.cs" %>
    
<%@ MasterType VirtualPath="~/CustomerService.master" %>    
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Administer User Reports</h2>
    <p>Use the grid below to update or delete existing reports.</p>
    <asp:GridView ID="ReportsGridview" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ReportID" DataSourceID="ReportsDatasource" 
        ForeColor="#333333" GridLines="None" OnRowUpdated="ReportsGridview_RowUpdated" >
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:TemplateField HeaderText="Title" SortExpression="Title">
                <EditItemTemplate>
                    <asp:TextBox ID="TitleTextbox" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="TitleExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="TitleTextbox" ErrorMessage="Title is required" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="URL" SortExpression="URL">
                <EditItemTemplate>
                    <asp:TextBox ID="UrlTextbox" runat="server" Text='<%# Bind("URL") %>'></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="UrlExistsValidator" runat="server" Display="Dynamic"
                        ControlToValidate="UrlTextbox" ErrorMessage="URL is required" ValidationGroup="GridviewValidationGroup">
                    </asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="UrlLabel" runat="server" Text='<%# Bind("URL") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Publicly Visible" SortExpression="Publicly Visible">
                <EditItemTemplate>
                    <asp:CheckBox ID="PubliclyVisibleCheckboxForEditing" runat="server" Checked='<%# Bind("PubliclyVisible") %>' />                
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="PubliclyVisibleCheckboxForDisplay" runat="server" Checked='<%# Bind("PubliclyVisible") %>' />                
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:CommandField ShowEditButton="True" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle VerticalAlign="Top" />
            </asp:CommandField>
        </Columns>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="ReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Report ID] AS ReportId, Title, URL, [Publicly Visible] AS PubliclyVisible FROM [Cops Reports]"
        UpdateCommand="UPDATE [Cops Reports] SET [Title]=@Title, [URL]=@URL, [Publicly Visible]=@PubliclyVisible WHERE [Report ID]=@ReportId">
        <UpdateParameters>
            <asp:Parameter Name="ReportId" />
            <asp:Parameter Name="Title" />
            <asp:Parameter Name="URL" />
            <asp:Parameter Name="PubliclyVisible" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
