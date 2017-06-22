<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ExportControl.ascx.cs" Inherits="Controls_ExportControl" %>
<div class="contentDiv">
    <dx:ASPxButton ID="btnExport" runat="server" Text="Export XLSX" OnClick="btnExport_Click"></dx:ASPxButton>
    <dx:ASPxGridViewExporter ID="gvExporter" runat="server"></dx:ASPxGridViewExporter>
</div>
