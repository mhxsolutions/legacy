<%@ Page Title="Checkoff" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="recv_Confirm.aspx.cs" Inherits="Clients_Customers__Assigned_recv_Confirm" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        ETI Receiver Checkoff for TTL Bakersfield</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Metropolis">
    </dx:ASPxButton>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver_ID" 
            Theme="Metropolis">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver_ID" 
                    ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Type" FieldName="Receiver_Type" 
                    ReadOnly="True" VisibleIndex="2">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Date" FieldName="Date_Received" 
                    ReadOnly="True" VisibleIndex="3">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn Caption="Confirm Receiver" FieldName="Client_A" 
                    VisibleIndex="4">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Client_B" VisibleIndex="5">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Client_C" VisibleIndex="6">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn Caption="Enter Note" FieldName="Client_Note" 
                    VisibleIndex="7">
                    <EditFormSettings VisibleIndex="0" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Comments" FieldName="Equipment_Comments" 
                    ReadOnly="True" VisibleIndex="8">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="15">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <SettingsEditing EditFormColumnCount="1" Mode="PopupEditForm" />
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsPopup>
                <EditForm HorizontalAlign="LeftSides" MinWidth="400px" Modal="True" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            DeleteCommand="DELETE FROM [Receivers S] WHERE [Receiver ID] = @original_Receiver_ID AND (([Receiver Type] = @original_Receiver_Type) OR ([Receiver Type] IS NULL AND @original_Receiver_Type IS NULL)) AND (([Date Received] = @original_Date_Received) OR ([Date Received] IS NULL AND @original_Date_Received IS NULL)) AND (([Client A] = @original_Client_A) OR ([Client A] IS NULL AND @original_Client_A IS NULL)) AND (([Client B] = @original_Client_B) OR ([Client B] IS NULL AND @original_Client_B IS NULL)) AND (([Client C] = @original_Client_C) OR ([Client C] IS NULL AND @original_Client_C IS NULL)) AND (([Client Note] = @original_Client_Note) OR ([Client Note] IS NULL AND @original_Client_Note IS NULL)) AND (([Equipment Comments] = @original_Equipment_Comments) OR ([Equipment Comments] IS NULL AND @original_Equipment_Comments IS NULL))" 
            InsertCommand="INSERT INTO [Receivers S] ([Receiver Type], [Date Received], [Client A], [Client B], [Client C], [Client Note], [Equipment Comments]) VALUES (@Receiver_Type, @Date_Received, @Client_A, @Client_B, @Client_C, @Client_Note, @Equipment_Comments)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT [Receiver ID] AS Receiver_ID, [Receiver Type] AS Receiver_Type, [Date Received] AS Date_Received, [Client A] AS Client_A, [Client B] AS Client_B, [Client C] AS Client_C, [Client Note] AS Client_Note, [Equipment Comments] AS Equipment_Comments FROM [Receivers S] WHERE (([Terminal] = @Terminal) AND ([Record Lock] = @Record_Lock))" 
            UpdateCommand="UPDATE [Receivers S] SET [Receiver Type] = @Receiver_Type, [Date Received] = @Date_Received, [Client A] = @Client_A, [Client B] = @Client_B, [Client C] = @Client_C, [Client Note] = @Client_Note, [Equipment Comments] = @Equipment_Comments WHERE [Receiver ID] = @original_Receiver_ID AND (([Receiver Type] = @original_Receiver_Type) OR ([Receiver Type] IS NULL AND @original_Receiver_Type IS NULL)) AND (([Date Received] = @original_Date_Received) OR ([Date Received] IS NULL AND @original_Date_Received IS NULL)) AND (([Client A] = @original_Client_A) OR ([Client A] IS NULL AND @original_Client_A IS NULL)) AND (([Client B] = @original_Client_B) OR ([Client B] IS NULL AND @original_Client_B IS NULL)) AND (([Client C] = @original_Client_C) OR ([Client C] IS NULL AND @original_Client_C IS NULL)) AND (([Client Note] = @original_Client_Note) OR ([Client Note] IS NULL AND @original_Client_Note IS NULL)) AND (([Equipment Comments] = @original_Equipment_Comments) OR ([Equipment Comments] IS NULL AND @original_Equipment_Comments IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Receiver_ID" Type="Int32" />
                <asp:Parameter Name="original_Receiver_Type" Type="String" />
                <asp:Parameter Name="original_Date_Received" Type="DateTime" />
                <asp:Parameter Name="original_Client_A" Type="Boolean" />
                <asp:Parameter Name="original_Client_B" Type="Boolean" />
                <asp:Parameter Name="original_Client_C" Type="Boolean" />
                <asp:Parameter Name="original_Client_Note" Type="String" />
                <asp:Parameter Name="original_Equipment_Comments" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Receiver_Type" Type="String" />
                <asp:Parameter Name="Date_Received" Type="DateTime" />
                <asp:Parameter Name="Client_A" Type="Boolean" />
                <asp:Parameter Name="Client_B" Type="Boolean" />
                <asp:Parameter Name="Client_C" Type="Boolean" />
                <asp:Parameter Name="Client_Note" Type="String" />
                <asp:Parameter Name="Equipment_Comments" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="2145330251" Name="Terminal" Type="Int32" />
                <asp:Parameter DefaultValue="true" Name="Record_Lock" Type="Boolean" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Receiver_Type" Type="String" />
                <asp:Parameter Name="Date_Received" Type="DateTime" />
                <asp:Parameter Name="Client_A" Type="Boolean" />
                <asp:Parameter Name="Client_B" Type="Boolean" />
                <asp:Parameter Name="Client_C" Type="Boolean" />
                <asp:Parameter Name="Client_Note" Type="String" />
                <asp:Parameter Name="Equipment_Comments" Type="String" />
                <asp:Parameter Name="original_Receiver_ID" Type="Int32" />
                <asp:Parameter Name="original_Receiver_Type" Type="String" />
                <asp:Parameter Name="original_Date_Received" Type="DateTime" />
                <asp:Parameter Name="original_Client_A" Type="Boolean" />
                <asp:Parameter Name="original_Client_B" Type="Boolean" />
                <asp:Parameter Name="original_Client_C" Type="Boolean" />
                <asp:Parameter Name="original_Client_Note" Type="String" />
                <asp:Parameter Name="original_Equipment_Comments" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Receiver Checkoff" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

