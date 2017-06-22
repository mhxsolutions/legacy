<%@ Page Title="OCTG Inventory" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InventoryOCTG2" 
    CodeBehind="InventoryOCTG2.aspx.cs" CodeFile="InventoryOCTG2.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG Inventory at Terminal</h3>
    <h3>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Export to Excel" />
    </h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            Theme="Office2003Silver">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1" SortIndex="0" 
                    SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" 
                        HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="2" SortIndex="1" 
                    SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="3" 
                    SortIndex="2" SortOrder="Ascending">
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="4" SortIndex="3" 
                    SortOrder="Ascending">
                    <PropertiesTextEdit>
                        <Style Wrap="False">
                        </Style>
                    </PropertiesTextEdit>
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    <DataItemTemplate>
                        <a id="clickElement" 
                           href="product_transactions_lookup_runningtotals2.aspx?product_group_1=<%# Eval("Product").ToString()%>&amp;profile=<%# Eval("Profile").ToString()%>"
                            ><%# Eval("Product").ToString()%></a>
                    </DataItemTemplate>
                    <CellStyle Wrap="False">
                    </CellStyle>
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn FieldName="Mill" VisibleIndex="5" SortIndex="4" 
                    SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Inspection" VisibleIndex="6" 
                    SortIndex="5" SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="7">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="8">
                    <Settings AutoFilterCondition="Greater" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client ref" Visible="False" 
                    VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            </Columns>
            <SettingsPager PageSize="50">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
            <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/BlackGlass/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/BlackGlass/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/BlackGlass/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" 
                CssPostfix="BlackGlass">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <DetailRow Wrap="False">
                </DetailRow>
                <Cell Wrap="False">
                </Cell>
            </Styles>
            <StylesEditors>
                <CalendarHeader Spacing="1px">
                </CalendarHeader>
                <ProgressBar Height="25px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
    </p>
    <p>
        Now including zero count balances so that Inventory Report ties out with 
        Transaction Log running blances.</p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT * FROM [COPS OCTG Inventory Summary] WHERE ([Client ref] = @Client_ref) ORDER BY [Terminal], [Profile], [Description]">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="OCTGgrid1" runat="server" 
        FileName="OCTG inventory at terminal" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
</asp:Content>

