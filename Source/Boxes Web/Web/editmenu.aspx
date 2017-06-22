<%@ Page Language="VB" AutoEventWireup="false" CodeFile="editmenu.aspx.vb" Inherits="test" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Edit report descriptions.</h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="web report ID" Theme="Metropolis">
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="web report ID" ReadOnly="True" VisibleIndex="8">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Category" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Requested" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Report Title" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Report Link" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Company ID ref" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="6">
                </dx:GridViewDataCheckColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" DeleteCommand="DELETE FROM [web reports] WHERE [web report ID] = @original_web_report_ID" InsertCommand="INSERT INTO [web reports] ([Description], [Category], [Requested], [Report Title], [Report Link], [Company ID ref], [Active]) VALUES (@Description, @Category, @Requested, @Report_Title, @Report_Link, @Company_ID_ref, @Active)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [web reports] WHERE ([Company ID ref] = @Company_ID_ref)" UpdateCommand="UPDATE [web reports] SET [Description] = @Description, [Category] = @Category, [Requested] = @Requested, [Report Title] = @Report_Title, [Report Link] = @Report_Link, [Company ID ref] = @Company_ID_ref, [Active] = @Active WHERE [web report ID] = @original_web_report_ID ">
            <DeleteParameters>
                <asp:Parameter Name="original_web_report_ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="Requested" Type="String" />
                <asp:Parameter Name="Report_Title" Type="String" />
                <asp:Parameter Name="Report_Link" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Active" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Category" Type="String" />
                <asp:Parameter Name="Requested" Type="String" />
                <asp:Parameter Name="Report_Title" Type="String" />
                <asp:Parameter Name="Report_Link" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Active" Type="Boolean" />
                <asp:Parameter Name="original_web_report_ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    
    </div>
    </form>
</body>
</html>
