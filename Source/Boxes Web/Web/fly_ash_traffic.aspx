<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fly_ash_traffic.aspx.vb" Inherits="fly_ash_traffic" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fly Ash Traffic<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" CssPostfix="Office2010Blue" 
        DataSourceID="SqlDataSource1" KeyFieldName="fly_ash_traffic_ID" EnableTheming="True" Theme="Metropolis">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" ShowEditButton="True" ShowNewButtonInHeader="True">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="fly_ash_traffic_ID" ReadOnly="True" 
                Visible="False" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Carrier" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="SqlDataSource2" DropDownStyle="DropDown" 
                    IncrementalFilteringMode="StartsWith" TextField="Carrier" ValueField="Carrier">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="Unit_Number" VisibleIndex="4" 
                Caption="Tractor">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Trailer" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Destination" VisibleIndex="7">
                <PropertiesComboBox DataSourceID="SqlDataSource3" DropDownStyle="DropDown" 
                    IncrementalFilteringMode="StartsWith" TextField="fly_ash_destination" 
                    ValueField="fly_ash_destination">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn FieldName="Arrive" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="3" Caption="Arrive Time">
                <PropertiesDateEdit DisplayFormatString="g" EditFormat="DateTime" 
                    EditFormatString="g" UseMaskBehavior="True" DateOnError="Today">
                    <CalendarProperties ShowWeekNumbers="False">
                    </CalendarProperties>
                </PropertiesDateEdit>
                <Settings AutoFilterCondition="GreaterOrEqual" />
                <EditFormSettings Caption="Arrive Time" />
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Scale" VisibleIndex="10" 
                Caption="On Scale Time">
                <PropertiesDateEdit DisplayFormatInEditMode="True" DisplayFormatString="t" 
                    EditFormat="DateTime" NullText="on scale time" UseMaskBehavior="True">
                </PropertiesDateEdit>
                <Settings AutoFilterCondition="GreaterOrEqual" />
                <EditFormSettings Caption="On Scale Time" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Depart" VisibleIndex="14" 
                Caption="Off Scale Time">
                <PropertiesDateEdit DisplayFormatInEditMode="True" DisplayFormatString="t" 
                    EditFormat="DateTime" NullText="depart time" UseMaskBehavior="True">
                </PropertiesDateEdit>
                <Settings AutoFilterCondition="GreaterOrEqual" />
                <EditFormSettings Caption="Depart Time" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Customer" VisibleIndex="6">
                <PropertiesComboBox DataSourceID="SqlDataSource4" DropDownStyle="DropDown" 
                    IncrementalFilteringMode="StartsWith" TextField="Carrier" ValueField="Carrier">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="Tare" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Lot" VisibleIndex="11"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ticket" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Gross" 
                VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Product" VisibleIndex="8">
                <PropertiesComboBox IncrementalFilteringMode="StartsWith">
                    <Items>
                        <dx:ListEditItem Text="fly ash" Value="fly ash" />
                        <dx:ListEditItem Text="white cement" Value="white cement" />
                    </Items>
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Rail Car" FieldName="Rail_Car" 
                VisibleIndex="15">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="18" Width="300px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn Caption="Grease Bottom" FieldName="Grease_Bottom" 
                VisibleIndex="16">
                <HeaderStyle Wrap="True" />
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataCheckColumn Caption="Grease Middle" FieldName="Grease_Middle" 
                VisibleIndex="17">
                <HeaderStyle Wrap="True" />
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsPager PageSize="30">
        </SettingsPager>
        <SettingsEditing Mode="EditForm" />
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" />
        <Images SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
            CssPostfix="Office2010Blue">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
            <DetailRow Wrap="False">
            </DetailRow>
            <LoadingPanel ImageSpacing="5px">
            </LoadingPanel>
        </Styles>
        <StylesPager>
            <PageNumber ForeColor="#3E4846">
            </PageNumber>
            <Summary ForeColor="#1E395B">
            </Summary>
        </StylesPager>
        <SettingsSearchPanel Visible="True" />
        <StylesEditors ButtonEditCellSpacing="0">
            <ProgressBar Height="21px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        DeleteCommand="DELETE FROM [fly ash traffic] WHERE [fly ash traffic ID] = @fly_ash_traffic_ID" 
        InsertCommand="INSERT INTO [fly ash traffic] ([Carrier], [Unit Number], [Arrive], [Scale], [Release], [Depart], [Customer], [Product], [Tare], [Gross], [Trailer], [Destination], [Lot], [Ticket], [Rail Car], [Note], [Grease Bottom], [Grease Middle]) VALUES (@Carrier, @Unit_Number, @Arrive, @Scale, @Release, @Depart, @Customer, @Product, @Tare, @Gross, @Trailer, @Destination, @Lot, @Ticket, @Rail_Car, @Note, @Grease_Bottom, @Grease_Middle)" 
        SelectCommand="SELECT [fly ash traffic ID] AS fly_ash_traffic_ID, [Carrier], [Unit Number] AS Unit_Number, [Arrive], [Scale], [Release], [Depart], [Customer], [Product], [Tare], [Gross], [Trailer], [Destination], [Lot], [Ticket], [Rail Car] AS Rail_Car, [Note], [Grease Bottom] AS Grease_Bottom, [Grease Middle] AS Grease_Middle FROM [fly ash traffic]" 
        
        
        UpdateCommand="UPDATE [fly ash traffic] SET [Carrier] = @Carrier, [Unit Number] = @Unit_Number, [Arrive] = @Arrive, [Scale] = @Scale, [Release] = @Release, [Depart] = @Depart, [Customer] = @Customer, [Product] = @Product, [Tare] = @Tare, [Gross] = @Gross, [Trailer] = @Trailer, [Destination] = @Destination, [Lot] = @Lot, [Ticket] = @Ticket, [Rail Car] = @Rail_Car, [Note] = @Note, [Grease Bottom] = @Grease_Bottom, [Grease Middle] = @Grease_Middle WHERE [fly ash traffic ID] = @fly_ash_traffic_ID">
        <DeleteParameters>
            <asp:Parameter Name="fly_ash_traffic_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Carrier" Type="String" />
            <asp:Parameter Name="Unit_Number" Type="String" />
            <asp:Parameter Name="Arrive" Type="DateTime" />
            <asp:Parameter Name="Scale" Type="DateTime" />
            <asp:Parameter Name="Release" Type="String" />
            <asp:Parameter Name="Depart" Type="DateTime" />
            <asp:Parameter Name="Customer" Type="String" />
            <asp:Parameter Name="Product" Type="String" />
            <asp:Parameter Name="Tare" Type="Int32" />
            <asp:Parameter Name="Gross" Type="Int32" />
            <asp:Parameter Name="Trailer" Type="String" />
            <asp:Parameter Name="Destination" Type="String" />
            <asp:Parameter Name="Lot" Type="Int32" />
            <asp:Parameter Name="Ticket" Type="Int32" />
            <asp:Parameter Name="Rail_Car" Type="String" />
            <asp:Parameter Name="Note" Type="String" />
            <asp:Parameter Name="Grease_Bottom" Type="Boolean" />
            <asp:Parameter Name="Grease_Middle" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Carrier" Type="String" />
            <asp:Parameter Name="Unit_Number" Type="String" />
            <asp:Parameter Name="Arrive" Type="DateTime" />
            <asp:Parameter Name="Scale" Type="DateTime" />
            <asp:Parameter Name="Release" Type="String" />
            <asp:Parameter Name="Depart" Type="DateTime" />
            <asp:Parameter Name="Customer" Type="String" />
            <asp:Parameter Name="Product" Type="String" />
            <asp:Parameter Name="Tare" Type="Int32" />
            <asp:Parameter Name="Gross" Type="Int32" />
            <asp:Parameter Name="Trailer" Type="String" />
            <asp:Parameter Name="Destination" Type="String" />
            <asp:Parameter Name="Lot" Type="Int32" />
            <asp:Parameter Name="Ticket" Type="Int32" />
            <asp:Parameter Name="Rail_Car" Type="String" />
            <asp:Parameter Name="Note" Type="String" />
            <asp:Parameter Name="Grease_Bottom" Type="Boolean" />
            <asp:Parameter Name="Grease_Middle" Type="Boolean" />
            <asp:Parameter Name="fly_ash_traffic_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT [Carrier] FROM [Fly Ash Carrier] ORDER BY [Carrier]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        DeleteCommand="DELETE FROM [fly ash destinations] WHERE [FA Dest ID] = @FA_Dest_ID" 
        InsertCommand="INSERT INTO [fly ash destinations] ([fly ash destination]) VALUES (@fly_ash_destination)" 
        ProviderName="<%$ ConnectionStrings:DWS No Rep DataConnectionString.ProviderName %>" 
        SelectCommand="SELECT [FA Dest ID] AS FA_Dest_ID, [fly ash destination] AS fly_ash_destination FROM [fly ash destinations]" 
        UpdateCommand="UPDATE [fly ash destinations] SET [fly ash destination] = @fly_ash_destination WHERE [FA Dest ID] = @FA_Dest_ID">
        <DeleteParameters>
            <asp:Parameter Name="FA_Dest_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="fly_ash_destination" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="fly_ash_destination" Type="String" />
            <asp:Parameter Name="FA_Dest_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        DeleteCommand="DELETE FROM [Fly Ash Carrier] WHERE [FA Carrier ID] = @FA_Carrier_ID" 
        InsertCommand="INSERT INTO [Fly Ash Carrier] ([Carrier]) VALUES (@Carrier)" 
        ProviderName="<%$ ConnectionStrings:DWS No Rep DataConnectionString.ProviderName %>" 
        SelectCommand="SELECT [FA Carrier ID] AS FA_Carrier_ID, [Carrier] FROM [Fly Ash Carrier]" 
        UpdateCommand="UPDATE [Fly Ash Carrier] SET [Carrier] = @Carrier WHERE [FA Carrier ID] = @FA_Carrier_ID">
        <DeleteParameters>
            <asp:Parameter Name="FA_Carrier_ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Carrier" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Carrier" Type="String" />
            <asp:Parameter Name="FA_Carrier_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
