<%@ Page Language="VB" AutoEventWireup="false" CodeFile="test.aspx.vb" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Load">
            <Columns>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="0">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="POD_Time" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="POD_Date" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" DeleteCommand="DELETE FROM [tblPoscoLoads] WHERE [Load] = @original_Load AND (([POD] = @original_POD) OR ([POD] IS NULL AND @original_POD IS NULL)) AND (([POD Time] = @original_POD_Time) OR ([POD Time] IS NULL AND @original_POD_Time IS NULL)) AND (([POD Date] = @original_POD_Date) OR ([POD Date] IS NULL AND @original_POD_Date IS NULL))" InsertCommand="INSERT INTO [tblPoscoLoads] ([POD], [POD Time], [POD Date], [Load]) VALUES (@POD, @POD_Time, @POD_Date, @Load)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [POD], [POD Time] AS POD_Time, [POD Date] AS POD_Date, [Load] FROM [tblPoscoLoads]" UpdateCommand="UPDATE [tblPoscoLoads] SET [POD] = @POD, [POD Time] = @POD_Time, [POD Date] = @POD_Date WHERE [Load] = @original_Load AND (([POD] = @original_POD) OR ([POD] IS NULL AND @original_POD IS NULL)) AND (([POD Time] = @original_POD_Time) OR ([POD Time] IS NULL AND @original_POD_Time IS NULL)) AND (([POD Date] = @original_POD_Date) OR ([POD Date] IS NULL AND @original_POD_Date IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Load" Type="String" />
                <asp:Parameter Name="original_POD" Type="Boolean" />
                <asp:Parameter Name="original_POD_Time" Type="DateTime" />
                <asp:Parameter Name="original_POD_Date" Type="DateTime" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="POD" Type="Boolean" />
                <asp:Parameter Name="POD_Time" Type="DateTime" />
                <asp:Parameter Name="POD_Date" Type="DateTime" />
                <asp:Parameter Name="Load" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="POD" Type="Boolean" />
                <asp:Parameter Name="POD_Time" Type="DateTime" />
                <asp:Parameter Name="POD_Date" Type="DateTime" />
                <asp:Parameter Name="original_Load" Type="String" />
                <asp:Parameter Name="original_POD" Type="Boolean" />
                <asp:Parameter Name="original_POD_Time" Type="DateTime" />
                <asp:Parameter Name="original_POD_Date" Type="DateTime" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
