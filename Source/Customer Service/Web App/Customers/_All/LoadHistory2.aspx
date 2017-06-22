<%@ Page Title="Load History" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_LoadHistory2" 
    CodeBehind="LoadHistory2.aspx.cs" CodeFile="LoadHistory2.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Load Plan History - Delivery with POD scan</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Load" SortIndex="1" SortOrder="Ascending" 
                    VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Delivery Date" FieldName="Plan_Date" 
                    SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Destination" FieldName="Final_Destination" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="PDF_File" Visible="False" 
                    VisibleIndex="5">
                    <PropertiesHyperLinkEdit Text="PDF" TextFormatString="">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataHyperLinkColumn Caption="PDF" FieldName="PDF_link_w_load" 
                    VisibleIndex="6">
                    <PropertiesHyperLinkEdit 
                        NavigateUrlFormatString="" EncodeHtml="False" TextFormatString="">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn Caption="Age" FieldName="age" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Load], [Plan Date] AS Plan_Date, Origin, [Final Destination] AS Final_Destination, [PDF File] AS PDF_File, [PDF File Name] AS PDF_File_Name, age, PDF_link_w_load FROM [COPSLoadPlanHistory DLVonly] WHERE ([Shipper Ref] = @Shipper_Ref) OR ([Dest ref] = @Dest_ref) OR ([Origin ref] = @Origin_ref) OR ([Receiver ref] = @Receiver_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Shipper_Ref" SessionField="context_clientID" 
                    Type="Int32" />
                <asp:SessionParameter Name="Dest_ref" SessionField="context_clientID" 
                    Type="Int32" />
                <asp:SessionParameter Name="Origin_ref" SessionField="context_clientID" 
                    Type="Int32" />
                <asp:SessionParameter Name="Receiver_ref" SessionField="context_clientID" 
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        PDF link not active if no POD scan available.</p>
    <p>
        No will-call loads.</p>
</asp:Content>

