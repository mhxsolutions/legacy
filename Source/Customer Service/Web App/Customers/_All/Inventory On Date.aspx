<%@ Page Title="Inventory On Date" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    CodeBehind="Inventory On Date.aspx.cs" CodeFile="Inventory On Date.aspx.cs" Inherits="Web_App.Customers._All.Inventory_On_Date" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory on Selected Date</h3>
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
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
    </dx:ASPxButton>
</p>
<p>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
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
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" SortIndex="1" SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 1" FieldName="Group Label 1" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product 1" FieldName="Product Group 1" SortIndex="2" SortOrder="Ascending" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 2" FieldName="Group Label 2" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product 2" FieldName="Product Group 2" SortIndex="3" SortOrder="Ascending" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 3" FieldName="Group Label 3" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product 3" FieldName="Product Group 3" SortIndex="4" SortOrder="Ascending" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 4" FieldName="Group Label 4" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product 4" FieldName="Product Group 4" SortIndex="5" SortOrder="Ascending" VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 5" FieldName="Group Label 5" VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 5" FieldName="Product Group 5" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Wt" VisibleIndex="25">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Unit" FieldName="Unit Label" VisibleIndex="21">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unit Count" VisibleIndex="22">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pcs in Unit" FieldName="Count In Package" VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Pcs" VisibleIndex="24">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="26">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Recd Date" VisibleIndex="27">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Exit Date" Visible="False" VisibleIndex="28">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Ship Date" VisibleIndex="30">
            </dx:GridViewDataDateColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Wt" SummaryType="Sum" ValueDisplayFormat="n0" />
            <dx:ASPxSummaryItem FieldName="LnFt" SummaryType="Sum" ValueDisplayFormat="n0" />
            <dx:ASPxSummaryItem FieldName="Unit Count" SummaryType="Sum" ValueDisplayFormat="n0" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Wt" ShowInGroupFooterColumn="Wt" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Unit Count" ShowInGroupFooterColumn="Unit Count" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="LnFt" ShowInGroupFooterColumn="Ln Ft" SummaryType="Sum" />
        </GroupSummary>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, [Product Profile Description], [Group Label 1], [Product Group 1], [Group Label 2], [Product Group 2], [Group Label 3], [Product Group 3], [Group Label 4], [Product Group 4], [Group Label 5], [Product Group 5], [Item ID], [Weight Label], Wt, Avg_Wt, Tons, [Unit Label], [Unit Count], [Count In Package], [Total Pcs], LnFt, Terminal, [Terminal Abr], [Recd Date], [Exit Date], [Company ID ref], [Ship Date], [Product Profile Ref], [Product Type] FROM [Inventory All received and shipped summary] WHERE ([Recd Date] &lt;= @Recd_Date) AND ([Exit Date] &gt; @Exit_Date) AND ([Company ID ref] = @Company_ID_ref) AND ([Receiving Client Ref] = @Receiving_Client_Ref)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Recd_Date" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar1" Name="Exit_Date" PropertyName="SelectedDate" Type="DateTime" />
            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_ClientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory on Date" GridViewID="ASPxGridView1">
</dx:ASPxGridViewExporter>
</asp:Content>
