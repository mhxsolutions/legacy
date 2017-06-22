<%@ Page Title="Edit sample" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="editsample.aspx.cs" Inherits="Web.Clients.All.editsample" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Edit Table from Data Grid</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ID" Theme="Metropolis">
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" ShowSelectCheckbox="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="flag" VisibleIndex="2">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="note" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="value" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [a test table] WHERE [ID] = @original_ID AND [flag] = @original_flag AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND (([value] = @original_value) OR ([value] IS NULL AND @original_value IS NULL))" InsertCommand="INSERT INTO [a test table] ([flag], [note], [value]) VALUES (@flag, @note, @value)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [a test table]" UpdateCommand="UPDATE [a test table] SET [flag] = @flag, [note] = @note, [value] = @value WHERE [ID] = @original_ID AND [flag] = @original_flag AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL)) AND (([value] = @original_value) OR ([value] IS NULL AND @original_value IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_flag" Type="Boolean" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_value" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="flag" Type="Boolean" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="value" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="flag" Type="Boolean" />
                <asp:Parameter Name="note" Type="String" />
                <asp:Parameter Name="value" Type="Decimal" />
                <asp:Parameter Name="original_ID" Type="Int32" />
                <asp:Parameter Name="original_flag" Type="Boolean" />
                <asp:Parameter Name="original_note" Type="String" />
                <asp:Parameter Name="original_value" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
