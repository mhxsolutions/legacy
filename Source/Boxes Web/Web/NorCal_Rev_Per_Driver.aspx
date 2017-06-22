<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_Rev_Per_Driver.aspx.vb" Inherits="NorCal_Rev_Per_Driver" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NorCal Driver Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            NorCal Revenue Per Driver<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
            Theme="Office2010Black">
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Revenue" SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Load Date" GroupIndex="0" ReadOnly="True" 
                    SortIndex="0" SortOrder="Descending" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" GroupIndex="1" ReadOnly="True" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="RFS Rate Total" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Manual Rate Total" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [NorCal pre assigned load revenue]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
