<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ContainersInYard.aspx.vb" Inherits="ContainersInYard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>In Yard</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>MHX Containers in Yard<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Client Name" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="In Yard to Process]" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [MHXcontainersInYard]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
