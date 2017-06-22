<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__OCTG_All_receiving" 
    Title="OCTG Receiving History" CodeBehind="ReceivingOCTG.aspx.cs" CodeFile="ReceivingOCTG.aspx.cs"%>

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
                    BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt"
                    ForeColor="Black" Height="220px" Width="400px" NextPrevFormat="FullMonth" 
                    TitleFormat="Month">
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" 
                        Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TodayDayStyle BackColor="#CCCC99" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" 
                        ForeColor="#333333" Height="10pt" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" 
                        ForeColor="White" Height="14pt" />
                </asp:Calendar>
            </td>
            <td align="left" style="width: 100px" valign="top">
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt"
                    ForeColor="Black" Height="220px" Width="400px" NextPrevFormat="FullMonth" 
                    TitleFormat="Month">
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" 
                        Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TodayDayStyle BackColor="#CCCC99" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" 
                        ForeColor="#333333" Height="10pt" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" 
                        ForeColor="White" Height="14pt" />
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
        Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver_ID" 
                ReadOnly="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Date Rcd" FieldName="Date_Received" 
                VisibleIndex="4">
                <PropertiesDateEdit DisplayFormatString="{0:d}">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_1" Visible="False" 
                VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Product" FieldName="Group_1" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_2" Visible="False" 
                VisibleIndex="17">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Mill" FieldName="Group_2" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Label_3" Visible="False" 
                VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Inspection" FieldName="Group_3" 
                VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item_ID" Visible="False" 
                VisibleIndex="14">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct_in_Pkg" Visible="False" 
                VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="13">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ct" FieldName="Pkg" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Description" 
                FieldName="Extended_Description" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LnFt" VisibleIndex="15">
                <PropertiesTextEdit DisplayFormatString="{0:f1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Client PO" FieldName="Client Web Ref" 
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        <Styles>
            <Row Wrap="False">
            </Row>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ReceOCTGExport" runat="server">
    </dx:ASPxGridViewExporter>
</asp:Content>

