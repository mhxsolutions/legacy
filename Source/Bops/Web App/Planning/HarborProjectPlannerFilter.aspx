<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master" Inherits="Planning_HarborProjectPlannerFilter" Codebehind="HarborProjectPlannerFilter.aspx.cs" %>

<asp:content id="Content1" contentplaceholderid="ContentPlaceHolder1" runat="Server">
        <h2>Filter Settings</h2>
        Select the project status codes to include in the data:<br />
        <br />
        <asp:CheckBoxList ID="StatusCodes" runat="server" AutoPostBack="True"></asp:CheckBoxList><br />
        <asp:Label ID="ErrorMessage" runat="server" ForeColor="Maroon" Text="Error: You must select at least <i>one</i> of the project status codes.<br /><br />"
            Visible="False"></asp:Label>
        <asp:Button ID="ApplyFilter" runat="server" Text="Apply Filter" OnClick="ApplyFilter_Click" />
        <asp:Button ID="Cancel" runat="server" Text="Cancel" PostBackUrl="~/Planning/HarborProjectPlanner.aspx" />

</asp:content>
