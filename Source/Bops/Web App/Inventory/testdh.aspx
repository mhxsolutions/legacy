<%@ Page Title="" Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" CodeBehind="testdh.aspx.cs" Inherits="Web_App.Inventory.testdh" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <dx:ASPxGridView ID="ASPxGridView1" runat="server">
    </dx:ASPxGridView>
</asp:Content>
