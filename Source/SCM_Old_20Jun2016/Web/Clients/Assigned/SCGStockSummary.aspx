<%@ Page Title="Stock Summary" Language="C#" MasterPageFile="~/SCM.master" AutoEventWireup="true" CodeBehind="SCGStockSummary.aspx.cs" Inherits="Web.Clients.Assigned.SCGStockSummary" %>
<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Stock Summary on Select Date</h3>
    <p>
        Select Inventory Date</p>
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
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="Inv_on_a_date" Theme="Metropolis">
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
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" />
            <SettingsBehavior AutoExpandAllGroups="True" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Product Profile Description" VisibleIndex="3" Caption="Profile">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 1" VisibleIndex="6" Caption="PSEP">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 4" VisibleIndex="12" Caption="Description">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 5" VisibleIndex="14" Caption="New Description">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt" VisibleIndex="17" Caption="Pounds">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Label" VisibleIndex="21" Caption="UOM">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Count" VisibleIndex="22">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count In Package" VisibleIndex="23" Caption="Ct in Pkg">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total Pcs" VisibleIndex="24">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="4" Caption="Terminal">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="26">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="29">
                </dx:GridViewDataDateColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Wt" ShowInColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="LnFt" ShowInColumn="Ln Ft" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="LnFt" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Wt" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Row Wrap="False">
                </Row>
            </Styles>
        </dx:ASPxGridView>
        <br />
        <asp:SqlDataSource ID="Inv_on_a_date" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Inventory All received and shipped summary auth viewer] WHERE (([Receiving Client Ref] = @Receiving_Client_Ref) AND ([Exit Date] &gt; @Exit_Date) AND ([Recd Date] &lt;= @Recd_Date))">
            <SelectParameters>
                <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_ClientID" Type="Int32" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Content>
