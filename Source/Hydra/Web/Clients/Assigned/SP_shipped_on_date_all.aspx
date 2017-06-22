<%@ Page Title="SP Shipped" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="SP_shipped_on_date_all.aspx.cs" Inherits="Web.Clients.Assigned.SP_shipped_on_date_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>SP Formatted Shipping</h3>
    <table class="dxic-fileManager">
        <tr>
            <td style="width: 268px"><b>Start Date</b></td>
            <td><b>End Date</b></td>
        </tr>
        <tr>
            <td style="width: 268px">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="257px">
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
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" Height="165px" NextPrevFormat="FullMonth" TitleFormat="Month" Width="257px">
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
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="BOL" Theme="Office2003Olive">
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="BOL" ReadOnly="True" VisibleIndex="3" SortIndex="4" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load Type" SortIndex="5" SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" SortIndex="6" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper Number" SortIndex="7" SortOrder="Ascending" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" SortIndex="3" SortOrder="Ascending" VisibleIndex="2" Caption="Ship Date">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Vendor/Supplier" SortIndex="8" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Release#" SortIndex="9" SortOrder="Ascending" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Comment" FieldName="Withdrawl Comment" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="#Bales" VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt Lb" VisibleIndex="15">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Carrier" FieldName="Equipment Reference" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Container#" FieldName="Container Number" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Seal#" FieldName="Seal Numbers" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Booking Number" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="18">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="19" Caption="Product">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" ValueDisplayFormat="{0:n1}" />
                <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="#Bales" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" ValueDisplayFormat="{0:n1}" />
                <dx:ASPxSummaryItem FieldName="Wt Lb" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </GroupSummary>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Shipped on Date" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT Client, Profile, BOL, [Load Type], [Car Number], [Shipper Number], [Shipment Date], [Vendor/Supplier], Release#, [Withdrawl Comment], [#Bales], [Wt Lb], Tons, [Ship Rec Lock], Mo, [Terminal Abr], [Equipment Reference], [Container Number], [Seal Numbers], [Booking Number], R_Cleint_Ref, [Company ID ref], [Product Type] FROM [Hydra Shipping History for scrap paper] WHERE ([Shipment Date] &gt;= @Shipment_Date) AND ([Shipment Date] &lt;= @Shipment_Date2) AND ([Company ID ref] = @curr_co)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Shipment_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar2" Name="Shipment_Date2" PropertyName="SelectedDate" Type="DateTime" />
                <asp:Parameter DefaultValue="3" Name="curr_co" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1"  />
</asp:Content>
