<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_OutboundShippingMap"
    Title="BudwayDirect | Outbound Shipping Map" CodeBehind="OutboundShippingMap.aspx.cs" CodeFile="OutboundShippingMap.aspx.cs"%>

<%@ MasterType VirtualPath="~/CustomerService.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Outbound Shipping Map</h2>
    <table>
        <tr>
            <td>
                <div id='map' style="border: 1px solid rgb(0, 0, 0); position: relative; left: 0; top: 0; width: 800px; height: 500px; z-index: 102;" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="MapObjectsGridview" runat="server" AutoGenerateColumns="False"
                    CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="MapObjectsGridview_RowDataBound"
                    AllowPaging="True" AllowSorting="True" PageSize="5" OnPageIndexChanging="MapObjectsGridview_PageIndexChanging"
                    OnSorting="MapObjectsGridview_Sorting" Width="800px">
                    <EmptyDataTemplate>
                        <asp:Label ID="EmptyMapLabel" runat="Server">No outbound shipping found to display on map.</asp:Label>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:HyperLinkField DataNavigateUrlFields="Load Ref" DataNavigateUrlFormatString="~/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}"
                            HeaderText="Load" DataTextField="Load Ref" SortExpression="Load Ref">
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="Shipper Name" HeaderText="Shipper" SortExpression="Shipper Name">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Destination Name" HeaderText="Destination" SortExpression="Destination Name">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="CenterMapLinkbutton" runat="Server" Text="Show" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
