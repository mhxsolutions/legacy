<%@ Control Language="C#" AutoEventWireup="true" Inherits="Web_App.Controls.LoadTrackingControl" CodeFile="LoadTrackingControl.ascx.cs" %>

<asp:Panel DefaultButton="TrackingButton" ID="LoadTrackingControlPanel" runat="server">
    <div style="padding: 15px 0px 10px 5px">
    <asp:TextBox ID="LoadReference" runat="server" Width="95px" Text=""  placeholder="Load Reference" ValidationGroup="LoadTrackingControlValidationGroup"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LoadReference"
        ValidationGroup="LoadTrackingControlValidationGroup" ErrorMessage="*" />
        <dx:ASPxButton ID="TrackingButton" runat="server" Text="Track" ValidationGroup="LoadTrackingControlValidationGroup"
        OnClick="TrackingButton_Click" Height="15"></dx:ASPxButton>

    <%--<asp:Button ID="TrackingButton" runat="server" Text="Track" ValidationGroup="LoadTrackingControlValidationGroup"
        OnClick="TrackingButton_Click" /><br />--%>
    </div>
</asp:Panel>