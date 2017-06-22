<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="ReceivingOCTG.aspx.cs" Inherits="Customers__OCTG_All_receiving" Title="OCTG Receiving History" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG
        Receiving History<br />
    </h3>
    <br />
    <table>
        <tr>
            <td align="left" style="width: 100px" valign="top">
                <strong>Start Date</strong></td>
            <td align="left" style="width: 100px" valign="top">
                <strong>End Date</strong></td>
        </tr>
        <tr>
            <td align="left" style="width: 100px" valign="top">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                    BorderColor="White" Font-Names="Verdana" Font-Size="9pt"
                    ForeColor="Black" Height="160px" Width="290px" NextPrevFormat="FullMonth" BorderWidth="1px">
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#333333" Font-Bold="True" VerticalAlign="Bottom" />
                    <DayHeaderStyle 
                        Font-Bold="True" Font-Size="8pt" />
                    <TitleStyle BackColor="White" Font-Bold="True" Font-Size="12pt" 
                        ForeColor="#333399" BorderColor="Black" BorderWidth="4px" />
                </asp:Calendar>
            </td>
            <td align="left" style="width: 100px" valign="top">
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="White" Font-Names="Verdana" Font-Size="9pt"
                    ForeColor="Black" Height="160px" Width="290px" NextPrevFormat="FullMonth" BorderWidth="1px">
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#333333" Font-Bold="True" VerticalAlign="Bottom" />
                    <DayHeaderStyle 
                        Font-Bold="True" Font-Size="8pt" />
                    <TitleStyle BackColor="White" Font-Bold="True" Font-Size="12pt" 
                        ForeColor="#333399" BorderColor="Black" BorderWidth="4px" />
                </asp:Calendar>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT Terminal, [Receiver ID] AS Receiver_ID, Type, [Date Received] AS Date_Received, Profile, [Label 1] AS Label_1, [Group 1] AS Group_1, [Label 2] AS Label_2, [Group 2] AS Group_2, [Label 3] AS Label_3, [Group 3] AS Group_3, [Item ID] AS Item_ID, [Ct in Pkg] AS Ct_in_Pkg, Pounds, Pkg, Carrier, [Extended Description] AS Extended_Description, LnFt, [Client Web Ref] FROM [Receivers semi summarized] WHERE (client = @client) AND ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2) ORDER BY Terminal, Receiver_ID, Group_1">
        <SelectParameters>
            <asp:SessionParameter Name="client" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="Calendar1" DbType="DateTime" Name="Date_Received"
                PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="Calendar2" DbType="DateTime" Name="Date_Received2"
                PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver_ID" 
        Theme="Metropolis">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1" SortIndex="0" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver_ID" 
                ReadOnly="True" VisibleIndex="3" SortIndex="2" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Date Rcd" FieldName="Date_Received" 
                VisibleIndex="2" SortIndex="1" SortOrder="Descending">
                <PropertiesDateEdit DisplayFormatString="{0:d}">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_1" Visible="False" 
                VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Group_1" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_2" Visible="False" 
                VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mill" FieldName="Group_2" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_3" Visible="False" 
                VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Inspection" FieldName="Group_3" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item_ID" Visible="False" 
                VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct_in_Pkg" Visible="False" 
                VisibleIndex="13">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="16">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count" FieldName="Pkg" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Description" 
                FieldName="Extended_Description" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="14" Caption="LNFT">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PO Ref" FieldName="Client Web Ref" 
                VisibleIndex="11">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ReceOCTGExport" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>

