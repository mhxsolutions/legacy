<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UnplannedLoadsSummary.aspx.vb" Inherits="UnplannedLoadsSummary" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unplanned Loads</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>MHX Unplanned Loads (<a href="index.aspx">home</a>)</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export Excel" Theme="MetropolisBlue">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue">
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Schedule Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load_Priority" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
            <FormatConditions>
                <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'must deliver'" FieldName="Load_Priority">
                </dx:GridViewFormatConditionHighlight>
                <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'high'" FieldName="Load_Priority" Format="YellowFillWithDarkYellowText">
                </dx:GridViewFormatConditionHighlight>
                <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'requested'" FieldName="Load_Priority" Format="LightGreenFill">
                </dx:GridViewFormatConditionHighlight>
            </FormatConditions>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Unplanned Loads Summary] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="MHX Unplanned Load Summary" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
        <p>
          <uc1:SaveLayout runat="server" ID="SaveLayout"  GridViewID="ASPxGridView1"/>  </p>
        <br /><br />
        Loads not on Plan and not marked Arrive/Depart.
        <br /><br />
        <p><b>Detail List</b></p>
        <p>
            <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue">
                <SettingsPager PageSize="20">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings ShowAllItem="True" Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Origin Name" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Destination Name" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Schedule Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangePicker">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="LoadNotes" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="7">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Load_Priority" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <FormatConditions>
                    <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'must deliver'" FieldName="Load_Priority">
                    </dx:GridViewFormatConditionHighlight>
                    <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'high'" FieldName="Load_Priority" Format="YellowFillWithDarkYellowText">
                    </dx:GridViewFormatConditionHighlight>
                    <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Load_Priority] = 'requested'" FieldName="Load_Priority" Format="LightGreenFill">
                    </dx:GridViewFormatConditionHighlight>
                </FormatConditions>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Unplanned Loads] WHERE ([Company ID ref] = @Company_ID_ref)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <br />
        <%--<uc1:SaveLayout runat="server" ID="SaveLayout1"  GridViewID="ASPxGridView2"/>--%>
        <br />
        <br />
    </form>
</body>
</html>
