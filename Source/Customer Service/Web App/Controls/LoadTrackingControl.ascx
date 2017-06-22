<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_LoadTrackingControl" Codebehind="LoadTrackingControl.ascx.cs" %>

<asp:Panel DefaultButton="TrackingButton" ID="LoadTrackingControlPanel" runat="server">
    Load Reference:<br />
    <asp:TextBox ID="LoadReference" runat="server" Width="90px" Text="" ValidationGroup="LoadTrackingControlValidationGroup"></asp:TextBox>
    <asp:Button ID="TrackingButton" runat="server" Text="Track" ValidationGroup="LoadTrackingControlValidationGroup"
        OnClick="TrackingButton_Click" /><br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LoadReference"
        ValidationGroup="LoadTrackingControlValidationGroup" ErrorMessage="Invalid Load Reference" />
</asp:Panel>