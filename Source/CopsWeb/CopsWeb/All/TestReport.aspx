<%@ Page Title="Test Report" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="TestReport.aspx.cs" Inherits="All_TestReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Test Report</h2>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID">
        <Settings ShowGroupPanel="False" ShowFilterRow="True">
        </Settings>
        <SettingsSearchPanel Visible="False"></SettingsSearchPanel>
        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit"></SettingsAdaptivity>
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" ShowDeleteButton="True"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="flag" VisibleIndex="2"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="note" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="value" VisibleIndex="4"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DWS No Rep DataConnectionString %>' DeleteCommand="DELETE FROM [a test table] WHERE [ID] = @ID" InsertCommand="INSERT INTO [a test table] ([flag], [note], [value]) VALUES (@flag, @note, @value)" SelectCommand="SELECT * FROM [a test table]" UpdateCommand="UPDATE [a test table] SET [flag] = @flag, [note] = @note, [value] = @value WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="flag" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="note" Type="String"></asp:Parameter>
            <asp:Parameter Name="value" Type="Decimal"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="flag" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="note" Type="String"></asp:Parameter>
            <asp:Parameter Name="value" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

