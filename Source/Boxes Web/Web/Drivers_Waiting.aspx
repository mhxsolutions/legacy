<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Drivers_Waiting.aspx.vb" Inherits="Drivers_Waiting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drivers Waiting</title>
    <style type="text/css">
        .auto-style1 {
            width: 529px;
            font-weight: bold;
            text-align: left;
            vertical-align: top;
        }
        .auto-style2 {
            text-align: left;
            vertical-align: top;
        }
        .auto-style3 {
            width: 529px;
            text-align: left;
            vertical-align: top;
        }
        .auto-style4 {
            font-weight: bold;
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Drivers Waiting</h3>
        <br />
        <table class="dx-justification">
            <tr>
                <td class="auto-style1">Drivers Waiting</td>
                <td class="auto-style4">Average Dwell</td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Moderno">
                        <SettingsPager PageSize="100" Visible="False">
                        </SettingsPager>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT [Driver], [Location], [Fleet], [Dwell] FROM [MobileApp_WaitTimes] WHERE ([Company ID ref] = @Company_ID_ref)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="auto-style2">
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Mulberry">
                        <SettingsPager PageSize="100" Visible="False">
                        </SettingsPager>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Location_City" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="AvgDwell" SortIndex="0" SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT [Location], [Location City] AS Location_City, [AvgDwell] FROM [MobileApp AvgDwell] WHERE ([Company ID ref] = @Company_ID_ref)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
    
    </div>
    </form>
</body>
</html>
