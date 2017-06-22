<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EOM.aspx.vb" Inherits="EOM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EOM Status</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        EOM Status<br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" KeyFieldName="EOM ID">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="EOM ID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Company" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Task ID" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Task" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Predecessor" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Hours" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Level" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Complete" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="List Date" VisibleIndex="8">
                </dx:GridViewDataDateColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>" 
            DeleteCommand="DELETE FROM [EOM Tasks] WHERE [EOM ID] = @original_EOM_ID AND [Company] = @original_Company AND [Task ID] = @original_Task_ID AND [Task] = @original_Task AND (([Predecessor] = @original_Predecessor) OR ([Predecessor] IS NULL AND @original_Predecessor IS NULL)) AND [Hours] = @original_Hours AND [Group Level] = @original_Group_Level AND [Complete] = @original_Complete AND [List Date] = @original_List_Date" 
            InsertCommand="INSERT INTO [EOM Tasks] ([Company], [Task ID], [Task], [Predecessor], [Hours], [Group Level], [Complete], [List Date]) VALUES (@Company, @Task_ID, @Task, @Predecessor, @Hours, @Group_Level, @Complete, @List_Date)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [EOM Tasks]" 
            UpdateCommand="UPDATE [EOM Tasks] SET [Company] = @Company, [Task ID] = @Task_ID, [Task] = @Task, [Predecessor] = @Predecessor, [Hours] = @Hours, [Group Level] = @Group_Level, [Complete] = @Complete, [List Date] = @List_Date WHERE [EOM ID] = @original_EOM_ID AND [Company] = @original_Company AND [Task ID] = @original_Task_ID AND [Task] = @original_Task AND (([Predecessor] = @original_Predecessor) OR ([Predecessor] IS NULL AND @original_Predecessor IS NULL)) AND [Hours] = @original_Hours AND [Group Level] = @original_Group_Level AND [Complete] = @original_Complete AND [List Date] = @original_List_Date">
            <DeleteParameters>
                <asp:Parameter Name="original_EOM_ID" Type="Int32" />
                <asp:Parameter Name="original_Company" Type="String" />
                <asp:Parameter Name="original_Task_ID" Type="Int32" />
                <asp:Parameter Name="original_Task" Type="String" />
                <asp:Parameter Name="original_Predecessor" Type="Int32" />
                <asp:Parameter Name="original_Hours" Type="Double" />
                <asp:Parameter Name="original_Group_Level" Type="Int32" />
                <asp:Parameter Name="original_Complete" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="original_List_Date" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Company" Type="String" />
                <asp:Parameter Name="Task_ID" Type="Int32" />
                <asp:Parameter Name="Task" Type="String" />
                <asp:Parameter Name="Predecessor" Type="Int32" />
                <asp:Parameter Name="Hours" Type="Double" />
                <asp:Parameter Name="Group_Level" Type="Int32" />
                <asp:Parameter Name="Complete" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="List_Date" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Company" Type="String" />
                <asp:Parameter Name="Task_ID" Type="Int32" />
                <asp:Parameter Name="Task" Type="String" />
                <asp:Parameter Name="Predecessor" Type="Int32" />
                <asp:Parameter Name="Hours" Type="Double" />
                <asp:Parameter Name="Group_Level" Type="Int32" />
                <asp:Parameter Name="Complete" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="List_Date" />
                <asp:Parameter Name="original_EOM_ID" Type="Int32" />
                <asp:Parameter Name="original_Company" Type="String" />
                <asp:Parameter Name="original_Task_ID" Type="Int32" />
                <asp:Parameter Name="original_Task" Type="String" />
                <asp:Parameter Name="original_Predecessor" Type="Int32" />
                <asp:Parameter Name="original_Hours" Type="Double" />
                <asp:Parameter Name="original_Group_Level" Type="Int32" />
                <asp:Parameter Name="original_Complete" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="original_List_Date" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
