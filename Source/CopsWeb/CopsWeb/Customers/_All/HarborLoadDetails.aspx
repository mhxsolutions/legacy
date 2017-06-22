<%@ Page Title="BudwayDirect - Harbor Load Detail" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="HarborLoadDetails.aspx.cs" Inherits="Customers__All_HarborLoadDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Driver Notes on Loads</h2>

    <div class="contentDiv">
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
            DataTextField="Plan_Date" DataValueField="Plan_Date">
        </asp:DropDownList>
        Select Plan Date
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [COPS planned del with Harbor Data] ORDER BY [Plan Date]"></asp:SqlDataSource>
        &nbsp;&nbsp;
    <br />
    </div>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" KeyFieldName="Pdid" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>


        <SettingsDataSecurity AllowEdit="true" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewCommandColumn ShowEditButton="True" VisibleIndex="0"></dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="2" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="3" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Action" VisibleIndex="4" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Stop" VisibleIndex="5" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sch_Arrive" VisibleIndex="6" ReadOnly="true" Caption="Sch Arrive">
                <PropertiesTextEdit DisplayFormatString="t">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load_Ct" VisibleIndex="7" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load_Wt" VisibleIndex="8" ReadOnly="true" PropertiesTextEdit-DisplayFormatString="{0:n0}">
                <PropertiesTextEdit DisplayFormatString="{0:n0}"></PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BL1" VisibleIndex="9" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BL2" VisibleIndex="10" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unit" VisibleIndex="11" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="12" ReadOnly="true"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client Number" VisibleIndex="13" ReadOnly="true"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>





    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load], Origin, Action, Stop, [Sch Arrive] AS Sch_Arrive, [Load Ct] AS Load_Ct, [Load Wt] AS Load_Wt, BL1, BL2, Unit, Vessel, [Plan Date], Pdid, Notes, [PMBOL Client Number] AS [Client Number], [Parent ref], [origin ref] FROM [COPS planned del with Harbor Data] WHERE ([destination ref] = @destination_ref) AND ([Plan Date] = @sel_date) OR ([Plan Date] = @sel_date) AND ([Parent ref] = @destination_ref) OR ([Plan Date] = @sel_date) AND ([origin ref] = @destination_ref) ORDER BY Sch_Arrive"
        UpdateCommand="UPDATE [Planner Detail] SET [Client Notes] = @Notes WHERE [Planner Detail ID] = @Pdid">
        <SelectParameters>
            <asp:SessionParameter Name="destination_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="sel_date" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Notes" Type="String" />
            <asp:Parameter Name="Pdid" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

