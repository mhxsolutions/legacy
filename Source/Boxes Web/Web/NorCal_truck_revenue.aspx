<%@ Page Language="VB" AutoEventWireup="false" CodeFile="NorCal_truck_revenue.aspx.vb" Inherits="NorCal_truck_revenue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NorCal Truck Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Public/Private Revenue by Driver and Date 
            - Stockton</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Theme="Aqua" Width="127px">
        </dx:ASPxButton>
        <br />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn FieldName="Driver" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Truck Default" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Total Hours" ReadOnly="True" 
                    VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Drive Time" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Est Transit" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Non Drive" VisibleIndex="8">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Est Dwell" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Private Revenue" VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Public Revenue" VisibleIndex="12">
                    <PropertiesTextEdit DisplayFormatString="c">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="50">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
            SelectCommand="SELECT * FROM [Driver Hours and Revenue by date fleet public private plan actual] WHERE (([Fleet] = @Fleet) AND ([Subhauler] = @Subhauler))">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
                <asp:Parameter DefaultValue="false" Name="Subhauler" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="NorCal Truck Revenue" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        Notes:</p>
    <ol>
        <li>Drivers and loads must be on Planner</li>
        <li>Drive/Non Drive Times require phone data. No corrections calculated</li>
        <li>Revenues calculated from RFS billing not invoicing</li>
        <li>Drive/Non Drive, Transit &amp; Dwell in minutes</li>
        <li>No Subs</li>
    </ol>
    </body>
</html>
