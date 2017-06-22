<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="ReceivingDeliveryStatusReport.aspx.cs" Inherits="Web.Clients.Assigned.ReceivingDeliveryStatusReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="position:relative; top:30px; left:30px; margin:5px auto;">
        <rsweb:ReportViewer ID="rvReportViewer" runat="server" Height="700px" SizeToReportContent="true" ></rsweb:ReportViewer>
    </div>
</asp:Content>
