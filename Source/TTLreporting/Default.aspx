<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>TTL Reporting</title>
    <style type="text/css">
        .style2
        {
            width: 100%;
        }
        .style3
        {
            width: 705px;
        }
        .style4
        {
            width: 321px;
            height: 78px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <p>
        <img alt="" class="style4" src="pics/TTL-Website-Header.jpg" /></p>
        <table class="style2">
            <tr>
                <td class="style3">
                    <h3>
        TTL Reporting</h3>
                </td>
                <td>
                    Current Rail Traffic</td>
            </tr>
            <tr>
                <td class="style3" valign="top">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis" 
                        Width="666px">

<Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="weblink" VisibleIndex="2" 
                                Caption="Report" ReadOnly="True">
                                <PropertiesTextEdit EncodeHtml="False">
                                </PropertiesTextEdit>
                                <settings sortmode="DisplayText" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Category" GroupIndex="0" SortIndex="0" 
                                SortOrder="Ascending" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Requested" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Report_Title" VisibleIndex="0" 
                                Visible="False" SortIndex="1" SortOrder="Ascending">
                                <PropertiesTextEdit DisplayFormatString="{0}">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataHyperLinkColumn FieldName="Report_Link" Visible="False" 
                                VisibleIndex="1">
                            </dx:GridViewDataHyperLinkColumn>
                        </Columns>
                        <SettingsPager PageSize="15">
                            <AllButton Visible="True">
                            </AllButton>
                            <PageSizeItemSettings Visible="True">
                            </PageSizeItemSettings>
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />

                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString2 %>" 
                        
                        SelectCommand="SELECT [Report Title], [Report Link], weblink, Description, Category, Requested, Company_ID_ref, Active FROM [web reports with formatted link] WHERE (Company_ID_ref = @Company_ID_ref)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="2" Name="Company_ID_ref" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
                <td valign="top">
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        DataSourceID="SqlDataSource1" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Terminal" HeaderText="Terminal" 
                                SortExpression="Terminal" />
                            <asp:BoundField DataField="Status" HeaderText="Status" 
                                SortExpression="Status" />
                            <asp:BoundField DataField="Commodity" HeaderText="Commodity" 
                                SortExpression="Commodity" />
                            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
                        
                        SelectCommand="SELECT Terminal, Status, Commodity, Count, [Status Flag] FROM [rail status 1-4] ORDER BY Terminal, [Status Flag], Commodity">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
