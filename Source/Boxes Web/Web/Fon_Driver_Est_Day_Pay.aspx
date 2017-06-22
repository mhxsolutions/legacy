<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Fon_Driver_Est_Day_Pay.aspx.vb" Inherits="Fon_Driver_Est_Day_Pay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fon Driver Day Pay</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver Daily Hours and Pay - Fontana - <a href="fon.aspx">home</a><br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Theme="Aqua" Width="122px">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Total Hours" ReadOnly="True" 
                    VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Drive Time" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Est Transit" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Non Drive" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Est Dwell" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Private Revenue" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Public Revenue" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Est Driver Pay" FieldName="Est Load Pay" 
                    VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Payroll as Submitted" FieldName="Payroll" 
                    VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Driver est Day Pay with hours and revenue 55 day ltd] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        FileName="driver daily hours and pay - fontana" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
    <p>
        Estimated Driver Pay based on load pay.</p>
    <p>
        Payroll as Submitted is driver pay from Operations approved load pay with 
        corrections.</p>
    <p>
        <a href="driver_detail_pay_revenue.aspx">Driver load by load detail</a></p>
</body>
</html>
