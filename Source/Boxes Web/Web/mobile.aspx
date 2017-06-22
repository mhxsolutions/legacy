<%@ Page Language="VB" AutoEventWireup="false" CodeFile="mobile.aspx.vb" Inherits="mobile" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>Boxes Mobile Menu</title>
</head>
<body>

    <h3>
        Mobile Reports</h3>
    <form id="form1" runat="server">
    <h3>
        <a href="etitonsmobile.aspx">ETI Tons</a></h3>
    <h3>
    &nbsp;<a href="flyashonsite.aspx">Fly Ash On-Site</a>
    </h3>
    <h3>
&nbsp;<a href="flyashmobile.aspx">Fly Ash Tons</a></h3>
    <h3>
        <a href="gpwillcall.aspx">GP Will Call</a></h3>
    <h3>
        <a href="phonereview.aspx">Phone Revie</a></h3>
    <h3>
        <a href="planning_status.aspx">Planning Status</a></h3>
    <h3>
        <a href="upipivot.aspx">UPI Tons</a></h3>
    <p>
        <strong>Fly Ash</strong></p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [fly ash load count by day] ORDER BY [Date] DESC, [Product]">
        </asp:SqlDataSource>
        <dx:ASPxGridView ID="ASPxGridView5" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource6" EnableTheming="True" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Date" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Product" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
    </p>
    <p>
        <strong>Fontana
        Staging</strong><dx:ASPxGridView ID="ASPxGridView3" runat="server" 
            AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Black/gridview/styles.css" 
            CssPostfix="Office2010Black" DataSourceID="SqlDataSource3" 
            Theme="Office2003Olive">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="1">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Loads Staged" VisibleIndex="2">
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Coils %" ReadOnly="True" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <images spritecssfilepath="~/App_Themes/Office2010Black/Gridview/sprite.css">
                <loadingpanelonstatusbar url="~/App_Themes/Office2010Black/GridView/Loading.gif">
                </loadingpanelonstatusbar>
                <loadingpanel url="~/App_Themes/Office2010Black/GridView/Loading.gif">
                </loadingpanel>
            </images>
            <imagesfiltercontrol>
                <loadingpanel url="~/App_Themes/Office2010Black/GridView/Loading.gif">
                </loadingpanel>
            </imagesfiltercontrol>
            <styles cssfilepath="~/App_Themes/Office2010Black/gridview/styles.css" 
                csspostfix="Office2010Black">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <loadingpanel imagespacing="5px">
                </loadingpanel>
            </styles>
            <StylesPager>
                <CurrentPageNumber ForeColor="Black">
                </CurrentPageNumber>
                <PageNumber ForeColor="White">
                </PageNumber>
                <Summary ForeColor="White">
                </Summary>
                <Ellipsis ForeColor="White">
                </Ellipsis>
            </StylesPager>
            <styleseditors buttoneditcellspacing="0">
                <progressbar height="21px">
                </progressbar>
            </styleseditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Gages staging of loads and coils] ORDER BY [LogOutDate] DESC">
        </asp:SqlDataSource>
    </p>
    <div>
        <strong>Fontana
    Dwell</strong>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Aqua/gridview/styles.css" CssPostfix="Aqua" 
            DataSourceID="SqlDataSource1" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Date" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pit Dwell" VisibleIndex="1" Caption="Pit">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Track 5 Dwell" VisibleIndex="2" 
                    Caption="Track 5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Yard Dwell" VisibleIndex="3" 
                    Caption="Yard">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inbound Dwell" VisibleIndex="4" 
                    Caption="Inbound">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Average" FieldName="Dwell" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="1" Visible="False">
            </SettingsPager>
            <SettingsLoadingPanel ImagePosition="Top" />
            <Images SpriteCssFilePath="~/App_Themes/Aqua/gridview/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesEditors>
                <DropDownEditDropDown>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                        PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
                </DropDownEditDropDown>
                <SpinEditIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
                </SpinEditIncrement>
                <SpinEditDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
                </SpinEditDecrement>
                <SpinEditLargeIncrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
                </SpinEditLargeIncrement>
                <SpinEditLargeDecrement>
                    <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                        PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
                </SpinEditLargeDecrement>
            </ImagesEditors>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Aqua/gridview/styles.css" CssPostfix="Aqua">
                <LoadingPanel ImageSpacing="8px">
                </LoadingPanel>
            </Styles>
            <StylesEditors>
                <CalendarHeader Spacing="1px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Gage dwell]"></asp:SqlDataSource>
        <br />
        <strong>Performance 2 Plan Today</strong></div>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/gridview/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Office2003Olive">
        <GroupSummary>
            <dx:ASPxSummaryItem DisplayFormat="Ct={0:n0}" FieldName="Driver Ct" 
                SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Min={0:n0}" FieldName="Plan Minutes" 
                SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="P2P={0:n0}" FieldName="P2P Today" 
                SummaryType="Sum" />
        </GroupSummary>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1" GroupIndex="1" 
                SortIndex="1" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="P2P Today" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="{0:n0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Plan Minutes" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="{0:n0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <images spritecssfilepath="~/App_Themes/BlackGlass/gridview/sprite.css">
            <loadingpanelonstatusbar url="~/App_Themes/BlackGlass/GridView/gvLoadingOnStatusBar.gif">
            </loadingpanelonstatusbar>
            <loadingpanel url="~/App_Themes/BlackGlass/GridView/Loading.gif">
            </loadingpanel>
        </images>
        <imagesfiltercontrol>
            <loadingpanel url="~/App_Themes/BlackGlass/Editors/Loading.gif">
            </loadingpanel>
        </imagesfiltercontrol>
        <styles cssfilepath="~/App_Themes/BlackGlass/gridview/styles.css" 
            csspostfix="BlackGlass">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
        </styles>
        <styleseditors>
            <calendarheader spacing="1px">
            </calendarheader>
            <progressbar height="25px">
            </progressbar>
        </styleseditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Gage P2P Today without subhaulers] WHERE ([Company ID ref] = @Company_ID_ref)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
        </SelectParameters>
        </asp:SqlDataSource>
        (measures total Schedule Adjust: negative is ahead of schedule)<br />
    <strong>GP<br />
    <dx:ASPxGridView ID="ASPxGridView6" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource4" EnableTheming="True" Theme="Office2010Blue">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Yr" SortIndex="0" SortOrder="Descending" 
                VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Mo" SortIndex="1" SortOrder="Descending" 
                VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MSF In" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="{0:n0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MSF Out" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="{0:n0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    </strong>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            
        SelectCommand="SELECT Yr, Mo, Client, [MSF In], [MSF Out] FROM [GP Special Invoice Value Monthly In n Out] ORDER BY Yr DESC, Mo DESC">
        </asp:SqlDataSource>
    
    <br />
    <strong>Fontana Load Rev</strong><dx:ASPxGridView ID="ASPxGridView7" 
        runat="server" AutoGenerateColumns="False" DataSourceID="LoadRev" 
        EnableTheming="True" Theme="Office2010Black" Width="2in">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="2">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Rev/Driver" FieldName="Rev/Driver" 
                ReadOnly="True" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="T/plan min" FieldName="T/plan min" 
                ReadOnly="True" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="LoadRev" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>House/Sub Split</strong><dx:ASPxGridView ID="ASPxGridView12" 
        runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource7" 
        EnableTheming="True" Theme="Office2010Black" Width="2in">
            <Settings ShowFilterRow="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Subhauler" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev/Driver" ReadOnly="True" 
                VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="T/plan min" ReadOnly="True" 
                VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct Sub - House split] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>Fontana - Load Rev $/Driver/Day</strong><dx:ASPxGridView 
        ID="ASPxGridView9" runat="server" AutoGenerateColumns="False" 
        DataSourceID="revperdriverfon" EnableTheming="True" 
        Theme="Office2010Black" Width="2in">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Year" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Avg Driver/Day" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Avg Rev/Day" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="$/Dr/Day" ReadOnly="True" 
                VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Days Worked" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
    </dx:ASPxGridView>
    <br />
    <asp:SqlDataSource ID="revperdriverfon" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev per Driver per Day M-F day ltd with Fleet] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Fontana" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <hr />
    <br />
    <strong>NorCal Load Rev</strong><dx:ASPxGridView ID="ASPxGridView8" 
        runat="server" AutoGenerateColumns="False" DataSourceID="LoadRev_Pit" 
        EnableTheming="True" Theme="Glass" Width="2in">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev/Driver" ReadOnly="True" 
                VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="T/plan min" ReadOnly="True" 
                VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager AlwaysShowPager="True">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="LoadRev_Pit" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>House/Sub Split</strong><dx:ASPxGridView ID="ASPxGridView11" 
        runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource5" EnableTheming="True" Theme="Glass" 
        Width="2in">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Date" VisibleIndex="1" SortIndex="0" 
                SortOrder="Descending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="3" 
                SortIndex="1" SortOrder="Ascending">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Revenue" ReadOnly="True" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev Ct" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev/Driver" ReadOnly="True" 
                VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="T/plan min" ReadOnly="True" 
                VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct Sub - House split] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>NorCal - Load Rev $/Driver/Day</strong><dx:ASPxGridView 
        ID="ASPxGridView10" runat="server" AutoGenerateColumns="False" 
        DataSourceID="loadrevperdrivernorcal" EnableTheming="True" Theme="Glass" 
        Width="2in">
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Year" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Avg Driver/Day" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Avg Rev/Day" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="$/Dr/Day" ReadOnly="True" 
                VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Days Worked" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="loadrevperdrivernorcal" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Rev per Driver per Day M-F day ltd with Fleet] WHERE ([Fleet] = @Fleet) ORDER BY [Year] DESC, [Month] DESC">
        <SelectParameters>
            <asp:Parameter DefaultValue="Bud- Pittsburg" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    
    </form>
</body>
</html>
