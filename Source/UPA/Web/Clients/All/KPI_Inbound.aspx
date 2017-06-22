<%@ Page Title="KPI Inbound" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="KPI_Inbound.aspx.cs" Inherits="Web.Clients.All.KPI_Inbound" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>KPI Inbound/Outbound</h3>
    <table class="dx-justification">
        <tr>
            <td style="width: 345px"><b>Start Date</b></td>
            <td style="width: 312px"><b>End Date</b></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 345px">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
            <td style="width: 312px">
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 345px; height: 23px"></td>
            <td style="height: 23px; width: 312px;"></td>
            <td style="height: 23px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 345px">Inbound - Advance Shipping Notices</td>
            <td style="width: 312px">Inbound - ASN&#39;s Arrived</td>
            <td>Inbound - Trucks Expedited</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="Date" FieldName="Date_Scheduled" SortIndex="1" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Count" FieldName="Trucks_Scheduled" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Destination" FieldName="Client_Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks Scheduled= {0:n0}" FieldName="Trucks_Scheduled" ShowInColumn="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Trucks_Scheduled" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Scheduled] AS Date_Scheduled, [Trucks Scheduled] AS Trucks_Scheduled, [Client Name] AS Client_Name FROM [UPA Number of Trucks Scheduled Inbound] WHERE (([Date Scheduled] &gt;= @Date_Scheduled) AND ([Date Scheduled] &lt;= @Date_Scheduled2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Scheduled" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Scheduled2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="actualArrive" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="Date" FieldName="Date_Arrived" SortIndex="1" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Trucks" FieldName="Trucks_Arrived" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client_Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Receiver Ct" VisibleIndex="3" Caption="Receivers">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks Arrived= {0:n0}" FieldName="Trucks_Arrived" ShowInColumn="Trucks" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Receivers= {0:n0}" FieldName="Receiver Ct" ShowInColumn="Receivers" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Trucks_Arrived" SummaryType="Sum" DisplayFormat="Trucks={0:n0}" />
                        <dx:ASPxSummaryItem FieldName="Receiver Ct" SummaryType="Sum" DisplayFormat="Recv={0:n0}" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="actualArrive" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Arrived] AS Date_Arrived, [Trucks Arrived] AS Trucks_Arrived, [Client Name] AS Client_Name, [Receiver Ct] FROM [UPA number of trucks arrived inbound] WHERE ([Date Arrived] &gt;= @Date_Arrived) AND ([Date Arrived] &lt;= @Date_Arrived2)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Arrived" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Arrived2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top;">
                <dx:ASPxGridView ID="ASPxGridView7" runat="server" AutoGenerateColumns="False" DataSourceID="expidited" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Date Arrived" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Trucks Arrived" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0" Caption="Client">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Receiver Ct" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks Expedited= {0:n0}" FieldName="Trucks Arrived" ShowInColumn="Trucks Arrived" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Receivers= {0:n0}" FieldName="Receiver Ct" ShowInColumn="Receiver Ct" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks= {0:n0}" FieldName="Trucks Arrived" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Receivers= {0:n0}" FieldName="Receiver Ct" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="expidited" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA Number of trucks not scheduled] WHERE (([Date Arrived] &gt;= @Date_Arrived) AND ([Date Arrived] &lt;= @Date_Arrived2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Arrived" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Arrived2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">&nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">&nbsp;</td>
            <td style="text-align: left; vertical-align: top;">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">Inbound - Expected Pieces</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">Inbound - Pieces Received</td>
            <td style="text-align: left; vertical-align: top;">Received ASN&#39;s Initially Missing Docs</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView5" runat="server" AutoGenerateColumns="False" DataSourceID="expected" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Pick_Up_Date" VisibleIndex="0" Caption="Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Client_Name" VisibleIndex="1" Caption="Client" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Expected_Material" VisibleIndex="2" Caption="Brief Desc" SortIndex="2" SortOrder="Ascending">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tot_Expected_Ct" VisibleIndex="3" Caption="Expected Count">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Expected Count= {0:n0}" FieldName="Tot_Expected_Ct" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Tot_Expected_Ct" SummaryType="Sum" ValueDisplayFormat="n0" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="expected" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Pick Up Date] AS Pick_Up_Date, [Client Name] AS Client_Name, [Expected Material] AS Expected_Material, [Tot_Expected_Ct], [Tot_Expected_LNFT] FROM [Inbound Scheduled Sum of Expected] WHERE (([Pick Up Date] &gt;= @Pick_Up_Date) AND ([Pick Up Date] &lt;= @Pick_Up_Date2) AND ([Company ID ref] = @Company_ID_ref))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Pick_Up_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Pick_Up_Date2" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="palletized" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="Date" FieldName="Date_Received" GroupIndex="1" SortIndex="1" SortOrder="Descending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="1" Caption="Palletized Items">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product_Group_4" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client_Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Palletized Count Received= {0:n0}" FieldName="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" DisplayFormat="Count={0:n0}" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="palletized" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Received] AS Date_Received, [Count], [Product Group 4] AS Product_Group_4, [Client Name] AS Client_Name FROM [StockCount Palletized] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top;">
                <dx:ASPxGridView ID="ASPxGridView16" runat="server" AutoGenerateColumns="False" DataSourceID="doc_issue_ct" EnableTheming="True" Theme="Metropolis">
                    <SettingsPager Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Date Arrived" GroupIndex="1" SortIndex="1" SortOrder="Descending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Documents Missing" FieldName="Count" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Descending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Docs Missing={0:n0}" FieldName="Count" ShowInGroupFooterColumn="Doc Ct" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="doc_issue_ct" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA number of trucks with missing documents] WHERE (([Date Arrived] &gt;= @Date_Arrived) AND ([Date Arrived] &lt;= @Date_Arrived2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Arrived" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Arrived2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">&nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">&nbsp;</td>
            <td style="text-align: left; vertical-align: top;">&nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">Inbound - Expected LNFT </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">Inbound&nbsp; - LNFT Received</td>
            <td style="text-align: left; vertical-align: top;">QA/QC Inspection</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView6" runat="server" AutoGenerateColumns="False" DataSourceID="expected" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Pick_Up_Date" VisibleIndex="0" Caption="Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Client_Name" VisibleIndex="1" Caption="Client" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Expected_Material" VisibleIndex="2" Caption="Brief Desc" SortIndex="2" SortOrder="Ascending">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tot_Expected_LNFT" VisibleIndex="3" Caption="Expected LNFT">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Expected LNFT= {0:n0}" FieldName="Tot_Expected_LNFT" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Tot_Expected_LNFT" SummaryType="Sum" ValueDisplayFormat="n0" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView4" runat="server" AutoGenerateColumns="False" DataSourceID="LNFT_in" EnableTheming="True" Theme="Metropolis" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="Date" FieldName="Date_Received" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product_Group_4" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client_Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Total LNFT Received= {0:n0}" FieldName="LNFT" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="LNFT" SummaryType="Sum" DisplayFormat="LNFT={0:n1}" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="LNFT_in" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Received] AS Date_Received, [LNFT], [Product Group 4] AS Product_Group_4, [Client Name] AS Client_Name FROM [StockCount Pipe LNFT] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>
            <td style="text-align: left; vertical-align: top;">
                <dx:ASPxGridView ID="ASPxGridView17" runat="server" AutoGenerateColumns="False" DataSourceID="QAQC_KPI_header" EnableTheming="True" Theme="Metropolis">
                    <SettingsPager Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn Caption="Date Inspected" FieldName="Date_Inspected" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Report#" FieldName="QAQC_Report_Number" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Days to Inspect" FieldName="Time to Inspect" ReadOnly="True" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Days to Report" FieldName="Time to Report" ReadOnly="True" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Days to Close" FieldName="Time to Close" ReadOnly="True" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Labor Hours" FieldName="Labor_Hours" VisibleIndex="6">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Parts Inspected" FieldName="Count_of_Parts_Inspected" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Hours={0:n1}" FieldName="Labor_Hours" ShowInColumn="Labor Hours" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Close={0:n0}" FieldName="Time to Close" ShowInColumn="Days to Close" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Inspect={0:n0}" FieldName="Time to Inspect" ShowInColumn="Days to Inspect" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Report={0:n0}" FieldName="Time to Report" ShowInColumn="Days to Report" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Ct Inspected" FieldName="Date_Inspected" ShowInColumn="Date Inspected" SummaryType="Count" />
                        <dx:ASPxSummaryItem DisplayFormat="Ct Closed" FieldName="Time to Close" ShowInColumn="Days to Close" ShowInGroupFooterColumn="Days to Close" />
                        <dx:ASPxSummaryItem DisplayFormat="Ct of Parts={0:n0}" FieldName="Count_of_Parts_Inspected" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Inspect={0:n0}" FieldName="Time to Inspect" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Report={0:n0}" FieldName="Time to Report" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Close={0:n0}" FieldName="Time to Close" SummaryType="Sum" />
                        <dx:ASPxSummaryItem DisplayFormat="Hr={0:n1}" FieldName="Labor_Hours" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="QAQC_KPI_header" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA_QAQC_TimeToAct] WHERE (([Date_Inspected] &gt;= @Date_Inspected) AND ([Date_Inspected] &lt;= @Date_Inspected2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" DbType="Date" Name="Date_Inspected" PropertyName="SelectedDate" />
                        <asp:ControlParameter ControlID="Calendar2" DbType="Date" Name="Date_Inspected2" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                Outbound - Trucks Scheduled</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                Outbound -
                Trucks Departed</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView8" runat="server" AutoGenerateColumns="False" DataSourceID="TrucksSchOut" EnableTheming="True" Theme="MetropolisBlue" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Schedule Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Load Type" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks Sch Out= {0:n0}" FieldName="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="TrucksSchOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [KPI Outbound Sch Loads] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Schedule Date] &gt;= @Schedule_Date) AND ([Schedule Date] &lt;= @Schedule_Date2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Schedule_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Schedule_Date2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView9" runat="server" AutoGenerateColumns="False" DataSourceID="TrucksOut" EnableTheming="True" Theme="MetropolisBlue" Width="250px">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Log Out Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Load Type" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Trucks Out= {0:n0}" FieldName="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="TrucksOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [KPI Outbound Load Log Out] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Log Out Date] &gt;= @Log_Out_Date) AND ([Log Out Date] &lt;= @Log_Out_Date2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Log_Out_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Log_Out_Date2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                Outbound - Palletized Count Scheduled</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                Outbound - Palletized Count Shipped</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView12" runat="server" AutoGenerateColumns="False" DataSourceID="PalletSchOut" EnableTheming="True" Theme="MetropolisBlue">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Sch Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Palletized Scheduled Out= {0:n0}" FieldName="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="PalletSchOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [StockCount Palletized Sch] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Sch Date] &gt;= @Sch_Date) AND ([Sch Date] &lt;= @Sch_Date2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Sch_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Sch_Date2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView10" runat="server" AutoGenerateColumns="False" DataSourceID="PalletOut" EnableTheming="True" Theme="MetropolisBlue">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="LogOutDate" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Palletized Count Shipped= {0:n0}" FieldName="Count" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="PalletOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [StockCount Palletized Shipped] WHERE (([Company ID ref] = @Company_ID_ref) AND ([LogOutDate] &gt;= @LogOutDate) AND ([LogOutDate] &lt;= @LogOutDate2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="LogOutDate" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="LogOutDate2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                Outbound - LNFT Scheduled</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                Outbound -
                LNFT Shipped</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView13" runat="server" AutoGenerateColumns="False" DataSourceID="PipeSchOut" EnableTheming="True" Theme="MetropolisBlue">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Sch Date" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="LNFT Scheduled Out= {0:n0}" FieldName="LNFT" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="LNFT" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="PipeSchOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [StockCount Pipe Sch] WHERE (([Company ID ref] = @Company_ID_ref) AND ([Sch Date] &gt;= @Sch_Date) AND ([Sch Date] &lt;= @Sch_Date2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Sch_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Sch_Date2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                <dx:ASPxGridView ID="ASPxGridView11" runat="server" AutoGenerateColumns="False" DataSourceID="PipeOut" EnableTheming="True" Theme="MetropolisBlue">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="LogOutDate" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="LNFT Shipped= {0:n0}" FieldName="LNFT" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="LNFT" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="PipeOut" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [StockCount Pipe Shipped] WHERE (([Company ID ref] = @Company_ID_ref) AND ([LogOutDate] &gt;= @LogOutDate) AND ([LogOutDate] &lt;= @LogOutDate2))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7" Name="Company_ID_ref" Type="Int32" />
                        <asp:ControlParameter ControlID="Calendar1" Name="LogOutDate" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="LogOutDate2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                Returns</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView14" runat="server" AutoGenerateColumns="False" DataSourceID="Returns" Theme="Metropolis">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewDataDateColumn FieldName="Sch Date" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Returned SCMS BOL" FieldName="SCMS_BOL_ref" SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Count" FieldName="Sch Return Count" Visible="False" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Returns={0:n0}" FieldName="SCMS_BOL_ref" SummaryType="Count" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Sch Return Count" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="Returns" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA Scheduled Returns] WHERE (([Sch Date] &gt;= @Sch_Date) AND ([Sch Date] &lt;= @Sch_Date2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Sch_Date" PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Sch_Date2" PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                Resource Utilization</td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: top; width: 345px;">
                <dx:ASPxGridView ID="ASPxGridView15" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
                    <SettingsPager PageSize="100" Visible="False">
                    </SettingsPager>
                    <Settings ShowFooter="True" />
                    <Columns>
                        <dx:GridViewCommandColumn VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="Category" FieldName="Man_Hrs_Category" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataCheckColumn FieldName="OT" Visible="False" VisibleIndex="2">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataCheckColumn FieldName="PTO" Visible="False" VisibleIndex="3">
                        </dx:GridViewDataCheckColumn>
                        <dx:GridViewDataDateColumn Caption="Date" FieldName="Man_Hrs_Date" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Hours" FieldName="Man_Hrs" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <TotalSummary>
                        <dx:ASPxSummaryItem DisplayFormat="Hours={0:n1}" FieldName="Man_Hrs" SummaryType="Sum" />
                    </TotalSummary>
                    <GroupSummary>
                        <dx:ASPxSummaryItem FieldName="Man_Hrs" SummaryType="Sum" />
                    </GroupSummary>
                    <Styles>
                        <Footer Font-Bold="True">
                        </Footer>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPA Labor Hours Detail] WHERE (([Man_Hrs_Date] &gt;= @Man_Hrs_Date) AND ([Man_Hrs_Date] &lt;= @Man_Hrs_Date2))">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" DbType="Date" Name="Man_Hrs_Date" PropertyName="SelectedDate" />
                        <asp:ControlParameter ControlID="Calendar2" DbType="Date" Name="Man_Hrs_Date2" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="text-align: left; vertical-align: top; width: 312px;">
                &nbsp;</td>
            <td style="text-align: left; vertical-align: top;">
                &nbsp;</td>
        </tr>
    </table>
    <p>
        &nbsp;</p>
</asp:Content>
