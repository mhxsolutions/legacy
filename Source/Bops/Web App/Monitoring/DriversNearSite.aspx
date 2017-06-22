<%@ Page Title="" Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" CodeBehind="DriversNearSite.aspx.cs" Inherits="Web_App.Monitoring.DriversNearSite" %>
<%@ MasterType VirtualPath="~/BopsWeb.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Select destination:
        <asp:DropDownList ID="DestinationList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DestinationList_SelectedIndexChanged" Width="400px" />
    </p>
    <div id='map1' style="position: relative; width: 600px; height: 600px; z-index: 101;"/>
</asp:Content>
