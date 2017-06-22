<%@ Page Title="Inventory on Date" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Inventory_on_date_lumber.aspx.cs" Inherits="Web.Clients.Assigned.Inventory_on_date_lumber" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory as of Selected Date</h3>
    <table style="width: 100%">
        <tr>
            <td><strong>Select Date</strong></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" Width="257px" DayNameFormat="Shortest" TitleFormat="Month">
            <DayHeaderStyle Font-Bold="True" Font-Size="7pt" BackColor="#CCCCCC" ForeColor="#333333" Height="10pt" />
            <DayStyle Width="14%" />
            <NextPrevStyle Font-Size="8pt" ForeColor="White" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
            <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
            <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
            <TodayDayStyle BackColor="#CCCC99" />
        </asp:Calendar>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product Code" FieldName="Product Group 1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 2" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Length" FieldName="Product Group 3" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Label" VisibleIndex="18" Caption="Type">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Count" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pcs each Unit" FieldName="Count In Package" VisibleIndex="17">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="21">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="22">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total Pcs" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Product Group 5" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Damage" FieldName="Damage Comments" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Unit Count" ShowInColumn="Unit Count" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Total Pcs" ShowInColumn="Total Pcs" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Unit Count" SummaryType="Sum" ShowInGroupFooterColumn="Unit Count" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Total Pcs" ShowInGroupFooterColumn="Total Pcs" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </GroupSummary>
            <FormatConditions>
                <dx:GridViewFormatConditionHighlight ApplyToRow="True" Expression="[Status] = 'Damaged'" FieldName="Product Profile Description" Format="LightRedFill">
                    <CellStyle Font-Bold="True">
                    </CellStyle>
                </dx:GridViewFormatConditionHighlight>
            </FormatConditions>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary with Loc] WHERE (([Receiving Client Ref] = @Receiving_Client_Ref) AND ([Exit Date] &gt; @Exit_Date) AND ([Recd Date] &lt;= @Recd_Date))">
            <SelectParameters>
                <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Lumber Inventory on Date" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
    </dx:ASPxGridViewExporter>
</asp:Content>
