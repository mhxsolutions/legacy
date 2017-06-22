<%@ Page Title="Inventory on Date" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" CodeBehind="Shipping_Inventory_on_Date.aspx.cs" Inherits="Web_App.Customers.steelscape.Shipping_Inventory_on_Date" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Rail Shipping Inventory on Select Date</h3>
    <p>
        <strong>Select Date</strong></p>
    <p>
        <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="153px" NextPrevFormat="FullMonth" Width="312px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>
    </p>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Material#" FieldName="Product Group 1" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Delivery#" FieldName="Product Group 2" SortIndex="3" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Order#" FieldName="Product Group 3" SortIndex="4" SortOrder="Ascending" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Customer" FieldName="Product Group 4" SortIndex="5" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Weight" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" ReadOnly="True" VisibleIndex="19">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Schedule Release Date" Visible="False" VisibleIndex="26">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Abbreviation" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Exit Date" ReadOnly="True" Visible="False" VisibleIndex="34">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Ship Date" ReadOnly="True" VisibleIndex="36">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="37">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Weight" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem FieldName="Age" SummaryType="Average" ValueDisplayFormat="n1" />
                <dx:ASPxSummaryItem FieldName="Age" SummaryType="Max" />
            </TotalSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Weight, [Package Label], [Count In Package], [Date Received], [Mfg Control Date], [BOL Date], LogOutDate, [Inventory Detail Ref], Disatched, LogOut, [Schedule Release Date], [Car Number], [Receiver Ref], Location, [Linear Ft], Terminal, [Company ID ref], Weight2, Abbreviation, [Exit Date], [Record Lock], [Ship Date], [Dest Client], [Dest City], [POD Date], [Load ID], [Receiver ID], [Product Profile Ref], [Product Type], Age FROM [Inventory All received and shipped] WHERE ([Company ID ref] = @Company_ID_ref) AND ([Exit Date] &gt; @Exit_Date) AND ([Receiving Client Ref] = @Receiving_Client_Ref) AND ([Date Received] &lt;= @Date_Received) AND ([Product Group 4] LIKE N'%rail%')">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_ClientID" Type="Int32" />
                <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
                <asp:Parameter DefaultValue="rail" Name="Product_Group_4" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory on Date" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    <br />
</asp:Content>
