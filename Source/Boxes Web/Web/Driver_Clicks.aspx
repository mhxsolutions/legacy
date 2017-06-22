<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Driver_Clicks.aspx.vb" Inherits="Driver_Clicks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Clicks</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Driver Phone Detail - <a href="Default.aspx">(home)</a></h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan_Date" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Transit" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Sch_Arrive" VisibleIndex="10">
                    <PropertiesDateEdit DisplayFormatString="t">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>
                <dx:GridViewBandColumn Caption="Phone Times" VisibleIndex="8">
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="End" FieldName="CMP_Time" VisibleIndex="2">
                            <PropertiesDateEdit DisplayFormatString="t">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="Arrive" FieldName="ARV_Time" VisibleIndex="1">
                            <PropertiesDateEdit DisplayFormatString="t">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn Caption="Start" FieldName="STA_Time" VisibleIndex="0">
                            <PropertiesDateEdit DisplayFormatString="t">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                    </Columns>
                </dx:GridViewBandColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [STA Time] AS STA_Time, [ARV Time] AS ARV_Time, [CMP Time] AS CMP_Time, [Driver], [Origin], [Destination], [Transit], [Dwell], [Order], [Sch Arrive] AS Sch_Arrive, [link] FROM [Agilis Work order Progression INFO] WHERE ([link] = @link)">
            <SelectParameters>
                <asp:QueryStringParameter Name="link" QueryStringField="link" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Data from drivers&#39; phones. Unedited click times.</p>
</body>
</html>
