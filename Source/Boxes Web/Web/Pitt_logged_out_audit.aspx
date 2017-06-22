<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pitt_logged_out_audit.aspx.vb" Inherits="Pitt_logged_out_audit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Pittsburg - loads not logged out</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Pittsburg - Planned Loads not Logged Out -
            <a href="pitt_default.aspx">home</a><br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
            Theme="Aqua">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Planned" ReadOnly="True" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Assigned" ReadOnly="True" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch Depart" VisibleIndex="4">
                    <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="100">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowGroupFooter="VisibleAlways" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Planner Status Detail - Pitt no log out]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
