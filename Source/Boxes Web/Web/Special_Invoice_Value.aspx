<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Special_Invoice_Value.aspx.vb" Inherits="Special_Invoice_Value" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Special Invoice Value</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 620px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Special Invoice Value Receiving and Shipping (BOL only)<br />
        </h3>
    
    </div>
    <table class="style1">
        <tr>
            <td class="style2">
                <strong>Receivers</strong></td>
            <td>
                <strong>BOLs</strong></td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
                    <GroupSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Tons={0:n1}" FieldName="Tons" 
                            SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Special={0:n1}" 
                            FieldName="Special Invoice Value" SummaryType="Sum" />
                    </GroupSummary>
                    <Columns>
                        <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                        <dx:GridViewDataTextColumn FieldName="Yr" GroupIndex="1" ReadOnly="True" 
                            SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Mo" GroupIndex="2" ReadOnly="True" 
                            SortIndex="2" SortOrder="Descending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" 
                            SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="4" 
                            SortOrder="Ascending" VisibleIndex="5">
                            <Settings GroupInterval="Date" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Receiver ID" SortIndex="5" 
                            SortOrder="Ascending" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" 
                            SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
                            <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" 
                                HeaderFilterMode="CheckedList" ShowFilterRowMenu="True" 
                                ShowInFilterControl="True" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tons" FieldName="Tons" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Special Invoice Value" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="30">
                        <AllButton Visible="True">
                        </AllButton>
                        <PageSizeItemSettings Visible="True">
                        </PageSizeItemSettings>
                    </SettingsPager>
                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                    SelectCommand="SELECT * FROM [Special Invoice Value by date term client]">
                </asp:SqlDataSource>
            </td>
            <td valign="top">
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2003Olive">
                    <GroupSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Tons={0:n1}" FieldName="Tons" 
                            SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Special={0:n1}" 
                            FieldName="Special Invoice Value" SummaryType="Sum" />
                    </GroupSummary>
                    <Columns>
                        <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                        <dx:GridViewDataTextColumn FieldName="Yr" GroupIndex="1" ReadOnly="True" 
                            SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Mo" GroupIndex="2" ReadOnly="True" 
                            SortIndex="2" SortOrder="Descending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Shipment Date" SortIndex="4" 
                            SortOrder="Ascending" VisibleIndex="6">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" ReadOnly="True" 
                            SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" 
                            SortIndex="6" SortOrder="Ascending" VisibleIndex="4">
                            <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" 
                                HeaderFilterMode="CheckedList" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Load ID" SortIndex="5" 
                            SortOrder="Ascending" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Special Invoice Value" VisibleIndex="9">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons" ReadOnly="True" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <SettingsPager PageSize="30">
                        <AllButton Visible="True">
                        </AllButton>
                        <PageSizeItemSettings Visible="True">
                        </PageSizeItemSettings>
                    </SettingsPager>
                    <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                    SelectCommand="SELECT * FROM [Special Invoice Value by date term client BOL]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
