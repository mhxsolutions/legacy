<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index.aspx.vb" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MHX Home</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 297px;
        }
        .auto-style3 {
            width: 234px;
        }
        .auto-style5 {
            width: 351px;
        }
        .auto-style6 {
            width: 170px;
        }
        .auto-style7 {
            width: 136px;
        }
        .auto-style8 {
            color: #FF0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table class="auto-style1">
            <tr>
                <td class="auto-style5">
            <asp:Image ID="Image1" runat="server" Height="198px" ImageUrl="~/Images/mhx-white.png" Width="290px" />
                </td>
                <td class="auto-style6">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
                        <SettingsPager Visible="False">
                        </SettingsPager>
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="Contractor POD's Missing" FieldName="Count" VisibleIndex="0">
                                <CellStyle Font-Size="Large" HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Count] FROM [Missing POD count] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Subhauler] = @Subhauler))">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                            <asp:Parameter DefaultValue="true" Name="Subhauler" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="auto-style7">
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" datasourceid="SqlDataSource2" EnableTheming="True" Theme="MetropolisBlue">
                        <SettingsPager Visible="False">
                        </SettingsPager>
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="Driver POD's Missing" FieldName="Count" VisibleIndex="0">
                                <CellStyle Font-Size="Large" HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Count] FROM [Missing POD count] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Subhauler] = @Subhauler))">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                            <asp:Parameter DefaultValue="false" Name="Subhauler" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="MetropolisBlue">
                        <SettingsPager Visible="False">
                        </SettingsPager>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="Open Billing" VisibleIndex="0">
                                <PropertiesTextEdit DisplayFormatString="c0">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <Styles>
                            <Cell Font-Size="Large" HorizontalAlign="Center">
                            </Cell>
                        </Styles>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Open Billing] FROM [Billing not Exported Total] WHERE ([Company ID ref] = @Company_ID_ref)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">&nbsp;</td>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    <h3>
        MHX
        Reports </h3>
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <h3>Transportation/Harbor</h3>
                </td>
                <td>
                    <h3>Warehouse</h3>
                </td>
                <td class="auto-style2">
                    <h3>CEC</h3>
                </td>
                <td>
                    <h3>Audits</h3>
                </td>
                <td>
                    <h3>Accounting/HR</h3>
                </td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="NorCal_COT-END_CP.aspx">Driver Clock In/Out</a></td>
                <td><a href="mhxcontainers.aspx">Containers Inbound</a></td>
                <td class="auto-style2"><a href="bolswithoutdetail.aspx">BOLs without Detail</a></td>
                <td><a href="auditbilling.aspx">Billing without Invoice</a></td>
                <td><a href="loadbillingdetail.aspx">Billing Detail - Loads</a></td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="norcal_mobilereview.aspx">Dispatch Review</a></td>
                <td><a href="containersinyard.aspx">Containers In Yard</a></td>
                <td class="auto-style2"><a href="delivery%20history%20summary.aspx">Delivery History Summary</a> - counts by OD</td>
                <td><a href="loadnobilling.aspx">Loads without Billing</a> </td>
                <td><a href="receiverbillingdetail.aspx">Billing Detail - Receivers</a> - <span class="auto-style8">updated</span></td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="Driverhours.aspx">Driver Hours</a></td>
                <td><a href="empirecontainers.aspx">Empire Containers</a></td>
                <td class="auto-style2"><a href="harborlogout.aspx">Harbor LogOut Summary</a></td>
                <td><a href="rfsloadaudit.aspx">Loads without RFS Summary</a></td>
                <td><a href="billingstatus.aspx">Billing Status</a></td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="harborloadstatus.aspx">Harbor Load Status</a> - <span class="auto-style8">new</span></td>
                <td><a href="billingforwarehouse.aspx">Warehouse Billing Summary</a></td>
                <td class="auto-style2"><a href="loadsneedingreceivers.aspx">Loads that need Receivers</a></td>
                <td><a href="p2p.aspx">Performance to Plan</a></td>
                <td><a href="mhxdriverhours.aspx">Driver Hours for UltiPro</a></td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="https://mhxone.sharepoint.com/Shared%20Documents/Harbor%20Schedule.xlsx?d=wd5a8d80a58f7409695393b99e4fc14ca">Harbor Plan</a></td>
                <td>&nbsp;</td>
                <td class="auto-style2"><a href="receivandship.aspx">Receceivers with matched BOLs</a></td>
                <td><a href="auditplannedloads.aspx">Planned Loads no LogOut/POD</a> - <span class="auto-style8">new</span></td>
                <td><a href="Loads%20And%20Drivers.aspx">Loads and Drivers</a></td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="porjecttotals.aspx">Harbor Projects</a></td>
                <td><a href="client_container.aspx">Client Container Demo</a></td>
                <td class="auto-style2"><a href="cec%20reports.aspx">Status on Invoicing</a></td>
                <td><a href="PODaudit.aspx">POD Status</a></td>
                <td><a href="revenuesummarybyitem.aspx">Revenue by Invoice Item Date</a> - AR accruals</td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="projectpurs.aspx">PUR to Project lookup</a> </td>
                <td>&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="plan_dest.aspx">Today&#39;s Plan</a></td>
                <td>&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3"><a href="unplannedloadssummary.aspx">Unplanned Loads</a></td>
                <td>&nbsp;</td>
                <td class="auto-style2">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <p>
            &nbsp;</p>
    
    </div>
    </form>
    <p>
        <a href="default.aspx">Budway Reports</a></p>
</body>
</html>
