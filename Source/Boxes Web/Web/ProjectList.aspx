<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ProjectList.aspx.vb" Inherits="ProjectList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SCM Project List</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>SCM Project List<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ProjectID" Theme="Metropolis">
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ProjectID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Project_Title" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Project_Description" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Project_Priority" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Project_Notes" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Company ID ref" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Project_Status" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" DeleteCommand="DELETE FROM SCMProjects WHERE (ProjectID = @original_ProjectID)" InsertCommand="INSERT INTO SCMProjects(Project_Title, Project_Description, Project_Priority, Project_Notes, [Company ID ref], Project_Status) VALUES (@Project_Title, @Project_Description, @Project_Priority, @Project_Notes, 1, @Project_Status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [SCMProjects]" UpdateCommand="UPDATE SCMProjects SET Project_Title = @Project_Title, Project_Description = @Project_Description, Project_Priority = @Project_Priority, Project_Notes = @Project_Notes, Project_Status = @Project_Status WHERE (ProjectID = @original_ProjectID)">
            <DeleteParameters>
                <asp:Parameter Name="original_ProjectID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Project_Title" Type="String" />
                <asp:Parameter Name="Project_Description" Type="String" />
                <asp:Parameter Name="Project_Priority" Type="Int32" />
                <asp:Parameter Name="Project_Notes" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Project_Status" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Project_Title" Type="String" />
                <asp:Parameter Name="Project_Description" Type="String" />
                <asp:Parameter Name="Project_Priority" Type="Int32" />
                <asp:Parameter Name="Project_Notes" Type="String" />
                <asp:Parameter Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="Project_Status" Type="String" />
                <asp:Parameter Name="original_ProjectID" Type="Int32" />
                <asp:Parameter Name="original_Project_Title" Type="String" />
                <asp:Parameter Name="original_Project_Description" Type="String" />
                <asp:Parameter Name="original_Project_Priority" Type="Int32" />
                <asp:Parameter Name="original_Project_Notes" Type="String" />
                <asp:Parameter Name="original_Company_ID_ref" Type="Int32" />
                <asp:Parameter Name="original_Project_Status" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
