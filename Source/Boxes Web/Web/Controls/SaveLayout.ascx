
<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SaveLayout.ascx.vb" Inherits="Controls_SaveLayout" %>
<style>
    #layoutLoaderTable td {
        padding-left: 5px;
    }
</style>
<table id="layoutLoaderTable">
    <tr>
        <td>Layout: </td>
        <td>
            <dx:ASPxComboBox ID="cmbLayout" runat="server" DropDownStyle="DropDown" ValueType="System.String">
                <ValidationSettings RequiredField-IsRequired="true" CausesValidation="true" ValidationGroup="LoadSaveLayout" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip"></ValidationSettings>
            </dx:ASPxComboBox>
        </td>
        <td>
            <dx:ASPxButton ID="btnLoadLayout" runat="server" OnClick="btnLoadLayout_Click" Text="Load" ValidationGroup="LoadSaveLayout"></dx:ASPxButton>
        </td>
        <td>
            <dx:ASPxButton ID="btnSaveLayout" runat="server" OnClick="btnSaveLayout_Click" Text="Save" ValidationGroup="LoadSaveLayout"></dx:ASPxButton>
        </td>
    </tr>
</table>