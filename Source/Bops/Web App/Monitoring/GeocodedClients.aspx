<%@ Page Title="" Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" CodeBehind="GeocodedClients.aspx.cs" Inherits="Web_App.Monitoring.GeocodedClients" %>
<%@ MasterType VirtualPath="~/BopsWeb.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!--
        The style attribute on the map is not set to the usual 100% height and width with relative
        positioning because the Microsoft Virtual Earth control does not function properly with those
        settings. When set to relative position with a percentage height, it produces nothing more
        than a blank page. It is apparently a known problem:
        
        http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=2284784&SiteID=1
        
        The solution mentioned in that post doesn't work in this case, perhaps because we're using
        master pages? What I know for sure is that the following settings do work, though they don't
        necessarily look correct at all browser sizes.
    -->
    <div id='map1' style="position: absolute; width: 83%; height: 87%; z-index: 101;" />
</asp:Content>
