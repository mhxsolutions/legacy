<%@ Page Title="Inventory Detail" Language="C#" MasterPageFile="~/SCM.master" AutoEventWireup="true" CodeBehind="InventoryDetail.aspx.cs" Inherits="Web.Clients.All.InventoryDetail" %>
<%@ Register assembly="DevExpress.Web.v15.2, Version=15.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Stock Detail on Select Date</h3>
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
    <p>
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
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior AutoExpandAllGroups="True" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Product Profile Description" VisibleIndex="5" Caption="Profile" SortIndex="1" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Label 1" VisibleIndex="7" Caption="Label 1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 1" VisibleIndex="8" Caption="Value 1" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Label 2" VisibleIndex="9" Caption="Label 2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 2" VisibleIndex="10" Caption="Value 2" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Label 3" VisibleIndex="11" Caption="Label 3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 3" VisibleIndex="12" Caption="Value 3" SortIndex="4" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Label 4" VisibleIndex="13" Caption="Label 4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 4" VisibleIndex="14" Caption="Value 4" SortIndex="5" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Group Label 5" VisibleIndex="15" Caption="Label 5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 5" VisibleIndex="16" Caption="Value 5" SortIndex="6" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="17">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight Label" VisibleIndex="18" Caption="Wt UOM">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Package Label" VisibleIndex="20" Caption="UOM">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count In Package" VisibleIndex="21" Caption="Ct in Pkg">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" ReadOnly="True" VisibleIndex="25">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="33">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="Disatched" VisibleIndex="31">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="32">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataDateColumn FieldName="Schedule Release Date" VisibleIndex="29">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Car Number" VisibleIndex="36">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="38">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="22" Caption="LNFT">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Company ID ref" VisibleIndex="40" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Abbreviation" VisibleIndex="1" Caption="Terminal" SortIndex="0" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest Client" VisibleIndex="45">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Dest City" VisibleIndex="46">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="35">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load ID" VisibleIndex="30" Caption="BOL">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver ID" VisibleIndex="28" Caption="Receiver">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="6" Caption="Product">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Age" ReadOnly="True" VisibleIndex="48">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="23">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Damage Comments" VisibleIndex="24">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Row Wrap="False">
                </Row>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="Inv_on_a_date" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Weight, [Package Label], [Count In Package], [Date Received], [Mfg Control Date], [BOL Date], LogOutDate, [Inventory Detail Ref], Disatched, LogOut, [Schedule Release Date], [Car Number], [Receiver Ref], Location, [Linear Ft], Terminal, [Company ID ref], Weight2, Abbreviation, [Exit Date], [Record Lock], [Ship Date], [Dest Client], [Dest City], [POD Date], [Load ID], [Receiver ID], [Product Profile Ref], [Product Type], Age, Status, [Damage Comments] FROM [Inventory All received and shipped] WHERE ([Date Received] &lt;= @Date_Received) AND ([Exit Date] &gt; @Exit_Date) AND ([Receiving Client Ref] = @Client)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
                <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
                <asp:SessionParameter DefaultValue="" Name="CLIENT" SessionField="CONTEXT_ClientID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
