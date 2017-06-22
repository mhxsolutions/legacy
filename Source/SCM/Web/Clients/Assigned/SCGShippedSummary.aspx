<%@ Page Title="Shipped Summary" Language="C#" MasterPageFile="~/SCM.master" AutoEventWireup="true" CodeBehind="SCGShippedSummary.aspx.cs" Inherits="Web.Clients.Assigned.SCGShippedSummary" %>
<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.10.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Consigned PSEP Stock Shipped by Date</h3>
    <table class="dx-justification">
        <tr>
            <td>Start Date</td>
            <td>End Date</td>
        </tr>
        <tr>
            <td>
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
            <td>
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="400px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
        </tr>
    </table>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="SCG Stock Code" FieldName="Product Group 1" SortIndex="2" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="3" SortOrder="Ascending" VisibleIndex="13" AllowTextTruncationInAdaptiveMode="True">
                    <CellStyle Wrap="True">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="New Description" FieldName="Product Group 5" VisibleIndex="15" AllowTextTruncationInAdaptiveMode="True">
                    <CellStyle Wrap="True">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="22">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Count" FieldName="Unit Count" VisibleIndex="21">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="23">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="25">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="28">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Dest Client" VisibleIndex="29">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest City" VisibleIndex="30">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="BOL_Client_PO" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Unit Count" ShowInColumn="Unit Count" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Unit Count" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="LnFt={0:n1}" FieldName="LnFt" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Row Wrap="False">
                </Row>
            </Styles>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Shipping by Date" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary with dest and PO] WHERE (([Auth_Viewer] = @Auth_Viewer) AND ([Ship Date] &gt;= @Ship_Date) AND ([Ship Date] &lt;= @Ship_Date2))">
            <SelectParameters>
                <asp:SessionParameter Name="Auth_Viewer" SessionField="context_clientID" Type="Int32" />
                <asp:ControlParameter ControlID="Calendar1" Name="Ship_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Ship_Date2" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
