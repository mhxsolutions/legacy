<%@ Page Title="Driver Audit" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="DriverAudit.aspx.cs" Inherits="Web.Clients.Assigned.DriverAudit" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Driver Phone Audit</h3>
    <p>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" Visible="False" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Order" SortIndex="2" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Sch Start" ReadOnly="True" VisibleIndex="9">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Sch Arrive" VisibleIndex="10">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Sch Depart" VisibleIndex="11">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Depart Origin" VisibleIndex="12">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Arrive Destination" VisibleIndex="13">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Depart Destination" VisibleIndex="14">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Start Time" VisibleIndex="4">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Payroll Start" VisibleIndex="5">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Driver Plan Scheduled and Actual Times] WHERE (([Plan Date] = @Plan_Date) AND ([Origin ref] = @Origin_ref))">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:SessionParameter Name="Origin_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <br />
    Select Date to show plan detail.<br />
    Will show all fleets with Origin matching the login user or impersonated client.
</asp:Content>
