<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master" Inherits="_Default" Codebehind="~/Default.aspx.cs" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate>
            You must be logged in to access BopsWeb features.
        </AnonymousTemplate>
        <LoggedInTemplate>
            Welcome to Budway Operations Software (BOPS) main page, <asp:LoginName ID="LoginName1" runat="server" />. 
            Use the navigation pane to the left to make your way through the site.
        </LoggedInTemplate>
    </asp:LoginView>
</asp:Content>
