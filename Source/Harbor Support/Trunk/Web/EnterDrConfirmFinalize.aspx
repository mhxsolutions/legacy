<%@ Page Language="C#" MasterPageFile="~/HarborWeb.master" AutoEventWireup="true" CodeFile="EnterDrConfirmFinalize.aspx.cs" Inherits="EnterDrConfirmFinalize" Title="Harbor Web | Confirm Finalize" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Confirm Finalize</h2>
    <p>The pickup request you have entered, <% Response.Write(Request.Params["LoadRef"]); %>, is already assigned to at least 
    one other DR. Are you sure you wish to use it for DR <% Response.Write(Request.Params["DrId"]); %> as well?</p>
    <asp:Button ID="ConfirmButton" runat="server" Text="Confirm" OnClick="ConfirmButton_Click" ToolTip="Confirms pickup request reuse and finalizes DR" />
    <asp:Button ID="CancelButton" runat="server" Text="Cancel" OnClick="CancelButton_Click" ToolTip="Cancels finalize and returns to editing DR" />
</asp:Content>
