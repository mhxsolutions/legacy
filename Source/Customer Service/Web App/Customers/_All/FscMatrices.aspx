<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_FscMatrices" 
    Title="BudwayDirect - FSC Matrix" CodeBehind="FscMatrices.aspx.cs" CodeFile="FscMatrices.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Fuel Surcharge Matrices</h2>
    <p>
        <asp:Button ID="Button1" runat="server" Text="Button" />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataKeyNames="ID,Cost Method Ref" DataSourceID="FscMatricesDatasource" ForeColor="#333333"
            GridLines="None" OnRowDataBound="GridView1_RowDataBound">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Begin Date" DataFormatString="{0:d}" HeaderText="Begin Date"
                    SortExpression="Begin Date" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="End Date" DataFormatString="{0:d}" HeaderText="End Date"
                    SortExpression="End Date" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:HyperLinkField DataTextField="Cost Method Ref">
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:HyperLinkField>
            </Columns>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="FscMatricesDatasource" EnableTheming="True" KeyFieldName="ID" 
            ondatabound="ASPxGridView1_DataBound" onrowcommand="ASPxGridView1_RowCommand" 
            onrowupdating="ASPxGridView1_RowUpdating" 
            onrowvalidating="ASPxGridView1_RowValidating" Theme="Office2003Silver" 
            oncustomcolumndisplaytext="ASPxGridView1_CustomColumnDisplayText" 
            onhtmldatacellprepared="ASPxGridView1_HtmlDataCellPrepared" 
            onhtmlrowcreated="ASPxGridView1_HtmlRowCreated" 
            onhtmlrowprepared="ASPxGridView1_HtmlRowPrepared" 
            oninitnewrow="ASPxGridView1_InitNewRow" onrowupdated="ASPxGridView1_RowUpdated">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Name" SortIndex="2" SortOrder="Ascending" 
                    VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Begin Date" SortIndex="4" 
                    SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="End Date" SortIndex="5" 
                    SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataHyperLinkColumn VisibleIndex="6" Caption="Column" 
                    FieldName="Cost Method Ref" SortIndex="5" SortOrder="Ascending">
                    <PropertiesHyperLinkEdit NavigateUrlFormatString="" TextFormatString="">
                    </PropertiesHyperLinkEdit>
                    <EditFormSettings Visible="True" VisibleIndex="6" />
                </dx:GridViewDataHyperLinkColumn>
            </Columns>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="FscMatricesDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [FSC Main].[Cost Method Ref], [FSC Main].[FSC ID] AS ID, [FSC Main].Name, [FSC Main].Description, [FSC Main].[Begin Date], [FSC Main].[End Date] FROM [FSC Main] INNER JOIN [FSC Cost Methods] ON [FSC Main].[Cost Method Ref] = [FSC Cost Methods].[Cost Method ID] ORDER BY [FSC Main].[Begin Date] DESC">
        </asp:SqlDataSource>
    </p>
</asp:Content>
