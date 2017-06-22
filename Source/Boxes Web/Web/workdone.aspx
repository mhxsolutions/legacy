<%@ Page Language="VB" AutoEventWireup="false" CodeFile="workdone.aspx.vb" Inherits="workdone" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Work Done</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 286px;
        }
        .style3
        {
            width: 286px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Work Done</h3>
        <p>
            <br />
            (a repot in progress)</p>
        <table class="style1">
            <tr>
                <td class="style3">
                    Receiving in DWS</td>
                <td>
                    <b>Shipping on Loads</b></td>
            </tr>
            <tr>
                <td class="style2" valign="top">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Tons In" SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem FieldName="Tons In" SummaryType="Sum" />
                        </GroupSummary>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="Date" GroupIndex="0" SortIndex="0" 
                                SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="Tons In" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                            ShowGroupPanel="True" />
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                        SelectCommand="SELECT * FROM [Tons received by Fleet and Date]">
                    </asp:SqlDataSource>
                    <br />
                    does not include UPI<br />
                </td>
                <td valign="top">
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2003Silver">
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Tons Out" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Tons {0:n1}" FieldName="Tons Out" 
                                SummaryType="Sum" />
                            <dx:ASPxSummaryItem DisplayFormat="Count {0:n0}" FieldName="Count" 
                                SummaryType="Sum" />
                        </GroupSummary>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn FieldName="LogOutDate" GroupIndex="0" SortIndex="0" 
                                SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn FieldName="Tons Out" VisibleIndex="3">
                                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" 
                            ShowFooter="True" ShowGroupPanel="True" />
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                        SelectCommand="SELECT * FROM [Tons Shipped (from loads) by fleet and date]">
                    </asp:SqlDataSource>
                    <br />
                    includes will call and UPI tons<br />
                    does not include weight on pick-up requests that are charged flat rate<br />
                    does not include Thoro<br />
                    does not include tons of shipped rail cars</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
