<%@ Page Title="Inventory On Date" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Inventory_On_Select_Date.aspx.cs" Inherits="Clients_All_Inventory_On_Select_Date" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <h3>Inventory On Selected Date</h3>
    </div>
    <strong>Select Date</strong><br />
    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="160px" NextPrevFormat="FullMonth" Width="290px">
        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
        <OtherMonthDayStyle ForeColor="#999999" />
        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
        <TodayDayStyle BackColor="#CCCCCC" />
    </asp:Calendar>
    <br />
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
    </dx:ASPxButton>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product_Profile_Description" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 1" FieldName="Group_Label_1" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product_Group_1" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 2" FieldName="Group_Label_2" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product_Group_2" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Label 3" FieldName="Group_Label_3" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product_Group_3" SortIndex="3" SortOrder="Ascending" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" SortIndex="4" SortOrder="Ascending" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pkg Type" FieldName="Package_Label" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count in Pkg" FieldName="Count_In_Package" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date_Received" VisibleIndex="12">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="Date Shipped" FieldName="LogOutDate" VisibleIndex="13">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Report On" ReadOnly="True" VisibleIndex="14">
            </dx:GridViewDataDateColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Product Profile Description] AS Product_Profile_Description, [Group Label 1] AS Group_Label_1, [Product Group 1] AS Product_Group_1, [Group Label 2] AS Group_Label_2, [Product Group 2] AS Product_Group_2, [Group Label 3] AS Group_Label_3, [Product Group 3] AS Product_Group_3, [Item ID] AS Item_ID, Weight, [Package Label] AS Package_Label, [Count In Package] AS Count_In_Package, [Date Received] AS Date_Received, LogOutDate, [Receiving Client Ref], [Exit Date], @Date_Sel AS [Report On] FROM [Inventory All received and shipped] WHERE ([Date Received] &lt;= @Date_Received) AND ([Receiving Client Ref] = @clientID) AND ([Exit Date] &gt;= @Date_Sel)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" DefaultValue="" Name="Date_Sel" PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="Calendar1" DefaultValue="" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
            <asp:SessionParameter Name="clientID" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory On Date" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
</asp:Content>

