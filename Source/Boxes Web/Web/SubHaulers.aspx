<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SubHaulers.aspx.vb" Inherits="SubHaulers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SubHaulers</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>MHX SubHaulers (<a href="index.aspx">home</a>)<br />
            <br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="EmployeeID" Theme="MetropolisBlue">
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="EmployeeID" ReadOnly="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LastName" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Title" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="City" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="State" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="WorkPhone" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Payroll Rate Description" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="3rd party co" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="3rd party co name" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NetSuiteID" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NetSuiteVendorID" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Subhaul Drivers] WHERE ([company ID ref] = @company_ID_ref)" UpdateCommand="UPDATE [Subhaul Drivers] SET Address =, City =, State =, [3rd party co] =, [3rd party co name] =, NetSuiteID =, NetSuiteVendorID =">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
